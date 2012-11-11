#! /usr/local/bin/eruby
<%
   require 'data-page-generator.rb'
   generator = DataPageGenerator.new(CGI.new,
      'all-personal-preferences.cgi',
      'persoonlijke voorkeuren',
      ['data-admin'],
      'teacher_timeslot',
      ['teacher','day','start','stop','score'],
      ['docent','dag','start','stop','score'])
      
   communication = generator.get_communication
  
   # teachers
   teachers_index = []
   teachers_name = []
   communication.get_teachers.each do |teacher| 
      teachers_index.push(teacher['index']); teachers_name.push(teacher['name'])
   end   

   # timeslots
   timeslots_index = []
   timeslots_name = []
   communication.get_timeslots.each do |timeslot| 
      timeslots_index.push(timeslot['index']); timeslots_name.push(timeslot['description'])
   end   

   form = generator.create_form('all-personal-preferences.cgi','add_teacher_timeslot',[
      generator.create_choice_input('teacher','Docent',teachers_index,teachers_name),
      generator.create_choice_input('timeslot','Tijdslot',timeslots_index,timeslots_name),
      generator.create_choice_input('score','Voorkeur',['1','-1'],['goed','slecht'])
   ])

   generator.create_page(form)
%> 
