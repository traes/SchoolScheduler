LastPreferableBeginHour = 17

class School
   def initialize(name)
      @name=name
      @course_meetings=[]
      @classrooms=[]
      @timeslots=[]
      @penalties=Hash.new(0)
      @required_classrooms=Hash.new
      @restricted_courses=Hash.new
      @restricted_timeslots=Hash.new
      @group_students=Hash.new
      @classrooms_capacity=Hash.new
      @classrooms_unavailable=Hash.new
      @teacher_timeslots=Hash.new
      @locations=Hash.new
   end
   def get_penalties
      return @penalties
   end
   def set_penalties(value)
      @penalties=value
   end   
   def create_scheduling_problem
       ### initialize ###
       problem = SchedulingProblem.new

       ### constraints & improvements ###
       puts 'penalties:' + @penalties.to_s
       ##problem.improvements.push TimeslotImprovement.new
       problem.get_constraints.push TeacherConstraint.new(@penalties['teacher'])
       problem.get_constraints.push ElectiveConstraint.new(@penalties['elective'])
       problem.get_constraints.push CompulsoryConstraint.new(@penalties['compulsory'])
       problem.get_constraints.push CapacityConstraint.new(@penalties['capacity'])
       problem.get_constraints.push ClassRoomDistanceConstraint.new(@penalties['classroom-distance'])
       problem.get_constraints.push LastTimeslotsConstraint.new(@penalties['last-timeslot'],LastPreferableBeginHour) 
       problem.get_constraints.push RequiredClassroomConstraint.new(@penalties['required-classroom'],@required_classrooms)
       problem.get_constraints.push RestrictedCoursesConstraint.new(@penalties['restricted-courses'],@restricted_courses)
       problem.get_constraints.push TeacherTimeslotConstraint.new(@penalties['teacher-timeslot'],@teacher_timeslots)
       problem.get_constraints.push TimeslotGapConstraint.new(@penalties['timeslot-gap'])
       problem.get_constraints.push LunchBreakConstraint.new(@penalties['lunch-break'])
       problem.get_constraints.push OneCourseADayConstraint.new(@penalties['one-course-a-day'])
       problem.get_constraints.push RestrictedTimeslotConstraint.new(@penalties['restricted-timeslots'],@restricted_timeslots)

       ### consumers ###
       @course_meetings.each do |meeting|
         problem.get_consumers.push(Consumer.new(meeting))
       end

       ### resources ###
       @classrooms.each do |classroom|
         @timeslots.each do |timeslot|
            if !(@classrooms_unavailable.has_key?(classroom.get_name) && @classrooms_unavailable[classroom.get_name].member?(timeslot.to_s)) 
         then 
            problem.get_resources.push(Resource.new(LessonSlot.new(timeslot,classroom)))
         else
            puts 'skipping resource: ' + classroom.to_s + timeslot.to_s
         end
         end
       end   
          
      return problem
   end
   def get_locations()
      return @locations
   end
   def set_locations(value)
      @locations = value
   end
   def get_name()
      return @name
   end
   def set_name(value)
      @name = value
   end
   def get_course_meetings()
      return @course_meetings
   end
   def set_course_meetings(value)
      @course_meetings = value
   end
   def get_classrooms()
      return @classrooms
   end
   def set_classrooms(value)
      @classrooms = value
   end
   def get_timeslots()
      return @timeslots
   end
   def set_timeslots(value)
      @timeslots = value
   end
   def get_schedule()
      return @schedule
   end
   def set_schedule(value)
      @schedule = value
   end
   def get_required_classrooms()
      return @required_classrooms
   end
   def set_required_classrooms(value)
      @required_classrooms = value
   end
   def get_restricted_courses()
      return @restricted_courses
   end
   def set_restricted_courses(value)
      @restricted_courses = value
   end
   def get_restricted_timeslots()
      return @restricted_timeslots
   end
   def set_restricted_timeslots(value)
      @restricted_timeslots = value
   end
   def get_group_students()
      return @group_students
   end
   def set_group_students(value)
      @group_students = value
   end
   def get_classrooms_capacity()
      return @classrooms_capacity
   end
   def set_classrooms_capacity(value)
      @classrooms_capacity = value
   end
   def get_classrooms_unavailable()
      return @classrooms_unavailable
   end
   def set_classrooms_unavailable(value)
      @classrooms_unavailable = value
   end
   def get_teacher_timeslots()
      return @teacher_timeslots
   end
   def set_teacher_timeslots(value)
      @teacher_timeslots = value
   end
   def to_s
      return @name.to_s
   end
end
