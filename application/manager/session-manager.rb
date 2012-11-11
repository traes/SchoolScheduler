# SessionManager is responsible for the sessions

class SessionManager < AbstractManager
   def initialize(application)
      super('log/session-manager.log')
      @latest_id=0
      @sessions = Hash.new 
      @application=application
      self.info('session manager started')
   end   
   
   # send OK in XML to socket
   def xml_ok(socket)
      begin
         socket.puts(REXML::Document.new.add_element('OK').to_s)
      rescue
         self.error('cannot write to socket')
      end
   end

   # send ERROR in XML to socket
   def xml_error(socket)
      begin
         self.warning("sending ERROR to client")
         socket.puts(REXML::Document.new.add_element('ERROR').to_s)
      rescue
         self.error('cannot write to socket')
      end   
   end

   # create a new session id
   def create_session_id
      @latest_id += 1
      session_hash = MD5.new(@latest_id.to_s).to_s 
      self.info('created session id:' + session_hash)
      return session_hash
   end

   # get session with given id
   def get_session(id)
         return @sessions[id.to_s]
   end

   # get user with given sesision id
   def get_user(session_id)
         session = self.get_session(session_id)
         return session.get_user
   end

   # check whether a session id is currently in use
   def valid_session_id?(id)
      return @sessions.has_key?(id)
   end

   # check whether a user is logged in
   def logged_in?(username)
      @sessions.values.map{|session| session.get_user.get_name}.member?(username)
   end

   # handle the command from a socket
   def handle(socket)
         command = Command.new socket
         self.info(command.to_s)
         case command.get_attribute('type')
         
            # login/logout
            when 'login' then self.create_session(socket,command)
            when 'logout' then self.remove_session(socket,command)
            when 'get_login_style' then self.get_login_style(socket,command)
         
            # users
            when 'get_username' then self.get_username(socket,command)
            when 'get_usertype' then self.get_usertype(socket,command)

            # let session itself handle the command
            else self.continue_session(socket,command)
         end
   end

   # stop and remove a session
   def remove_session(socket,command)
      begin
         session_id = command.get_attribute('id')
         @sessions.delete(session_id)
         result = Result.new
         result.set_attribute('type','logout')
         result.set_attribute('id',session_id)
         socket.puts result.to_s
         puts result.to_s
         self.info(result.to_s)
      rescue
         self.error('cannot terminate session')
         self.xml_error(socket)
      end
   end

   # create a new session
   def create_session(socket,command)

      # managers
      auth_manager = @application.get_auth_manager
      user_manager = @application.get_user_manager
   
      # default result
      result = Result.new
      result.set_attribute('type','login')
      result.set_attribute('id',0)
      result.set_attribute('homepage','failed-login.cgi')
      
      begin
         # check password
         name = command.get_attribute('name')
         password = command.get_attribute('password')
         self.info("checking password for name: #{name} password: #{password}")
         password = MD5.new(password).to_s
         valid = auth_manager.valid_password(name,password)
      rescue
         # wrong password
         self.error('failed to authenticate:' + name.to_s + password.to_s)
         self.xml_error(socket)
         exit
      end
      
      if valid then 
         # users can only be logged in once
         if self.logged_in?(name) then
            result.set_attribute('error','double_login')   
            self.error("user already logged in #{name}")
         else

            # create session
            id = self.create_session_id
            user = user_manager.get_user(name)
            session = user.create_session(id)
            @sessions[id] = session
            
            # adapt result
            result.set_attribute('id',id)
            result.set_attribute('homepage',session.get_homepage(@application))
         end
      end

      # send result
      socket.puts result.to_s
      self.info(result.to_s)
   end

   # let the session handle the command
   def continue_session(socket,command)
      begin
         session_id = command.get_attribute('id')
         if self.valid_session_id?(session_id)
            then
               session = self.get_session(session_id)
               result = session.execute(command,@application)
               socket.puts result.to_s
               puts(result.to_s)
               self.info('session handled')
            else
               self.error('invalid session: ' + session_id.to_s)
               self.invalid_session_error(socket)
         end   
      rescue
         self.error('failed to continue session')
         self.xml_error(socket)
      end
   end   

   # send the username to the interface layer
   def get_username(socket,request)
      begin
         session_id = request.get_attribute('id')
         session = self.get_session(session_id)
         username = session.get_user.get_name
         result = Result.new
         result.set_attribute('username',username)
         socket.puts result.to_s
         self.info(result.to_s)
      rescue
         self.error('failed to get username')
         self.xml_error(socket)
      end
   end

   # send the usertype to the intrface layer
   def get_usertype(socket,request)
      begin
         session_id = request.get_attribute('id')
         session = self.get_session(session_id)
         user = self.get_user(session_id) 
         result = Result.new
         result.set_attribute('usertype',user.get_usertype)
         socket.puts result.to_s
         self.info(result.to_s)
      rescue
         self.error('failed to get usertype')
         self.xml_error(socket)
      end
   end

   # send an error "invalid session" to the interface layer
   def invalid_session_error(socket)
      result = Result.new
      result.set_attribute('type','error')
      result.set_attribute('description','invalid session')
      socket.puts result.to_s
   end

   # send the stylesheet for the login screen
   def get_login_style(socket,command)
      css = "<STYLE type=\"text/css\"> \
            html {background-color: #DDDDDD} \
            h1 {color: black; background-color: white;} \
          form { \
            background-color: #CCCCCC; \
            color: #000000; \
            border: 1px solid #999999; \
            font-family: Verdana, Arial, Helvetica, sans-serif; \
            width: 33%; \
          }\
         label   {\
            width: 4em;\
            float: left;\
            text-align: left;\
            display: block   \
         } \
         </STYLE>"
      socket.puts css
   end
end


