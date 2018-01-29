require 'plugins/mcollective'

module Deployments # rubocop:disable Style/Documentation
  def deploy(branch, deleted)
    if settings.use_mcollective
      result = PuppetWebhook::Mcollective.new('r10k',
                                              'deploy',
                                              {
                                                dtimeoute: settings.discovery_timeout,
                                                timeout: settings.client_timeout
                                              },
                                              settings.client_cfg,
                                              environment: branch).run.first
      raise result.results[:statusmsg] unless result.results[:statuscode].zero?

      message = result.results[:statusmsg]
    else
      command = "#{settings.command_prefix} r10k deploy environment #{branch} #{settings.r10k_deploy_arguments}"
      message = run_command(command)
    end
    status_message = { status: :success, message: message.to_s, branch: branch, status_code: 200 }
    LOGGER.info("message: #{message} branch: #{branch}")
    unless deleted
      generate_types(branch) if types?
    end
    notify_slack(status_message) if slack?
    status_message.to_json
  rescue StandardError => e
    status_message = { status: :fail, message: e.message, trace: e.backtrace, branch: branch, status_code: 500 }
    LOGGER.error("message: #{e.message} trace: #{e.backtrace}")
    status 500
    notify_slack(status_message) if slack?
    status_message.to_json
  end

  def deploy_module(module_name)
    command = if settings.use_mcollective
                "#{settings.command_prefix} mco r10k deploy_module #{module_name} #{settings.mco_arguments}"
              else
                "#{settings.command_prefix} r10k deploy module #{module_name}"
              end
    message = run_command(command)
    LOGGER.info("message: #{message} module_name: #{module_name}")
    status_message = { status: :success, message: message.to_s, module_name: module_name, status_code: 200 }
    notify_slack(status_message) if slack?
    status_message.to_json
  rescue StandardError => e
    LOGGER.error("message: #{e.message} trace: #{e.backtrace}")
    status 500
    status_message = { status: :fail, message: e.message, trace: e.backtrace, module_name: module_name, status_code: 500 }
    notify_slack(status_message) if slack?
    status_message.to_json
  end
end
