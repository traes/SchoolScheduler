class SystemAdminSessionController < AbstractSessionController
   # nodes
   def add_node(application,command)
      data_manager = application.get_data_manager
      node = command.get_attribute('node')
      data_manager.add_node(node)
      doc = REXML::Document.new
      doc.add_element('OK')
      return doc
   end
   def remove_node(application,command)
      data_manager = application.get_data_manager
      index = command.get_attribute('index')
      data_manager.remove_node(index)
      doc = REXML::Document.new
      doc.add_element('OK')
      return doc
   end
   # users
   def add_user(application,command)
      data_manager = application.get_data_manager
      username = command.get_attribute('username')
      usertype = command.get_attribute('usertype')
      password = command.get_attribute('password')
      data_manager.add_user(username,usertype,password)
      doc = REXML::Document.new
      doc.add_element('OK')
      return doc
   end
   def remove_user(application,command)
      data_manager = application.get_data_manager
      index = command.get_attribute('index')
      data_manager.remove_user(index)
      doc = REXML::Document.new
      doc.add_element('OK')
      return doc
   end
   # logs
   def rotate_logs(application,command)
      managers = application.get_all_managers
      managers.each {|manager| manager.rotate_log}
      doc = REXML::Document.new
      doc.add_element('OK')
      return doc
   end
   # backup
   def create_backup(application,command)
      data_manager = application.get_data_manager
      data_manager.create_backup
      doc = REXML::Document.new
      doc.add_element('OK')
      return doc
   end
   def restore_backup(application,command)
      data_manager = application.get_data_manager
      data_manager.restore_backup
      doc = REXML::Document.new
      doc.add_element('OK')
      return doc
   end
end
