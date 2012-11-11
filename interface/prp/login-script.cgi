#! /usr/local/bin/eruby
<% 
require 'cgi'
require 'communication.rb'
cgi = CGI.new("html3")
communication = Communication.new(cgi)
username = cgi.params['gebruikersnaam'].to_s
password = cgi.params['paswoord'].to_s
result = communication.login(username,password)
id = result.root.attributes['id'].to_s
homepage = result.root.attributes['homepage'].to_s
puts '<meta HTTP-EQUIV="REFRESH" content="0; url=' + homepage + '?id=' + id + '">' 
%>

