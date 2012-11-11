# UserManager is responsible for the users
class UserManager < AbstractManager

   def initialize(application)
      super('log/user-manager.log')
      @application=application
   end

   # get the user with given name
   def get_user(name)

      # the system administrator should be able to login when the data layer is inreachable
      if name == 'system' then
         user = SystemAdminUser.new(name)
      else   
         # all other users are stored in the datalayer
         data_manager = @application.get_data_manager
         usertype = data_manager.get_usertype(name)
         user = nil
         case usertype
            when 'teacher' then user=TeacherUser.new(name)
            when 'student' then user=StudentUser.new(name)
            when 'data-admin' then user=DataAdminUser.new(name)
            else self.error("unnown usertype: #{usertype}")
         end
      end   
      return user
   end
end   
