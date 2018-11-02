require 'spec_helper'
require 'plugins/mcollective'

describe PuppetWebhook::Mcollective do
  describe '#initialize' do
    it 'should create a new object' do
      mcollective_object = PuppetWebhook::Mcollective.new('r10k',
                                                          'deploy',
                                                          {
                                                            timeout: 120,
                                                            dtimeout: 10
                                                          },
                                                          environment: 'production')
      expect(mcollective_object.instance_variable_get('@agent')).to eq('r10k')
      expect(mcollective_object.instance_variable_get('@command')).to eq('deploy')
      expect(mcollective_object.instance_variable_get('@timeout')).to eq(120)
      expect(mcollective_object.instance_variable_get('@dtimeout')).to eq(10)
      expect(mcollective_object.instance_variable_get('@args')).to eq(environment: 'production')
    end
  end

  describe '#run' do
    before(:each) do
      allow(PuppetWebhook::Mcollective).to receive(:new).and_return(nil)
    end

    it 'should run correctly' do
      result_data = {
        agent: 'puppet',
        action: 'disable',
        sender: 'example.net',
        statuscode: 0,
        statusmsg: 'OK',
        data: {
          status: 'Succesfully locked the Puppet agent: Disabled via MCollective by choria=vp.mcollective at 2017-12-25 07:59',
          enabled: false
        }
      }

      allow(PuppetWebhook::Mcollective).to receive(:run).and_return(result_data)
      expect(PuppetWebhook::Mcollective.run).to eq(result_data)
    end
  end

  describe '#client' do
    context 'expect return of a client object' do
      before(:each) do
        allow(PuppetWebhook::Mcollective).to receive(:new).and_return(nil)
        allow(MCollective::RPC::Client).to receive(:new).and_return(nil)
      end

      it 'is expected to return a client to send commands to' do
        client_data = {
          agent: 'r10k',
          timeout: 120,
          discovery_timeout: 10,
          progress: false
        }

        allow(PuppetWebhook::Mcollective).to receive(:client).and_return(client_data)
        expect(PuppetWebhook::Mcollective.client).to eq(client_data)
      end
    end
  end
end
