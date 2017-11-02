require 'sinatra/base'
require 'sinatra/config_file'
require 'json'
require 'cgi'
require 'parsers/webhook_json_parser'

class PuppetWebhook < Sinatra::Base
  use Rack::Parser,
    parsers: { 'application/json' => Sinatra::Parsers::WebhookJsonParser.new },
    handlers: { 'application/json' => proc { |e, type| [400, { 'Content-Type' => type }, [{ error: e.to_s }.to_json]] } }
  register Sinatra::ConfigFile
  config_file '../config.yml'

  set :static, false
  set :lock, true if settings.enable_mutex_lock

  require 'helpers/init'

  get '/' do
    raise Sinatra::NotFound
  end

  get '/heartbeat' do
    return 200, { status: :success, message: 'running' }.to_json
  end

  # Simulate a github post:
  # curl -d '{ "repository": { "name": "puppetlabs-stdlib" } }' -H "Accept: application/json" 'https://puppet:487156B2-7E67-4E1C-B447-001603C6B8B2@localhost:8088/module' -k -q
  #
  # Simulate a BitBucket post:
  # curl -X POST -d '{ "repository": { "full_name": "puppetlabs/puppetlabs-stdlib", "name": "PuppetLabs : StdLib" } }' 'https://puppet:puppet@localhost:8088/module' -k -q
  # This example shows that, unlike github, BitBucket allows special characters
  # in repository names but translates it to generate a full_name which
  # is used in the repository URL and is most useful for this webhook handler.
  post '/module' do
    protected! if settings.protected
    request.body.rewind # in case someone has already read it

    # Short circuit if we're ignoring this event
    return 200 if ignore_event?

    decoded = request.body.read
    verify_signature(decoded) if verify_signature?
    data = JSON.parse(decoded, quirks_mode: true)

    if data['repository'].key?('full_name')
      # Handle BitBucket webook
      module_name = (data['repository']['full_name']).sub(%r{^.*\/.*-}, '')
    else
      module_name = data['repository']['name'].sub(%r{^.*-}, '')
    end

    module_name = sanitize_input(module_name)
    LOGGER.info("Deploying module #{module_name}")
    deploy_module(module_name)
  end

  # Simulate a github post:
  # curl -d '{ "ref": "refs/heads/production" }' -H "Accept: application/json" 'https://puppet:puppet@localhost:8088/payload' -k -q
  #
  # If using stash look at the stash_mco.rb script included here.
  # It will filter the stash post and make it look like a github post.
  #
  # Simulate a Gitorious post:
  # curl -X POST -d '%7b%22ref%22%3a%22master%22%7d' 'http://puppet:puppet@localhost:8088/payload' -q
  # Yes, Gitorious does not support https...
  #
  # Simulate a BitBucket post:
  # curl -X POST -d '{ "push": { "changes": [ { "new": { "name": "production" } } ] } }' 'https://puppet:puppet@localhost:8088/payload' -k -q

  post '/payload' do
    LOGGER.info "params = #{params}"
    protected! if settings.protected
    request.body.rewind # in case someone already read it

    # Short circuit if we're ignoring this event
    return 200 if ignore_event?

    # Check if content type is x-www-form-urlencoded
    if request.content_type.to_s.downcase.eql?('application/x-www-form-urlencoded')
      decoded = CGI.unescape(request.body.read).gsub(/^payload\=/, '')
    else
      decoded = request.body.read
    end
    verify_signature(decoded) if settings.github_secret
    data = JSON.parse(decoded, quirks_mode: true)

    # Iterate the data structure to determine what's should be deployed
    branch = params['branch']

    # If prefix is enabled in our config file, determine what the prefix should be
    prefix = case settings.prefix
             when :repo
               repo_name(data)
             when :user
               repo_user(data)
             when :command, TrueClass
               run_prefix_command(data.to_json)
             when String
               settings.prefix
             end

    # When a branch is being deleted, a deploy against it will result in a failure, as it no longer exists.
    # Instead, deploy the default branch, which will purge deleted branches per the user's configuration
    deleted = params['deleted']

    if deleted
      branch = settings.default_branch
    else
      branch = sanitize_input(branch)
    end

    # r10k doesn't yet know how to deploy all branches from a single source.
    # The best we can do is just deploy all environments by passing nil to
    # deploy() if we don't know the correct branch.
    if prefix.nil? or prefix.empty? or branch.nil? or branch.empty?
      env = normalize(branch)
    else
      env = normalize("#{prefix}_#{branch}")
    end

    if ignore_env?(env)
      LOGGER.info("Skipping deployment of environment #{env} according to ignore_environments configuration parameter")
      return 200
    else
      LOGGER.info("Deploying environment #{env}")
      deploy(env, deleted)
    end
  end

  not_found do
    halt 404, "You shall not pass! (page not found)\n"
  end
end
