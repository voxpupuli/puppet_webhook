require 'rack/parser'
require 'json'

module Sinatra
  class WebhookJsonParser
    def call(body)
      data = JSON.parse(body, quirks_mode: true)
      branch = (
        data['ref']                                          ||  # github & gitlab
        data['refChanges'][0]['refId']            rescue nil ||  # stash
        data['push']['changes'][0]['new']['name'] rescue nil ||  # bitbucket
        data['resource']['refUpdates'][0]['name'] rescue nil ||  # TFS/VisualStudio-Git
        data['repository']['default_branch']                     # github tagged release; no ref.
      ).sub('refs/heads/', '') rescue nil
      { branch: branch }
    end
  end
end
