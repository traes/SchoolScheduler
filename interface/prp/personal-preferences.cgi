#! /usr/local/bin/eruby
<%
   require 'data-page-generator.rb'
   generator = DataPageGenerator.new(CGI.new,
      'personal-preferences.cgi',
      'persoonlijke voorkeuren',
      ['teacher'],
      'teacher_timeslot',
      ['teacher','day','start','stop','score'],
      ['docent','dag','start','stop','score'])
   communication = generator.get_communication
   teachers = communication.get_teachers
   teacher_name = communication.get_username
   teacher_index = 0
   teachers.each do |teacher|
      if teacher['name'] == teacher_name then teacher_index = teacher['index'] end
   end
   timeslots = communication.get_timeslots
   timeslot_indices = []
   timeslot_descriptions = []
   timeslots.each {|timeslot| timeslot_indices.push(timeslot['index']); timeslot_descriptions.push(timeslot['description'])}
   form = generator.create_form('personal-preferences.cgi','add_teacher_timeslot',[
      generator.create_text_input('teacher','hidden',teacher_index),
      generator.create_choice_input('timeslot','Tijd',timeslot_indices,timeslot_descriptions),
      generator.create_choice_input('score','Voorkeur',['1','-1'],['goed','slecht'])
   ])
   generator.create_page(form)
%> 
