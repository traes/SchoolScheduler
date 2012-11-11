#! /usr/local/bin/eruby
<%
   require 'data-page-generator.rb'
   generator = DataPageGenerator.new(CGI.new,
      'electivegroups.cgi',
      'Keuzevakgroepen',
      ['data-admin'],
      'electivegroup',
      ['name'],
      ['naam'])
   generator.create_page
%> 
