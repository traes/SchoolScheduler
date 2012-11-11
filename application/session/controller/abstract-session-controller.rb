
class AbstractSessionController
   def unknown_command(command_type)
      result = Result.new
      result.set_attribute('type','error')
      result.set_attribute('description','unknown command')
      result.set_attribute('command',command_type)
      puts 'unkown command:' + command_type.to_s
      return result
   end
   def change_password(application,command)
      data_manager = application.get_data_manager
      username = command.get_attribute('username').to_s
      new_password = command.get_attribute('password').to_s
      data_manager.set_password(username,new_password)
   end
   def ok
      doc = REXML::Document.new
      doc.add_element('OK')
      return doc.to_s
   end
end
