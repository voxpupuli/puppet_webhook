require 'puppet_webhook'
require 'logger'

LOGGER = Logger.new('/var/log/puppet_webhook').freeze
COMMAND_PREFIX = 'umask 0022;'.freeze
PIDFILE = '/var/run/puppet_webhook/puppet_webhook.pid'.freeze
LOCKFILE = '/var/run/puppet_webhook/puppet_webhook.lock'.freeze

FileUtils.makedirs('/var/run/puppet_webhook') unless File.exist?('/var/run/puppet_webhook')
FileUtils.touch(LOCKFILE) unless File.exist?(LOCKFILE)

PuppetWebhook.set :root, File.dirname(__FILE__)
PuppetWebhook.set :logger, LOGGER

run PuppetWebhook
