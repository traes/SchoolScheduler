#! /usr/local/bin/eruby
<%
   require 'link-page-generator.rb'
   generator = LinkPageGenerator.new(CGI.new,'hoofdpagina docent',['teacher'])
   generator.set_links({'rooster' => 'schedule-teacher.cgi',
         'persoonlijke voorkeuren' => 'personal-preferences.cgi'})
   generator.create_page
%>   
