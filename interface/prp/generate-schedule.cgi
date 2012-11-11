#! /usr/local/bin/eruby
<%
require 'abstract-page-generator.rb'
cgi = CGI.new
cgi.params['type']='generate_schedule'
generator = AbstractPageGenerator.new(cgi,['data-admin'])
generator.get_communication.execute_command
top=generator.get_top('lessenrooster opstellen')
style = generator.get_communication.get_style
%>

<HTML>
<HEAD><%= style %></HEAD>
<BODY>
<%=top%>
<P>
Niew lessenrooster aan het berekenen.
</P>
</BODY>
</HTML>
