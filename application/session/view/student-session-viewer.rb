class StudentSessionViewer < AbstractSessionViewer
   def get_homepage(application)
      return 'home-student.cgi'
   end   
   def get_html_background_color
      return DarkGrey 
   end
   def get_form_background_color
      return LightGrey 
   end
end
