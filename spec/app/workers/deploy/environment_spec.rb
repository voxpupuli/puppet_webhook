# frozen_string_literal: true

require 'spec_helper'

describe Deploy::EnvironmentWorker do
  let(:environment) { 'test' }
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

  let(:deploy) { double('R10K::Action::Deploy::Environment') }

  before do
    allow(R10K::Action::Deploy::Environment).to receive(:new) { deploy }
  end

  it 'successfully deploys environment' do
    job = Deploy::EnvironmentWorker.new
    expect(deploy).to receive(:call) { true }
    job.perform(environment, config)
  end
end
