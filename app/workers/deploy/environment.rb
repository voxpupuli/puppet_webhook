require 'r10k/action/deploy/environment'
require './app/helpers/puppet_helpers'

module Deploy
  # This worker will deploy a puppet environment using r10k then generate
  # puppet resource types from the code in the moduleapth.
  class EnvironmentWorker < ApplicationWorker
    def perform(environment, config, paths, deleted)
      # r10k doesn't like stringified hash keys. This forces symbolized keys
      config = config.symbolize_keys
      @basedir = config[:sources].first[1]['basedir']
      deploy = R10K::Action::Deploy::Environment.new({ config: config }, [environment], config).call

      if deploy # rubocop:disable Style/GuardClause
        generate_types(environment, paths) unless deleted
      else
        raise 'Failed to deploy'
      end
    end

    private

    def generate_types(environment, paths)
      env_object = PuppetHelpers.set_environment(environment, paths)
      inputs = PuppetHelpers.find_inputs(env_object)
      PuppetHelpers.gen_types(inputs, "#{@basedir}/#{environment}/.resource_types")
    end
  end
end
