#!/usr/bin/ruby
require 'load-files.rb'

# datalayer
#config = application.get_configuration_manager
#config.set_datalayer_host('localhost')
#config.set_datalayer_port('4242')

configuration_file = 'config'
application = Application.new(configuration_file)
server = ApplicationServer.new(application)
server.start
