#!/usr/env ruby

require 'rubygems'
require 'environment'


class App < Sinatra::Base
  use Rack::Session::Cookie, :secret => 'secret key goes here'
  use Rack::Flash

  set :app_file, __FILE__
  set :root, File.dirname(__FILE__)

  error do
    e = request.env['sinatra.error']
  end

  helpers do
    def status_message(status)
      status.instance_variable_get(:@message)
    end
    def partial(name, options={})
      item_name = name.to_sym
      counter_name = "#{name}_counter".to_sym
      if collection = options.delete(:collection)
        collection.enum_for(:each_with_index).collect do |item, index|
          partial(name, options.merge(:locals => { item_name => item, counter_name => index + 1 }))
        end.join

      elsif object = options.delete(:object)
        partial name, options.merge(:locals => {item_name => object, counter_name => nil})
      else
        haml "_#{name}".to_sym, options.merge(:layout => false)
      end
    end
    def fb2hd
      if fb[:user]
        @email = DmUser.first(:fb_uid => fb[:user].to_s)
        @user = AbUser.first(:email => @email.email)
      end
    end

  end


  before do
    #nothing for now
  end


  get '/' do
    haml :index
  end

  get '/css/style.css' do
    content_type 'text/css'
    sass :style
  end
end
