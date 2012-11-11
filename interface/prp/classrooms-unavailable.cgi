#! /usr/local/bin/eruby
<%
   require 'data-page-generator.rb'
   generator = DataPageGenerator.new(CGI.new,
      'classrooms-unavailable.cgi',
      'onbeschikbare lokalen',
      ['data-admin'],
      'classroom_unavailable',
      ['classroom','day','start','stop'],
      ['klaslokaal','dag','start','stop'])
      
   communication = generator.get_communication

   # timeslots
   timeslot_indices = []
   timeslot_descriptions = []
   timeslots = communication.get_timeslots
   timeslots.each do |timeslot| 
      timeslot_indices.push(timeslot['index']); timeslot_descriptions.push(timeslot['description'])
   end   

   # classrooms
   classrooms_indices = []
   classrooms_names = []
   communication.get_classrooms.each do |classroom| 
      classrooms_indices.push(classroom['index']); classrooms_names.push(classroom['name'])
   end    

   # form
   form = generator.create_form('classrooms-unavailable.cgi','add_classroom_unavailable',[
      generator.create_choice_input('classroom','Lokaal',classrooms_indices,classrooms_names),
      generator.create_choice_input('timeslot','Tijdslot',timeslot_indices,timeslot_descriptions),
   ])

   # page
   generator.create_page(form)
%> 
