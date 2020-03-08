# frozen_string_literal: true

require 'sidekiq'

# Main ApplicationWorker class that all other workers inherit from.
class ApplicationWorker
  include Sidekiq::Worker
end
