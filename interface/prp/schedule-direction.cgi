#! /usr/local/bin/eruby
<%
require 'abstract-page-generator.rb'
cgi = CGI.new
generator = AbstractPageGenerator.new(cgi,['student','teacher','data-admin','system-admin'])
top=generator.get_top('lessenrooster')
style = generator.get_communication.get_style
direction = cgi.params['direction']
result = generator.get_communication.execute_custom_command('view_schedule_direction',{'direction'=>direction})
attributes = ['day','start','stop','course','teacher','classroom','direction','compulsory','electivegroup']
attribute_names = ['dag','start','stop','vak','docent','klaslokaal','studierichting','verplicht','keuzevakgroep']
communication = generator.get_communication
directions = communication.get_directions
directions_name = []
directions_index = []
directions.each {|direction| directions_name.push(direction['name']); directions_index.push(direction['index'])}
%>
<HTML>
<HEAD><%= style %></HEAD>
<BODY>
<%= top %>
<CENTER>
<%
form = generator.create_form('schedule-direction.cgi','view_schedule_direction',[
   generator.create_choice_input('direction','Studierichting',directions_name) # use the name of the direction
])
puts form

puts '<P>'
puts 'Versie:'
puts result.root.attribute('version')
puts '</P>'

puts '<TABLE>'
puts '<TR>'
attribute_names.each {|x| puts('<TD class="data-item"><B>'+x+'</B></TD>')}
puts '</TR>'
result.root.elements.each do |x| 
   puts '<TR>'
   attributes.each do |att|
      begin
      puts "<TD class=\"data-item\"> #{x.attribute(att)} </TD>"
      rescue
      end
   end
   puts '</TR>'
end   
puts '</TABLE>'
%>
</CENTER>
</BODY>
</HTML>

