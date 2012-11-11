#! /usr/local/bin/eruby
<%
   require 'data-page-generator.rb'
   generator = DataPageGenerator.new(CGI.new,
      'course-meetings.cgi',
      'vakbijeenkomsten',
      ['data-admin'],
      'course_meeting',
      ['course','teacher','direction','electivegroup','compulsory','persons'],
      ['vak','docent','studierichting','keuzevakgroep','verplicht','personen'])
      
   communication = generator.get_communication

   # courses
   courses_index = []
   courses_name = []
   communication.get_courses.each do |course| 
      courses_index.push(course['index']) 
      courses_name.push(course['name'])
   end   

   # teachers
   teachers_index = []
   teachers_name = []
   communication.get_teachers.each do |teacher| 
      teachers_index.push(teacher['index'])
      teachers_name.push(teacher['name'])
   end   

   # directions
   directions_index = []
   directions_name = []
   communication.get_directions.each do |direction| 
      directions_index.push(direction['index'])
      directions_name.push(direction['name'])
   end   

   # electivegroups
   electivegroups_index = []
   electivegroups_name = []
   communication.get_electivegroups.each do |electivegroup| 
      electivegroups_index.push(electivegroup['index'])
      electivegroups_name.push(electivegroup['name'])
   end


   numbers = (1..99).to_a

   # form
   form = generator.create_form('course-meetings.cgi','add_course_meeting',[
      generator.create_choice_input('course','Vak',courses_index,courses_name),
      generator.create_choice_input('teacher','Docent',teachers_index,teachers_name),
      generator.create_choice_input('direction','Studierichting',directions_index,directions_name),
      generator.create_choice_input('electivegroup','Keuzevakgroep',electivegroups_index,electivegroups_name),
      generator.create_choice_input('compulsory','Verplicht',['ja','nee']),
      generator.create_choice_input('persons','Personen',numbers)
   ])

   # page
   generator.create_page(form)
%> 
