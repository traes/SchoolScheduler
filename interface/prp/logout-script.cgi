#! /usr/local/bin/eruby
<% 
require 'cgi' 
require 'communication.rb'
cgi = CGI.new
Communication.new(cgi).logout
puts '<meta HTTP-EQUIV="REFRESH" content="0; url=login.cgi">' 
%>

