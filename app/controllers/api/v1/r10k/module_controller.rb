# frozen_string_literal: true

class Api
  class V1
    class R10K
      # Module controller for sinatra app
      class ModuleController < ApplicationController
        # POST: /module
        post %r{\/(module|api\/v1\/r10k\/module)} do
          protected! if APP_CONFIG.protected
          request.body.rewind
          data = PuppetWebhook::Parsers.new(request).params

          ModuleController.helpers R10kHelpers

          # Short circuit if we're ignoring this event
          # return 200 if ignore_event?

          # TODO: Move these two lines of code into the parser
          # decoded = request.body.read
          # verify_signature(settings.github_secret, decoded) if verify_signature?

          module_name = data.module_name

          module_name = sanitize_input(module_name)
          logger.info("Deploying module #{module_name}")
          Deploy::ModuleWorker.perform_async(module_name, config)
        end

        private

        def sanitize_input(input_string)
          require 'shellwords'
          sanitized = Shellwords.shellescape(input_string)
          logger.info("Module or Branch name #{sanitized} had to be escaped") unless input_string == sanitized
          sanitized
        end
      end
    end
  end
end
