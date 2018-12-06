# Sinatra::Instrumentation

Auto-instrumenter for Sinatra applications. It traces routes using
`Rack::Tracer` and patches Sinatra to trace template rendering.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sinatra-instrumentation'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sinatra-instrumentation

## Usage

In a classic Sinatra application, this can be used by requiring the library:

```ruby
require 'sinatra/instrumentation'
```

A modular application will need to register it manually:

```ruby
class SinatraApp < Sinatra::Base
    register Sinatra::Instrumentation
    ...
end
```

## Tags

In addition to the standard OpenTracing tags, the instrumentation also adds:
- `sinatra.template`: the name of the view template, or if rendering a string with view code, the contents of the string.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/signalfx/ruby-sinatra-instrumentation.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
