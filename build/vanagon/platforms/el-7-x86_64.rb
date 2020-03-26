# frozen_string_literal: true

platform 'el-7-x86_64' do |plat|
  plat.servicedir '/usr/lib/systemd/system'
  plat.defaultdir '/etc/sysconfig'
  plat.servicetype 'systemd'

  plat.docker_image 'voxpupuli/pkg_builder:el7'
  plat.docker_run_args '--privileged=true'

  plat.provision_with "yum update -y; yum groupinstall --assumeyes 'Development Tools'; yum install --assumeyes autoconf automake createrepo devscripts fakeroot rsync gcc make rpmdevtools rpm-libs yum-utils rpm-sign"
  plat.install_build_dependencies_with 'yum install --assumeyes'

  packages = %w[
    bzip2-devel
    readline-devel
    make
    pkgconfig
    zlib-devel
    pl-cmake
    pl-gcc
    systemtap-sdt-devel
    java-1.8.0-openjdk-headless
  ]

  plat.provision_with "yum install --assumeyes #{packages.join(' ')}"

  plat.output_dir File.join('el', 'PC1')
end
