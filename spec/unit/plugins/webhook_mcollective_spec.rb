require 'spec_helper'
require 'mcollective'

describe PuppetWebhook::Mcollective do
  describe '#run' do
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
    end
  end
end