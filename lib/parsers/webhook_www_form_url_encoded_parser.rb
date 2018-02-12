require 'rack/bodyparser'
require 'json'

require_relative 'webhook_parser'

module Sinatra
  module Parsers
    class WebhookWWWFormURLEncodedParser # rubocop:disable Style/Documentation
      include Sinatra::Parsers::WebhookParser

      def parse_data(body)
        JSON.parse(CGI.unescape(body).gsub(%r{^payload\=}, ''))
      end
    end
  end
end
