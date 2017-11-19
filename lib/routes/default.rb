require 'sinatra'

module Sinatra
  module PuppetWebhookRoutes
    module Default
      def self.registered(puppet_webhook)
        puppet_webhook.get '/' do
          raise Sinatra::NotFound
        end

        puppet_webhook.get '/heartbeat' do
          return 200, { status: :success, message: 'running' }.to_json
        end
      end
    end
  end
end