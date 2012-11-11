class TimeslotImprovement < Improvement
   def initialize
      super() do |solution,problem|
        unused_resources = problem.resources.dup
        solution.combinations.map {|alloc| alloc.resource}.each do |alloc|
           unused_resources.delete(alloc)
        end
        solution.combinations.each do |a1|
          solution.combinations.each do |a2|
            if( (a1.consumer.value.teacher == a2.consumer.value.teacher) &&
           (a1.resource.value.timeslot == a2.resource.value.timeslot) &&
           (a1.consumer.value != a2.consumer.value))
            then
         original = a1.resource
         a1.set_resource(unused_resources.pop)
         unused_resources.push(original)
            end
          end
        end
        solution
      end
   end
end


