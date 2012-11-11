
# Application contains all the managers
class Application
   def initialize(configuration_file)
      @data_manager=DataManager.new(self)
      @schedule_manager=ScheduleManager.new(self)
      @user_manager=UserManager.new(self)
      @session_manager=SessionManager.new(self)
      @auth_manager=AuthManager.new(self)
      @config_manager=ConfigManager.new(self,configuration_file)
   end
   def get_all_managers()
      result = []
      result.push(@data_manager)
      result.push(@schedule_manager)
      result.push(@user_manager)
      result.push(@session_manager)
      result.push(@auth_manager)
      result.push(@config_manager)
      return result
   end
   def get_config_manager()
      return @config_manager
   end
   def set_config_manager(value)
      @configruation_manager = value
   end   
   def get_data_manager()
      return @data_manager
   end
   def set_data_manager(value)
      @data_manager = value
   end
   def get_schedule_manager()
      return @schedule_manager
   end
   def set_schedule_manager(value)
      @schedule_manager = value
   end
   def get_user_manager()
      return @user_manager
   end
   def set_user_manager(value)
      @user_manager = value
   end
   def get_session_manager()
      return @session_manager
   end
   def set_session_manager(value)
      @session_manager = value
   end
   def get_auth_manager()
      return @auth_manager
   end
   def set_auth_manager(value)
      @auth_manager = value
   end
   def to_s
      return 'application'
   end
end
