require 'spec_helper'

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

    it "calls the patch_render method" do
      expect(Sinatra::Tracer).to receive(:patch_render)

      Sinatra::Tracer.registered(Sinatra::Base)
    end
  end
end
