require 'spec_helper'

describe PuppetWebhook do
  it '/heartbeat returns 200 ok and success message' do
    get '/heartbeat'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('{"status":"success","message":"running"}')
  end

  it 'index returns 404 error message' do
    get '/'
    expect(last_response).not_to be_ok
    expect(last_response.body).to eq("You shall not pass! (page not found)\n")
  end

  it '/module returns data' do
    stub_const('LOGGER', Logger.new(STDOUT))
    header 'Content-Type', "application-json"
    header 'HTTP_X_GITLAB_EVENT', "Push Hook"
    header 'Authorization', "Basic #{Base64::encode64('puppet:puppet')}"
    post '/module', body: read_fixture('gitlab/update.json')
    puts last_response.body
  end
end
