require 'spec_helper'

describe Sinatra::Parsers::WebhookJsonParser do
  services = %w[stash bitbucket github gitlab tfs]
  let(:result) { subject.call(payload) }
  services.each do |service|
    context "when payload is from #{service}" do
      describe '#call' do
        context 'payload is an update' do
          let(:payload) { read_fixture("#{service}/update.json") }
          it 'returns correctly populated params hash' do
            expect(subject).to receive(:detect_vcs).and_return(service)
            expect(result).to include(
              branch: 'feature_branch',
              deleted: false,
              module_name: 'r10k',
              repo_name: 'puppet-r10k'
            )
          end
          it 'does not populate repo_user', unless: service =~ %r{github|gitlab} do
            # The stash payload doesn't contain anything we could use for repo_user
            expect(subject).to receive(:detect_vcs).and_return(service)
            expect(result).not_to include(:repo_user)
          end
        end

        context 'payload is for a delete' do
          let(:payload) { read_fixture("#{service}/delete.json") }
          it 'returns params hash with :deleted => true' do
            expect(subject).to receive(:detect_vcs).and_return(service)
            expect(result).to include(deleted: true)
          end
        end
      end

      describe '#detect_vcs' do
        it 'detects the correct VCS' do
          subject.env = read_json_fixture("#{service}/update-headers.json")
          subject.data = read_json_fixture("#{service}/update.json")
          expect(subject.detect_vcs).to eq(service)
        end
      end
    end
  end

  describe '#detect_vcs' do
    context 'unrecognised payload' do
      it 'raises an error' do
        subject.env = {}
        subject.data = {}
        expect { subject.detect_vcs }.to raise_error(StandardError, 'payload not recognised')
      end
    end
  end
end
