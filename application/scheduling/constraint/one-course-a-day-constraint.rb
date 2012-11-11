class OneCourseADayConstraint < AbstractConstraint
   def initialize(penalty)
      super(penalty) do |solution|
          conflicts = 0
          # create table directions[direction][day][course] -> [timeslots, timeslot, ...]
          directions = Hash.new
          solution.get_combinations.each do |a|
            direction = a.get_consumer.get_value.get_direction.to_s
            timeslot = a.get_resource.get_value.get_timeslot
            day = timeslot.get_day.to_s
            course = a.get_consumer.get_value.get_course.to_s
            if !directions.has_key?(direction) then
               directions[direction] = Hash.new
            end
            if !directions[direction].has_key?(day) then
               directions[direction][day] = Hash.new
            end
            if !directions[direction][day].has_key?(course) then
               directions[direction][day][course] = []
            end
            directions[direction][day][course].push(timeslot)
          end
          # check for conflicts
          directions.each_pair do |direction,days|
             days.each_pair do |day,courses|
               courses.each_pair do |course,timeslots|
               if timeslots.size > 1 then
                  conflicts += 1
               end
            end
         end
      end
      result = conflicts * self.get_penalty
      puts "CAD #{conflicts.to_s} (#{result.to_s})"
      result
   end
   end
end   

   


