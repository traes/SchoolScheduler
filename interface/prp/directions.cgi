#! /usr/local/bin/eruby
<%
   require 'data-page-generator.rb'
   generator = DataPageGenerator.new(CGI.new,
      'directions.cgi',
      'Studierichtingen',
      ['data-admin'],
      'direction',
      ['name'],
      ['naam'])
   generator.create_page
%> 
