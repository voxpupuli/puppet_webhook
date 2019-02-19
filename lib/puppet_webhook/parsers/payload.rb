module PuppetWebhook
  class Parsers
    # Main parser class used by the json and www_form_url_encoded parsers. This will
    # parse json payloads from Verson Control Systems into usable fields for the Puppet
    # Webhook service.
    #
    # @example
    #   request.body.rewind
    #   payload = PuppetWebhook::Parsers::Payload.new(request.env, request.body.read)
    #   payload.parse!
    class Payload
      # Public: Initialize the Payload object
      #
      # @param [Sinatra::Request] request Rack request object to be parsed
      #
      # @return [PuppetWebhook::Parsers::Payload]
      def initialize(headers, body)
        @headers = headers
        @body = body
      end

      # Public: Parse the Rack request into a usable OpenStruct
      # object.
      #
      # @return [OpenStruct]
      def parse!
        @vcs = detect_vcs
        OpenStruct.new({
          branch: branch,
          deleted: deleted? || false,
          module_name: repo_name.sub(%r{^.*-}, ''),
          repo_name: repo_name,
          repo_user: repo_user
        }.delete_if { |_k, v| v.nil? })
      end

      private

      # Private: Set the version control system
      #
      # @return [String]
      def detect_vcs
        return 'github'           if github_webhook?
        return 'gitlab'           if gitlab_webhook?
        return 'bitbucket-server' if bitbucket_server_webhook?
        return 'bitbucket'        if bitbucket_webhook?
        return 'stash'            if stash_webhook?
        return 'tfs'              if tfs_webhook?

        raise StandardError, 'payload not recognised'
      end

      # Private: Check HTTP Headers for the Github event header
      #
      # @return [Boolean]
      def github_webhook?
        # https://developer.github.com/v3/activity/events/types/#pushevent
        @headers.key?('HTTP_X_GITHUB_EVENT')
      end

      # Private: Check HTTP Headers for the Gitlab event Header
      #
      # @return [Boolean]
      def gitlab_webhook?
        # https://docs.gitlab.com/ce/user/project/integrations/webhooks.html
        @headers.key?('HTTP_X_GITLAB_EVENT')
      end

      # Private: Checks for the BitBucket Server Event and Request ID http headers.
      #
      # @return [Boolean]
      def bitbucket_server_webhook?
        # https://confluence.atlassian.com/bitbucketserver/event-payload-938025882.html
        @headers.key?('HTTP_X_EVENT_KEY') && @headers.key?('HTTP_X_REQUEST_ID')
      end

      # Private: Checks for the BitBucket.org Event and Hook UUID http headers.
      #
      # @return [Boolean]
      def bitbucket_webhook?
        # https://confluence.atlassian.com/bitbucket/event-payloads-740262817.html
        @headers.key?('HTTP_X_EVENT_KEY') && @headers.key?('HTTP_X_HOOK_UUID')
      end

      # Private: Checks for the stash/bitbucket-server post receive hook plugin headers.
      #
      # @return [Boolean]
      def stash_webhook?
        # This payload is the `Web Post Hooks for Bitbucket Server` hook plugin.
        # https://marketplace.atlassian.com/apps/1211539/web-post-hooks-for-bitbucket-server?hosting=server&tab=overview
        # https://confluence.atlassian.com/bitbucketserver/post-service-webhook-for-bitbucket-server-776640367.html
        @headers.key?('HTTP_X_ATLASSIAN_TOKEN')
      end

      # Private: Checks for the VSTS resource and eventType keys in the request body.
      #
      # @return [Boolean]
      def tfs_webhook?
        # https://docs.microsoft.com/en-us/vsts/service-hooks/services/webhooks
        return false unless @data.key? 'resource'
        return false unless @data.key? 'eventType'

        true
      end

      # Private: Gets the name of the git branch from the request body.
      #
      # @return [String]
      def branch
        case @vcs
        when 'github'
          if @data.key? 'ref'
            @data['ref'].sub('refs/heads/', '')
          else
            @data['repository']['default_branch']
          end
        when 'gitlab'
          @data['ref'].sub('refs/heads/', '')
        when 'bitbucket-server'
          @data['changes'][0]['refId'].sub('refs/heads/', '')
        when 'bitbucket'
          return @data['push']['changes'][0]['new']['name'] unless deleted?

          @data['push']['changes'][0]['old']['name']
        when 'stash'
          @data['refChanges'][0]['refId'].sub('refs/heads/', '')
        when 'tfs'
          @data['resource']['refUpdates'][0]['name'].sub('refs/heads/', '')
        end
      end

      # Private: Determine if the branch has been deleted or not.
      #
      # @return [Boolean]
      def deleted?
        case @vcs
        when 'github'
          @data['deleted']
        when 'gitlab'
          @data['after'] == '0000000000000000000000000000000000000000'
        when 'bitbucket-server'
          @data['changes'][0]['type'] == 'DELETE'
        when 'bitbucket'
          @data['push']['changes'][0]['closed']
        when 'stash'
          @data['refChanges'][0]['type'] == 'DELETE'
        when 'tfs'
          @data['resource']['refUpdates'][0]['newObjectId'] == '0000000000000000000000000000000000000000'
        end
      end

      # Private: Get the repository name
      #
      # @return [String]
      def repo_name
        if @vcs == 'gitlab'
          @data['project']['name']
        elsif @vcs == 'tfs'
          @data['resource']['repository']['name']
        else
          @data['repository']['name']
        end
      end

      # Private: Get the repository user from a Github or Gitlab repo.
      #
      # @return [String]
      def repo_user
        # TODO: Clarify what repo_user actually is.
        # github is currently using the repo's 'owner', gitlab is using the user who pushed.
        case @vcs
        when 'github'
          @data['repository']['owner']['login']
        when 'gitlab'
          @data['user_username']
        end
        # TODO: Bitbucket, Stash/Bitbucket Server, TFS
      end
    end
  end
end
