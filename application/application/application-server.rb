# ApplicationServer makes an application available on the network
class ApplicationServer
   def initialize(application)
      @config_manager = application.get_config_manager
      host = @config_manager.get('application_host')
      port = @config_manager.get('application_port')
      @server = TCPServer.new(host,port)
      @application=application
   end   
   def start
      while(true) do
         socket=@server.accept
         Thread.start do
            currentSocket=socket
            session_manager = @application.get_session_manager
            session_manager.handle(currentSocket)
            currentSocket.close
         end
      end
   end
end

