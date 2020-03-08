# frozen_string_literal: true

# This component exists to link in the gcc and stdc++ runtime libraries.
component 'runtime-client-tools' do |pkg, _settings, platform|
  pkg.environment 'PROJECT_SHORTNAME', 'runtime'

  if platform.name !~ %r{el-8-x86_64}
    libbase = platform.architecture =~ %r{64} ? 'lib64' : 'lib'
    libdir = "/opt/pl-build-tools/#{libbase}"
    pkg.add_source 'file://build/vanagon/files/runtime/runtime.sh'
    pkg.install do
      "bash runtime.sh #{libdir} webhook"
    end
  end
end
