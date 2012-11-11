
class SchedulingProblem
   def initialize()
      @consumers=[]
      @resources=[]
      @constraints=[]
      @improvements=[]
      @reuse_resources=false
   end
   def get_consumers()
      return @consumers
   end
   def set_consumers(value)
      @consumers = value
   end
   def get_resources()
      return @resources
   end
   def set_resources(value)
      @resources = value
   end
   def get_constraints()
      return @constraints
   end
   def set_constraints(value)
      @constraints = value
   end
   def get_improvements()
      return @improvements
   end
   def set_improvements(value)
      @improvements = value
   end
   def get_reuse_resources()
      return @reuse_resources
   end
   def set_reuse_resources(value)
      @reuse_resources = value
   end
end
