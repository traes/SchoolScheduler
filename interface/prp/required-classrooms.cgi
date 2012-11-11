#! /usr/local/bin/eruby
<%
   require 'data-page-generator.rb'
   generator = DataPageGenerator.new(CGI.new,
      'required-classrooms.cgi',
      'vakken beperkt op lokalen',
      ['data-admin'],
      'required_classroom',
      ['course','classroom'],
      ['vak','klaslokaal'])

   # communication   
   communication = generator.get_communication

   # courses
   courses_index = []
   courses_name = []
   communication.get_courses.each do |course| 
      courses_index.push(course['index'])
      courses_name.push(course['name'])
   end   

   # classrooms
   classrooms_index = []
   classrooms_name = []
   communication.get_classrooms.each do |classroom| 
      classrooms_index.push(classroom['index'])
      classrooms_name.push(classroom['name'])
   end   

   # form
   form = generator.create_form('required-classrooms.cgi','add_required_classroom',[
      generator.create_choice_input('course','Vak',courses_index,courses_name),
      generator.create_choice_input('classroom','Lokaal',classrooms_index,classrooms_name)
   ])   

   # page
   generator.create_page(form)
%>
