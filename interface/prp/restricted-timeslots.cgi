#! /usr/local/bin/eruby
<%
   require 'data-page-generator.rb'
   generator = DataPageGenerator.new(CGI.new,
      'restricted-timeslots.cgi',
      'richtingen beperkt op lesuren',
      ['data-admin'],
      'restricted_timeslot',
      ['direction','day','start','stop'],
      ['richting','dag','start','stop'])
   
   # communication
   communication = generator.get_communication

   # directions
   directions_index = []
   directions_name = []
   communication.get_directions.each do |direction| 
      directions_index.push(direction['index'])
      directions_name.push(direction['name'])
   end   

   # timeslots
   timeslots_index = []
   timeslots_description = []
   communication.get_timeslots.each do |timeslot| 
      timeslots_index.push(timeslot['index'])
      timeslots_description.push(timeslot['description'])
   end   

   # form
   form = generator.create_form('restricted-timeslots.cgi','add_restricted_timeslot',[
      generator.create_choice_input('direction','Studierichting',directions_index,directions_name),
      generator.create_choice_input('timeslot','Tijdslot',timeslots_index,timeslots_description),
   ])

   # page
   generator.create_page(form)
%>   
