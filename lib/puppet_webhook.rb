require 'sinatra/base'
require 'sinatra/config_file'
require 'json'
require 'cgi'
require 'parsers/webhook_json_parser'

# Routes
require_relative 'routes/default'
require_relative 'routes/module'
require_relative 'routes/payload'

class PuppetWebhook < Sinatra::Base # rubocop:disable Style/Documentation
  set :root, File.dirname(__FILE__)
  use Rack::BodyParser,
      parsers: { 'application/json' => Sinatra::Parsers::WebhookJsonParser.new },
      handlers: { 'application/json' => proc { |e, type| [400, { 'Content-Type' => type }, [{ error: e.to_s }.to_json]] } }
  register Sinatra::ConfigFile

  config_file(File.join(__dir__, '..', 'config', 'app.yml'), '/etc/puppet_webhook/app.yml')

  COMMAND_PREFIX = if settings.respond_to?(:command_prefix=)
                     settings.command_prefix
                   else
                     'umask 0022;'
                   end

  set :static, false
  set :lock, true if settings.enable_mutex_lock

  require 'helpers/init'

  register Sinatra::PuppetWebhookRoutes::Default
  register Sinatra::PuppetWebhookRoutes::Module
  register Sinatra::PuppetWebhookRoutes::Payload

  not_found do
    halt 404, "You shall not pass! (page not found)\n"
  end
end
