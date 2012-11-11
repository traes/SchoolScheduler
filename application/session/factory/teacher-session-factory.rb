
class TeacherSessionFactory < AbstractSessionFactory
   def create_session(id,user)
      TeacherSession.new(id,user)
   end
   def to_s
      return 'teacher session factory'
   end
end
