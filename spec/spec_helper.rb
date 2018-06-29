require 'rspec'
require 'rack/test'

require 'simplecov'
require 'simplecov-console'
SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::Console
]
SimpleCov.start do
  add_filter '.gems'
  add_filter 'spec'
  add_filter 'pkg'
  add_filter 'vendor'
  add_filter '.vendor'
end

ENV['RACK_ENV'] = 'test'

require File.expand_path '../lib/puppet_webhook.rb', __dir__

def app
  PuppetWebhook
end

def call(env)
  app.call(env)
end

module Webhook
  module Test
    module Methods
      def read_fixture(name)
        File.read(File.join(File.expand_path(__dir__), 'fixtures', name))
      end

      def read_json_fixture(name)
        JSON.parse(read_fixture(name))
      end
    end
  end
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include Webhook::Test::Methods
  conf.include DataParsers
end
