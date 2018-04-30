require 'sinatra/base'
require 'sinatra/config_file'
require 'json'
require 'cgi'
require 'parsers/webhook_json_parser'
require 'parsers/webhook_www_form_url_encoded_parser'

# Routes
require_relative 'routes/default'
require_relative 'routes/module'
require_relative 'routes/payload'

class PuppetWebhook < Sinatra::Base # rubocop:disable Style/Documentation
  set :root, File.dirname(__FILE__)
  use Rack::BodyParser,
      parsers: {
        'application/json' => Sinatra::Parsers::WebhookJsonParser.new,
        'application/x-www-form-urlencoded' => Sinatra::Parsers::WebhookWWWFormURLEncodedParser.new
      },
      handlers:  {
        'application/json' => proc { |e, type|
          [400, { 'Content-Type' => type }, [{ error: e.to_s }.to_json]]
        }
      }
  register Sinatra::ConfigFile

  config_file(File.join(__dir__, '..', 'config', 'app.yml'), '/etc/puppet_webhook/app.yml')

  # Sinatra settings
  set :static, false
  set :lock, true

  # Custom Settings
  set :protected, false unless settings.respond_to? :protected=
  set :client_cfg, '/etc/puppetlabs/mcollective/client.cfg' unless settings.respond_to? :client_cfg=
  set :client_timeout, '120' unless settings.respond_to? :client_timeout=
  set :use_mco_ruby, false unless settings.respond_to? :use_mco_ruby=
  set :use_mcollective, false unless settings.respond_to? :use_mcollective=
  set :discovery_timeout, false unless settings.respond_to? :discovery_timeout=
  set :chatops, false unless settings.respond_to? :chatops=
  set :chatops_service, 'slack' unless settings.respond_to? :chatops_service=
  set :chatops_url, '' unless settings.respond_to? :chatops_url=
  set :chatops_channel, '#general' unless settings.respond_to? :chatops_channel=
  set :chatops_user, 'puppet_webhook' unless settings.respond_to? :chatops_user=
  set :chatops_options, {} unless settings.respond_to? :chatops_options=
  set :default_branch, 'production' unless settings.respond_to? :default_branch=
  set :ignore_environments, [] unless settings.respond_to? :ignore_environments=
  set :prefix, nil unless settings.respond_to? :prefix=
  set :prefix_command, '' unless settings.respond_to? :prefix_command=
  set :r10k_deploy_arguments, '-pv' unless settings.respond_to? :r10k_deploy_arguments=
  set :allow_uppercase, true unless settings.respond_to? :allow_uppercase=
  set :command_prefix, 'umask 0022;' unless settings.respond_to? :command_prefix=
  set :github_secret, nil unless settings.respond_to? :github_secret=
  set :repository_events, nil unless settings.respond_to? :respository_events=

  require 'helpers/init'

  register Sinatra::PuppetWebhookRoutes::Default
  register Sinatra::PuppetWebhookRoutes::Module
  register Sinatra::PuppetWebhookRoutes::Payload

  not_found do
    halt 404, "You shall not pass! (page not found)\n"
  end
end
