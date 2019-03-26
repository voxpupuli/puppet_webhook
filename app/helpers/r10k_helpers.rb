# R10k helper methods for the sinatra app
module R10kHelpers
  def config
    config = APP_CONFIG.configfile ||= '/etc/puppetlabs/r10k/r10k.yaml'
    YAML.load_file(config)
  end
end
