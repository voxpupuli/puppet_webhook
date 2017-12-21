require 'rubocop/rake_task'
RuboCop::RakeTask.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

desc 'Run all tests'
task test: %i[rubocop spec]

require 'coveralls/rake/task'
require 'codacy-coverage'
desc 'Run all tests and report to coverage tools'
task test_and_report_coverage: [:test] do
  Coveralls::RakeTask.new
  Rake::Task['coveralls:push'].invoke
  result = ::SimpleCov::ResultMerger.merged_result
  Codacy::Formatter.new.format result
end

begin
  require 'github_changelog_generator/task'
  GitHubChangelogGenerator::RakeTask.new :changelog do |config|
    version = Gem::Specification.load('puppet_webhook.gemspec').version
    puts version
    config.future_release = "v#{version}" if version =~ /^\d+\.\d+.\d+$/
    config.header = "# Changelog\n\nAll notable changes to this project will be documented in this file.\nEach new release typically also includes the latest modulesync defaults.\nThese should not affect the functionality of the module."
    config.exclude_labels = %w{duplicate question invalid wontfix wont-fix modulesync skip-changelog}
    config.user = 'voxpupuli'
    config.project = (Gem::Specification.load('puppet_webhook.gemspec')).name
  end
rescue LoadError
end
# vim: syntax=ruby
