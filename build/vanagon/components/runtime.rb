# frozen_string_literal: true

# This component exists to link in the gcc and stdc++ runtime libraries as well as libssp.
component 'runtime' do |pkg, _settings, _platform|
  pkg.environment 'PROJECT_SHORTNAME', 'webhook'
  pkg.add_source 'file://build/vanagon/files/runtime.sh'

  libdir = '/opt/pl-build-tools/lib64'

  pkg.install do
    "bash runtime.sh #{libdir} puppet"
  end
end
