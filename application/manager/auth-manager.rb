# AuthManager is responsible for the authentication of users
class AuthManager < AbstractManager
   def initialize(application)
      super('log/auth-manager.log')
      @application=application
   end
   def system_password?(password)
         self.info("checking system password: #{password}")
         config_manager = @application.get_config_manager
         correct = config_manager.get('system')
         result = (correct == password)
         if !result then self.warning('failed system login') end
         return (correct == password)
   end
   def valid_password(name,password)
      # the password for the system administrator is stored in the application layer
      if name == 'system' then
         return self.system_password?(password)
      end   
      # all other accounts are stored in the data layer
      user_manager = @application.get_user_manager
      data_manager = @application.get_data_manager
      result = false
      begin
         correct = data_manager.get_password(name)
         result = (correct == password ) 
      rescue
         result = false
      end   
      self.info("match: #{result.to_s} received: #{password} correct: #{correct}")
      return result
   end
end   


