require 'mcollective'

class PuppetWebhook
  # Creates an Mcollective Agent object for running MCO agents
  class Mcollective
    attr_reader :results, :stats
    include MCollective::RPC

    def initialize(agent, command, timeouts = nil, options = nil, nodes = [], **args) # rubocop:disable Metrics/ParameterLists
      @agent = agent
      @command = command
      @timeout = timeouts[:timeout] || '120'
      @dtimeout = timeouts[:dtimeout] || '10'
      @options = options
      @nodes = nodes
      @args = args
    end

    def run
      LOGGER.info("Starting request for #{@agent}##{@command}")

      begin
        @results = client.send(@command, @args)
      rescue StandardError => e
        LOGGER.error("Error: #{e}")
      end

      @stats = client.stats
    end

    def client
      client = MCollective::RPC::Client.new(@agent, config_file: MCollective::Util.config_file_for_user, options: MCollective::Util.default_options)
      client.config = @options if @options
      client.timeout = @timeout if @timeout
      client.discovery_timeout = @dtimeout if @dtimeout
      client.progress = false
      client
    end
  end
end
