#!/usr/bin/env ruby

require 'environment'
require 'app'


set :run, false
set :environment, :devlopment
enable :logging


FileUtils.mkdir_p 'log' unless File.exists?('log')
log = File.new("log/sinatra.log", "a+")
$stdout.reopen(log)
$stderr.reopen(log)

run Sinatra::Application
