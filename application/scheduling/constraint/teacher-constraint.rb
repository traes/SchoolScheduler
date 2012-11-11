class TeacherConstraint < AbstractConstraint
   def initialize(penalty)
      super(penalty) do |solution|
          conflicts = 0
          solution.get_combinations.each do |a1|
             solution.get_combinations.each do |a2|
                if( (a1.get_consumer.get_value.get_teacher == a2.get_consumer.get_value.get_teacher) &&
                  (a1.get_resource.get_value.get_timeslot == a2.get_resource.get_value.get_timeslot) &&
                  (a1.get_consumer.get_value != a2.get_consumer.get_value))
                then 
                  conflicts += 1 
                end
             end
          end
     result = conflicts * self.get_penalty
     puts "THR #{conflicts.to_s} (#{result.to_s})"
     result
   end
   end
end   

   


