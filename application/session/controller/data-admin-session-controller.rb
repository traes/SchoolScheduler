class DataAdminSessionController < AbstractSessionController
   ### manage schedule ###
   def generate_schedule(application)
      Thread.new do
         schedule_manager = application.get_schedule_manager
         schedule_manager.generate
      end
      result = Result.new
      result.set_attribute('type','generate_schedule')
      return result
   end
   ### manage teacher timeslot constraint data ###
   def remove_teacher_timeslot(application,command)
      index = command.get_attribute('index')
      data_manager = application.get_data_manager
      data_manager.remove_teacher_timeslot(index)
      doc = REXML::Document.new
      doc.add_element('OK')
      return doc
   end
   def add_teacher_timeslot(application,command)
      teacher = command.get_attribute('teacher').to_s
      timeslot = command.get_attribute('timeslot').to_s
      score = command.get_attribute('score').to_s
      data_manager = application.get_data_manager
      data_manager.add_teacher_timeslot(teacher,timeslot,score)
      doc = REXML::Document.new
      doc.add_element('OK')
      return doc
   end
   ### manage unavailable classroom constraint data ###
   def remove_classroom_unavailable(application,command)
      index = command.get_attribute('index')
      data_manager = application.get_data_manager
      data_manager.remove_classroom_unavailable(index)
      doc = REXML::Document.new
      doc.add_element('OK')
      return doc
   end
   def add_classroom_unavailable(application,command)
      classroom = command.get_attribute('classroom').to_s
      timeslot = command.get_attribute('timeslot').to_s
      data_manager = application.get_data_manager
      data_manager.add_classroom_unavailable(classroom,timeslot)
      doc = REXML::Document.new
      doc.add_element('OK')
      return doc
   end
   ### manage restricted timeslot constraint data ###
   def remove_restricted_timeslot(application,command)
      index = command.get_attribute('index').to_s
      data_manager = application.get_data_manager
      data_manager.remove_restricted_timeslot(index)
      doc = REXML::Document.new
      doc.add_element('OK')
      return doc
   end
   def add_restricted_timeslot(application,command)
      direction = command.get_attribute('direction').to_s
      timeslot = command.get_attribute('timeslot').to_s
      data_manager = application.get_data_manager
      data_manager.add_restricted_timeslot(direction,timeslot)
      doc = REXML::Document.new
      doc.add_element('OK')
      return doc
   end
   ### manage restricted course constraint data ###
   def remove_restricted_course(application,command)
      index = command.get_attribute('index').to_s
      data_manager = application.get_data_manager
      data_manager.remove_restricted_course(index)
      doc = REXML::Document.new
      doc.add_element('OK')
      return doc
   end
   def add_restricted_course(application,command)
      classroom = command.get_attribute('classroom').to_s
      course = command.get_attribute('course').to_s
      data_manager = application.get_data_manager
      data_manager.add_restricted_course(classroom,course)
      doc = REXML::Document.new
      doc.add_element('OK')
      return doc
   end
   ### manage required classroom constraint data ###
   def remove_required_classroom(application,command)
      index = command.get_attribute('index').to_s
      data_manager = application.get_data_manager
      data_manager.remove_required_classroom(index)
      doc = REXML::Document.new
      doc.add_element('OK')
      return doc
   end
   def add_required_classroom(application,command)
      course = command.get_attribute('course').to_s
      classroom = command.get_attribute('classroom').to_s
      data_manager = application.get_data_manager
      data_manager.add_required_classroom(course,classroom)
      doc = REXML::Document.new
      doc.add_element('OK')
      return doc
   end
   ### manage classroom ###
   def remove_classroom(application,command)
      index = command.get_attribute('index').to_s
      data_manager = application.get_data_manager
      data_manager.remove_classroom(index)
      return self.ok
   end
   def add_classroom(application,command)
      name = command.get_attribute('name').to_s
      capacity = command.get_attribute('capacity').to_s.to_i
      location = command.get_attribute('location').to_s
      classroom = ClassRoom.new(name,capacity,location) 
      data_manager = application.get_data_manager
      data_manager.add_classroom(classroom)
      return self.ok
   end
   ### manage teachers ###
   def remove_teacher(application,command)
      index = command.get_attribute('index').to_s
      data_manager = application.get_data_manager
      data_manager.remove_teacher(index)
      return self.ok
   end
   def add_teacher(application,command)
      name = command.get_attribute('name').to_s
      data_manager = application.get_data_manager
      data_manager.add_teacher(name)
      return self.ok
   end

   ### manage  direction ###
   def remove_direction(application,command)
      index = command.get_attribute('index').to_s
      data_manager = application.get_data_manager
      data_manager.remove_direction(index)
      return self.ok
   end
   def add_direction(application,command)
      name = command.get_attribute('name').to_s
      data_manager = application.get_data_manager
      data_manager.add_direction(name)
      return self.ok
   end

   ### manage  electivegroup ###
   def remove_electivegroup(application,command)
      index = command.get_attribute('index').to_s
      data_manager = application.get_data_manager
      data_manager.remove_electivegroup(index)
      return self.ok
   end
   def add_electivegroup(application,command)
      name = command.get_attribute('name').to_s
      data_manager = application.get_data_manager
      data_manager.add_electivegroup(name)
      return self.ok
   end
   
   ### manage  electivegroup ###
   def remove_timeslot(application,command)
      index = command.get_attribute('index').to_s
      data_manager = application.get_data_manager
      data_manager.remove_timeslot(index)
      return self.ok
   end
   def add_timeslot(application,command)
      day = command.get_attribute('day').to_s
      start = command.get_attribute('start').to_s.to_i
      stop = command.get_attribute('stop').to_s.to_i
      timeslot = TimeSlot.new(day,start,stop)
      data_manager = application.get_data_manager
      data_manager.add_timeslot(timeslot)
      return self.ok
   end

   ### manage course ###
   def remove_course(application,command)
      index = command.get_attribute('index').to_s
      data_manager = application.get_data_manager
      data_manager.remove_course(index)
      return self.ok
   end
   def add_course(application,command)
      name = command.get_attribute('name').to_s
      data_manager = application.get_data_manager
      data_manager.add_course(name)
      return self.ok
   end

   ### manage penalty ###
   def remove_penalty(application,command)
      index = command.get_attribute('index')
      data_manager = application.get_data_manager
      data_manager.remove_penalty(index)
      return REXML::Document.new.add_element('OK')
   end
   def add_penalty(application,command)
      data_manager = application.get_data_manager
      constraint = command.get_attribute('constraint').to_s
      penalty = command.get_attribute('penalty').to_s
      data_manager.add_penalty(constraint,penalty)
      return REXML::Document.new.add_element('OK')
   end   
   ### manage course meeting ###
   def remove_course_meeting(application,command)
      index = command.get_attribute('index')
      data_manager = application.get_data_manager
      data_manager.remove_course_meeting(index)
      return REXML::Document.new.add_element('OK')
   end
   def add_course_meeting(application,command)
      data_manager = application.get_data_manager
      course = command.get_attribute('course').to_s
      teacher = command.get_attribute('teacher').to_s
      direction = command.get_attribute('direction').to_s
      electivegroup = command.get_attribute('electivegroup').to_s
      compulsory = command.get_attribute('compulsory').to_s
      persons = command.get_attribute('persons').to_s
      course_meeting=CourseMeeting.new(course,teacher,direction,electivegroup,compulsory,persons)
      data_manager.add_course_meeting(course_meeting)
      return REXML::Document.new.add_element('OK')
   end
end
