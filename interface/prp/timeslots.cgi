#! /usr/local/bin/eruby
<%
   require 'data-page-generator.rb'
   generator = DataPageGenerator.new(CGI.new,
      'timeslots.cgi',
      'Tijdsloten',
      ['data-admin'],
      'timeslot',
      ['day','start','stop'],
      ['Dag','Beginuur','Einduur'])
   generator.create_page
%> 
