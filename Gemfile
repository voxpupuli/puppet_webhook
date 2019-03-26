source 'https://rubygems.org'

puppet_version = ENV['PUPPET_GEM_VERSION'] ||= '6.3.0'

gem 'sinatra'
gem 'sinatra-contrib'
# gem 'sinatra-authentication'
gem 'activerecord', '4.2.11', require: 'active_record'
gem 'bcrypt'
gem 'github_changelog_generator'
gem 'mcollective-client'
gem 'pry'
gem 'puma'
gem 'puppet', puppet_version
gem 'puppet_forge', '2.2.8'
gem 'r10k'
gem 'rake'
gem 'require_all'
gem 'rocket-chat-notifier'
gem 'shotgun'
gem 'sidekiq'
gem 'sinatra-activerecord', require: 'sinatra/activerecord'
gem 'slack-notifier'
gem 'sqlite3', '1.3.13'
gem 'thin'
gem 'tux'
gem 'warden'

group :development do
  gem 'debase'
  gem 'rubocop'
  gem 'ruby-debug-ide'
  gem 'yard'
end

group :test do
  gem 'capybara'
  gem 'coveralls'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
  gem 'rack-test'
  gem 'rspec'
  gem 'simplecov'
  gem 'simplecov-console'
  gem 'webmock'
end
