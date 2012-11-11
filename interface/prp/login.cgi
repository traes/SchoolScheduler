#! /usr/local/bin/eruby
<%
require 'cgi'
require 'communication.rb'
cgi = CGI.new
communication = Communication.new(cgi)
style = communication.get_data('get_login_style')
%>
<HTML>
   <HEAD><%= style %></HEAD>
   <BODY>
   <CENTER><H1>EHB Lessenrooster</H1></CENTER>

   <CENTER>
      <FORM id="FORM1" name="FORM1" method="post" action="login-script.cgi">
         <P>
            <LABEL for="gebruikersnaam">gebruikersnaam</LABEL>
            <INPUT name="gebruikersnaam" type="text" size="20" maxlength="20" />
         </P>
         <P>
            <LABEL for="paswoord">paswoord</LABEL>
            <INPUT name="paswoord" type="password" size="20" maxlength="20" />
         </P>
         <P>
            <INPUT name="submit" type="submit" value="Inloggen" />
         </P>
      </FORM>
      <P>
         (c) 2006 Thomas Raes
      </P>
   </CENTER>
   </BODY>
</HTML>
