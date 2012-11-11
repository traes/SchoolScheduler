#!/usr/bin/env ruby
require 'socket'
require 'thread'
require 'rexml/document'
require 'mysql'

require '../common/abstract-manager.rb'
require '../common/configuration-file.rb'
require 'request.rb'
require 'data-server.rb'
require 'storage-manager.rb'

Thread.abort_on_exception=true

configfile = 'config'
data_server = DataServer.new(configfile)
data_server.start


