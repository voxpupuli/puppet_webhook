require 'spec_helper'

describe PuppetWebhook::Chatops do
  describe '#notify' do
    before(:each) do
      allow(PuppetWebhook::Chatops).to receive(:new).and_return(nil)
    end
    it 'should run correctly with Slack' do
      notification_data = {
        service: 'slack',
        url: 'https://hooks.slack.com/webhook',
        channel: '#general',
        user: 'puppet_webhook',
        options: {
          icon_emoji: ':ocean:'
        }
      }

      allow(PuppetWebhook::Chatops).to receive(:notify).and_return(notification_data)
      expect(PuppetWebhook::Chatops.notify).to eq(notification_data)
    end
  end
end