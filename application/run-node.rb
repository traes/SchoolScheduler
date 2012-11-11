#!/usr/bin/ruby

require 'thread'
require 'test/unit'
require 'logger'
require 'drb'

Thread.abort_on_exception = true

require 'load-files.rb'
Config='config'

port = ARGV[0]
if port.nil? then
   puts 'usage: ruby run-node.rb portnumber'
else   
   node = Node.new(port,Config)
end   

