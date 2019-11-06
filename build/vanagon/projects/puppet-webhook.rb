project 'puppet-webhook' do |proj|
  # Set preferred component versions
  platform = proj.get_platform

  proj.version_from_git
  proj.description "The Webhook API server for trigger puppet actions"
  proj.license "Apache 2.0"
  proj.vendor "Vox Pupuli Organization <voxpupuli@groups.io>"
  proj.homepage "https://voxpupuli.org"

  proj.setting(:install_root, "/opt/voxpupuli")
  proj.setting(:prefix, File.join(proj.install_root, "webhook"))
  proj.setting(:link_bindir, File.join(proj.prefix, "bin"))

  proj.setting(:libdir, File.join(proj.prefix, "lib"))
  proj.setting(:datadir, File.join(proj.prefix, "share"))
  proj.setting(:includedir, File.join(proj.prefix, "include"))
  proj.setting(:bindir, File.join(proj.prefix, "bin"))

  proj.setting(:ruby_version, "2.6.5")
  proj.setting(:ruby_api, "2.6.0")

  proj.setting(:privatedir, File.join(proj.prefix, "private"))
  proj.setting(:ruby_dir, File.join(proj.privatedir, "ruby", proj.ruby_version))
  proj.setting(:ruby_bindir, File.join(proj.ruby_dir, "bin"))
  proj.setting(:gem_home, File.join(proj.ruby_dir, "lib", "ruby", "gem", proj.ruby_api))

  proj.setting(:host_ruby, File.join(proj.ruby_bindir, "ruby"))
  proj.setting(:host_gem, File.join(proj.ruby_bindir, "gem"))
  proj.setting(:host_bundle, File.join(proj.ruby_bindir, "bundle"))

  proj.setting(:gem_install, "#{proj.host_gem} install --no-document --local ")

  proj.setting(:logdir, "/var/log/voxpupuli")
  proj.setting(:piddir, "/var/run/voxpupuli")
  proj.setting(:sysconfdir, "/etc/voxpupuli")

  raise "Couldn't find a :ruby_version setting in the project file" unless proj.ruby_version

  proj.setting(:host, host)

  # Components
  proj.component 'libedit'
  proj.component 'ruby-2.6'
  proj.component 'app'

  proj.directory "/opt/voxpupuli/webhook"
  proj.directory proj.sysconfdir
  proj.directory proj.libdir
end
