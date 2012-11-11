class StorageManager < AbstractManager
   def initialize(db_host,db_name,db_user,db_pasw)
      super('storage-manager.log')
      @db_host = db_host
      @db_name = db_name
      @db_user = db_user
      @db_pasw = db_pasw
      @backup_counter = 0
   end
   def handle(socket)
   begin
      request = Request.new socket
      self.info(request.to_s)
      case request.get_attribute('operation')
         # password
         when 'get-password' then self.get_password(socket,request)
         when 'set-password' then self.set_password(socket,request)
         # user
         when 'get-user' then self.get_user(socket,request)
         when 'get-usertype' then self.get_usertype(socket,request)
         when 'add-user' then self.add_user(socket,request)
         when 'remove-user' then self.remove_user(socket,request)
         # classroom
         when 'get-classroom' then self.get_classroom(socket,request)
         when 'remove-classroom' then self.remove_classroom(socket,request)
         when 'add-classroom' then self.add_classroom(socket,request)
         # elective groups
         when 'get-electivegroup' then self.get_electivegroup(socket,request)
         when 'remove-electivegroup' then self.remove_electivegroup(socket,request)
         when 'add-electivegroup' then self.add_electivegroup(socket,request)
         # penalty
         when 'get-penalty' then self.get_penalty(socket,request)
         when 'remove-penalty' then self.remove_penalty(socket,request)
         when 'add-penalty' then self.add_penalty(socket,request)
         # node 
         when 'get-node' then self.get_node(socket,request)
         when 'remove-node' then self.remove_node(socket,request)
         when 'add-node' then self.add_node(socket,request)
         # timeslot
         when 'get-timeslot' then self.get_timeslot(socket,request)
         when 'add-timeslot' then self.add_timeslot(socket,request)
         when 'remove-timeslot' then self.remove_timeslot(socket,request)
         # course meeting
         when 'get-course-meeting' then self.get_course_meeting(socket,request)
         when 'add-course-meeting' then self.add_course_meeting(socket,request)
         when 'remove-course-meeting' then self.remove_course_meeting(socket,request)
         # teacher timeslot
         when 'get-teacher-timeslot' then self.get_teacher_timeslot(socket,request)
         when 'add-teacher-timeslot' then self.add_teacher_timeslot(socket,request)
         when 'remove-teacher-timeslot' then self.remove_teacher_timeslot(socket,request)
         # required classroom
         when 'get-required-classroom' then self.get_required_classroom(socket,request)
         when 'add-required-classroom' then self.add_required_classroom(socket,request)
         when 'remove-required-classroom' then self.remove_required_classroom(socket,request)
         # restricted course
         when 'get-restricted-course' then self.get_restricted_course(socket,request)
         when 'add-restricted-course' then self.add_restricted_course(socket,request)
         when 'remove-restricted-course' then self.remove_restricted_course(socket,request)
         # restricted timeslot
         when 'get-restricted-timeslot' then self.get_restricted_timeslot(socket,request)
         when 'add-restricted-timeslot' then self.add_restricted_timeslot(socket,request)
         when 'remove-restricted-timeslot' then self.remove_restricted_timeslot(socket,request)
         # course student
         when 'get-group-student' then self.get_group_student(socket,request)
         when 'add-group-student' then self.add_group_student(socket,request)
         when 'remove-group-student' then self.remove_group_student(socket,request)
         # classroom unavailable
         when 'get-classroom-unavailable' then self.get_classroom_unavailable(socket,request)
         when 'add-classroom-unavailable' then self.add_classroom_unavailable(socket,request)
         when 'remove-classroom-unavailable' then self.remove_classroom_unavailable(socket,request)
         # backups
         when 'create-backup' then self.create_backup(socket,request)
         when 'restore-backup' then self.restore_backup(socket,request)
         # teacher
         when 'get-teacher' then self.get_teacher(socket,request)
         when 'add-teacher' then self.add_teacher(socket,request)
         when 'remove-teacher' then self.remove_teacher(socket,request)
         # course
         when 'get-course' then self.get_course(socket,request)
         when 'add-course' then self.add_course(socket,request)
         when 'remove-course' then self.remove_course(socket,request)
         # direction
         when 'get-direction' then self.get_direction(socket,request)
         when 'add-direction' then self.add_direction(socket,request)
         when 'remove-direction' then self.remove_direction(socket,request)
         # constraint
         when 'get-constraint' then self.get_constraint(socket,request)
         # unknown
         else self.unknown_request(socket)
      end   
   rescue
      self.xml_error(socket)
      self.error('cannot execute request')
   end
   end
   def execute(query) 
      self.info(query.to_s)
      connection = Mysql.real_connect(@db_host, @db_user, @db_pasw, @db_name)
      result = connection.query(query)
      connection.close
      return result
   end
   def create_backup(socket,request)
      @backup_counter += 1
      backupname = "db-backup-#{@backup_counter}.sql"
      `mysqldump -u #{@db_user} #{@db_name} --password=#{@db_pasw} > #{backupname}`
      self.ok(socket)
   end
   def restore_backup(socket,request)
      if !(@backup_counter == 0) then
         backupname = "db-backup-#{@backup_counter}.sql"
         `mysql -u #{@db_user} #{@db_name} --password=#{@db_pasw} < #{backupname}`
         self.ok(socket)
      end
   end
   def unknown_request(socket)
      self.xml_error(socket)
   end
   def ok(socket)
      socket.puts(REXML::Document.new.add_element('OK').to_s)
   end
   def xml_error(socket)
      socket.puts(REXML::Document.new.add_element('ERROR').to_s)
   end
   # passwords
   def get_password(socket,request)
      # parameters
      username = request.get_attribute('username').to_s
      # fetch from database
      result = self.execute("select Password from SystemAccounts where Username = '#{username}'")
      password = result.fetch_row[0].to_s
      # compose reply
      doc = REXML::Document.new
      result = doc.add_element('password')
      result.add_attribute('username',username)
      result.add_attribute('password',password)
      # send reply
      puts 'sending: ' + doc.to_s
      socket.puts doc.to_s
   end
   def set_password(socket,request)
      username = request.get_attribute('username').to_s
      password = request.get_attribute('password').to_s
      self.execute("update SystemAccounts set Password = '#{password}' where Username = '#{username}'")
      self.ok(socket)
   end

   # user
   def remove_user(socket,request)
      index = request.get_attribute('index')
      puts("delete from SystemAccounts where Id = '#{index}'")
      self.execute("delete from SystemAccounts where Id = '#{index}'")
      socket.puts(REXML::Document.new.add_element('OK').to_s)
   end
   def get_usertype(socket,request)
      username = request.get_attribute('username').to_s
      reply = self.execute("select Usertype from SystemAccounts where Username = '#{username}'")
      usertype = reply.fetch_row[0].to_s
      puts 'usertype: ' + usertype   
      doc = REXML::Document.new
      result = doc.add_element('usertype')
      result.add_attribute('username',username)
      result.add_attribute('usertype',usertype)
      socket.puts doc.to_s
   end
   def add_user(socket,request)
      username = request.get_attribute('username').to_s
      usertype = request.get_attribute('usertype').to_s
      password = request.get_attribute('password').to_s
      self.execute("insert into SystemAccounts (Id,Username,Usertype,Password) values (NULL,'#{username}','#{usertype}','#{password}')")
      self.ok(socket)
   end
   def get_user(socket,request)
      result = self.execute("select * from SystemAccounts")
      doc = REXML::Document.new
      doc.add_element('ACCOUNTS')
      while row = result.fetch_row do 
         item = doc.root.add_element('ACCOUNT')
         item.add_attribute('index',row[0])
         item.add_attribute('username',row[1])
         item.add_attribute('usertype',row[2])
      end
      socket.puts doc.to_s
   end
   
   # teacher
   def add_teacher(socket,request)
      name = request.get_attribute('name').to_s
      self.execute("insert into DataSchoolTeachers (Id,Name) values (NULL,'#{name}')")
      self.ok(socket)
   end
   def remove_teacher(socket,request)
      index = request.get_attribute('index')
      self.execute("delete from DataSchoolTeachers where Id = '#{index}'")
      self.ok(socket)
   end
   def get_teacher(socket,request)
      result = self.execute('select * from DataSchoolTeachers')
      doc = REXML::Document.new
      doc.add_element('TEACHERS')
      while row = result.fetch_row do
         item = doc.root.add_element('TEACHER')
         item.add_attribute('index',row[0])
         item.add_attribute('name',row[1])
      end
      socket.puts doc.to_s
   end

   # course
   def add_course(socket,request)
      name = request.get_attribute('name').to_s
      self.execute("insert into DataSchoolCourses (Id,Name) values (NULL,'#{name}')")
      self.ok(socket)
   end
   def remove_course(socket,request)
      index = request.get_attribute('index')
      self.execute("delete from DataSchoolCourses where Id = '#{index}'")
      self.ok(socket)
   end
   def get_course(socket,request)
      result = self.execute('select * from DataSchoolCourses')
      doc = REXML::Document.new
      doc.add_element('COURSES')
      while row = result.fetch_row do
         item = doc.root.add_element('COURSE')
         item.add_attribute('index',row[0])
         item.add_attribute('name',row[1])
      end
      socket.puts doc.to_s
   end   
   
   # direction
   def add_direction(socket,request)
      name = request.get_attribute('name').to_s
      self.execute("insert into DataSchoolDirections (Id,Name) values (NULL,'#{name}')")
      self.ok(socket)
   end
   def remove_direction(socket,request)
      index = request.get_attribute('index')
      self.execute("delete from DataSchoolDirections where Id = '#{index}'")
      self.ok(socket)
   end
   def get_direction(socket,request)
      result = self.execute('select * from DataSchoolDirections')
      doc = REXML::Document.new
      doc.add_element('DIRECTIONS')
      while row = result.fetch_row do 
         item = doc.root.add_element('DIRECTION')
         item.add_attribute('index',row[0])
         item.add_attribute('name',row[1])
      end
      socket.puts doc.to_s
   end

   # electivegroup 
   def add_electivegroup(socket,request)
      name = request.get_attribute('name').to_s
      self.execute("insert into DataSchoolElectivegroups (Id,Name) values (NULL,'#{name}')")
      self.ok(socket)
   end
   def remove_electivegroup(socket,request)
      index = request.get_attribute('index')
      self.execute("delete from DataSchoolElectivegroups where Id = '#{index}'")
      self.ok(socket)
   end
   def get_electivegroup(socket,request)
      result = self.execute('select * from DataSchoolElectivegroups')
      doc = REXML::Document.new
      doc.add_element('ELECTIVEGROUPS')
      while row = result.fetch_row do 
         item = doc.root.add_element('ELECTIVEGROUP')
         item.add_attribute('index',row[0])
         item.add_attribute('name',row[1])
      end
      socket.puts doc.to_s
   end
   
   # constraints
   def get_constraint(socket,request)
      result = self.execute('select `Id`, `Constraint` from DataConstraintsPenalties')
      doc = REXML::Document.new
      doc.add_element('CONSTRAINTS')
      while row = result.fetch_row do
         item = doc.root.add_element('CONSTRAINT')
         item.add_attribute('id',row[0])
         item.add_attribute('constraint',row[1])
      end
      socket.puts doc.to_s
   end
    
   # penalty
   def remove_penalty(socket,request)
      index = request.get_attribute('index')
      self.execute("delete from DataConstraintsPenalties where Id = '#{index}'")
      self.ok(socket)
   end
   def add_penalty(socket,request)
      constraint = request.get_attribute('constraint').to_s
      penalty = request.get_attribute('penalty').to_s
      self.execute("insert into DataConstraintsPenalties (`Id`,`Constraint`,`Penalty`) values (NULL,'#{constraint}','#{penalty}')")
      self.ok(socket)
   end
   def get_penalty(socket,request)
      result = self.execute("select * from DataConstraintsPenalties")
      doc = REXML::Document.new
      doc.add_element('PENALTIES')
      while row = result.fetch_row do 
         item = doc.root.add_element('PENALTY')
         item.add_attribute('index',row[0])
         item.add_attribute('constraint',row[1])
         item.add_attribute('penalty',row[2])
      end
      socket.puts doc.to_s
   end

   # node
   def remove_node(socket,request)
      index = request.get_attribute('index')
      self.execute("delete from SystemNodes where Id = '#{index}'")
      self.ok(socket)
   end
   def add_node(socket,request)
      node = request.get_attribute('node').to_s
      self.execute("insert into SystemNodes (Id,Name) values (NULL,'#{node}')")
      self.ok(socket)
   end
   def get_node(socket,request)
      result = self.execute("select * from SystemNodes")
      doc = REXML::Document.new
      doc.add_element('CLUSTER-NODES')
      while row = result.fetch_row do 
         item = doc.root.add_element('CLUSTER-NODE')
         item.add_attribute('index',row[0])
         item.add_attribute('node',row[1])
      end
      socket.puts doc.to_s
   end

   # classroom
   def remove_classroom(socket,request)
      index = request.get_attribute('index')
      self.execute("delete from DataSchoolClassrooms where Id = '#{index}'")
      self.ok(socket)
   end
   def add_classroom(socket,request)
      name = request.get_attribute('name').to_s
      capacity = request.get_attribute('capacity').to_s
      location = request.get_attribute('location').to_s
      self.execute("insert into DataSchoolClassrooms (`Id`,`Name`,`Capacity`,`Location`) values (NULL,'#{name}','#{capacity}','#{location}')")
      self.ok(socket)
   end
   def get_classroom(socket,request)
      result = self.execute("select * from DataSchoolClassrooms")
      doc = REXML::Document.new
      doc.add_element('CLASSROOMS')
      while row = result.fetch_row do 
         item = doc.root.add_element('CLASSROOM')
         item.add_attribute('index',row[0])
         item.add_attribute('name',row[1])
         item.add_attribute('capacity',row[2])
         item.add_attribute('location',row[3])
      end
      socket.puts doc.to_s
   end

   # timeslot
   def remove_timeslot(socket,request)
      index = request.get_attribute('index')
      self.execute("delete from DataSchoolTimeslots where Id = '#{index}'")
      self.ok(socket)
   end
   def get_timeslot(socket,request)
      result = self.execute("select * from DataSchoolTimeslots")
      doc = REXML::Document.new
      doc.add_element('TIMESLOTS')
      while row = result.fetch_row do 
         item = doc.root.add_element('TIMESLOT')
         item.add_attribute('index',row[0])
         item.add_attribute('day',row[1])
         item.add_attribute('start',row[2])
         item.add_attribute('stop',row[3])
      end
      socket.puts doc.to_s
   end
   def add_timeslot(socket,request)
      start = request.get_attribute('start').to_s
      stop = request.get_attribute('stop').to_s
      day = request.get_attribute('day').to_s
      self.execute("insert into DataSchoolTimeslots (Id,Day,Start,Stop) values (NULL,'#{day}','#{start}','#{stop}')")
      self.ok(socket)
   end
   
   # course meeting
   def get_course_meeting(socket,request)
      result = self.execute("select * from DataSchoolCoursemeetings, DataSchoolCourses, DataSchoolTeachers, DataSchoolElectivegroups, DataSchoolDirections where CourseId = DataSchoolCourses.Id and TeacherId = DataSchoolTeachers.Id and ElectivegroupId = DataSchoolElectivegroups.Id and DirectionId = DataSchoolDirections.Id")
      doc = REXML::Document.new
      doc.add_element('COURSE-MEETINGS')
      while row = result.fetch_row do 
         item = doc.root.add_element('COURSE-MEETING')
         item.add_attribute('index',row[0])
         item.add_attribute('course_index',row[1])
         item.add_attribute('teacher_index',row[2])
         item.add_attribute('direction_index',row[3])
         item.add_attribute('electivegroup_index',row[4])
         item.add_attribute('compulsory',row[5])
         item.add_attribute('persons',row[6])
         item.add_attribute('course',row[8])
         item.add_attribute('teacher',row[10])
         item.add_attribute('electivegroup',row[12])
         item.add_attribute('direction',row[14])
      end
      puts doc.to_s
      socket.puts doc.to_s
   end

   def add_course_meeting(socket,request)
      course = request.get_attribute('course').to_s
      teacher = request.get_attribute('teacher').to_s
      direction = request.get_attribute('direction').to_s
      electivegroup = request.get_attribute('electivegroup').to_s
      compulsory = request.get_attribute('compulsory').to_s
      persons = request.get_attribute('persons').to_s
      self.execute("insert into DataSchoolCoursemeetings (`Id`,`CourseId`,`TeacherId`,`DirectionId`,`ElectivegroupId`,`Compulsory`,`Persons`) values (NULL,'#{course}','#{teacher}','#{direction}','#{electivegroup}','#{compulsory}','#{persons}')")
      doc = REXML::Document.new
      doc.add_element('OK')
      socket.puts doc.to_s
   end
   def remove_course_meeting(socket,request)
      id = request.get_attribute('index')
      self.execute("delete from DataSchoolCoursemeetings where Id = '#{id}'")
      self.ok(socket)
   end

   # teacher timeslot 
   def get_teacher_timeslot(socket,request)
      result = self.execute("select * from DataConstraintsTeacherTimeslots, DataSchoolTimeslots, DataSchoolTeachers where TimeslotId = DataSchoolTimeslots.Id and TeacherId = DataSchoolTeachers.Id")
      doc = REXML::Document.new
      doc.add_element('TEACHER-TIMESLOTS')
      while row = result.fetch_row do 
         item = doc.root.add_element('TEACHER-TIMESLOT')
         item.add_attribute('index',row[0])
         item.add_attribute('teacher_index',row[1])
         item.add_attribute('timeslot_index',row[2])
         item.add_attribute('score',row[3])
         item.add_attribute('day',row[5])
         item.add_attribute('start',row[6])
         item.add_attribute('stop',row[7])
         item.add_attribute('teacher',row[9])
      end
      socket.puts doc.to_s
   end
   def add_teacher_timeslot(socket,request)
      teacher = request.get_attribute('teacher').to_s
      score = request.get_attribute('score').to_s
      timeslot = request.get_attribute('timeslot').to_s
      self.execute("insert into DataConstraintsTeacherTimeslots (Id,TeacherId,TimeslotId,Score) values (NULL,'#{teacher}','#{timeslot}','#{score}')")
      self.ok(socket)
   end
   def remove_teacher_timeslot(socket,request)
      index = request.get_attribute('index')
      self.execute("delete from DataConstraintsTeacherTimeslots where Id = '#{index}'")
      self.ok(socket)
   end
   # required classroom
   def get_required_classroom(socket,request)
      result = self.execute("select * from DataConstraintsRequiredClassrooms, DataSchoolCourses, DataSchoolClassrooms where CourseId = DataSchoolCourses.Id and ClassroomId = DataSchoolClassrooms.Id") 
      doc = REXML::Document.new
      doc.add_element('REQUIRED-CLASSROOMS')
      while row = result.fetch_row do 
         item = doc.root.add_element('REQUIRED-CLASSROOM')
         item.add_attribute('index',row[0])
         item.add_attribute('course_index',row[1])
         item.add_attribute('classroom_index',row[2])
         item.add_attribute('course',row[4])
         item.add_attribute('classroom',row[6])
      end
      socket.puts doc.to_s
   end
   def add_required_classroom(socket,request)
      course = request.get_attribute('course').to_s
      classroom = request.get_attribute('classroom').to_s
      self.execute("insert into DataConstraintsRequiredClassrooms (Id,CourseId,ClassroomId) values (NULL,'#{course}','#{classroom}')")
      self.ok(socket)
   end
   def remove_required_classroom(socket,request)
      index = request.get_attribute('index')
      self.execute("delete from DataConstraintsRequiredClassrooms where Id = '#{index}'")
      self.ok(socket)
   end
   # restricted courses
   def get_restricted_course(socket,request)
      result = self.execute("select * from DataConstraintsRestrictedCourses, DataSchoolClassrooms, DataSchoolCourses where ClassroomId = DataSchoolClassrooms.Id and CourseId = DataSchoolCourses.Id")
      doc = REXML::Document.new
      doc.add_element('RESTRICTED-COURSES')
      while row = result.fetch_row do 
         item = doc.root.add_element('RESTRICTED-COURSE')
         item.add_attribute('index',row[0])
         item.add_attribute('classroom_index',row[1])
         item.add_attribute('course_index',row[2])
         # row 3: classroom id
         item.add_attribute('classroom',row[4])
         # row 5: course id
         item.add_attribute('course',row[6])
      end
      socket.puts doc.to_s
   end
   def add_restricted_course(socket,request)
      classroom = request.get_attribute('classroom').to_s
      course = request.get_attribute('course').to_s
      self.execute("insert into DataConstraintsRestrictedCourses (Id,ClassroomId,CourseId) values (NULL,'#{classroom}','#{course}')")
      self.ok(socket)
   end
   def remove_restricted_course(socket,request)
      index = request.get_attribute('index')
      self.execute("delete from DataConstraintsRestrictedCourses where Id = '#{index}'")
      self.ok(socket)
   end
   # restricted timeslot 
   def get_restricted_timeslot(socket,request)
      result = self.execute("select * from DataConstraintsRestrictedTimeslots, DataSchoolDirections, DataSchoolTimeslots where DirectionId =  DataSchoolDirections.Id and TimeslotId = DataSchoolTimeslots.Id")
      doc = REXML::Document.new
      doc.add_element('RESTRICTED-TIMESLOTS')
      while row = result.fetch_row do 
         item = doc.root.add_element('RESTRICTED-TIMESLOTS')
         item.add_attribute('index',row[0])
         item.add_attribute('direction_id',row[1])
         item.add_attribute('timeslot_id',row[2])
         # row 3: direction id
         item.add_attribute('direction',row[4])
         # row 5: timeslot id
         item.add_attribute('day',row[6])
         item.add_attribute('start',row[7])
         item.add_attribute('stop',row[8])
      end
      puts doc.to_s
      socket.puts doc.to_s
   end
   def add_restricted_timeslot(socket,request)
      direction = request.get_attribute('direction').to_s
      timeslot = request.get_attribute('timeslot').to_s
      self.execute("insert into DataConstraintsRestrictedTimeslots (`Id`,`DirectionId`,`TimeslotId`) values (NULL,'#{direction}','#{timeslot}')")
      self.ok(socket)
   end
   def remove_restricted_timeslot(socket,request)
      index = request.get_attribute('index')
      self.execute("delete from DataConstraintsRestrictedTimeslots where Id = '#{index}'")
      self.ok(socket)
   end
   # classroom unavailable 
   def get_classroom_unavailable(socket,request)
      result = self.execute("select * from DataConstraintsClassroomsUnavailable, DataSchoolClassrooms, DataSchoolTimeslots where ClassroomId = DataSchoolClassrooms.Id and TimeslotId = DataSchoolTimeslots.Id")
      doc = REXML::Document.new
      doc.add_element('ALL-CLASSROOM-UNAVAILABLE')
      while row = result.fetch_row do 
         item = doc.root.add_element('CLASSROOM-UNAVAILABLE')
         item.add_attribute('index',row[0])
         item.add_attribute('classroom_index',row[1])
         item.add_attribute('timeslot_index',row[2])
         # row 3: classroom index
         item.add_attribute('classroom',row[4])
         # row 5: classroom capacity
         # row 6: classroom location
         # row 7: timeslot index
         item.add_attribute('day',row[8])
         item.add_attribute('start',row[9])
         item.add_attribute('stop',row[10])
      end
      socket.puts doc.to_s
   end
   def add_classroom_unavailable(socket,request)
      classroom = request.get_attribute('classroom').to_s
      timeslot = request.get_attribute('timeslot').to_s
      self.execute("insert into DataConstraintsClassroomsUnavailable (Id,ClassroomId,TimeslotId) values (NULL,'#{classroom}','#{timeslot}')")
      self.ok(socket)
   end
   def remove_classroom_unavailable(socket,request)
      index = request.get_attribute('index')
      self.execute("delete from DataConstraintsClassroomsUnavailable where Id = '#{index}'")
      self.ok(socket)
   end
end


