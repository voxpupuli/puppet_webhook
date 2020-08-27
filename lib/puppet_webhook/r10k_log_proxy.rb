# frozen_string_literal: true

require 'log4r/outputter/outputter'

module PuppetWebhook
  # This class creates a proxy that will grab r10k logging and output it to the logger passed into this class
  class R10KLogProxy < Log4r::Outputter
    def initialize(logger, level)
      super('puppet_webhook')

      @logger = logger
      @logger.level = level
    end

    def canonical_log(event)
      level = to_webhook_level(event.level)
      @logger.send(level, event.data)
    end

    def to_webhook_level(level_num)
      level_str = Log4r::LNAMES[level_num]&.downcase || 'debug'
      if level_str =~ %r{debug}
        :debug
      else
        level_str.to_sym
      end
    end
  end
end
