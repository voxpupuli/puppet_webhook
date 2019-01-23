require 'spec_helper'

class TestHelpers
  include R10kHelpers
end

describe R10kHelpers do
  subject { TestHelpers.new }

  describe '#deploy_environment' do
    context 'with valid branch' do
      let(:branch) { 'master' }
      let(:r10k_args) { ['environment', branch] }
      let(:deleted) { false }
      it 'returns a success' do
        allow(subject).to receive(:deploy).with(r10k_args, true).and_return(true)
        expect(subject.deploy_environment(branch, deleted)).to eq(true)
      end
    end

    context 'with invalid branch' do
      let(:branch) { false }
      let(:r10k_args) { ['environment', branch] }
      let(:deleted) { false }
      it 'returns a failure' do
        allow(subject).to receive(:deploy).with(r10k_args, true).and_return(false)
        expect(subject.deploy_environment(branch, deleted)).to eq(false)
      end
    end
  end

  describe '#deploy_module' do
    context 'with valid module' do
      let(:module_name) { 'foo-bar' }
      let(:r10k_args) { ['module', module_name] }
      it 'returns a success' do
        allow(subject).to receive(:deploy).with(r10k_args, false).and_return(true)
        expect(subject.deploy_module(module_name)).to eq(true)
      end
    end
  end
end
