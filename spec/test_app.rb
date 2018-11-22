require 'sinatra/base'

class TestApp < Sinatra::Base
  get '/' do
    erb "<h1>Test</h1>"
  end
end
