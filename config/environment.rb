ENV['SINATRA_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

config = YAML.load_file('config/config.yml').freeze
APP_CONFIG = OpenStruct.new(config[ENV['SINATRA_ENV']]).freeze

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require './lib/puppet_webhook'
require './app/controllers/application_controller'
require_all 'app'
