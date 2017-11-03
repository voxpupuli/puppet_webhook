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

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../lib/puppet_webhook.rb', __FILE__

module Webhook
  module Test
    module Methods
      def read_fixture(name)
        File.read(File.join(File.expand_path('..', __FILE__), 'fixtures', name))
      end
    end
  end
end

module RSpecMixin
  include Rack::Test::Methods
  include Webhook::Test::Methods
  def app
    described_class
  end
end
RSpec.configure do |conf|
  conf.include RSpecMixin
end
