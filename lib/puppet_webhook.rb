# frozen_string_literal: true

require_relative 'puppet_webhook/parsers'
require_relative 'puppet_webhook/orchestrators'
require_relative 'puppet_webhook/chatops'

# Module to contain the PuppetWebhook library.
module PuppetWebhook
  VERSION = '2.1.2'

  def self.loglevel
    case APP_CONFIG.loglevel
    when 'debug'
      Logger::DEBUG
    when 'info'
      Logger::INFO
    when 'error'
      Logger::ERROR
    when 'fatal'
      Logger::FATAL
    else
      Logger::WARN
    end
  end
end
