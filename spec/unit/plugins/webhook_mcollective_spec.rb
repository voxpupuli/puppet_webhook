require 'spec_helper'
require 'mcollective'

describe PuppetWebhook::Mcollective do
  describe '#run' do
    before(:each) do
      allow(PuppetWebhook::Mcollective).to receive(:new).and_return(nil)
    end
    it 'should run correctly' do
      result_data = {
        :agent => 'puppet',
        :action => 'disable',
        :sender => 'example.net',
        :statuscode => 0,
        :statusmsg => 'OK',
        :data => {
            :status => "Succesfully locked the Puppet agent: Disabled via MCollective by choria=vp.mcollective at 2017-12-25 07:59",
            :enabled => false
        }
      }

      allow(PuppetWebhook::Mcollective).to receive(:run).and_return(result_data)
      expect(PuppetWebhook::Mcollective.run).to eq(result_data)
    end
  end
end