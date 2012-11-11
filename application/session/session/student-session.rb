class StudentSession < AbstractSession
   def initialize(id,user)
      controller = StudentSessionController.new
      viewer = StudentSessionViewer.new
      super(id,user,controller,viewer)
   end
   def execute(command,application)
      controller = self.get_controller
      viewer = self.get_viewer
      case command.get_attribute('type')
         # style
         when 'get_style' then viewer.get_style(application)
         # timeslots
         when 'view_timeslot' then viewer.view_timeslot(application)
         # homepage
         when 'get_homepage' then viewer.get_homepage_xml(application)
         # directions
         when 'view_direction' then viewer.view_direction(application)
         # schedule
         when 'view_schedule' then viewer.view_schedule(application)
         # schedule direction
         when 'view_schedule_direction' then viewer.view_schedule_direction(application,command)
         # password
         when 'change_password' then controller.change_password(application,command)
         else controller.unknown_command(command.get_attribute('type'))
      end   
   end
end
