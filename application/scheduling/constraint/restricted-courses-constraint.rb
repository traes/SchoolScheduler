# some classrooms can only be used for certain courses

class RestrictedCoursesConstraint < AbstractConstraint
   def initialize(penalty,allowed)
      # hash: classroom -> [course,course,...,course] (allowed courses for a given classroom)
      @allowed = allowed
      super(penalty) do |solution|
        conflicts = 0
        solution.get_combinations.each do |a|
           course= a.get_consumer.get_value.get_course # course meeting
           classroom = a.get_resource.get_value.get_classroom.get_name # meeting slot
           if (allowed.has_key?(classroom) && !allowed[classroom].member?(course))
              then
               conflicts += 1
              end 
         end
         result = conflicts * self.get_penalty
         puts "RCO #{conflicts.to_s} (#{result.to_s})"
         result
      end
   end
end
