require 'rubocop/rake_task'
RuboCop::RakeTask.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

desc 'Run all tests'
task test: %i[rubocop spec]

require 'coveralls/rake/task'
desc 'Run all tests and report to coveralls'
task test_with_coveralls: [:test] do
  Coveralls::RakeTask.new
  Rake::Task['coveralls:push'].invoke
end
