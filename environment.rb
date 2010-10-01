require 'rubygems'
require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-aggregates'
require 'dm-migrations'
require 'haml'
require 'sass'
require 'pp'
require 'rack-flash'
require 'rack/reloader'
require 'ostruct'
require 'sinatra' unless defined?(Sinatra)


configure do
  SiteConfig = OpenStruct.new(
                              :title => 'app',
                              :author => 'Ari Turetzky',
                              :url_base =>'http://localhost:9292/')

  # Load Models
  $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
  Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb"){  |lib| require File.basename(lib, '.*')}

  DataMapper.setup(:default, (ENV["DATABASE_URL"] || "sqlite3:://#{File.expand_path(File.dirname(__FILE__))}/#{Sinatra::Base.environment}.db"))
end
