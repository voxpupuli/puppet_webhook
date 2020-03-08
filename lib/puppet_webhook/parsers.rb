# frozen_string_literal: true

require_relative 'parsers/json'
require_relative 'parsers/www_form_url_encoded'

module PuppetWebhook
  # Class object for parsing payloads from version control system webhook
  # services. This will parse content from the Rack::Request body (JSON) or
  # the Rack::Request params (Form data) into an OpenStruct object for use
  # by the Sinatra application.
  #
  # @example
  #   request.body.rewind
  #   data = PuppetWebhook::Parsers.new(request.env, request.body.read)
  #   data.params
  class Parsers
    # Public: Initialize the Parsers object
    #
    # @param [Sinatra::Request] request Rack request object to be parsed
    #
    # @return [PuppetWebhook::Parsers]
    def initialize(headers, body)
      @headers = headers
      @body = body
    end

    # Public: Pass request to appropriate sub-parser based on the Content-Type
    # request header.
    #
    # @return [OpenStruct]
    def params
      case @headers['CONTENT_TYPE']
      when 'application/json'
        PuppetWebhook::Parsers::JSON.new(@headers, @body).parse_data
      when 'application/x-www-form-urlencoded'
        PuppetWebhook::Parsers::WWWFormURLEncoded.new(@headers, @body).parse_data
      end
    end
  end
end
