# frozen_string_literal: true

require 'slack-notifier'

module PuppetWebhook
  class Chatops
    # Sets up Slack object that will send notifications to Slack via a webhook.
    class Slack
      def initialize(channel, url, user, message, options = {})
        @channel = channel
        @url = url
        @user = user
        @message = message
        @options = options
      end

      def notify
        notifier = ::Slack::Notifier.new @url, http_options: @options[:http_options]

        target = if @message[:branch]
                   @message[:branch]
                 elsif @message[:module]
                   @message[:module]
                 end

        msg = format_message(target)

        notifier.post text: msg[:fallback],
                      channel: @channel,
                      username: @user,
                      icon_emoji: @options[:icon_emoji],
                      attachments: [msg]
      end

      private

      def format_message(target)
        message = {
          author: 'r10k for Puppet',
          title: "r10k deployment of Puppet environment #{target}"
        }

        case @message[:status_code]
        when 202
          message.merge!(
            color: 'good',
            text: "Successfully started deployment of #{target}",
            fallback: "Successfully started deployment of #{target}"
          )
        when 500
          message.merge!(
            color: 'bad',
            text: "Failed to deploy #{target}",
            fallback: "Failed to deploy #{target}"
          )
        end

        message
      end
    end
  end
end
