# frozen_string_literal: true

project 'puppet-webhook' do |proj|
  # Set preferred component versions
  platform = proj.get_platform

  proj.version '2.1.1'
  proj.description 'The Webhook API server for trigger puppet actions'
  proj.license 'Apache 2.0'
  proj.vendor 'Vox Pupuli Organization <voxpupuli@groups.io>'
  proj.homepage 'https://voxpupuli.org'

  proj.setting(:install_root, '/opt/voxpupuli')
  proj.setting(:prefix, File.join(proj.install_root, 'webhook'))
  proj.setting(:link_bindir, File.join(proj.install_root, 'bin'))

  proj.setting(:libdir, File.join(proj.prefix, 'lib'))
  proj.setting(:datadir, File.join(proj.prefix, 'share'))
  proj.setting(:includedir, File.join(proj.prefix, 'include'))
  proj.setting(:bindir, File.join(proj.prefix, 'bin'))

  proj.setting(:miscdir, File.join(proj.install_root, 'misc'))
  proj.setting(:mandir, File.join(proj.datadir, 'man'))

  proj.setting(:ruby_version, '2.6.5')
  proj.setting(:ruby_api, '2.6.0')

  proj.setting(:privatedir, File.join(proj.prefix, 'private'))
  proj.setting(:ruby_dir, proj.prefix)
  proj.setting(:ruby_bindir, proj.bindir)

  ruby_base_version = proj.ruby_version.gsub(%r{(\d)\.(\d)\.(\d)}, '\1.\2.0')
  proj.setting(:gem_home, File.join(proj.libdir, 'ruby', 'gems', ruby_base_version))
  proj.setting(:ruby_vendordir, File.join(proj.libdir, 'ruby', 'vendor_ruby'))

  proj.setting(:host_ruby, File.join(proj.ruby_bindir, 'ruby'))
  proj.setting(:host_gem, File.join(proj.ruby_bindir, 'gem'))

  proj.setting(:gem_install, "#{proj.host_gem} install --no-document ")

  proj.setting(:logdir, '/var/log/voxpupuli')
  proj.setting(:piddir, '/var/run/voxpupuli')
  proj.setting(:sysconfdir, '/etc/voxpupuli')

  raise "Couldn't find a :ruby_version setting in the project file" unless proj.ruby_version

  # Components
  proj.component 'ruby-2.6'
  proj.component 'runtime'
  proj.component 'rubygem-bundler'
  proj.component 'rubygem-activemodel'
  proj.component 'rubygem-activerecord'
  proj.component 'rubygem-activesupport'
  proj.component 'rubygem-addressable'
  proj.component 'rubygem-ansi'
  proj.component 'rubygem-arel'
  proj.component 'rubygem-artifactory'
  proj.component 'rubygem-ast'
  proj.component 'rubygem-backports'
  proj.component 'rubygem-bcrypt'
  proj.component 'rubygem-bond'
  proj.component 'rubygem-builder'
  proj.component 'rubygem-byebug'
  proj.component 'rubygem-capybara'
  proj.component 'rubygem-coderay'
  proj.component 'rubygem-colored'
  proj.component 'rubygem-concurrent-ruby'
  proj.component 'rubygem-connection_pool'
  proj.component 'rubygem-coveralls'
  proj.component 'rubygem-crack'
  proj.component 'rubygem-cri'
  proj.component 'rubygem-csv'
  proj.component 'rubygem-daemons'
  proj.component 'rubygem-database_cleaner-active_record'
  proj.component 'rubygem-debase'
  proj.component 'rubygem-debase-ruby_core_source'
  proj.component 'rubygem-diff-lcs'
  proj.component 'rubygem-docile'
  proj.component 'rubygem-docopt'
  proj.component 'rubygem-eventmachine'
  proj.component 'rubygem-faraday'
  proj.component 'rubygem-faraday-http-cache'
  proj.component 'rubygem-faraday_middleware'
  proj.component 'rubygem-fast_gettext'
  proj.component 'rubygem-fustigit'
  proj.component 'rubygem-gettext'
  proj.component 'rubygem-gettext-setup'
  proj.component 'rubygem-git'
  proj.component 'rubygem-github_changelog_generator'
  proj.component 'rubygem-hashdiff'
  proj.component 'rubygem-i18n'
  proj.component 'rubygem-jaro_winkler'
  proj.component 'rubygem-json'
  proj.component 'rubygem-locale'
  proj.component 'rubygem-lock_manager'
  proj.component 'rubygem-log4r'
  proj.component 'rubygem-mcollective-client'
  proj.component 'rubygem-method_source'
  proj.component 'rubygem-mime-types'
  proj.component 'rubygem-mime-types-data'
  proj.component 'rubygem-mini_mime'
  proj.component 'rubygem-mini_portile2'
  proj.component 'rubygem-minitar'
  proj.component 'rubygem-minitest'
  proj.component 'rubygem-multi_json'
  proj.component 'rubygem-multipart-post'
  proj.component 'rubygem-mustermann'
  proj.component 'rubygem-nio4r'
  proj.component 'rubygem-nokogiri'
  proj.component 'rubygem-octokit'
  proj.component 'rubygem-packaging'
  proj.component 'rubygem-parallel'
  proj.component 'rubygem-parser'
  proj.component 'rubygem-pry'
  proj.component 'rubygem-pry-byebug'
  proj.component 'rubygem-public_suffix'
  proj.component 'rubygem-puma'
  proj.component 'rubygem-puppet_forge'
  proj.component 'rubygem-r10k'
  proj.component 'rubygem-rack'
  proj.component 'rubygem-rack-console'
  proj.component 'rubygem-rack-protection'
  proj.component 'rubygem-rack-test'
  proj.component 'rubygem-rainbow'
  proj.component 'rubygem-rake'
  proj.component 'rubygem-rb-readline'
  proj.component 'rubygem-redis'
  proj.component 'rubygem-regexp_parser'
  proj.component 'rubygem-release-metrics'
  proj.component 'rubygem-require_all'
  proj.component 'rubygem-rest-client'
  proj.component 'rubygem-retriable'
  proj.component 'rubygem-ripl'
  proj.component 'rubygem-ripl-multi_line'
  proj.component 'rubygem-ripl-rack'
  proj.component 'rubygem-rocket-chat-notifier'
  proj.component 'rubygem-rspec'
  proj.component 'rubygem-rspec-core'
  proj.component 'rubygem-rspec-expectations'
  proj.component 'rubygem-rspec-mocks'
  proj.component 'rubygem-rspec-support'
  proj.component 'rubygem-rubocop'
  proj.component 'rubygem-ruby-debug-ide'
  proj.component 'rubygem-ruby-git'
  proj.component 'rubygem-ruby-progressbar'
  proj.component 'rubygem-safe_yaml'
  proj.component 'rubygem-sawyer'
  proj.component 'rubygem-semantic_puppet'
  proj.component 'rubygem-shotgun'
  proj.component 'rubygem-sidekiq'
  proj.component 'rubygem-simplecov'
  proj.component 'rubygem-simplecov-console'
  proj.component 'rubygem-simplecov-html'
  proj.component 'rubygem-sinatra'
  proj.component 'rubygem-sinatra-activerecord'
  proj.component 'rubygem-sinatra-contrib'
  proj.component 'rubygem-slack-notifier'
  proj.component 'rubygem-sqlite3'
  proj.component 'rubygem-stomp'
  proj.component 'rubygem-systemu'
  proj.component 'rubygem-term-ansicolor'
  proj.component 'rubygem-terminal-table'
  proj.component 'rubygem-text'
  proj.component 'rubygem-thin'
  proj.component 'rubygem-thor'
  proj.component 'rubygem-thread_safe'
  proj.component 'rubygem-tilt'
  proj.component 'rubygem-tins'
  proj.component 'rubygem-tux'
  proj.component 'rubygem-tzinfo'
  proj.component 'rubygem-unicode-display_width'
  proj.component 'rubygem-vanagon'
  proj.component 'rubygem-warden'
  proj.component 'rubygem-webmock'
  proj.component 'rubygem-xpath'
  proj.component 'rubygem-yard'
  proj.component 'app'

  proj.directory '/opt/voxpupuli/webhook'
  proj.directory proj.sysconfdir
  proj.directory proj.libdir
end
