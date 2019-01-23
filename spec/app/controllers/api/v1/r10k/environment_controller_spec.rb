require 'spec_helper'

describe 'Api::V1::R10K::EnvironmentController' do
  context 'valid body' do
    let(:body) { File.read('spec/fixtures/github/create.json') }
    let(:headers) do
      {
        'CONTENT_TYPE' => 'application/json',
        'HTTP_X_GITHUB_EVENT' => 'Push Event',
        'ACCEPT' => '*/*',
        'ACCEPT_ENCODING' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'USER_AGENT' => 'Ruby'
      }
    end

    it 'responds with a 200' do
      stub_request(:post, 'localhost/api/v1/r10k/environment').with(body: body, headers: headers).to_return(status: 200)

      Net::HTTP.post URI('http://localhost/api/v1/r10k/environment'), body, headers
    end
  end

  context 'invalid body' do
    let(:body) { { project: 'puppet-foo' }.to_json }
    let(:headers) do
      {
        'CONTENT_TYPE' => 'application/json',
        'HTTP_X_GITHUB_EVENT' => 'Push Event'
      }
    end

    it 'returns 500 internal server error' do
      stub_request(:post, 'localhost/api/v1/r10k/environment')
        .with(body: body, headers: headers).to_return(status: [500, 'Internal Server Error'])

      Net::HTTP.post URI('http://localhost/api/v1/r10k/environment'), body, headers
    end
  end
end
