require 'sinatra'

module Sinatra
  module PuppetWebhookRoutes
    # Registers a POST endpoint for the PuppetWebhook App
    module Module
      def self.registered(puppet_webhook)
        puppet_webhook.post '/module' do
          protected! if settings.protected
          request.body.rewind # in case someone has already read it

          # Short circuit if we're ignoring this event
          return 200 if ignore_event?

          # TODO: Move these two lines of code into the parser
          decoded = request.body.read
          verify_signature(decoded) if verify_signature?

          module_name = payload['module_name']

          module_name = sanitize_input(module_name)
          LOGGER.info("Deploying module #{module_name}")
          deploy_module(module_name)
        end
      end
    end
  end
end
