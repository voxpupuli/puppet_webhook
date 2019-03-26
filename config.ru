require './config/environment'
require 'sidekiq/web'

raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.' if ActiveRecord::Migrator.needs_migration?

map '/' do
  use AuthenticationController
  use Api::V1::R10K::EnvironmentController
  use Api::V1::R10K::ModuleController

  run ApplicationController
end

map '/sidekiq' do
  run Sidekiq::Web
end
