#! /usr/local/bin/eruby
<%
   require 'data-page-generator.rb'
   generator = DataPageGenerator.new(CGI.new,'classrooms.cgi',
      'lokalen',
      ['data-admin'],
      'classroom',
      ['name','capacity','location'],
      ['naam','capaciteit','locatie'])
   generator.create_page
%> 
