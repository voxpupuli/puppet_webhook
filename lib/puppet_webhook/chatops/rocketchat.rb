# frozen_string_literal: true

require 'rocket-chat-notifier'

class PuppetWebhook
  class Chatops
    # Sets up Rocketchat object that will send notifications to Slack via a webhook.
    class Rocketchat
      def initialize(channel, url, user, message, options = {})
        @channel = channel
        @url = url
        @user = user
        @message = message
        @options = options
      end

      def notify
        notifier = RocketChat::Notifier.new @url, http_options: @options[:http_options]
        notifier.username = @user
        notifier.channel = @channel

        target = if @message[:branch]
                   @message[:branch]
                 elsif @message[:module]
                   @message[:module]
                 end

        msg = "r10k deployment of Puppet environment/module #{target} started..."

        attachment = format_attachment(target)

        notifier.ping(msg, icon_emoji: @options[:icon_emoji], attachments: [attachment])
      end

      private

      def format_attachment(target)
        attachment = {
          author: 'r10k for Puppet',
          title: "r10k deployment of Puppet environment #{target}"
        }

        case @message[:status_code]
        when 200
          attachment.merge!(
            color: 'good',
            text: "Successfully started deployment of #{target}",
            fallback: "Successfully started deployment of #{target}"
          )
        when 500
          attachment.merge!(
            color: 'bad',
            text: "Failed to deploy #{target}",
            fallback: "Failed to deploy #{target}"
          )
        end

        attachment
      end
    end
  end
end
