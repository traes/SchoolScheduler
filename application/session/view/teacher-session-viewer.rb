class TeacherSessionViewer < AbstractSessionViewer
   def get_homepage(application)
      return 'home-teacher.cgi'
   end
   def get_html_background_color
      return DarkYellow
   end
   def get_form_background_color
      return LightYellow
   end
   # teacher timeslot
   def view_teacher_timeslot(application)
      return application.get_data_manager.get_teacher_timeslot_xml
   end
   def view_teacher(application)
      return application.get_data_manager.get_teacher_xml
   end
   def view_schedule_teacher(application,command)
      view_teacher = command.get_attribute('teacher').to_s
      doc = REXML::Document.new
      schedule_manager = application.get_schedule_manager
      doc.add_element('SCHEDULE',{'version'=> schedule_manager.get_version.to_s})
      if schedule_manager.schedule_available? then
         schedule = schedule_manager.get_schedule
         schedule.combinations.each do |combination|
            begin
            cm = combination.get_consumer.value # course meeting
            ms = combination.get_resource.value # meeting slot
            if cm.get_teacher.to_s == view_teacher then
               puts 'adding coursemeeting'
               meeting = doc.root.add_element('MEETING')
               timeslot = ms.timeslot
               meeting.add_attribute('course',cm.get_course.to_s)
               meeting.add_attribute('teacher',cm.get_teacher.to_s)
               meeting.add_attribute('direction',cm.get_direction.to_s)
               meeting.add_attribute('electivegroup',cm.get_electivegroup.to_s)
               meeting.add_attribute('compulsory',cm.get_compulsory.to_s)
               meeting.add_attribute('persons',cm.get_persons.to_s)
               meeting.add_attribute('day',timeslot.day.to_s)
               meeting.add_attribute('start',timeslot.start.to_s)
               meeting.add_attribute('stop',timeslot.stop.to_s)
               meeting.add_attribute('classroom',ms.get_classroom.get_name.to_s)
            else
               puts 'ignoring coursemeeting'
            end
            rescue 
               puts 'failed to add elements' 
            end
         end   
      end
      return doc
   end


end
