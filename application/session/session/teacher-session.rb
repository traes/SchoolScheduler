class TeacherSession < AbstractSession
   def initialize(id,user)
      controller = TeacherSessionController.new
      viewer = TeacherSessionViewer.new
      super(id,user,controller,viewer)
   end
   def execute(command,application)
      controller = self.get_controller
      viewer = self.get_viewer
      case command.get_attribute('type')
         # change password
         when 'change_password' then controller.change_password(application,command)
         # timeslots
         when 'view_timeslot' then viewer.view_timeslot(application)
         # style
         when 'get_style' then viewer.get_style(application)
         # directions
         when 'view_direction' then viewer.view_direction(application)
         # homepage
         when 'get_homepage' then viewer.get_homepage_xml(application)
         # teachers
         when 'view_teacher' then viewer.view_teacher(application)
         # schedule
         when 'view_schedule_teacher' then viewer.view_schedule_teacher(application,command)
         # teacher timeslot 
         when 'view_teacher_timeslot' then viewer.view_teacher_timeslot(application)
         when 'remove_teacher_timeslot' then controller.remove_teacher_timeslot(application,command)
         when 'add_teacher_timeslot' then controller.add_teacher_timeslot(application,command)

         else self.unknown_command(command.get_attribute('type'))
      end   
   end
end
