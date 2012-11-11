# Command represents a request from the interface layer
class Command
   def initialize(socket)
      @xmlString = socket.gets.chop
      @xmlDocument = REXML::Document.new @xmlString
   end
   def get_attribute(name)
      result = @xmlDocument.root.attributes[name]
      return result
   end   
   def login?
      return self.get_attribute('type')=='login'
   end
   def to_s
      return @xmlString.to_s
   end
end


