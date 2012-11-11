require 'socket'
require 'rexml/document'
require 'configuration-file.rb'

ConfigFile = "config" # location of the configuration file

class Communication
   def initialize(cgi)
      config = ConfigurationFile.new(ConfigFile)
      @port=config['port'].to_i
      @host=config['host']
      @cgi=cgi
   end
   
   # attributes
   def get_port()
      return @port
   end
   def set_port(value)
      @port = value
   end
   def get_host()
      return @host
   end
   def set_host(value)
      @host = value
   end
   def get_cgi
      return @cgi
   end
   def set_cgi(value)
      @cgi = value
   end   
   
   # execute a command requested by the user (eg. view_schedule)
   def execute_command
      begin
         if @cgi.has_key?('type') then
            doc = REXML::Document.new
            command = doc.add_element 'COMMAND'
            @cgi.params.each_pair { |key,value| command.attributes[key]=value}
            xmlCommand = doc.to_s
            socket = TCPSocket.new(@host,@port)
            socket.puts xmlCommand 
            xmlResult = socket.gets.chop
            docResult = REXML::Document.new xmlResult
         end
      rescue
         puts 'Probleem bij uitvoeren commando'
         exit
      end
   end
   def execute_custom_command(type,args)
      begin
         doc = REXML::Document.new
         command = doc.add_element 'COMMAND'
         command.attributes['type']=type
         @cgi.params.each_pair { |key,value| command.attributes[key]=value}
         args.each_pair {|key,value| command.attributes[key]=value}
         xmlCommand = doc.to_s
         socket = TCPSocket.new(@host,@port)
         socket.puts xmlCommand
         xmlResult = socket.gets.chop
         docResult = REXML::Document.new xmlResult
      rescue
         puts 'Probleem bij uitvoeren aangepast commando'
      end   
   end
   def get_data(command_name)
      begin
         doc = REXML::Document.new
         command = doc.add_element 'COMMAND'
         command.attributes['type']=command_name
         command.attributes['id']=@cgi.params['id']
         xmlCommand = doc.to_s
         socket = TCPSocket.new(@host,@port)
         socket.puts xmlCommand 
         xmlResult = socket.gets.chop
         docResult = REXML::Document.new xmlResult
      rescue
         puts 'Probleem bij opvragen data'
         exit
      end
   end
   def login(name,password)
      return execute_custom_command('login',{'name'=>name,'password'=>password})
   end
   def logout
      return execute_custom_command('logout',{})
   end
   def check(usertypes)
      begin
         usertype = self.get_data('get_usertype').root.attributes['usertype']
         if !usertypes.member?(usertype) then raise end
      rescue
        puts 'Toegang geweigerd'
        exit
      end
   end
   def get_style
      begin
         return self.get_data('get_style')
      rescue
        uts 'Probleem bij opvragen stijlinformatie'
        exit
      end
   end
   def get_username
      begin
         return self.get_data('get_username').root.attribute('username').to_s
      rescue
        puts 'Probleem bij opvragen gebruikersnaam'
        exit
      end
   end
   def get_homepage
      begin
         return self.get_data('get_homepage').root.attribute('homepage').to_s
      rescue
        puts 'Probleem bij opvragen hoofdpagina'
        exit
      end
   end   
   def get_classrooms
      begin
         result = []
         reply = self.get_data('view_classroom')
         reply.root.elements.each do |classroom|
            name = classroom.attribute('name').to_s
            index = classroom.attribute('index').to_s
            result.push({'name'=>name,'index'=>index})
         end
         return result
      rescue
         puts 'Probleem bij opvragen klaslokalen'
         exit
      end
   end
   def get_teachers
      begin
         result = []
         reply = self.get_data('view_teacher')
         reply.root.elements.each do |teacher|
            name = teacher.attribute('name').to_s
            index = teacher.attribute('index').to_s
            result.push({'name'=>name,'index'=>index})
         end
         return result
      rescue
         puts 'Probleem bij opvragen docenten'
         exit
      end   
   end
   def get_courses
      begin
         result = []
         reply = self.get_data('view_course')
         reply.root.elements.each do |course|
            name = course.attribute('name').to_s
            index = course.attribute('index').to_s
            result.push({'name'=>name,'index'=>index})
         end
         return result
      rescue
         puts 'Probleem bij opvragen vakken'
         exit
      end
   end
   def get_directions
      begin
         result = []
         reply = self.get_data('view_direction')
         reply.root.elements.each do |direction|
            name = direction.attribute('name').to_s
            index = direction.attribute('index').to_s
            result.push({'name'=>name,'index'=>index})
         end
         return result
      rescue
         puts 'Probleem bij opvragen studierichtingen'
         exit
      end
   end
   def get_timeslots
    begin
         result = []
         reply = self.get_data('view_timeslot')
         reply.root.elements.each do |timeslot|
            day = timeslot.attribute('day').to_s
            start = timeslot.attribute('start').to_s
            stop = timeslot.attribute('stop').to_s
            index = timeslot.attribute('index').to_s
            description = "#{day} van #{start} tot #{stop}"
            result.push({'index'=>index,'description'=>description})
         end
         return result
      rescue
         puts 'Probleem bij opvragen tijdsloten'
         exit
      end
   end
   def get_electivegroups
      begin
         result = []
         reply = self.get_data('view_electivegroup')
         reply.root.elements.each do |electivegroup|
            name = electivegroup.attribute('name').to_s
            index = electivegroup.attribute('index').to_s
            result.push({'name'=>name,'index'=>index})
         end
         return result
      rescue
         puts 'Probleem bij opvragen keuzevakgroepen'
         exit
      end
   end
   def get_constraints
      begin
         result = []
         reply = self.get_data('view_constraint')
         reply.root.elements.each do |constraint|
            name = constraint.attribute('name').to_s
            result.push(name)
         end
         return result
      rescue
         puts 'Probleem bij opvragen beperkingen'
         exit
      end
   end
   def get_days
      return ['maandag','dinsdag','woensdag','donderdag','vrijdag']
   end
   def get_id
      return @cgi.params['id']
   end
end



