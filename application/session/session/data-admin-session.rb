class DataAdminSession < AbstractSession
   def initialize(id,user)
      controller = DataAdminSessionController.new
      viewer = DataAdminSessionViewer.new
      super(id,user,controller,viewer)
   end
   def execute(command,application)
      controller = self.get_controller
      viewer = self.get_viewer
      case command.get_attribute('type')
         # change password
         when 'change_password' then controller.change_password(application,command)
         # style
         when 'get_style' then viewer.get_style(application)
         # homepage
         when 'get_homepage' then viewer.get_homepage_xml(application)
         # penalty
         when 'view_penalty' then viewer.view_penalty(application)
         when 'remove_penalty' then controller.remove_penalty(application,command)
         when 'add_penalty' then controller.add_penalty(application,command)
         # classroom
         when 'view_classroom' then viewer.view_classroom(application)
         when 'remove_classroom' then controller.remove_classroom(application,command)
         when 'add_classroom' then controller.add_classroom(application,command)
         # teachers
         when 'view_teacher' then viewer.view_teacher(application)
         when 'remove_teacher' then controller.remove_teacher(application,command)
         when 'add_teacher' then controller.add_teacher(application,command)
         # course
         when 'view_course' then viewer.view_course(application)
         when 'add_course' then controller.add_course(application,command)
         when 'remove_course' then controller.remove_course(application,command)
         # directions
         when 'view_direction' then viewer.view_direction(application)
         when 'remove_direction' then controller.remove_direction(application,command)
         when 'add_direction' then controller.add_direction(application,command)
         # timeslots
         when 'view_timeslot' then viewer.view_timeslot(application)
         when 'remove_timeslot' then controller.remove_timeslot(application,command)
         when 'add_timeslot' then controller.add_timeslot(application,command)
         # elective groups
         when 'view_electivegroup' then viewer.view_electivegroup(application)
         when 'remove_electivegroup' then controller.remove_electivegroup(application,command)
         when 'add_electivegroup' then controller.add_electivegroup(application,command)
         # constraint
         when 'view_constraint' then viewer.view_constraint(application)
         # course meeting
         when 'view_course_meeting' then viewer.view_course_meeting(application,command)
         when 'remove_course_meeting' then controller.remove_course_meeting(application,command)
         when 'add_course_meeting' then controller.add_course_meeting(application,command)
         # schedule
         when 'view_schedule_direction' then viewer.view_schedule_direction(application,command)
         when 'view_schedule' then viewer.view_schedule(application)
         when 'generate_schedule' then controller.generate_schedule(application)
         # required classroom
         when 'view_required_classroom' then viewer.view_required_classroom(application)
         when 'remove_required_classroom' then controller.remove_required_classroom(application,command)
         when 'add_required_classroom' then controller.add_required_classroom(application,command)
         # restricted course
         when 'view_restricted_course' then viewer.view_restricted_course(application)
         when 'remove_restricted_course' then controller.remove_restricted_course(application,command)
         when 'add_restricted_course' then controller.add_restricted_course(application,command)
         # restricted timeslot
         when 'view_restricted_timeslot' then viewer.view_restricted_timeslot(application)
         when 'remove_restricted_timeslot' then controller.remove_restricted_timeslot(application,command)
         when 'add_restricted_timeslot' then controller.add_restricted_timeslot(application,command)
         # unavailable classroom 
         when 'view_classroom_unavailable' then viewer.view_classroom_unavailable(application)
         when 'remove_classroom_unavailable' then controller.remove_classroom_unavailable(application,command)
         when 'add_classroom_unavailable' then controller.add_classroom_unavailable(application,command)
         # group student
         when 'view_group_student' then viewer.view_group_student(application)
         when 'remove_group_student' then controller.remove_group_student(application,command)
         when 'add_group_student' then controller.add_group_student(application,command)
         # classroom location
         when 'view_classroom_location' then viewer.view_classroom_location(application)
         when 'remove_classroom_location' then controller.remove_classroom_location(application,command)
         when 'add_classroom_location' then controller.add_classroom_location(application,command)
         # classroom capacity
         when 'view_classroom_capacity' then viewer.view_classroom_capacity(application)
         when 'remove_classroom_capacity' then controller.remove_classroom_capacity(application,command)
         when 'add_classroom_capacity' then controller.add_classroom_capacity(application,command)
         # teacher timeslot 
         when 'view_teacher_timeslot' then viewer.view_teacher_timeslot(application)
         when 'remove_teacher_timeslot' then controller.remove_teacher_timeslot(application,command)
         when 'add_teacher_timeslot' then controller.add_teacher_timeslot(application,command)
           # unknown
         else controller.unknown_command(command.get_attribute('type'))
      end   
   end
end
