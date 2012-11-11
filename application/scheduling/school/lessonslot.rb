
class LessonSlot
   def initialize(timeslot,classroom)
      @timeslot=timeslot
      @classroom=classroom
   end
   def get_timeslot()
      return @timeslot
   end
   def set_timeslot(value)
      @timeslot = value
   end
   def get_classroom()
      return @classroom
   end
   def set_classroom(value)
      @classroom = value
   end
   def to_s
      return "#{timeslot.to_s} #{@classroom.to_s}"
   end
end
