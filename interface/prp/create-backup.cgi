#! /usr/local/bin/eruby
<%
 require 'abstract-page-generator.rb'
 cgi = CGI.new
 generator = AbstractPageGenerator.new(cgi,['system-admin'])
 top=generator.get_top('maak backup van database')
 style = generator.get_communication.get_style
 result = generator.get_communication.execute_custom_command('create_backup',{})
%>

<HTML>
  <HEAD><%= style %></HEAD>
  <BODY>
    <%=top%>
    Er is een backup van de database gemaakt.
  </BODY>
</HTML>

