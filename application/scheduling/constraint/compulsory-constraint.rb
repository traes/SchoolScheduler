# student's compulsory courses should not overlap

class CompulsoryConstraint < AbstractConstraint
   def initialize(penalty)()
      super(penalty) do |solution|
        conflicts = 0
        solution.get_combinations.each do |a1|
           solution.get_combinations.each do |a2|
              # course meetings
              cm1 = a1.get_consumer.get_value
              cm2 = a2.get_consumer.get_value
              # meeting slots
              ms1 = a1.get_resource.get_value
              ms2 = a2.get_resource.get_value
              if (cm1.to_s != cm2.to_s && # different course meetings
                 cm1.get_direction == cm2.get_direction &&  # same direction
                 cm1.get_compulsory && cm2.get_compulsory && # both compulsory
                 ms1.get_timeslot.overlaps?(ms2.get_timeslot)) # same timeslot
                 then
                    conflicts += 1
                 end 
              end
           end
        result = conflicts * self.get_penalty
        puts "COM #{conflicts.to_s} (#{result.to_s})"   
        result 
      end
   end
end
