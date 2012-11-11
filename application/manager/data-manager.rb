# DataManager is responsible for storing and retrieving the data
# It handles the connection with the data layer

class DataManager < AbstractManager
   def initialize(application)
      super('log/data-manager.log')
      @application=application
   end

   # application
   def get_application()
      return @application
   end
   def set_application(value)
      @application = value
   end

   # connection with data layer
   def link
      begin
         config_manager = @application.get_config_manager
         host = config_manager.get('data_host')
         port = config_manager.get('data_port')
         datalink = DataLink.new(host,port)
         return datalink
      rescue
         self.error("could not connect to datalayer")
      end
   end

   # passwords
   def get_password(user)
      reply = self.link.send('get-password',{'username'=>user})
      return reply.root.attributes['password']
   end
   def set_password(user,password)
      password = MD5.new(password)
      self.info("changing password for user #{user} into #{password}")
      self.link.send('set-password',{'username'=>user,'password'=>password})
   end

   # user
   def get_user_xml
      return self.link.send('get-user',{})
   end
   def get_usertype(username)
      result = self.link.send('get-usertype',{'username'=>username})
      return result.root.attributes['usertype']
   end
   def add_user(username,usertype,password)
      password = MD5.new(password)
      self.link.send('add-user',{'username'=>username,'usertype'=>usertype,'password'=>password})
   end
   def remove_user(value)
      self.link.send('remove-user',{'index'=>value})
   end

   # backup
   def create_backup
      self.link.send('create-backup',{})
   end
   def restore_backup
      self.link.send('restore-backup',{})
   end

   # node
   def get_node_xml
      return self.link.send('get-node',{})
   end
   def get_node()
      result = []
      reply = self.link.send('get-node',{})
      reply.root.elements.each do |x|
         node = x.attribute('node').to_s
         result.push(node)
      end   
      return result
   end
   def add_node(node)
      self.link.send('add-node',{'node'=>node})
   end
   def remove_node(value)
      self.link.send('remove-node',{'index'=>value})
   end

   # penalty
   def get_penalty_xml
      return self.link.send('get-penalty',{})
   end
   def get_penalty
      result = Hash.new(0)
      reply = self.link.send('get-penalty',{})
      reply.root.elements.each do |x|
         constraint = x.attribute('constraint').to_s
         penalty = x.attribute('penalty').to_s.to_i
         result[constraint]=penalty
      end
      return result
   end
   def add_penalty(constraint,penalty)
      self.link.send('add-penalty',{'constraint'=>constraint,'penalty'=>penalty})
   end
   def remove_penalty(index)
      self.link.send('remove-penalty',{'index'=>index})
   end   
   
   # classroom
   def get_classroom_xml
      return self.link.send('get-classroom',{})
   end
   def get_classroom()
      result = []
      reply = self.link.send('get-classroom',{})
      reply.root.elements.each do |x|
         name = x.attribute('name').to_s
         capacity = x.attribute('capacity').to_s.to_i
         location = x.attribute('location').to_s
         result.push(ClassRoom.new(name,capacity,location))
      end   
      return result
   end
   def add_classroom(classroom)
      name = classroom.get_name
      capacity = classroom.get_capacity.to_s
      location = classroom.get_location
      self.link.send('add-classroom',{'name'=>name,'capacity'=>capacity,'location'=>location})
   end
   def remove_classroom(value)
      self.link.send('remove-classroom',{'index'=>value})
   end

   # teacher
   def get_teacher_xml
      return self.link.send('get-teacher',{})
   end
   def get_teacher()
      result = []
      reply = self.link.send('get-teacher',{})
      reply.root.elements.each do |x|
         name = x.attribute('name').to_s
         result.push(name)
      end   
      return result
   end
   def add_teacher(name)
      self.link.send('add-teacher',{'name'=>name})
   end
   def remove_teacher(value)
      self.link.send('remove-teacher',{'index'=>value})
   end

   # direction 
   def get_direction_xml
      return self.link.send('get-direction',{})
   end
   def get_direction()
      result = []
      reply = self.link.send('get-direction',{})
      reply.root.elements.each do |x|
         name = x.attribute('name').to_s
         result.push(name)
      end   
      return result
   end
   def add_direction(name)
      self.link.send('add-direction',{'name'=>name})
   end
   def remove_direction(value)
      self.link.send('remove-direction',{'index'=>value})
   end

   # electivegroup 
   def get_electivegroup_xml
      return self.link.send('get-electivegroup',{})
   end
   def get_electivegroup()
      result = []
      reply = self.link.send('get-electivegroup',{})
      reply.root.elements.each do |x|
         name = x.attribute('name').to_s
         result.push(name)
      end   
      return result
   end
   def add_electivegroup(name)
      self.link.send('add-electivegroup',{'name'=>name})
   end
   def remove_electivegroup(value)
      self.link.send('remove-electivegroup',{'index'=>value})
   end

   # course 
   def get_course_xml
      return self.link.send('get-course',{})
   end
   def get_course()
      result = []
      reply = self.link.send('get-course',{})
      reply.root.elements.each do |x|
         name = x.attribute('name').to_s
         result.push(name)
      end   
      return result
   end
   def add_course(name)
      self.link.send('add-course',{'name'=>name})
   end
   def remove_course(value)
      self.link.send('remove-course',{'index'=>value})
   end

   # timeslot
   def get_timeslot_xml
      return self.link.send('get-timeslot',{})
   end
   def get_timeslot()
      result = []
      reply = self.link.send('get-timeslot',{})
      reply.root.elements.each do |x|
         day = x.attribute('day').to_s
         start = x.attribute('start').to_s
         stop = x.attribute('stop').to_s
         result.push(TimeSlot.new(day,start,stop))
      end   
      return result
   end
   def add_timeslot(timeslot)
      day = timeslot.get_day
      start = timeslot.get_start
      stop = timeslot.get_stop
      self.link.send('add-timeslot',{'day'=>day,'start'=>start,'stop'=>stop})
   end
   def remove_timeslot(value)
      self.link.send('remove-timeslot',{'index'=>value})
   end

   # course meeting
   def get_course_meeting_xml
      return self.link.send('get-course-meeting',{})
   end
   def get_course_meeting()
      result = Hash.new
      reply = self.link.send('get-course-meeting',{})
      reply.root.elements.each do |x|
         index = x.attribute('index').to_s
         course = x.attribute('course').to_s
         teacher = x.attribute('teacher').to_s
         direction = x.attribute('direction').to_s
         electivegroup = x.attribute('electivegroup').to_s
         compulsory_text = x.attribute('compulsory').to_s
         persons = x.attribute('persons').to_s
         compulsory = false
         if compulsory_text == 'ja' then compulsory = true end
         result[index]=CourseMeeting.new(course,teacher,direction,electivegroup,compulsory,persons)
      end   
      return result
   end
   def add_course_meeting(course_meeting)
      course = course_meeting.get_course()
      teacher = course_meeting.get_teacher()
      direction = course_meeting.get_direction()
      electivegroup = course_meeting.get_electivegroup()
      compulsory = course_meeting.get_compulsory()
      persons = course_meeting.get_persons()
      self.link.send('add-course-meeting',{'course'=>course,'teacher'=>teacher,'direction'=>direction,'electivegroup'=>electivegroup,'compulsory'=>compulsory,'persons'=>persons})
   end
   def remove_course_meeting(value)
      self.link.send('remove-course-meeting',{'index'=>value})
   end

   # teacher timeslot 
   def get_teacher_timeslot_xml
      return self.link.send('get-teacher-timeslot',{})
   end
   def get_teacher_timeslot()
      result = Hash.new
      reply = self.link.send('get-teacher-timeslot',{})
      reply.root.elements.each do |x|
         teacher = x.attribute('teacher').to_s
         timeslot = x.attribute('timeslot').to_s
         score = x.attribute('score').to_s.to_i
         if !result.has_key?(teacher) then
            result[teacher]=Hash.new
         end
         result[teacher.to_s][timeslot.to_s]=score
      end   
      return result
   end
   def remove_teacher_timeslot(value)
      self.link.send('remove-teacher-timeslot',{'index'=>value})
   end
   def add_teacher_timeslot(teacher,timeslot,score)
      self.link.send('add-teacher-timeslot',{'teacher'=>teacher,'timeslot'=>timeslot,'score'=>score})
   end
   
   # required classroom
   def get_required_classroom_xml
      return self.link.send('get-required-classroom',{})
   end   
   def get_required_classroom()
      result = Hash.new
      reply = self.link.send('get-required-classroom',{})
      reply.root.elements.each do |x|
         course = x.attribute('course').to_s
         classroom = x.attribute('classroom').to_s
         index = x.attribute('index').to_s
         if !result.has_key?(course) then
            result[course]=[]
         end
         result[course].push(classroom)
      end   
      return result
   end
   def remove_required_classroom(index)
      self.link.send('remove-required-classroom',{'index'=>index})
   end
   def add_required_classroom(course,classroom)
      self.link.send('add-required-classroom',{'course'=>course,'classroom'=>classroom})
   end
   
   # restricted course
   def get_restricted_course_xml
      return self.link.send('get-restricted-course',{})
   end   
   def get_restricted_course()
      result = Hash.new
      reply = self.link.send('get-restricted-course',{})
      reply.root.elements.each do |x|
         classroom = x.attribute('classroom').to_s
         course = x.attribute('course').to_s
         if !result.has_key?(classroom) then
            result[classroom]=[]
         end
         result[classroom].push(course)
      end   
      return result
   end
   def remove_restricted_course(index)
      self.link.send('remove-restricted-course',{'index'=>index})
   end
   def add_restricted_course(classroom,course)
      self.link.send('add-restricted-course',{'course'=>course,'classroom'=>classroom})
   end

   # restricted timeslot
   def get_restricted_timeslot_xml
      return self.link.send('get-restricted-timeslot',{})
   end   
   def get_restricted_timeslot()
      result = Hash.new
      reply = self.link.send('get-restricted-timeslot',{})
      reply.root.elements.each do |x|
         direction = x.attribute('direction').to_s
         timeslot = x.attribute('timeslot').to_s
         if !result.has_key?(direction) then
            result[direction]=[]
         end
         result[direction].push(timeslot)
      end   
      return result
   end
   def remove_restricted_timeslot(index)
      self.link.send('remove-restricted-timeslot',{'index'=>index})
   end
   def add_restricted_timeslot(direction,timeslot)
      self.link.send('add-restricted-timeslot',{'direction'=>direction,'timeslot'=>timeslot})
   end

   # course student
   def get_group_student_xml
      return self.link.send('get-group-student',{})
   end   
   def get_group_student()
      result = Hash.new
      reply = self.link.send('get-group-student',{})
      reply.root.elements.each do |x|
         group = x.attribute('group').to_s
         student = x.attribute('student').to_s.to_i
         result[group]=student
      end   
      return result
   end
   def remove_group_student(index)
      self.link.send('remove-group-student',{'index'=>index})
   end
   def add_group_student(group,student)
      self.link.send('add-group-student',{'group'=>group,'student'=>student})
   end

   # classroom unavailable
   def get_classroom_unavailable_xml
      return self.link.send('get-classroom-unavailable',{})
   end   
   def get_classroom_unavailable()
      result = Hash.new
      reply = self.link.send('get-classroom-unavailable',{})
      reply.root.elements.each do |x|
         classroom = x.attribute('classroom').to_s
         timeslot = x.attribute('timeslot').to_s
         if !result.has_key?(classroom) then
            result[classroom]=[]
         end
         result[classroom].push(timeslot.to_s)
      end   
      return result
   end
   def remove_classroom_unavailable(index)
      self.link.send('remove-classroom-unavailable',{'index'=>index})
   end
   def add_classroom_unavailable(classroom,timeslot)
      self.link.send('add-classroom-unavailable',{'classroom'=>classroom,'timeslot'=>timeslot})
   end

   # teacher
   def get_teacher_xml
      return self.link.send('get-teacher',{})
   end

   # course
   def get_course_xml
      return self.link.send('get-course',{})
   end

   # direction
   def get_direction_xml
      return self.link.send('get-direction',{})
   end

   # constraint
   def get_constraint_xml
      return self.link.send('get-constraint',{})
   end   

   def to_s
      return 'data manager'
   end
end
