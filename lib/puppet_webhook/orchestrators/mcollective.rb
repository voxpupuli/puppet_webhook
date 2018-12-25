require 'mcollective'

module PuppetWebhook
  class Orchestrators
    # Complete interface for creating and sending MCollective client calls to
    # a MCO or Choria compatible Mcollective agent. It will also return results
    # and stats information about the MCO run.
    #
    # @example
    #   agent = PuppetWebhook::Orchestrators::MCollective.new('package', 'install', package: 'vim')
    #   agent.run
    class MCollective
      attr_reader :results, :stats
      include ::MCollective::RPC

      # Public: Initializer for the MCollective class.
      #
      # @param [String] agent Mcollective agent to use.
      # @param [String] command Agent command to execute
      # @param [Hash] timeouts The discovery and command timeouts
      # @option timeouts [Integer] :dtimeout Set the discovery timeout in milliseconds
      # @option timeouts [Integer] :timeout Set the connection timeout in milliseconds
      # @param [Hash] options Set the Mcollective RPC options or config load file.
      # @param [Array] nodes Array of nodes to execute this against.
      # @param [Hash] args Arguments to pass the agent command. This is specific to the agent being used.
      #
      # @return [PuppetWebhook::Orchestrators::MCollective]
      def initialize(agent, command, timeouts = nil, options = nil, nodes = [], **args) # rubocop:disable Metrics/ParameterLists
        @agent = agent
        @command = command
        @timeout = timeouts[:timeout] || '120'
        @dtimeout = timeouts[:dtimeout] || '10'
        @options = options
        @nodes = nodes
        @args = args
      end

      # Public: Execute the agent command
      #
      # returns [::MCollective::RPC::Stats]
      def run
        logger.info("Starting request for #{@agent}##{@command}")

        begin
          @results = client.send(@command, @args)
        rescue StandardError => e
          logger.error("Error: #{e}")
        end

        @stats = client.stats
      end

      # Private: Set the client object.
      #
      # returns [::MCollective::RPC::Client]
      def client
        client = ::MCollective::RPC::Client.new(@agent, config_file: ::MCollective::Util.config_file_for_user, options: ::MCollective::Util.default_options) # rubocop:disable Metrics/LineLength
        client.config = @options if @options
        client.timeout = @timeout if @timeout
        client.discovery_timeout = @dtimeout if @dtimeout
        client.progress = false
        client
      end
    end
  end
end
