require 'puppet_webhook'
require 'logger'

LOGGER = Logger.new('/var/log/puppet_webhook')

PuppetWebhook.set :root, File.dirname(__FILE__)
PuppetWebhook.set :logger, LOGGER

run PuppetWebhook