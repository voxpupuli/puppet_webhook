require 'rack/parser'
require 'json'

module Sinatra
  module Parsers
    class WebhookJsonParser
      def call(body)
        data = JSON.parse(body, quirks_mode: true)
        {
          branch: parse_branch(data),
          deleted: parse_deleted?(data)
        }
      end

      def parse_branch(data)
        (
          data['ref'] rescue nil || # github & gitlab
          data['refChanges'][0]['refId'] rescue nil ||  # stash
          data['push']['changes'][0]['new']['name'] rescue nil ||  # bitbucket
          data['resource']['refUpdates'][0]['name'] rescue nil ||  # TFS/VisualStudio-Git
          data['repository']['default_branch'] rescue nil # github tagged release; no ref.
        ).sub('refs/heads/', '') rescue nil
      end

      def parse_deleted?(data)
        branch_deleted = (
          data['deleted'] rescue nil || # Github
          data['push']['changes'][0]['closed'] rescue nil || # Bitbucket
          data['refChanges'][0]['type'] rescue nil || # Stash/Bitbucket Server
          data['after'] rescue nil # Gitlab
        )
        [
          true,
          'DELETED',
          '0000000000000000000000000000000000000000'
        ].include?(branch_deleted)
      end
    end
  end
end
