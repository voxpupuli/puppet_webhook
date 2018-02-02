# require 'spec_helper'
#
# describe PuppetWebhook::Mcollective do
#   describe '#run' do
#     let(:create) { }
#     let(:mco) do
#       PuppetWebhook::Mcollective.new do |opts|
#         opts.agent = 'r10k',
#         opts.command = 'deploy',
#         opts.args = { environment: 'production' },
#       end
#     end
#   end
#
#   it 'returns an mcollective run' do
#     allow(run).to receive(:rpc) { }
#   end
# end