require 'sinatra'

module Sinatra
  module PuppetWebhookRoutes
    # Registers a POST route for the Payload endpoint on PuppetWebhook
    module Payload
      def self.registered(puppet_webhook)
        puppet_webhook.post '/payload' do # rubocop:disable Metrics/BlockLength
          LOGGER.info "params = #{params}"
          protected! if settings.protected
          request.body.rewind # in case someone already read it

          # Short circuit if we're ignoring this event
          return 200 if ignore_event?

          # Check if content type is x-www-form-urlencoded
          decoded = if request.content_type.to_s.casecmp('application/x-www-form-urlencoded').zero?
                      CGI.unescape(request.body.read).gsub(%r{^payload\=}, '')
                    else
                      request.body.read
                    end
          verify_signature(decoded) if verify_signature?
          data = JSON.parse(decoded, quirks_mode: true)

          # Iterate the data structure to determine what's should be deployed
          branch = params['branch']

          # If prefix is enabled in our config file, determine what the prefix should be
          prefix = case settings.prefix
                   when :repo
                     params['repo_name']
                   when :user
                     params['repo_user']
                   when :command, TrueClass
                     run_prefix_command(data.to_json)
                   when String
                     settings.prefix
                   end

          # When a branch is being deleted, a deploy against it will result in a failure, as it no longer exists.
          # Instead, deploy the default branch, which will purge deleted branches per the user's configuration
          deleted = params['deleted']

          branch = if deleted
                     settings.default_branch
                   else
                     sanitize_input(branch)
                   end

          # r10k doesn't yet know how to deploy all branches from a single source.
          # The best we can do is just deploy all environments by passing nil to
          # deploy() if we don't know the correct branch.
          env = if prefix.nil? || prefix.empty? || branch.nil? || branch.empty?
                  normalize(branch)
                else
                  normalize("#{prefix}_#{branch}")
                end

          if ignore_env?(env)
            LOGGER.info("Skipping deployment of environment #{env} according to ignore_environments configuration parameter")
            return 200
          else
            LOGGER.info("Deploying environment #{env}")
            deploy(env, deleted)
          end
        end
      end
    end
  end
end
