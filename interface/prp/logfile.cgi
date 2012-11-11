#! /usr/local/bin/eruby
<%
require 'data-page-generator.rb'
cgi = CGI.new
generator = DataPageGenerator.new(cgi,
   'logfile.cgi',
   'logbestanden',
   ['system-admin'],
   'logfile',
   ['item'],
   ['log'])
communication = generator.get_communication
result = nil
if cgi.params.has_key?('filename') then
   result = communication.execute_custom_command('view_logfile',{})
end
style = communication.get_style
top = generator.get_top('logbestanden')
logfiles = ['auth-manager.log',
   'config-manager.log',
   'data-manager.log',
   'schedule-manager.log',
   'session-manager.log',
   'user-manager.log']
descriptions = ['aanmelding',
   'configuratiebeheer',
   'databeheer',
   'roosterbeheer',
   'sessiebeheer',
   'gebruikersbeheer']
%>
<HTML>
<HEAD><%=style%></HEAD>
<BODY>
<%= top %>
<CENTER>
<%=
   generator.create_form('logfile.cgi','view_logfile',[
      generator.create_choice_input('filename','Log',logfiles,descriptions)
   ])   
%>
<%
if cgi.params.has_key?('filename') then
   puts '<TABLE>'
   result.root.elements.each do |x| 
      puts "<TR><TD bgcolor=\"white\"> #{x.attribute('item')} </TD></TR>"
   end   
   puts '</TABLE>'
end
%>
</CENTER>
</BODY>
</HTML>

