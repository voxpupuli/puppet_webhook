require 'spec_helper'

describe PuppetWebhook::Parsers do
  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }
  let(:result) do
    {
      branch: 'master',
      deleted: false,
      module_name: 'r10k',
      repo_name: 'puppet-r10k',
      repo_user: 'moduletux'
    }
  end

  context 'github' do
    before { headers['HTTP_X_GITHUB_EVENT'] = 'Push Event' }
    let(:body) { File.read('spec/fixtures/github/create.json') }

    subject { described_class.new(headers, body) }

    it 'should return github data' do
      expect(subject.params).to eq(OpenStruct.new(result))
    end
  end

  context 'gitlab' do
    before { headers['HTTP_X_GITLAB_EVENT'] = 'Push Event' }
    let(:body) { File.read('spec/fixtures/gitlab/create.json') }

    subject { described_class.new(headers, body) }

    it 'should return gitlab data' do
      result[:branch] = 'feature_branch'
      result[:repo_user] = 'dhollinger'
      expect(subject.params).to eq(OpenStruct.new(result))
    end
  end

  context 'bitbucket server' do
    before do
      headers.merge!('HTTP_X_EVENT_KEY' => 'Push', 'HTTP_X_REQUEST_ID' => '12345')
    end
    let(:body) { File.read('spec/fixtures/bitbucket-server/create.json') }

    subject { described_class.new(headers, body) }

    it 'returns bitbucket server data' do
      result[:branch] = 'test-branch'
      result[:module_name] = 'Control'
      result[:repo_name] = 'Puppet-Control'
      result.delete(:repo_user)
      expect(subject.params).to eq(OpenStruct.new(result))
    end
  end

  context 'stash/bitbucket server using Post-Receive WebHooks plugin' do
    before do
      headers.merge!('HTTP_X_ATLASSIAN_TOKEN' => 'no-check')
    end
    let(:body) { File.read('spec/fixtures/stash/create.json') }

    subject { described_class.new(headers, body) }

    it 'returns webhook plugin data' do
      result[:branch] = 'feature_branch'
      result.delete(:repo_user)
      expect(subject.params).to eq(OpenStruct.new(result))
    end
  end

  context 'visual studio team services' do
    let(:body) { File.read('spec/fixtures/tfs/update.json') }

    subject { described_class.new(headers, body) }

    it 'returns vsts data' do
      result[:branch] = 'feature_branch'
      result.delete(:repo_user)
      expect(subject.params).to eq(OpenStruct.new(result))
    end
  end
end
