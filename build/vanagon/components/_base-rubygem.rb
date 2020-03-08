# frozen_string_literal: true

# This file is a common basis for multiple rubygem components.
#
# It should not be included as a component itself; Instead, other components
# should load it with instance_eval after setting pkg.version. Parts of this
# shared configuration may be overridden afterward.

name = pkg.get_name.gsub('rubygem-', '')
raise 'Rubygem component files that instance_eval _base-rubygem must be named rubygem-<gem-name>.rb' unless name && !name.empty?

version = pkg.get_version
raise "You must set the `pkg.version` in your rubygem component before instance_eval'ing _base-rubygem.rb" unless version && !version.empty?

# When cross-compiling, we can't use the rubygems we just build.
# Instead we use the host gem installation and override GEM_HOME.
pkg.environment 'GEM_HOME', settings[:gem_home]

pkg.environment 'RUBYLIB', "#{settings[:ruby_vendordir]}:$(RUBYLIB)" if settings[:ruby_vendordir]

pkg.install do
  "#{settings[:gem_install]} #{name} -v #{version}"
end
