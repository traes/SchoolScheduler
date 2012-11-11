class TeacherSessionController < AbstractSessionController
   ### manage teacher timeslot constraint data ###
   def remove_teacher_timeslot(application,command)
      index = command.get_attribute('index').to_s
      data_manager = application.get_data_manager
      data_manager.remove_teacher_timeslot(index)
      doc = REXML::Document.new
      doc.add_element('OK')
      return doc
   end
   def add_teacher_timeslot(application,command)
      teacher = command.get_attribute('teacher').to_s
      timeslot_index = command.get_attribute('timeslot').to_s
      score = command.get_attribute('score').to_s
      data_manager = application.get_data_manager
      data_manager.add_teacher_timeslot(teacher,timeslot_index,score)
      return self.ok
   end
end
