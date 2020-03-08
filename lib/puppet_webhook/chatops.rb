# frozen_string_literal: true

module PuppetWebhook
  # Chatops object for sending webhook notifications to chatops tools
  #
  # @example
  #   chatops = PuppetWebhook::Chatops.new('slack', 'https://webhook.slack.com/blah', '#general', 'slack_user')
  #   chatops.notify('It works!')
  class Chatops
    # Public: Initialize Chatops class.
    #
    # @param [String] service Name of the service to use.
    # @param [String] url Webhook/Service url to send notification.
    # @param [String] channel Channel or room to post to.
    # @param [String] user User to post as.
    # @param [Hash] options Service-specific options to send.
    #
    # @return [PuppetWebhook::Chatops]
    def initialize(service, url, channel, user, options = {})
      @service = service
      @url = url
      @channel = channel
      @user = user
      @args = options
    end

    # Public: Send notification to service. Will dynamically detect
    # which service is being used and initialize a new object for said class.
    #
    # @param [String] message Message string to pass to the upstream object.
    def notify(message)
      case @service
      when 'slack'
        require_relative 'chatops/slack'
        logger.info("Sending Slack webhook message to #{@url}")
        Chatops::Slack.new(
          @channel,
          @url,
          @user,
          message,
          http_options: @args[:http_options] || {},
          icon_emoji: @args[:icon_emoji]
        ).notify
      when 'rocketchat'
        require_relative 'chatops/rocketchat'
        logger.info("Sending Rocket.Chat webhook message to #{@url}")
        Chatops::Rocketchat.new(
          @channel,
          @url,
          @user,
          message,
          http_options: @args[:http_options] || {},
          icon_emoji: @args[:icon_emoji]
        ).notify
      else
        LOGGER.error("Service #{@service} is not currently supported")
      end
    end
  end
end
