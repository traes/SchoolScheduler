class AbstractUser
   def initialize(name)
      @name=name
   end
   def get_name()
      return @name
   end
   def set_name(value)
      @name = value
   end
   def create_session(id)
      session_factory = self.get_session_factory
      return session_factory.create_session(id,self)
   end
   def get_usertype
      return 'abstract user'
   end
   def to_s
      return @name.to_s 
   end
end
