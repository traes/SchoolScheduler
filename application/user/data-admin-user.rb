
class DataAdminUser < AbstractUser
   def initialize(name)
      super(name)
      @session_factory = DataAdminSessionFactory.new
   end
   def get_usertype
      return 'data-admin'
   end
   def get_session_factory()
      return @session_factory
   end
   def set_session_factory(value)
      @session_factory = value
   end
end
