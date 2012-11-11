#! /usr/local/bin/eruby
<%
require 'abstract-page-generator.rb'
cgi = CGI.new
generator = AbstractPageGenerator.new(cgi,['student','teacher','data-admin','system-admin'])
generator.get_communication.execute_command
style = generator.get_communication.get_style
top = generator.get_top('wijzig paswoord')
username = generator.get_communication.get_username
%>

<HTML>
<HEAD><%= style %></HEAD>
<BODY>
<%=top%>
<CENTER>
   <FORM id="form1" name="form1" type="classrooms.cgi">
      <INPUT name="id" type="hidden" value="<%=generator.get_id%>" />
      <INPUT name="type" type="hidden" value="change_password" />
      <INPUT name="username" type="hidden" value="<%=username%>"/>
      <P>
      <LABEL for="old_password">Oud</LABEL>
      <INPUT name="old_password" type="password" size="20" maxlength="20" />
      </P>
      <P>
      <LABEL for="password">Nieuw</LABEL>
      <INPUT name="password" type="password" size="20" maxlength="20" />
      </P>
      <INPUT name="submit" type="submit" value="toevoegen" />
   </FORM>
</CENTER>
</BODY>
</HTML>
