# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |spec|
  spec.name = 'puppet_webhook'
  spec.summary = 'Sinatra Webhook Server for Puppet/R10K'
  spec.version = '0.0.1'
  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.1.9'
  spec.authors = ['Vox Pupuli']
  spec.email = 'voxpupuli@groups.io'
  spec.files = Dir[
                   'CHANGELOG.md',
                   'README.md',
                   'LICENSE',
                   'config.yml',
                   'lib/**/*',
                   'bin/*'
                  ]
  spec.homepage = 'https://github.com/voxpupuli/puppet-webhook'
  spec.license = 'apache'
  spec.executables = ['puppet_webhook']
  spec.require_paths = ['lib']
  spec.add_runtime_dependency 'json'
  spec.add_runtime_dependency 'mcollective-client'
  spec.add_runtime_dependency 'rack-parser'
  spec.add_runtime_dependency 'sinatra'
  spec.add_runtime_dependency 'sinatra-contrib'
  spec.add_runtime_dependency 'slack-notifier'
  spec.add_runtime_dependency 'webrick'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'github_changelog_generator'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov-console'
end
