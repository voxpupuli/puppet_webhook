require 'r10k/action/deploy/module'

module Deploy
  # This worker deploy a puppet module via the R10K API.
  class ModuleWorker < ApplicationWorker
    def perform(ppt_module, config)
      # r10k doesn't like stringified hash keys. This forces symbolized keys
      config = config.symbolize_keys
      deploy = R10K::Action::Deploy::Module.new({ config: config }, [ppt_module], config).call

      raise 'Failed to deploy' unless deploy
    end
  end
end
