#! /usr/local/bin/eruby
<%
require 'abstract-page-generator.rb'
cgi = CGI.new
generator = AbstractPageGenerator.new(cgi,['system-admin'])
top=generator.get_top('roteer logbestanden')
style = generator.get_communication.get_style
result = generator.get_communication.execute_custom_command('rotate_logs',{})
%>
<HTML>
<HEAD><%= style %></HEAD>
<BODY>
<%=top%>
<CENTER>
De logbestanden zijn geroteerd
</CENTER>
</BODY>
</HTML>

