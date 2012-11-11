#! /usr/local/bin/eruby
<%
require 'abstract-page-generator.rb'
cgi = CGI.new
generator = AbstractPageGenerator.new(cgi,['student','teacher','data-admin','system-admin'])
top=generator.get_top('lessenrooster')
style = generator.get_communication.get_style
username = generator.get_communication.get_username
result = generator.get_communication.execute_custom_command('view_schedule_teacher',{'teacher'=>username})
attributes = ['day','start','stop','course','teacher','classroom','direction','compulsory','electivegroup']
attribute_names = ['dag','start','stop','vak','docent','klaslokaal','studierichting','verplicht','keuzevakgroep']
%>
<HTML>
<HEAD><%= style %></HEAD>
<BODY>
<%=top%>
<CENTER>
<%
if result.root.attribute('version').to_s.to_i == 0 then
   puts '<P>Er is nog geen rooster beschikbaar</P>'
else  
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
end
%>
</CENTER>
</BODY>
</HTML>

