#!/usr/env ruby

require 'rubygems'
require 'environment'


class App < Sinatra::Base
  use Rack::Session::Cookie, :secret => 'secret key goes here'
  use Rack::Flash, :sweep => true
  use Rack::MethodOverride

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
  end


  before do
    #nothing for now
  end


  get '/' do
#    flash[:notice] = "Welcome! Friend"
    haml :index
  end

  get '/css/style.css' do
    content_type 'text/css'
    sass :style
  end

  get '/ao/show/:id' do
    @ao = AppObject.first(:id => params[:id])
    haml :ao_show
  end

  get '/ao/create' do
    haml :ao_create
  end

  post '/ao/create' do
    ao = AppObject.new
    ao.name = params[:name]
    ao.value = params[:value]
    ao.numeral = params[:numeral]
    ao.save
    flash[:notice] = "object #{ao.id} created"
    redirect "/ao/show/#{ao.id}"
  end

  get '/ao/edit/:id' do
    @ao = AppObject.first(:id => params[:id])
    haml :ao_edit
  end

  put '/ao/edit/:id' do
    ao = AppObject.first(:id => params[:id])
    ao.name = params[:name]
    ao.value = params[:value]
    ao.numeral = params[:numeral]
    ao.save
    flash[:notice] = "object id #{params[:id]} updated!"
    redirect "/ao/show/#{ao.id}"
  end

  get '/ao/delete/:id' do

  end
  delete '/ao/delete/:id' do
    ao = AppObject.get(params[:id])
    ao.destroy
    flash[:notice] = "object id #{params[:id]} destroyed!"
    redirect '/'
  end

end
