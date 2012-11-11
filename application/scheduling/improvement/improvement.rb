
class Improvement
   def initialize(&improve)
      @improve=improve
   end
   def get_improve()
      return @improve
   end
   def set_improve(value)
      @improve = value
   end
end
