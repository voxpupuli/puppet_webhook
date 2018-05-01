require 'plugins/chatops/slack'

class PuppetWebhook
  # Chatops object for sending webhook notifications to chatops tools
  class Chatops
    def initialize(service, url, channel, user, options = {})
      @service = service
      @url = url
      @channel = channel
      @user = user
      @args = options
    end

    def notify(message)
      case @service
      when 'slack'
        LOGGER.info("Sending Slack webhook message to #{@url}")
        Chatops::Slack.new(
          @channel, @url, @user, message, http_options: @args[:http_options] || {}, icon_emoji: @args[:icon_emoji]
        ).notify
      when 'rocketchat'
        LOGGER.info("Sending Rocket.Chat webhook message to #{@url}")
        Chatops::Rocketchat.new(
          @channel, @url, @user, message, http_options: @args[:http_options] || {}, icon_emoji: @args[:icon_emoji]
        ).notify
      else
        LOGGER.error("Service #{@service} is not currently supported")
      end
    end
  end
end
