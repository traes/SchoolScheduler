# DataLink is responsible for the connection with the data layer
class DataLink
   def initialize(host,port)
      @host=host
      @port=port
   end
   def send(operation,args)
      begin
         doc = REXML::Document.new
         request = doc.add_element 'REQUEST'
         request.attributes['operation']=operation
         args.each_pair do |key,value|
            request.attributes[key]=value
         end
         socket = TCPSocket.new(@host,@port)
         socket.puts doc.to_s
         xmlResult = socket.gets.chop
         docResult = REXML::Document.new xmlResult
         return docResult
      rescue
         puts 'datalink could not connect to server'
      end
   end
   def get_host()
      return @host
   end
   def set_host(value)
      @host = value
   end
   def get_port()
      return @port
   end
   def set_port(value)
      @port = value
   end
   def to_s
      return @host.to_s + ' ' + @port.to_s 
   end
end
