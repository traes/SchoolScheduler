class ConfigManager < AbstractManager
   def initialize(application,file_name)
      super('log/config-manager.log')
      @application=application
      @configuration_file = ConfigurationFile.new(file_name)
   end
   def get(var)
      begin
         val =  @configuration_file[var]
         self.info("#{var} : #{val}")
         return val
      rescue
         self.error("couldn't get #{var}")
         exit
      end
   end
   def to_s
      return @application.to_s + ' '  + @datalayer_host.to_s + ' ' + @datalayer_port.to_s 
   end
end
