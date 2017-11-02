require 'open3'
require 'slack-notifier'
require 'mcollective'
include MCollective::RPC

module Tasks
  def ignore_env?(env)
    list = settings.ignore_environments
    return false if list.nil? || list.empty?

    list.each do |l|
      # Even unquoted array elements wrapped by slashes becomes strings after YAML parsing
      # So we need to convert it into Regexp manually
      if l =~ %r{^/.+/$}
        return true if env =~ Regexp.new(l[1..-2])
      else
        return true if env == l
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

  def run_command(command)
    message = ''
    File.open(LOCKFILE, 'w+') do |file|
      # r10k has a small race condition which can cause failed deploys if two happen
      # more or less simultaneously. To mitigate, we just lock on a file and wait for
      # the other one to complete.
      file.flock(File::LOCK_EX)

      if Open3.respond_to?('capture3')
        stdout, stderr, exit_status = Open3.capture3(command)
        message = "triggered: #{command}\n#{stdout}\n#{stderr}"
      else
        message = "forked: #{command}"
        Process.detach(fork { exec "#{command} &" })
        exit_status = 0
      end
      raise "#{stdout}\n#{stderr}" if exit_status != 0
    end
    message
  end

  def generate_types(environment)
    command = "#{COMMAND_PREFIX} /opt/puppetlabs/puppet/bin generate types --environment #{environment}"

    message = run_command(command)
    LOGGER.info("message: #{message} environment: #{environment}")
    status_message = { status: :success, message: message.to_s, environment: environment, status_code: 200 }
    notify_slack(status_message) if slack?
  rescue => e
    LOGGER.error("message: #{e.message} trace: #{e.backtrace}")
    status_message = { status: :fail, message: e.message, trace: e.backtrace, environment: environment, status_code: 500 }
    notify_slack(status_message) if slack?
  end

  def notify_slack(status_message)
    return unless settings.slack_webhook

    slack_channel = settings.slack_channel  || '#default'
    slack_user    = settings.slack_username || 'r10k'

    if settings.slack_proxy_url
      uri = URI(settings.slack_proxy_url)
      http_options = {
        proxy_address:  uri.hostname,
        proxy_port:     uri.port,
        proxy_from_env: false
      }
    else
      http_options = {}
    end

    notifier = Slack::Notifier.new settings.slack_webhook do
      defaults channel: slack_channel,
               username: slack_user,
               icon_emoji: ':ocean:',
               http_options: http_options
    end

    if status_message[:branch]
      target = status_message[:branch]
    elsif status_message[:module]
      target = status_message[:module]
    end

    message = {
      author: 'r10k for Puppet',
      title: "r10k deployment of Puppet environment #{target}"
    }

    case status_message[:status_code]
    when 200
      message.merge!(
        color: 'good',
        text: "Successfully deployed #{target}",
        fallback: "Successfully deployed #{target}"
      )
    when 500
      message.merge!(
        color: 'bad',
        text: "Failed to deploy #{target}",
        fallback: "Failed to deploy #{target}"
      )
    end

    notifier.post text: message[:fallback], attachments: [message]
  end

  def slack?
    !!settings.slack_webhook
  end

  def types?
    !!settings.generate_tasks
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

  def mco(branch)
    options = MCollective::Util.default_options
    options[:config] = settings.client_cfg
    client = rpcclient('r10k', exit_on_failure: false, options: options)
    client.discovery_timeout = settings.discovery_timeout
    client.timeout           = settings.client_timeout
    client.send('deploy', environment: branch)
  end
end
