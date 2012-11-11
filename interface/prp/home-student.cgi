#! /usr/local/bin/eruby
<%
   require 'link-page-generator.rb'
   generator = LinkPageGenerator.new(CGI.new,'hoofdpagina student',['student'])
   generator.set_links({'lessenrooster' => 'schedule-direction.cgi'})
   generator.create_page
%>
