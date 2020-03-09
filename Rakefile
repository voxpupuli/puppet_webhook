# frozen_string_literal: true

ENV['SINATRA_ENV'] ||= 'development'

require './lib/puppet_webhook'
require 'sinatra/activerecord/rake'
require 'securerandom'
require 'github_changelog_generator/task'

namespace :db do
  task :load_config do
    require './app/controllers/application_controller'
  end

  desc 'Generate auth token for the application'
  task :generate_token do
    require './app/models/auth_token'
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: "db/#{ENV['SINATRA_ENV']}.sqlite3"
    )
    token = SecureRandom.urlsafe_base64
    AuthToken.delete_all
    AuthToken.create(token: token).save!
    puts token
  end
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

desc 'Run all tests'
task test: %i[rubocop spec]

require 'coveralls/rake/task'
desc 'Run all tests and report to coverage tools'
task test_and_report_coverage: [:test] do
  Coveralls::RakeTask.new
  Rake::Task['coveralls:push'].invoke
end

GitHubChangelogGenerator::RakeTask.new :changelog do |config|
  config.user = 'voxpupuli'
  config.project = 'puppet_webhook'
  config.future_release = PuppetWebhook::VERSION
end
# vim: syntax=ruby
