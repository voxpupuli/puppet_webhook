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
