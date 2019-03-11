require './config/environment'

raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.' if ActiveRecord::Migrator.needs_migration?

run ApplicationController
use AuthenticationController
use Api::V1::R10K::EnvironmentController
use Api::V1::R10K::ModuleController
