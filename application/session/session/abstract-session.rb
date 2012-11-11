class AbstractSession
   def initialize(id,user,controller,viewer)
      @id=id
      @user=user
      @controller=controller
      @viewer=viewer
   end
   def get_id()
      return @id
   end
   def set_id(value)
      @id = value
   end
   def get_user()
      return @user
   end
   def set_user(value)
      @user = value
   end
   def get_controller()
      return @controller
   end
   def set_controller(value)
      @controller = value
   end
   def get_viewer()
      return @viewer
   end
   def set_viewer(value)
      @viewer = value
   end
   def get_homepage(application)
      return self.get_viewer.get_homepage(application)
   end
   def to_s
      return "session: #{@id.to_s}"
   end
end
