#! /usr/local/bin/eruby
<%
   require 'link-page-generator.rb'
   generator = LinkPageGenerator.new(CGI.new,'hoofdpagina systeembeheerder',['system-admin'])
   generator.set_links({
      'gebruikers' => 'users.cgi',
      'cluster nodes' => 'nodes.cgi',
      'bekijk logs' => 'logfile.cgi',
      'roteer logs' => 'rotate-logs.cgi',
      'maak backup' => 'create-backup.cgi',
      'herstel backup' => 'restore-backup.cgi'
   })
   generator.create_page
%>   
