#! /usr/local/bin/eruby
<%
require 'abstract-page-generator.rb'
cgi = CGI.new
generator = AbstractPageGenerator.new(cgi,['system-admin'])
top=generator.get_top('backup in de database laden')
style = generator.get_communication.get_style
result = generator.get_communication.execute_custom_command('restore_backup',{})
%>
<HTML>
   <HEAD><%= style %></HEAD>
   <BODY>
   <%=top%>
   De laatstgemaakte backup is in de database geladen.
   </BODY>
</HTML>

