# teachers can prefer not to give lessons on given timeslots

class TeacherTimeslotConstraint < AbstractConstraint
   def initialize(penalty,restricted)
      # hash: teacher -> [timeslot,...]
      @restricted = restricted
      super(penalty) do |solution|
        total_score = 0
        solution.get_combinations.each do |a|
           timeslot = a.get_resource.get_value.get_timeslot.to_s
           teacher = a.get_consumer.get_value.get_teacher.to_s
           if (restricted.has_key?(teacher) && @restricted[teacher].has_key?(timeslot))
              then
               score = @restricted[teacher][timeslot]
               total_score += score.to_i
              end 
         end
         puts "TTC #{total_score.to_s}"
         total_score    
      end
   end
end
