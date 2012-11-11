
class PersonalPreference
   def initialize(username,description,arg)
      @username=username
      @description=description
      @arg=arg
   end
   def to_constraint
      constraint = Constraint.new do |solution|
         conflicts = 0
         solution.combinations.each do |a|
            if ((a.consumer.value.teacher == @username) &&
                (a.resource.value.timeslot.start.to_i < @arg.to_i))
                then 
                   conflicts += 1 
                end
         end       
         conflicts   
      end
      return constraint
   end
   def get_username()
      return @username
   end
   def set_username(value)
      @username = value
   end
   def get_description()
      return @description
   end
   def set_description(value)
      @description = value
   end
   def get_arg()
      return @arg
   end
   def set_arg(value)
      @arg = value
   end
   def to_s
      return @username.to_s + ' ' + @description.to_s + ' ' + @arg.to_s 
   end
end
