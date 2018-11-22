require 'sinatra'
require 'opentracing'
require 'jaeger/client'
require 'jaeger/client/http_sender'
require 'logger'

require 'sinatra/tracer'

accessToken = ""
headers = { }
service_name = "sinatra-tracer-test"
encoder = Jaeger::Client::Encoders::ThriftEncoder.new(service_name: service_name)
httpsender = Jaeger::Client::HttpSender.new(url: "http://localhost:14268/api/traces", headers: headers, encoder: encoder, logger: Logger.new(STDOUT))
OpenTracing.global_tracer = Jaeger::Client.build(service_name: service_name, sender: httpsender)

get '/' do
  "#{hello}"
end

get '/render' do
  code = "<%= Time.now %>"
  erb code
end

def hello
  hello_str = "hello"
  OpenTracing.start_active_span("hello") do
    puts hello_str
  end
  hello_str
end
