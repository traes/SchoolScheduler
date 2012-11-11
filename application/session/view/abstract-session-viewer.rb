class AbstractSessionViewer
   def get_homepage_xml(application)
     result = Result.new
     result.set_attribute('homepage',self.get_homepage(application))
     return result
   end
   def get_html_background_color
      return LightGrey 
   end
   def get_form_background_color
      return DarkGrey
   end
   def view_timeslot(application)
      return application.get_data_manager.get_timeslot_xml
   end  
   def view_direction(application)
      return application.get_data_manager.get_direction_xml
   end
   def get_style(application)
      hb = self.get_html_background_color
      fb = self.get_form_background_color
      css = "<STYLE type=\"text/css\"> \
            html{\
               background-color: #{hb};\
            }\
            \
            .ignore{\
               background-color: #{fb};\
            } \
            \
            .data-item \
            {\
              text-align: center;\
              background-color: #{fb};\
              color: black;\
            }\
            .top-item \
            {\
            text-align: center;\
            background-color: #{fb};\
            border: 1px solid black;\
            color: black;\
            }\
            \
            .delete \
            {\
            color: red;\
             background-color: #{fb};\
             text-align: center;\
               }\
            .top\
            {  \
               text-align: center;\
               background-color: #{fb};\
                border: 1px solid black;\
                  color: black; \
            }\
            \
            a\
            {\
            text-decoration: none;\
            color: black;\
            }\
            \
            form\
            {\
               background-color: #{fb};\
               border: 1px solid black;\
               width: 30%;\
            }\
            \
            label\
            {\
               display: block;\
               text-align: left;\
               float: left;\
               width: 4em;\
            }\
         </STYLE>"
      return css
   end
   def view_schedule(application)
      doc = REXML::Document.new
      schedule_manager = application.get_schedule_manager
      doc.add_element('SCHEDULE',{'version'=> schedule_manager.get_version.to_s})
      if schedule_manager.schedule_available? then
         schedule = schedule_manager.get_schedule
         schedule.get_combinations.each do |combination|
            begin
            meeting = doc.root.add_element('MEETING')
            cm = combination.get_consumer.get_value # course meeting
            ms = combination.get_resource.get_value # meeting slot
            timeslot = ms.get_timeslot
            meeting.add_attribute('course',cm.get_course.to_s)
            meeting.add_attribute('teacher',cm.get_teacher.to_s)
            meeting.add_attribute('direction',cm.get_direction.to_s)
            meeting.add_attribute('electivegroup',cm.get_electivegroup.to_s)
            meeting.add_attribute('compulsory',cm.get_compulsory.to_s)
            meeting.add_attribute('persons',cm.get_persons.to_s)
            meeting.add_attribute('day',timeslot.get_day.to_s)
            meeting.add_attribute('start',timeslot.get_start.to_s)
            meeting.add_attribute('stop',timeslot.get_stop.to_s)
            meeting.add_attribute('classroom',ms.get_classroom.get_name.to_s)
            rescue 
               puts 'failed to add elements' 
            end
         end   
      end
      return doc
   end
   def view_schedule_direction(application,command)
      view_direction = command.get_attribute('direction').to_s # the name of the direction
      doc = REXML::Document.new
      schedule_manager = application.get_schedule_manager
      doc.add_element('SCHEDULE',{'version'=> schedule_manager.get_version.to_s})
      if schedule_manager.schedule_available? then
         schedule = schedule_manager.get_schedule
         schedule.get_combinations.each do |combination|
            begin
            cm = combination.get_consumer.get_value # course meeting
            ms = combination.get_resource.get_value # meeting slot
            if cm.get_direction.to_s == view_direction then
               puts 'adding coursemeeting'
               meeting = doc.root.add_element('MEETING')
               timeslot = ms.get_timeslot
               meeting.add_attribute('course',cm.get_course.to_s)
               meeting.add_attribute('teacher',cm.get_teacher.to_s)
               meeting.add_attribute('direction',cm.get_direction.to_s)
               meeting.add_attribute('electivegroup',cm.get_electivegroup.to_s)
               meeting.add_attribute('compulsory',cm.get_compulsory.to_s)
               meeting.add_attribute('persons',cm.get_persons.to_s)
               meeting.add_attribute('day',timeslot.get_day.to_s)
               meeting.add_attribute('start',timeslot.get_start.to_s)
               meeting.add_attribute('stop',timeslot.get_stop.to_s)
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
   def to_s
      return  'abstract session viewer'
   end
end
