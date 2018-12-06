require 'rack/tracer'
require 'sinatra/base'
require 'sinatra/instrumentation/version'
require 'opentracing'

module Sinatra
  module Instrumentation

    class << self

      def registered(app)
        # enable the Rack Tracer middleware
        app.use Rack::Tracer

        patch_render
      end

      def patch_render
        ::Sinatra::Base.module_eval do
          alias_method :render_original, :render

          def render(engine, data, options = {}, locals = {}, &block)
            result = ""

            OpenTracing.global_tracer.start_active_span("sinatra.render") do |scope|
              result = render_original(engine, data, options, locals, &block)
              scope.span.set_tag("sinatra.template", data)
            end

            result
          end
        end
      end

    end
  end

  register Instrumentation
end
