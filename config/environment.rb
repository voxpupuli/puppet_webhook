ENV['SINATRA_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

config_path = ENV['WEBHOOK_CONFDIR'] || 'config/config.yml'

config = YAML.load_file(config_path)
APP_CONFIG = OpenStruct.new(config[ENV['SINATRA_ENV']])

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require 'require_all'
require 'sinatra'
require 'sinatra/activerecord'
require 'warden'
require './lib/puppet_webhook'
require './app/controllers/application_controller'
require_all 'app'
