#! /usr/local/bin/eruby
<%
   require 'link-page-generator.rb'
   generator = LinkPageGenerator.new(CGI.new,'hoofdpagina databeheerder',['data-admin'])
   generator.set_links({
      'bekijk rooster' => 'schedule.cgi',
      'rooster per studierichting' => 'schedule-direction.cgi',
      'genereer rooster' => 'generate-schedule.cgi',
      'lokalen' => 'classrooms.cgi',
      'vakbijeenkomsten' => 'course-meetings.cgi',
      'vakken beperkt op lokalen' => 'required-classrooms.cgi',
      'lokalen beperkt op vakken' => 'restricted-courses.cgi',
      'richtingen beperkt op lesuren' => 'restricted-timeslots.cgi',
      'lokalen onbeschikbaar' => 'classrooms-unavailable.cgi',
      'gewicht beperkingen' => 'penalties.cgi',
      'voorkeuren docenten' => 'all-personal-preferences.cgi',
      'docenten' => 'teachers.cgi',
      'studierichtingen' => 'directions.cgi',
      'keuzevakgroepen' => 'electivegroups.cgi',
      'vakken' => 'courses.cgi',
      'tijdssloten' => 'timeslots.cgi'
   })  
   generator.create_page 
%>
