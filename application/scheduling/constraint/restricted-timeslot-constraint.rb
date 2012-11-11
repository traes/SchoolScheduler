# some directions can only take lessons during certain timeslots

class RestrictedTimeslotConstraint < AbstractConstraint
   def initialize(penalty,restricted)
      # hash: direction -> [timeslot,...]
      @restricted = restricted
      super(penalty) do |solution|
        conflicts = 0
        solution.get_combinations.each do |a|
           timeslot = a.get_resource.get_value.get_timeslot.to_s
           direction = a.get_consumer.get_value.get_direction
           if (restricted.has_key?(direction) && @restricted[direction].map{|x| x.to_s}.member?(timeslot))
              then
               conflicts += 1
              end 
         end
        result = conflicts * self.get_penalty
        puts "RTS #{conflicts.to_s} (#{result.to_s})"
        result
      end
   end
end
