# This file is a common basis for multiple rubygem components.
#
# It should not be included as a component itself; Instead, other components
# should load it with instance_eval after setting pkg.version. Parts of this
# shared configuration may be overridden afterward.

name = pkg.get_name.gsub('rubygem-', '')
unless name && !name.empty?
  raise "Rubygem component files that instance_eval _base-rubygem must be named rubygem-<gem-name>.rb"
end

version = pkg.get_version
unless version && !version.empty?
  raise "You must set the `pkg.version` in your rubygem component before instance_eval'ing _base-rubygem.rb"
end

# When cross-compiling, we can't use the rubygems we just build.
# Instead we use the host gem installation and override GEM_HOME.
pkg.environment "GEM_HOME", settings[:gem_home]

if settings[:ruby_vendordir]
  pkg.environment "RUBYLIB", "#{settings[:ruby_vendordir]}:$(RUBYLIB)"
end


pkg.install do
  "#{settings[:gem_install]} #{name} -v #{version}"
end
