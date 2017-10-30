module Deployments
  def deploy(branch, deleted)
    begin
      if settings.use_mco_ruby
        result = mco(branch).first
        if result.results[:statuscode] == 0
          message = result.results[:statusmsg]
        else
          raise result.results[:statusmsg]
        end
      else
        if settings.use_mcollective
          command = "#{COMMAND_PREFIX} mco r10k deploy #{branch} #{settings.mco_arguments}"
        else
          # If you don't use mcollective then this hook needs to be running as r10k's user i.e. root
          command = "#{COMMAND_PREFIX} r10k deploy environment #{branch} #{settings.r10k_deploy_arguments}"
        end
        message = run_command(command)
      end
      status_message =  { status: :success, message: message.to_s, branch: branch, status_code: 200 }
      LOGGER.info("message: #{message} branch: #{branch}")
      unless deleted
        generate_types(branch) if types?
      end
      notify_slack(status_message) if slack?
      status_message.to_json
    rescue => e
      status_message = {status: :fail, message: e.message, trace: e.backtrace, branch: branch, status_code: 500 }
      LOGGER.error("message: #{e.message} trace: #{e.backtrace}")
      status 500
      notify_slack(status_message) if slack?
      status_message.to_json
    end
  end

  def deploy_module(module_name)
    begin
      if settings.use_mcollective
        command = "#{COMMAND_PREFIX} mco r10k deploy_module #{module_name} #{settings.mco_arguments}"
      else
        command = "#{COMMAND_PREFIX} r10k deploy module #{module_name}"
      end
      message = run_command(command)
      LOGGER.info("message: #{message} module_name: #{module_name}")
      status_message = { status: :success, message: message.to_s, module_name: module_name, status_code: 200 }
      notify_slack(status_message) if slack?
      status_message.to_json
    rescue => e
      LOGGER.error("message: #{e.message} trace: #{e.backtrace}")
      status 500
      status_message = { status: :fail, message: e.message, trace: e.backtrace, module_name: module_name, status_code: 500 }
      notify_slack(status_message) if slack?
      status_message.to_json
    end
  end
end
