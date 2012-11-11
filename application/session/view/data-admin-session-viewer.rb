class DataAdminSessionViewer < AbstractSessionViewer
   def get_homepage(application)
      return 'home-data-admin.cgi'
   end   
   def get_html_background_color
      return DarkGreen 
   end
   def get_form_background_color
      return LightGreen
   end
   def view_teacher(application)
      return application.get_data_manager.get_teacher_xml
   end
   def view_course(application)
      return application.get_data_manager.get_course_xml
   end
   def view_constraint(application)
      return application.get_data_manager.get_constraint_xml
   end   
   def view_electivegroup(application)
      return application.get_data_manager.get_electivegroup_xml
   end
   def view_penalty(application)
      return application.get_data_manager.get_penalty_xml
   end
   def view_teacher_timeslot(application)
      return application.get_data_manager.get_teacher_timeslot_xml
   end
   def view_classroom_capacity(application)
      return application.get_data_manager.get_classroom_capacity_xml
   end
   def view_classroom_location(application)
      return application.get_data_manager.get_classroom_location_xml
   end
   def view_group_student(application)
      return application.get_data_manager.get_group_student_xml
   end
   def view_classroom_unavailable(application)
      return application.get_data_manager.get_classroom_unavailable_xml
   end
   def view_restricted_timeslot(application)
      return application.get_data_manager.get_restricted_timeslot_xml
   end
   def view_restricted_course(application)
      return application.get_data_manager.get_restricted_course_xml
   end
   def view_required_classroom(application)
      return application.get_data_manager.get_required_classroom_xml
   end
   def view_classroom(application)
      return application.get_data_manager.get_classroom_xml
   end
   def view_course_meeting(application,command)
      return application.get_data_manager.get_course_meeting_xml
   end
end
