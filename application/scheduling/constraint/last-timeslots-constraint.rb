# timeslots after the given hour should be avoided wherever possible

class LastTimeslotsConstraint < AbstractConstraint
   def initialize(penalty,last_hour)
      @last_hour = last_hour
      super(penalty) do |solution|
        total_score = 0
        solution.get_combinations.each do |a|
           timeslot = a.get_resource.get_value.get_timeslot
           if timeslot.get_start.to_i > last_hour 
              then
               total_score += 1
              end 
        end
        result = total_score * self.get_penalty
        puts "LTC #{total_score.to_s} (#{result})"
        result
      end
   end
end
