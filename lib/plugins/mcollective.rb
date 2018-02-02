require 'mcollective'

class PuppetWebhook
  class Mcollective
    include MCollective::RPC

    def initialize(agent, command, timeouts = {}, options = {}, **args)
      @agent = agent
      @command = command
      @timeout = timeouts[:timeout] || '120'
      @dtimeout = timeouts[:dtimeout] || '10'
      @options = MCollective::Util.default_options
      @options[:config] = options if options
      @args = args
    end

    # TODO: Fork process as MCO user or add docs to add webhook user to MCollective.
    def run
      LOGGER.info(@args)
      create.send(@command, @args)
    end

    def create
      rpcclient(@agent, exit_on_failure: false, timeout: @timeout, discovery_timeout: @dtimeout, options: @options)
    end
  end
end
