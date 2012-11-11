
class CourseMeeting
   def initialize(course,teacher,direction,electivegroup,compulsory,persons)
      @course=course
      @teacher=teacher
      @direction=direction
      @electivegroup=electivegroup
      @compulsory=compulsory
      @persons=persons
   end
   def same_students?(other)
      result = false
      if (self.get_compulsory && other.get_compulsory) then
         result = (self.get_direction == other.get_direction)
      end   
      if (!self.get_compulsory && !other.get_compulsory) then
         result = (self.get_electivegroup == other.get_electivegroup)
      end
      return result
   end
   def get_course()
      return @course
   end
   def set_course(value)
      @course = value
   end
   def get_teacher()
      return @teacher
   end
   def set_teacher(value)
      @teacher = value
   end
   def get_direction()
      return @direction
   end
   def set_direction(value)
      @direction = value
   end
   def get_electivegroup()
      return @electivegroup
   end
   def set_electivegroup(value)
      @electivegroup = value
   end
   def get_compulsory()
      return @compulsory
   end
   def set_compulsory(value)
      @compulsory = value
   end
   def get_persons()
      return @persons
   end
   def set_persons(value)
      @persons = value
   end
   def to_s
      return @course.to_s + ' ' + @teacher.to_s + ' ' + @direction.to_s + ' ' + @electivegroup.to_s + ' ' + @compulsory.to_s + ' ' + @persons.to_s 
   end
end
