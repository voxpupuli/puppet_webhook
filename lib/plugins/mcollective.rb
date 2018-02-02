require 'mcollective'

class PuppetWebhook
  class Mcollective
    attr_writer :agent, :command
    include MCollective::RPC

    def initialize(agent, command, timeouts = nil, options = nil, nodes = [], **args)
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
        client.send(@command, @args) do |result|
          result
        end
      rescue => e
        LOGGER.error("Error: #{e}")
      end
    end

    def client
      client = RPC::Client.new(@agent, config_file: Util.config_file_for_user, options: Util.default_options)
      client.config = @options if @options
      client.timeout = @timeout if @timeout
      client.discovery_timeout = @dtimeout if @dtimeout
      client.progress = false
      client
    end
  end
end
