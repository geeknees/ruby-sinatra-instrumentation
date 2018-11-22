require 'spec_helper'
require 'rack/test'
require 'test_app'

RSpec.describe Sinatra::Tracer do
  describe "Class Methods" do
    it { should respond_to :registered }
    it { should respond_to :patch_render }
  end

  describe :registered do
    it "adds Rack::Tracer middleware" do
      expect(Sinatra::Base).to receive(:use).with(Rack::Tracer)

      Sinatra::Tracer.registered(Sinatra::Base)
    end
  end
end

# verify that it adds spans as expected
RSpec.describe TestApp do
  include Rack::Test::Methods

  def app
    TestApp.new
  end

  it "adds spans" do
    OpenTracing.global_tracer = OpenTracingTestTracer.build

    require 'sinatra/tracer'

    get "/"

    expect(OpenTracing.global_tracer.spans.count).to be > 0
  end
end
