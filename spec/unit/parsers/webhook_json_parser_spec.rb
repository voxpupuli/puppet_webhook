require 'spec_helper'

describe Sinatra::Parsers::WebhookJsonParser do
  let(:result) { subject.call(payload) }
  context 'when payload is from stash' do
    describe '#call' do
      context 'payload is an update' do
        let(:payload) { read_fixture('stash/update.json') }
        it 'returns correctly populated params hash' do
          expect(result).to include(
            branch: 'feature_branch',
            deleted: false,
            module_name: 'r10k',
            repo_name: 'puppet-r10k'
          )
        end
        it 'doesn\'t populate repo_user' do
          # The stash payload doesn't contain anything we could use for repo_user
          expect(result).not_to include(:repo_user)
        end
      end
      context 'payload is for a delete' do
        let(:payload) { read_fixture('stash/delete.json') }
        it 'returns params hash with :deleted => true' do
          expect(result).to include(deleted: true)
        end
      end
    end
  end
end
