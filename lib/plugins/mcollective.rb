require 'mcollective'

class PuppetWebhook
  class Mcollective
    include MCollective::RPC

    def initialize(agent, command, timeouts, options, **args)
      @agent = agent
      @command = command
      @timeouts = timeouts
      @options = MCollective::Util.default_options
      @options[:config] = options if options
      @args = args
    end

    # TODO: Fork process as MCO user or add docs to add webhook user to MCollective.
    def run
      LOGGER.info(@args)
      client = rpcclient(@agent, exit_on_failure: false, options: @options)
      client.discovery_timeout = timeouts[:dtimeout] || '10'
      client.timeout = timeouts[:timeout] || '120'
      client.send(@command, @args)
    end

  end
end