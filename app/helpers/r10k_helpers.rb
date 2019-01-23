# R10k helper methods for the sinatra app
module R10kHelpers
  def deploy_environment(branch, deleted)
    r10k_args = ['environment', branch]
    generate_types = true unless deleted
    deploy(r10k_args, generate_types)
  end

  def deploy_module(module_name)
    r10k_args = ['module', module_name]
    generate_types = false
    deploy(r10k_args, generate_types)
  end

  private

  def deploy(r10k_args, generate_types)
    if APP_CONFIG.use_mcollective
      results = PuppetWebhook::Orchestrators::MCollective.new('r10k',
                                                              'deploy',
                                                              {
                                                                dtimeout: APP_CONFIG.discovery_timeout,
                                                                timeout: APP_CONFIG.client_timeout
                                                              },
                                                              APP_CONFIG.client_cfg,
                                                              r10k_args[0].to_sym => r10k_args[1]).run
      results.each do |result|
        raise result.results[:statusmsg] unless result.results[:statuscode].zero?
      end
      raise results.stats[:noresponsefrom] unless result.stats[:noresponsefrom].length.zero?

      message = result.results[:statusmsg]
    else
      command = "#{APP_CONFIG.command_prefix} r10k deploy #{r10k_args[0]} #{r10k_args[1]} #{r10k_arguments(r10k_args[0])}"
      message = run_command(command)
    end
    status_message = { status: :success, message: message.to_s, branch: branch, status_code: 202 }
    logger.info("message: #{message} branch: #{branch}")
    if generate_types
      generate_types(r10k_args[1]) if APP_CONFIG.generate_types
    end
    notification(status_message)
    [status_message[:status_code], status_message.to_json]
  rescue StandardError => e
    status_message = { status: :fail, message: e.message, trace: e.backtrace, status_code: 500 }
    logger.error("message: #{e.message} trace: #{e.backtrace}")
    status 500
    notification(status_message)
    status_message.to_json
  end

  def r10k_arguments(command)
    return APP_CONFIG.r10k_deploy_arguments if command == 'environment'

    '-v'
  end

  def run_command(command)
    message = "forked: #{command}"
    system "#{command} &"
    message
  end

  def generate_types(environment)
    command = "#{settings.command_prefix} /opt/puppetlabs/puppet/bin/puppet generate types --environment #{environment}"

    message = run_command(command)
    logger.info("message: #{message} environment: #{environment}")
    status_message = { status: :success, message: message.to_s, environment: environment, status_code: 200 }
    notification(status_message)
  rescue StandardError => e
    logger.error("message: #{e.message} trace: #{e.backtrace}")
    status_message = { status: :fail, message: e.message, trace: e.backtrace, environment: environment, status_code: 500 }
    notification(status_message)
  end
end
