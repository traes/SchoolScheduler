# some courses can only be given in certain classrooms

class RequiredClassroomConstraint < AbstractConstraint
   def initialize(penalty,allowed)
      # hash: course -> [room,room,...,room] (allowed rooms for a given course)
      @allowed = allowed
      super(penalty) do |solution|
        conflicts = 0
        solution.get_combinations.each do |a|
           course= a.get_consumer.get_value.get_course # course meeting
           classroom = a.get_resource.get_value.get_classroom.get_name # meeting slot
           if (allowed.has_key?(course) && !allowed[course].member?(classroom)) then
               conflicts += 1
           end 
        end
       result = conflicts * self.get_penalty
       puts "RCL #{conflicts.to_s} (#{result.to_s})"
       result 
      end
   end
end
