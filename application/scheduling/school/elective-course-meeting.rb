
class ElectiveCourseMeeting < CourseMeeting
   def initialize(course,teacher,group,elective_group)
      super(course,teacher,group)
      @elective_group = elective_group
   end   
   def is_elective
      return true
   end   
   def get_elective_group()
      return @elective_group
   end
   def set_elective_group(value)
      @elective_group = value
   end
   def to_s
      return super.to_s + ' ' +  @elective_group.to_s
   end
end
