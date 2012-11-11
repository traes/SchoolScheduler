#! /usr/local/bin/eruby
<%
   require 'data-page-generator.rb'
   generator = DataPageGenerator.new(CGI.new,
      'courses.cgi',
      'Vakken',
      ['data-admin'],
      'course',
      ['name'],
      ['naam'])
   generator.create_page
%> 
