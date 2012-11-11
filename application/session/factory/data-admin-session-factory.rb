class DataAdminSessionFactory < AbstractSessionFactory
   def create_session(id,user)
      return DataAdminSession.new(id,user)
   end
end
