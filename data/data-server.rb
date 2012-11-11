class DataServer
   def initialize(configfile)
      @config = ConfigurationFile.new(configfile)
      
      # create server 
      host = @config['host']
      port = @config['port']
      @server = TCPServer.new(host,port)
      
      # create data storage
      db_host = @config['db_host']
      db_name = @config['db_name']
      db_user = @config['db_user']
      db_pasw = @config['db_pasw']
      @storage = StorageManager.new(db_host,db_name,db_user,db_pasw)
   end   
   def start
      while(true) do
         socket=@server.accept
         Thread.start do
            currentSocket=socket
            @storage.handle(socket)
            currentSocket.close
         end
      end
   end
end

