#! /usr/local/bin/eruby
<%
   require 'data-page-generator.rb'
   generator = DataPageGenerator.new(CGI.new,'teachers.cgi','Docenten',['data-admin'],'teacher',['name'],['naam'])
   generator.create_page
%> 
