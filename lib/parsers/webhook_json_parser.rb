require 'rack/bodyparser'
require 'json'

module Sinatra
  module Parsers
    class WebhookJsonParser # rubocop:disable Style/Documentation
      attr_accessor :env

      def call(body)
        @data = JSON.parse(body, quirks_mode: true)
        @vcs  = detect_vcs
        {
          branch:    branch,
          deleted:   deleted?,
          module_name: repo_name.sub(%r{^.*-}, ''),
          repo_name: repo_name,
          repo_user: repo_user
        }.delete_if { |_k, v| v.nil? }
      end

      def detect_vcs
        return 'github'    if github_webhook?
        return 'gitlab'    if gitlab_webhook?
        return 'stash'     if stash_webhook?
        return 'bitbucket' if bitbucket_webhook?
        return 'tfs'       if tfs_webhook?
        raise StandardError, 'payload not recognised'
      end

      def github_webhook?
        # https://developer.github.com/v3/activity/events/types/#pushevent
        env.key?('HTTP_X_GITHUB_EVENT')
      end

      def gitlab_webhook?
        # https://docs.gitlab.com/ce/user/project/integrations/webhooks.html
        env.key?('HTTP_X_GITLAB_EVENT')
      end

      # stash/bitbucket server
      def stash_webhook?
        # https://confluence.atlassian.com/bitbucketserver/post-service-webhook-for-bitbucket-server-776640367.html
        env.key?('HTTP_X_ATLASSIAN_TOKEN')
      end

      def bitbucket_webhook?
        # https://confluence.atlassian.com/bitbucket/event-payloads-740262817.html
        env.key?('HTTP_X_EVENT_KEY')
      end

      def tfs_webhook?
        # https://docs.microsoft.com/en-us/vsts/service-hooks/services/webhooks
        return false unless @data.key? 'resource'
        return false unless @data.key? 'eventType'
        true
      end

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
        when 'stash'
          @data['refChanges'][0]['refId'].sub('refs/heads/', '')
        when 'bitbucket'
          return @data['push']['changes'][0]['new']['name'] unless deleted?
          @data['push']['changes'][0]['old']['name']
        when 'tfs'
          @data['resource']['refUpdates'][0]['name'].sub('refs/heads/', '')
        end
      end

      def deleted?
        case @vcs
        when 'github'
          @data['deleted']
        when 'gitlab'
          @data['after'] == '0000000000000000000000000000000000000000'
        when 'stash'
          @data['refChanges'][0]['type'] == 'DELETE'
        when 'bitbucket'
          @data['push']['changes'][0]['closed']
        when 'tfs'
          @data['resource']['refUpdates'][0]['newObjectId'] == '0000000000000000000000000000000000000000'
        else
          false
        end
      end

      def repo_name
        if @vcs == 'gitlab'
          @data['project']['name']
        elsif @vcs == 'tfs'
          @data['resource']['repository']['name']
        else
          @data['repository']['name']
        end
      end

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
