#! /usr/local/bin/eruby
<%
   require 'data-page-generator.rb'
   generator = DataPageGenerator.new(CGI.new,
      'users.cgi',
      'gebruikers',
      ['system-admin'],
      'user',
      ['username','usertype','password'],
      ['gebruikersnaam','gebruikerstype','paswoord'])
   generator.create_page
%>   
