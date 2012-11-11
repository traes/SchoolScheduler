
class TimeSlot
   def initialize(day,start,stop)
      @day=day.to_s
      @start=start.to_i
      @stop=stop.to_i
   end
   def overlaps?(other)
      if @day != other.get_day then
         return false
      end
      if other.get_start == self.get_start then
         return true
      end
      # other timeslot lies after current
      if other.get_start >= self.get_stop then
         return false
      end   
      # other timeslot lies before current
      if other.get_start < self.get_start then 
         return !(other.get_stop <= self.get_start)
      else
         return true
      end   
   end
   def get_day()
      return @day
   end
   def set_day(value)
      @day = value
   end
   def get_start()
      return @start
   end
   def set_start(value)
      @start = value
   end
   def get_stop()
      return @stop
   end
   def set_stop(value)
      @stop = value
   end
   def to_s
      return @day.to_s + ' ' + @start.to_s + '->' + @stop.to_s 
   end
end
