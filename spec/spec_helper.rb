require 'simplecov'
require 'simplecov-console'
require 'sidekiq/testing'

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

Sidekiq::Logging.logger = nil

ENV['SINATRA_ENV'] = 'test'

require_relative '../config/environment'
require 'rack/test'
require 'capybara/rspec'
require 'capybara/dsl'
require 'webmock/rspec'

raise 'Migrations are pending. Run `rake db:migrate SINATRA_ENV=test` to resolve the issue.' if ActiveRecord::Migrator.needs_migration?

ActiveRecord::Base.logger = nil

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.include Rack::Test::Methods
  config.include Capybara::DSL
  DatabaseCleaner.strategy = :truncation

  config.before do
    DatabaseCleaner.clean
  end

  config.after do
    DatabaseCleaner.clean
  end

  config.order = 'default'
end

def app
  Rack::Builder.parse_file('config.ru').first
end

Capybara.app = app
