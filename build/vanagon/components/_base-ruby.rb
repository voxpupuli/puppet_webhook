ruby_version_condensed = pkg.get_version.tr('.', '')
ruby_version_y = pkg.get_version.gsub(/(\d)\.(\d)\.(\d)/, '\1.\2')

pkg.url("https://cache.ruby-lang.org/pub/ruby/#{ruby_version_y}/ruby-#{pkg.get_version}.tar.gz")

ruby_dir ||= settings[:ruby_dir]
ruby_bindir ||= settings[:ruby_bindir]

#############
# ENVIRONMENT
#############

pkg.environment 'PATH', "#{settings[:bindir]}:$$PATH"
pkg.environment 'CC', '/usr/bin/gcc'
pkg.environment 'LDFLAGS', "-Wl,-rpath=#{settings[:libdir]}"

pkg.build do
  [ 'make' ]
end

pkg.install do
  [ 'make install' ]
end
