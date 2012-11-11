class StudentSessionFactory < AbstractSessionFactory
   def create_session(id,user)
      return StudentSession.new(id,user)
   end
end
