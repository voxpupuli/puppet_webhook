require 'chatops/slack'

class PuppetWebhook
  class Chatops
    def initialize(message, service, url, channel, user, **args)
      @message = message
      @service = service
      @url = url
      @channel = channel
      @user = user
      @args = args
    end

    def notify
      case @service
      when 'slack'
        Chatops::Slack.new(@channel, @url, @user, @args[:icon_emoji], @args[:http_options]).notify
      else
        LOGGER.error("Service #{@service} is not currently supported")
      end
    end
  end
end