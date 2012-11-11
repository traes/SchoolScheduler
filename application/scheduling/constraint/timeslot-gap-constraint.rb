# teachers prefer not to have gaps between their lessons

class TimeslotGapConstraint < AbstractConstraint
   def initialize(penalty)
      super(penalty) do |solution|
          conflicts = 0
          # create table teachers[teacher][day] -> [timeslots, timeslot, ...]
          teachers = Hash.new
          solution.get_combinations.each do |a|
             teacher = a.get_consumer.get_value.get_teacher
             timeslot = a.get_resource.get_value.get_timeslot
         day = timeslot.get_day
         if !teachers.has_key?(teacher.to_s) then
            teachers[teacher.to_s] = Hash.new
         end
         if !teachers[teacher.to_s].has_key?(day.to_s) then
            teachers[teacher.to_s][day.to_s] = []
         end
         teachers[teacher.to_s][day.to_s].push(timeslot)
          end
          # check for conflicts
          teachers.each_pair do |teacher,days|
             days.each_pair do |day,timeslots|
            timeslots = timeslots.sort {|x,y| x.get_start.to_i <=> y.get_start.to_i}
            0.upto(timeslots.size-2) do |index|
               current_timeslot = timeslots[index]
               next_timeslot = timeslots[index+1]
               if next_timeslot.get_start > current_timeslot.get_stop then
                  conflicts += 1
               end   
            end
         end
      end
     result = conflicts * self.get_penalty
     puts "TGC #{conflicts.to_s} (#{result.to_s})"
     result
    end
  end
end   

   


