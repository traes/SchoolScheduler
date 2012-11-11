#! /usr/local/bin/eruby
<%
require 'cgi'
cgi = CGI.new
id = cgi.params['id']
%>
<HTML>
   <BODY>
   <CENTER>
   <H1>Toegang geweigerd</H1>
   <A href="login.cgi">probeer opnieuw</A>
   </CENTER>
   </BODY>
</HTML>
