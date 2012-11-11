#! /usr/local/bin/eruby
<%
   require 'data-page-generator.rb'
   generator = DataPageGenerator.new(CGI.new,
      'nodes.cgi',
      'cluster nodes',
      ['system-admin'],
      'node',
      ['node'],
      ['node'])
   generator.create_page
%>

