# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'

# Main sinatra app class
class ApplicationController < Sinatra::Base
  configure do
    register Sinatra::ActiveRecordExtension
    set :database, "sqlite3:db/#{environment}.sqlite3"
    set :public_folder, 'public'
    set :views, 'app/views'

    # Logging settings
    logger = Logger.new(STDOUT)
    logger.level = PuppetWebhook.loglevel
    set :logger, logger
  end

  not_found do
    halt 404, "You shall not pass! (page not found)\n"
  end

  get '/' do
    not_found
  end

  get '/heartbeat' do
    json status: :success, message: 'running'
  end

  private

  def protected!
    env['warden'].authenticate!(:access_token, :basic)
  end

  def authorized?
    # TODO: add token-based authentication?
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials &&
      @auth.credentials == [APP_CONFIG.user, APP_CONFIG.pass]
  end

  def normalize(allow_upper, str)
    allow_upper ? str : str.downcase
  end

  def notification(message)
    return unless APP_CONFIG.chatops || APP_CONFIG.slack_webhook

    require 'plugins/chatops'

    slack_settings if APP_CONFIG.chatops == false && APP_CONFIG.slack_webhook != false
    PuppetWebhook::Chatops.new(APP_CONFIG.chatops_service,
                               APP_CONFIG.chatops_url,
                               APP_CONFIG.chatops_channel,
                               APP_CONFIG.chatops_user,
                               APP_CONFIG.chatops_options).notify(message)
  end

  # Deprecated
  # TODO: Remove in release 3.0.0
  def slack_settings
    APP_CONFIG.chatops_service = 'slack'
    logger.warn('APP_CONFIG.slack_webhook is deprecated and will be removed in puppet_webhook 3.0.0')
    APP_CONFIG.chatops_url = APP_CONFIG.slack_webhook
    logger.warn('APP_CONFIG.slack_user is deprecated and will be removed in puppet_webhook 3.0.0')
    APP_CONFIG.chatops_user = APP_CONFIG.slack_user
    logger.warn('APP_CONFIG.slack_channel is deprecated and will be removed in puppet_webhook 3.0.0')
    APP_CONFIG.chatops_channel = APP_CONFIG.slack_channel
    logger.warn('APP_CONFIG.slack_emoji is deprecated and will be removed in puppet_webhook 3.0.0')
    APP_CONFIG.chatops_options[:icon_emoji] = APP_CONFIG.slack_emoji
    logger.warn('APP_CONFIG.slack_proxy_url is deprecated and will be removed in puppet_webhook 3.0.0')
    APP_CONFIG.chatops_options[:http_options] = if APP_CONFIG.slack_proxy_url
                                                  slack_proxy
                                                else
                                                  {}
                                                end
  end

  def headers
    headers = {}
    request.env.each do |k, v|
      headers[k.to_s] = v.to_s if k =~ %r{^([A-Z]|_)+$}
    end
    headers
  end

  def req_body
    request.body.rewind
    request.body.read
  end
end
