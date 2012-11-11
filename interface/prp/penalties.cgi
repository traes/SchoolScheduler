#! /usr/local/bin/eruby
<%
   require 'data-page-generator.rb'
   generator = DataPageGenerator.new(CGI.new,
      'penalties.cgi',
      'Prioriteit constraints',
      ['data-admin'],
      'penalty',
      ['constraint','penalty'],
      ['beperking','prioriteit'])
   communication = generator.get_communication
   constraints = communication.get_constraints
   constraint_descriptions = [
      'lokalen hebben voldoende capaciteit',
      'na elkaar gebruikte lokalen liggen nabij',
      'verplichte vakken overlappen niet',
      'keuzevakgroepen hebben zelfde lesuren',
      'de laatste lesuren worden liefst niet gebruikt',
      'middagpauze',
      'elk vak hoogstens 1 keer per dag',
      'vakken beperkt op lokalen',
      'lokalen beperkt op vakken',
      'studierichtingen beperkt op lesuren',
      'beschikbaarheid leerkrachten',
      'voorkeuren leerkrachten',
      'springuren']
   constraint_names = [
      'capacity',
      'classroom-distance',
      'compulsory',
      'elective',
      'last-timeslots',
      'lunch-break',
      'one-course-a-day',
      'required-classrooms',
      'restricted-courses',
      'teacher',
      'teacher-timeslot',
      'timeslot-gap'
   ]
  
   penalty_scores = ['0','-1','-1000']
   penalty_descriptions = ['onbelangrijk','belangrijk','zeer belangrijk']
   form = generator.create_form('penalties.cgi','add_penalty',[
      generator.create_choice_input('constraint','Beperking',constraint_names,constraint_descriptions),
      generator.create_choice_input('penalty','Prioriteit',penalty_scores,penalty_descriptions),
   ])

   generator.create_page(form)
%>

