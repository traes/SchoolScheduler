# teachers and students prefer consecutive lessons to take place in nearby classrooms

class ClassRoomDistanceConstraint < AbstractConstraint
   def initialize(penalty)
      super(penalty) do |solution|
         conflicts = 0
         solution.get_combinations.each do |a1|
            solution.get_combinations.each do |a2|
               # timeslots
               timeslot1 = a1.get_resource.get_value.get_timeslot
               timeslot2 = a2.get_resource.get_value.get_timeslot
               # course meetings
               cm1 = a1.get_consumer.get_value
               cm2 = a2.get_consumer.get_value
               # check whether one timeslots follows the next
               if timeslot1.get_stop() == timeslot2.get_start() then
                  # check whether the teachers are the same
                  teacher1 = a1.get_consumer.get_value.get_teacher.to_s
                  teacher2 = a2.get_consumer.get_value.get_teacher.to_s
                  if ((teacher1 == teacher2) || cm1.same_students?(cm2)) then
                     # check whether the classrooms are different
                     classroom1 = a1.get_resource.get_value.get_classroom   
                     classroom2 = a2.get_resource.get_value.get_classroom   
                     if classroom1.get_location != classroom2.get_location then
                        conflicts += 1
                     end
                  end
               end
            end
         end
         result = conflicts * self.get_penalty
         puts "DIS #{conflicts.to_s} (#{result})"
         result
      end
   end
end
