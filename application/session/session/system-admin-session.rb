class SystemAdminSession < AbstractSession
   def initialize(id,user)
      controller = SystemAdminSessionController.new
      viewer = SystemAdminSessionViewer.new
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
         # homepage
         when 'get_homepage' then viewer.get_homepage_xml(application)
         # directions
         when 'view_direction' then viewer.view_direction(application)
         # node 
         when 'view_node' then viewer.view_node(application)
         when 'add_node' then controller.add_node(application,command)
         when 'remove_node' then controller.remove_node(application,command)
         # user
         when 'view_user' then viewer.view_user(application)
         when 'add_user' then controller.add_user(application,command)
         when 'remove_user' then controller.remove_user(application,command)
         # logfiles
         when 'view_logfile' then viewer.view_logfiles(application,command)
         when 'rotate_logs' then controller.rotate_logs(application,command)
         # backup
         when 'create_backup' then controller.create_backup(application,command)
         when 'restore_backup' then controller.restore_backup(application,command)
         # unknown
         else controller.unknown_command(command.get_attribute('type'))
      end   
   end
end
