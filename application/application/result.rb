# Result represents a response from the application layer
class Result
   def initialize
        @xmlDocument = REXML::Document.new
      @result = @xmlDocument.add_element 'RESULT'
   end
   def set_attribute(name,value)
      @result.attributes[name]=value
   end
   def get_attribute(name)
      return @result.attributes[name]
   end
   def to_s
      return @xmlDocument.to_s
   end
end


