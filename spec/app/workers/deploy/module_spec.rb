require 'spec_helper'

describe Deploy::ModuleWorker do
  let(:ppt_module) { 'foobar' }
  let(:config) do
    {
      sources: {
        main: {
          remote: 'https://example.com/foo/bar',
          basedir: '/etc/foo/bar'
        }
      }
    }
  end

  let(:deploy) { double('R10K::Action::Deploy::Module') }

  before do
    allow(R10K::Action::Deploy::Module).to receive(:new) { deploy }
  end

  it 'successfully deploys a module' do
    job = Deploy::ModuleWorker.new
    expect(deploy).to receive(:call) { true }
    job.perform(ppt_module, config)
  end
end
