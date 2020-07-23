# frozen_string_literal: true

platform 'ubuntu-20.04-amd64' do |plat|
  plat.defaultdir '/etc/default'
  plat.servicetype 'systemd'
  plat.codename 'focal'
  plat.servicedir '/etc/systemd/system'

  plat.docker_image 'voxpupuli/builder:focal'
  plat.docker_run_args '--privileged=true'

  plat.provision_with 'export DEBIAN_FRONTEND=noninteractive; apt-get update -qq; apt-get install -qy --no-install-recommends build-essential devscripts make quilt pkg-config debhelper rsync fakeroot'
  plat.install_build_dependencies_with 'DEBIAN_FRONTEND=noninteractive; apt-get install -qy --no-install-recommends --allow-unauthenticated'

  packages = [
    'libbz2-dev',
    'libreadline-dev',
    'make',
    'pkg-config',
    'zlib1g-dev',
    'pl-cmake',
    'pl-gcc',
    'systemtap-sdt-dev',
    'openjdk-8-jre-headless'
  ]

  plat.provision_with "export DEBIAN_FRONTEND=noninteractive; apt-get install -qy --no-install-recommends #{packages.join(' ')}"

  plat.output_dir File.join('deb', plat.get_codename, 'PC1')
end
