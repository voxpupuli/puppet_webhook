# frozen_string_literal: true

environment = ENV.fetch('RACK_ENV', 'development')

require './lib/puppet_webhook'
require 'sinatra/activerecord/rake'
require 'securerandom'
require 'github_changelog_generator/task'

namespace :db do
  task :load_config do
    require './config/environment.rb'
    require './app/controllers/application_controller'
  end

  desc 'Generate auth token for the application'
  task :generate_token do
    require './app/models/auth_token'
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: "db/#{environment}.sqlite3"
    )
    token = SecureRandom.urlsafe_base64
    AuthToken.delete_all
    AuthToken.create(token: token).save!
    puts token
  end
end

if environment != 'production'
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new

  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)

  desc 'Run all tests'
  task test: %i[rubocop spec]

  GitHubChangelogGenerator::RakeTask.new :changelog do |config|
    config.user = 'voxpupuli'
    config.project = 'puppet_webhook'
    config.future_release = PuppetWebhook::VERSION
    config.exclude_labels = %w[duplicate question invalid wontfix wont-fix modulesync skip-changelog]
  end
end
# vim: syntax=ruby
