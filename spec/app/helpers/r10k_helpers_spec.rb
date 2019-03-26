require 'spec_helper'

class TestHelpers
  include R10kHelpers
end

describe R10kHelpers do
  subject { TestHelpers.new }

  describe '#config' do
    context 'without configfile' do
      let(:r10k_config) do
        {
          sources: {
            main: {
              remote: 'git@example.com:foo/bar.git',
              basedir: '/etc/foo/bar'
            }
          }
        }
      end

      it 'returns a success' do
        allow(subject).to receive(:config).and_return(r10k_config)
        expect(subject.config).to eq(r10k_config)
      end
    end
  end
end
