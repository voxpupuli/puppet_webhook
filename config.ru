require 'fileutils'
require 'logger'
require 'puppet_webhook'

LOGGER = Logger.new('/var/log/puppet_webhook').freeze
COMMAND_PREFIX = 'umask 0022;'.freeze
LOCKFILE = '/var/run/puppet_webhook/puppet_webhook.lock'.freeze

FileUtils.makedirs('/var/run/puppet_webhook')
FileUtils.touch(LOCKFILE) unless File.exist?(LOCKFILE)

PuppetWebhook.set :root, File.dirname(__FILE__)
PuppetWebhook.set :logger, LOGGER

run PuppetWebhook
