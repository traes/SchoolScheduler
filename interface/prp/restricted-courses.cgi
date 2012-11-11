#! /usr/local/bin/eruby
<%
   require 'data-page-generator.rb'
   generator = DataPageGenerator.new(CGI.new,
      'restricted-courses.cgi',
      'lokalen beperkt op vakken',
      ['data-admin'],
      'restricted_course',
      ['classroom','course'],
      ['klaslokaal','vak'])

   # communication   
   communication = generator.get_communication

   # classrooms
   classrooms_index = []
   classrooms_name = []
   communication.get_classrooms.each do |classroom| 
      classrooms_index.push(classroom['index'])
      classrooms_name.push(classroom['name'])
   end   

   # courses
   courses_index = []
   courses_name = []
   communication.get_courses.each do |course| 
      courses_index.push(course['index'])
      courses_name.push(course['name'])
   end   

   # form
   form = generator.create_form('restricted_courses.cgi','add_restricted_course',[
            generator.create_choice_input('classroom','Lokaal',classrooms_index,classrooms_name),
            generator.create_choice_input('course','Vak',courses_index,courses_name)
   ])

   # page
   generator.create_page(form)
%> 
