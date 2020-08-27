# frozen_string_literal: true

environment = ENV.fetch('RACK_ENV', 'development').freeze

require 'bundler/setup'
Bundler.require(:default, environment)

config_path = ENV.fetch('WEBHOOK_CONFDIR', 'config/config.yml')

config = YAML.load_file(config_path)
APP_CONFIG = OpenStruct.new(config[environment])

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: "db/#{environment}.sqlite3"
)

require './lib/puppet_webhook'
require './app/controllers/application_controller'
require_all 'app'
