# frozen_string_literal: true

source 'https://rubygems.org'

group :default do
  gem 'activerecord', '4.2.11', require: 'active_record'
  gem 'bcrypt'
  gem 'github_changelog_generator'
  gem 'log4r'
  gem 'mcollective-client'
  gem 'nokogiri', '>= 1.11.0' # Forced security update
  gem 'puma'
  gem 'puppet_forge', '>= 2.3.0'
  gem 'r10k', '>= 3.4.1'
  gem 'rake'
  gem 'rb-readline'
  gem 'require_all'
  gem 'rexml', '>= 3.2.5' # Forced security update
  gem 'rocket-chat-notifier'
  gem 'shotgun'
  gem 'sidekiq', '< 6.0.0'
  gem 'sinatra'
  gem 'sinatra-activerecord', require: 'sinatra/activerecord'
  gem 'sinatra-contrib'
  gem 'slack-notifier'
  gem 'sqlite3', '1.3.13'
  gem 'thin'
  gem 'tux'
  gem 'warden'
end

group :development do
  gem 'debase'
  gem 'git'
  gem 'pry'
  gem 'pry-byebug'
  gem 'rack-console'
  gem 'rubocop'
  gem 'ruby-debug-ide'
  gem 'yard', '>= 0.9.20'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner-active_record'
  gem 'rack-test'
  gem 'rspec'
  gem 'simplecov'
  gem 'simplecov-console'
  gem 'webmock'
end

group :build do
  gem 'fustigit'
  gem 'vanagon', '0.15.25'
end
