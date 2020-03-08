# frozen_string_literal: true

require 'spec_helper'

def app
  ApplicationController
end

describe ApplicationController do
  it 'responds with a 404 message' do
    get '/'
    expect(last_response.status).to eq(404)
    expect(last_response.body).to include("You shall not pass! (page not found)\n")
  end

  it 'responds with a heartbeat' do
    response = {
      status: 'success',
      message: 'running'
    }.to_json
    get '/heartbeat'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include(response)
  end
end
