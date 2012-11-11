class SystemAdminSessionViewer < AbstractSessionViewer
   def get_homepage(application)
      return 'home-system-admin.cgi'
   end   
   def get_html_background_color
      return DarkBlue 
   end
   def get_form_background_color
      return LightBlue
   end
   # node 
   def view_node(application)
      return application.get_data_manager.get_node_xml
   end
   # user
   def view_user(application)
      return application.get_data_manager.get_user_xml
   end
   # logfiles
   def view_logfiles(application,command)
      begin
      filename = command.get_attribute('filename').to_s
      if filename == '' then
         return REXML::Document.new
      else   
      config_manager = application.get_config_manager
      logdir = config_manager.get('logdir')
      puts(logdir+filename)
      doc = REXML::Document.new
      doc.add_element('LOG',{})
      file = File.open(logdir+filename,'r')
      file.each_line do |line|
         item = doc.root.add_element('LOG-ITEM')
         item.add_attribute('item',line.chop.to_s)
      end
      end
      return doc
      rescue
         puts 'error'
      end
   end
end
