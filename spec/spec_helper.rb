require 'rspec'
require 'rack/test'

require 'simplecov'
require 'simplecov-console'
SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::Console
]
SimpleCov.start do
  track_files 'lib/**/*.rb'
  add_filter '/spec'
  add_filter '/vendor'
  add_filter '/.vendor'
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
