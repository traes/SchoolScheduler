require 'logger.rb'

class AbstractManager
   def initialize(name)
      @name = name
      @logger = Logger.new(name)
      @rotation_counter = 0
   end
   def get_logger
      return @logger
   end
   def get_name
      return @name
   end   
   def rotate_log
       @logger.close
       @rotation_counter += 1
       archive_name = @name + '-rotation-' + @rotation_counter.to_s
       `mv #{name} #{archive_name}`
       @logger=Logger.new(name)
   end
   def info(message)
      puts "#{self.class.to_s} INFO #{message}"
      self.get_logger.add(Logger::INFO,message)   
   end
   def warning(message)
      puts "#{self.class.to_s} WARN #{message}"
      self.get_logger.add(Logger::WARN,message)
   end
   def error(message)
      puts "#{self.class.to_s} ERROR #{message}"
      self.get_logger.add(Logger::ERROR,message)
   end   
end
