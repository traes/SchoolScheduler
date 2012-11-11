
class Request
   attr_accessor :xmlDocument
   def initialize(socket)
      xmlString = socket.gets.chop
      @xmlDocument = REXML::Document.new xmlString
   end
   def get_attribute(name)
      result = @xmlDocument.root.attributes[name]
      return result
   end   
   def to_s
      return @xmlDocument.to_s
   end
end


