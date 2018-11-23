require 'fileutils'
require 'logger'
require 'puppet_webhook'
require 'sidekiq/web'

LOGGER = Logger.new('/var/log/puppet_webhook').freeze
LOCKFILE = '/var/run/puppet_webhook/puppet_webhook.lock'.freeze

FileUtils.makedirs('/var/run/puppet_webhook')
FileUtils.touch(LOCKFILE) unless File.exist?(LOCKFILE)

PuppetWebhook.set :root, File.dirname(__FILE__)
PuppetWebhook.set :logger, LOGGER
PuppetWebhook.set :command_prefix, 'umask 0022;'

map '/sidekiq' do
  run Sidekiq::Web
end

run PuppetWebhook
