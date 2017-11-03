require 'spec_helper'

describe PuppetWebhook do
  it '/heartbeat returns 200 ok and success message' do
    get '/heartbeat'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('{"status":"success","message":"running"}')
  end
end
