require 'rack/parser'
require 'json'

module Sinatra
  module Parsers
    class WebhookJsonParser
      def call(body)
        @data = JSON.parse(body, quirks_mode: true)
        @vcs  = detect_vcs
        {
          branch:  branch,
          deleted: deleted?
        }
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
        # X-GitHub-Event header is set, but not accessible here.
        return false unless @data.key? 'repository'
        return false unless @data['repository'].key? 'id'
        return false unless @data['repository'].key? 'html_url'
        return false unless @data['repository']['html_url'] =~ %r{github\.com}
        true
      end

      def gitlab_webhook?
        # https://docs.gitlab.com/ce/user/project/integrations/webhooks.html
        # X-Gitlab-Event is set, but not accessible here.
        return false unless @data.key? 'object_kind'
        return false unless @data.key? 'ref'
        true
      end

      # stash/bitbucket server
      def stash_webhook?
        # https://confluence.atlassian.com/bitbucketserver/post-service-webhook-for-bitbucket-server-776640367.html
        return false unless @data.key? 'refChanges'
        true
      end

      def bitbucket_webhook?
        # https://confluence.atlassian.com/bitbucket/event-payloads-740262817.html
        return false unless @data.key? 'actor'
        return false unless @data.key? 'repository'
        return false unless @data.key? 'push'
        true
      end

      def tfs_webhook?
        # https://docs.microsoft.com/en-us/vsts/service-hooks/services/webhooks
        return false unless @data.key? 'resource'
        return false unless @data.key? 'event.type'
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
          @data['push']['changes'][0]['new']['name']
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
          @data['refChanges'][0]['type'] == 'DELETED'
        when 'bitbucket'
          @data['push']['changes'][0]['closed']
        else
          # TODO: TFS
          false
        end
      end
    end
  end
end
