# the classrooms needs enough capacity for all the persons
class CapacityConstraint < AbstractConstraint
   def initialize(penalty)
      super(penalty) do |solution|
         conflicts = 0
         solution.get_combinations.each do |a|
            persons = a.get_consumer.get_value.get_persons.to_i
            capacity = a.get_resource.get_value.get_classroom.get_capacity.to_i
               if persons > capacity then
                  conflicts += 1
               end
            end
         result = conflicts * self.get_penalty
         puts "CAP #{conflicts.to_s} (#{result})"
         result
      end
   end
end
