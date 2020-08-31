# frozen_string_literal: true

component 'app' do |pkg, _settings, _platform|
  pkg.url 'https://github.com/voxpupuli/puppet_webhook'

  if platform.is_deb?
    pkg.build_requires 'sqlite3'
    pkg.requires 'sqlite3'
    pkg.requires 'redis-server'
  elsif platform.is_el?
    build_requires 'sqlite-devel'
    pkg.requires 'sqlite'
    pkg.requires 'redis'
  else
    raise("Plaform #{platform.name} is not yet supported")
  end

  pkg.build_requires 'ruby-2.6'
  pkg.build_requires 'runtime'
  pkg.environment 'PATH', '/opt/voxpupuli/webhook/bin:$(PATH)'
  pkg.environment 'GEM_HOME', '/opt/voxpupuli/webhook/lib/ruby/2.6.0'

  pkg.add_source 'file://resources/puppet-webhook.service'
  pkg.add_source 'file://resources/puppet-webhook-app.service'
  pkg.add_source 'file://resources/puppet-webhook-sidekiq.service'
  pkg.add_source 'file://resources/puppetwebhook'
  pkg.add_source 'file://resources/postinst.sh'
  pkg.add_source 'file://resources/generate_token'

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
      'cp ../postinst.sh /opt/voxpupuli/webhook/bin/',
      'cp ../generate_token /opt/voxpupuli/webhook/bin/',
      'cp /opt/voxpupuli/webhook/config/config.yml.example /etc/voxpupuli/webhook.yaml',
      "echo 'App installed'"
    ]
  end

  pkg.install_service('../puppet-webhook.service', '../puppetwebhook', 'puppet-webhook')
  pkg.install_service('../puppet-webhook-app.service', nil, 'puppet-webhook-app')
  pkg.install_service('../puppet-webhook-sidekiq.service', nil, 'puppet-webhook-sidekiq')

  pkg.add_postinstall_action('install', 'cd /opt/voxpupuli/webhook && bin/bundle update --bundler --quiet')

  pkg.add_postinstall_action(%w[install upgrade], 'cd /opt/voxpupuli/webhook && bin/postinst.sh')

  pkg.add_postinstall_action(%w[install upgrade], 'systemctl daemon-reload && systemctl enable puppet-webhook puppet-webhook-app puppet-webhook-sidekiq && systemctl restart puppet-webhook')

  pkg.add_postremove_action('removal', 'rm -rf /opt/voxpupuli/webhook')
end
