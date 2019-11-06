component 'app' do |pkg, settings, platform|
  pkg.version '0.0.1'
  pkg.url 'https://github.com/voxpupuli/puppet_webhook'

  pkg.build_requires 'ruby-2.6'
  pkg.build_requires 'sqlite3'
  pkg.environment 'PATH', '/opt/voxpupuli/webhook/bin:$(PATH)'
  pkg.environment 'GEM_HOME', '/opt/voxpupuli/webhook/lib/ruby/2.6.0'

  pkg.install do
    [
      "cp -rf app/ /opt/voxpupuli/webhook/",
      "cp -rf config/ /opt/voxpupuli/webhook/",
      "cp -rf db/ /opt/voxpupuli/webhook/",
      "cp -rf lib/* /opt/voxpupuli/webhook/lib",
      "cp config.ru /opt/voxpupuli/webhook/config.ru",
      "cp Gemfile* /opt/voxpupuli/webhook/",
      "cp README.md /opt/voxpupuli/webhook/",
      "cp Rakefile /opt/voxpupuli/webhook/",
      "cp /opt/voxpupuli/webhook/config/config.yml.example /etc/voxpupuli/webhook.yaml",
      "systemctl daemon-reload",
      "echo 'App installed'",
      "/opt/voxpupuli/webhook/bin/bundle install --without=development --without=test",
    ]
  end
end
