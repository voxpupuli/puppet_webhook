require 'open3'
require 'slack-notifier'
require 'mcollective'

module Tasks # rubocop:disable Style/Documentation
  include MCollective::RPC

  def ignore_env?(env)
    list = settings.ignore_environments
    return false if list.nil? || list.empty?

    list.each do |l|
      # Even unquoted array elements wrapped by slashes becomes strings after YAML parsing
      # So we need to convert it into Regexp manually
      if l =~ %r{^/.+/$}
        return true if env =~ Regexp.new(l[1..-2])
      elsif env == 1
        return true
      end
    end

    false
  end

  # Check to see if this is an event we care about. Default to responding to all events
  def ignore_event?
    # Explicitly ignore Github ping events
    return true if request.env['HTTP_X_GITHUB_EVENT'] == 'ping'

    list = nil unless settings.repository_events
    event = request.env['HTTP_X_GITHUB_EVENT']

    # Negate this, because we should respond if any of these conditions are true
    !(list.nil? || (list == event) || list.include?(event))
  end

  def run_prefix_command(payload)
    IO.popen(settings.prefix_command, 'r+') do |io|
      io.write payload.to_s
      io.close_write
      begin
        io.readlines.first.chomp
      rescue StandardError
        ''
      end
    end
  end

  def run_command(command)
    message = "forked: #{command}"
    system "#{command} &"
    message
  end

  def generate_types(environment)
    command = "#{settings.command_prefix} /opt/puppetlabs/puppet/bin generate types --environment #{environment}"

    message = run_command(command)
    LOGGER.info("message: #{message} environment: #{environment}")
    status_message = { status: :success, message: message.to_s, environment: environment, status_code: 200 }
    notify_slack(status_message) if slack?
  rescue StandardError => e
    LOGGER.error("message: #{e.message} trace: #{e.backtrace}")
    status_message = { status: :fail, message: e.message, trace: e.backtrace, environment: environment, status_code: 500 }
    notify_slack(status_message) if slack?
  end

  def notification(message)
    return unless settings.chatops || settings.slack_webhook
    slack_settings if settings.chatops == false && settings.slack_webhook != false
    PuppetWebhook::Chatops.new(settings.chatops_service,
                               settings.chatops_url,
                               settings.chatops_channel,
                               settings.chatops_user,
                               settings.chatops_options).notify(message)
  end

  # Deprecated
  # TODO: Remove in release 3.0.0
  def slack_settings
    settings.chatops_service = 'slack'
    LOGGER.warn('settings.slack_webhook is deprecated and will be removed in puppet_webhook 3.0.0')
    settings.chatops_url = settings.slack_webhook
    LOGGER.warn('settings.slack_user is deprecated and will be removed in puppet_webhook 3.0.0')
    settings.chatops_user = settings.slack_user
    LOGGER.warn('settings.slack_channel is deprecated and will be removed in puppet_webhook 3.0.0')
    settings.chatops_channel = settings.slack_channel
    LOGGER.warn('settings.slack_emoji is deprecated and will be removed in puppet_webhook 3.0.0')
    settings.chatops_options[:icon_emoji] = settings.slack_emoji
    LOGGER.warn('settings.slack_proxy_url is deprecated and will be removed in puppet_webhook 3.0.0')
    settings.chatops_options[:http_options] = if settings.slack_proxy_url
                                                slack_proxy
                                              else
                                                {}
                                              end
  end

  # Deprecated
  # TODO: Remove in release 3.0.0
  def slack_proxy
    uri = URI(settings.slack_proxy_url)
    http_options = {
      proxy_address:  uri.hostname,
      proxy_port:     uri.port,
      proxy_from_env: false
    }
    http_options
  end

  def types?
    return false unless settings.respond_to?(:generate_types=)
    return false if settings.generate_types.nil?
    settings.generate_types
  end

  def authorized?
    # TODO: add token-based authentication?
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials &&
      @auth.credentials == [settings.user, settings.pass]
  end

  def verify_signature?
    true unless settings.github_secret.nil?
  end

  def protected!
    if authorized?
      LOGGER.info("Authenticated as user #{settings.user} from IP #{request.ip}")
    else
      response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
      LOGGER.error("Authentication failure from IP #{request.ip}")
      throw(:halt, [401, "Not authorized\n"])
    end
  end
end
