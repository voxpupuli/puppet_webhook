# frozen_string_literal: true

require 'r10k/action/deploy/environment'

module Deploy
  # This worker will deploy a puppet environment using r10k then generate
  # puppet resource types from the code in the moduleapth.
  class EnvironmentWorker < ApplicationWorker
    def perform(environment, config)
      # r10k doesn't like stringified hash keys. This forces symbolized keys
      config = config.symbolize_keys
      @basedir = config[:sources].first[1]['basedir']
      deploy = R10K::Action::Deploy::Environment.new({ config: config }, [environment], config)

      R10K::Logging.instance_variable_set(:@outputter, PuppetWebhook::R10KLogProxy.new(logger, logger.level))

      raise 'Failed to deploy' unless deploy.call
    end
  end
end
