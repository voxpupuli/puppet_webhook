# frozen_string_literal: true

require_relative 'payload'

module PuppetWebhook
  class Parsers
    # Sub-class of PuppetWebhook::Parsers::Payload for parsing payloads of
    # Content-Type: application/x-www-form-urlencoded
    #
    # @example
    #   request.body.rewind
    #   payload = PuppetWebhook::Parsers::WWWFormURLEncoded.new(request.env, request.body.read)
    #   payload.parse!
    class WWWFormURLEncoded < Payload
      # Public: Parse URL encoded form data into OpenStruct
      #
      # @return [OpenStruct]
      def parse_data
        @data = ActiveSupport::JSON.decode(@body)
        parse!
      end
    end
  end
end
