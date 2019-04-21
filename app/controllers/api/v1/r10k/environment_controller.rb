class Api
  class V1
    class R10K
      # Environment controller for sinatra app
      class EnvironmentController < ApplicationController
        # POST: /payloads
        post %r{\/(payload|api\/v1\/r10k\/environment)} do
          protected! if APP_CONFIG.protected
          data = PuppetWebhook::Parsers.new(headers, req_body).params
          prefix = get_prefix(data)
          branch = get_branch(data)
          env = get_env(branch, prefix)

          EnvironmentController.helpers R10kHelpers

          # Short circuit if this event is ignored
          # return 200 if ignore_event?

          if ignore_env?(env)
            logger.info("Skipping deployment of environment #{env} according to ignore_environments configuration parameter")
            return 200
          else
            logger.info("Deploying environment #{env}")
            # Replace this with Sidekiq
            Deploy::EnvironmentWorker.perform_async(branch, config)
          end
        end

        private

        def headers
          headers = {}
          request.env.each do |k, v|
            headers[k.to_s] = v.to_s if k =~ %r{^([A-Z]|_)+$}
          end
          headers
        end

        def req_body
          request.body.rewind
          request.body.read
        end

        def get_prefix(data)
          case APP_CONFIG.prefix
          when 'repo'
            data.repo_name
          when 'user'
            data.repo_user
          when String
            APP_CONFIG.prefix
          end
        end

        def get_branch(data)
          return APP_CONFIG.default_branch if data.deleted

          data.branch
        end

        def get_env(branch, prefix)
          if prefix.nil? || prefix.empty? || branch.nil? || branch.empty?
            normalize(APP_CONFIG.allow_uppercase, branch)
          else
            normalize(APP_CONFIG.allow_uppercase, "#{prefix}_#{branch}")
          end
        end

        def ignore_env?(env)
          list = APP_CONFIG.ignore_environments
          return false if list.nil? || list.empty?

          list.each do |l|
            # Even unquoted array elements wrapped by slashes becomes strings after YAML parsing
            # So we need to convert it into Regexp manually
            if l =~ %r{^/.+/$}
              return true if env =~ Regexp.new(l[1..-2])
            elsif env == 1
              return true
            end
          end

          false
        end
      end
    end
  end
end
