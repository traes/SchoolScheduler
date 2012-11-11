# all students should have a lunchbreak

# first lunch break
FirstLunchBreakStart = 11
FirstLunchBreakStop = 12

# second lunch break
SecondLunchBreakStart = 12
SecondLunchBreakStop = 13

# third lunch break
ThirdLunchBreakStart = 13
ThirdLunchBreakStop = 14

class LunchBreakConstraint < AbstractConstraint
   def initialize(penalty)
      super(penalty) do |solution|
          conflicts = 0
          # create table directions[direction][day] -> [timeslots, timeslot, ...]
          directions = Hash.new
          solution.get_combinations.each do |a|
             direction = a.get_consumer.get_value.get_direction
             timeslot = a.get_resource.get_value.get_timeslot
             day = timeslot.get_day
             if !directions.has_key?(direction.to_s) then
               directions[direction.to_s] = Hash.new
             end
             if !directions[direction.to_s].has_key?(day.to_s) then
               directions[direction.to_s][day.to_s] = []
             end
             directions[direction.to_s][day.to_s].push(timeslot)
          end
          # check for conflicts
          directions.each_pair do |direction,days|
            days.each_pair do |day,timeslots|
            lunch_hours = []
            lunch_hours.push(TimeSlot.new(day.to_s,FirstLunchBreakStart,FirstLunchBreakStop))
            lunch_hours.push(TimeSlot.new(day.to_s,SecondLunchBreakStart,SecondLunchBreakStop))
            lunch_hours.push(TimeSlot.new(day.to_s,ThirdLunchBreakStart,ThirdLunchBreakStop))
            timeslots.each do |timeslot|
               lunch_hours.delete_if do |lunch_hour| 
                  timeslot.overlaps?(lunch_hour)
               end
            end
            if lunch_hours.size == 0 then
               conflicts += 1
            end   
         end
       end
     result = conflicts * self.get_penalty
     puts "LNB #{conflicts.to_s} (#{result.to_s})"
     result
     end
   end
end   

   


