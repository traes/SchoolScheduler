
class Consumer
   def initialize(value)
      @value=value
   end
   def get_value()
      return @value
   end
   def set_value(value)
      @value = value
   end
   def to_s
      return @value.to_s
   end   
end
