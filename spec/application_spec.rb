require "#{File.dirname(__FILE__)}/spec_helper"

describe 'main application' do
  include Rack::Test::Methods

  def app
    App.new
  end

  specify 'should show the default index page' do
    get '/'
    last_response.should be_ok
  end

  specify 'Create a new AppObject ' do
    a = AppObject.new()
    a.should_not == nil
  end
  specify 'should have more specs' do
    pending
  end
end
