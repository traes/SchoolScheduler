
class ClassRoom
   def initialize(name,capacity,location)
      @name=name
      @capacity=capacity
      @location=location
   end
   def get_name()
      return @name
   end
   def set_name(value)
      @name = value
   end
   def get_capacity()
      return @capacity
   end
   def set_capacity(value)
      @capacity = value
   end
   def get_location()
      return @location
   end
   def set_location(value)
      @location = value
   end
   def to_s
      return @name.to_s + ' ' + @capacity.to_s + ' ' + @location.to_s 
   end
end
