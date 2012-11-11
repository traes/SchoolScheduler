class SystemAdminSessionFactory < AbstractSessionFactory
   def create_session(id,user)
      return SystemAdminSession.new(id,user)
   end
end
