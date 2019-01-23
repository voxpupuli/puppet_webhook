require_relative 'payload'

module PuppetWebhook
  class Parsers
    # Sub-class of PuppetWebhook::Parsers::Payload for parsing payloads of
    # Content-Type: application/json
    #
    # @example
    #   request.body.rewind
    #   payload = PuppetWebhook::Parsers::JSON.new(request.env, request.body.read)
    #   payload.parse!
    class JSON < Payload
      # Public: Parse JSON HTTP body into OpenStruct
      #
      # @return [OpenStruct]
      def parse_data
        @data = ActiveSupport::JSON.decode(@body)
        parse!
      end
    end
  end
end
