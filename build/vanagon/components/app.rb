# frozen_string_literal: true

component 'app' do |pkg, _settings, _platform|
  pkg.url 'https://github.com/voxpupuli/puppet_webhook'

  pkg.build_requires 'ruby-2.6'
  pkg.build_requires 'sqlite3'
  pkg.build_requires 'runtime'
  pkg.environment 'PATH', '/opt/voxpupuli/webhook/bin:$(PATH)'
  pkg.environment 'GEM_HOME', '/opt/voxpupuli/webhook/lib/ruby/2.6.0'

  pkg.add_source 'file://resources/puppet-webhook.service'
  pkg.add_source 'file://resources/puppetwebhook'

  pkg.install do
    [
      'cp -rf app/ /opt/voxpupuli/webhook/',
      'cp -rf config/ /opt/voxpupuli/webhook/',
      'cp -rf db/ /opt/voxpupuli/webhook/',
      'cp -rf lib/* /opt/voxpupuli/webhook/lib',
      'cp config.ru /opt/voxpupuli/webhook/config.ru',
      'cp Gemfile* /opt/voxpupuli/webhook/',
      'cp README.md /opt/voxpupuli/webhook/',
      'cp Rakefile /opt/voxpupuli/webhook/',
      'cp /opt/voxpupuli/webhook/config/config.yml.example /etc/voxpupuli/webhook.yaml',
      "echo 'App installed'"
    ]
  end

  pkg.install_service('../puppet-webhook.service', '../puppetwebhook', 'puppet-webhook')

  pkg.add_postinstall_action('install', 'cd /opt/voxpupuli/webhook && bin/bundle update --bundler')

  pkg.add_postinstall_action(%w[install upgrade], 'cd /opt/voxpupuli/webhook && bin/bundle install --with=default && bin/bundle exec rake db:migrate')
  pkg.add_postinstall_action(%w[install upgrade], 'systemctl daemon-reload')
end
