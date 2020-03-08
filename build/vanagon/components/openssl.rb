# frozen_string_literal: true

component 'openssl' do |pkg, settings, platform|
  pkg.version '1.1.1d'
  pkg.md5sum '3be209000dbc7e1b95bcdf47980a3baa'
  pkg.url "https://openssl.org/source/openssl-#{pkg.get_version}.tar.gz"

  #############################
  # ENVIRONMENT, FLAGS, TARGETS
  #############################

  target = cflags = ldflags = sslflags = ''

  pkg.environment 'PATH', '/opt/pl-build-tools/bin:$$PATH'
  pkg.environment 'CC', "/opt/pl-build-tools/bin/#{settings[:platform_triple]}-gcc"

  cflags = "#{settings[:cflags]} -fPIC"

  ldflags = "-Wl,-rpath=/opt/pl-build-tools/#{settings[:platform_triple]}/lib -Wl,-rpath=#{settings[:libdir]} -L/opt/pl-build-tools/#{settings[:platform_triple]}/lib"
  pkg.environment 'PATH', '/opt/pl-build-tools/bin:$(PATH):/usr/local/bin'

  cflags = settings[:cflags]
  ldflags = "#{settings[:ldflags]} -Wl,-z,relro"
  if platform.architecture =~ %r{86$}
    target = 'linux-elf'
    sslflags = '386'
  elsif platform.architecture =~ %r{64$}
    target = 'linux-x86_64'
  end

  ####################
  # BUILD REQUIREMENTS
  ####################

  pkg.build_requires "runtime-#{settings[:runtime_project]}"

  ###########
  # CONFIGURE
  ###########

  #  if platform.is_cross_compiled?
  #    pkg.apply_patch 'resources/patches/openssl/openssl-1.1.1a-revert-7a061312.patch'
  #  end

  # OpenSSL Configure doesn't honor CFLAGS or LDFLAGS as environment variables.
  # Instead, those should be passed to Configure at the end of its options, as
  # any unrecognized options are passed straight through to ${CC}. Defining
  # --libdir ensures that we avoid the multilib (lib/ vs. lib64/) problem,
  # since configure uses the existence of a lib64 directory to determine
  # if it should install its own libs into a multilib dir. Yay OpenSSL!
  configure_flags = [
    "--prefix=#{settings[:prefix]}",
    '--libdir=lib',
    "--openssldir=#{settings[:prefix]}/ssl",
    'shared',
    'no-asm',
    target,
    sslflags,
    'no-camellia',
    'no-ec2m',
    'no-md2',
    'no-ssl3'
  ]

  # Individual projects may provide their own openssl configure flags:
  project_flags = settings[:openssl_extra_configure_flags] || []
  perl_exec = ''
  configure_flags << project_flags << cflags << ldflags

  pkg.configure do
    ["#{perl_exec} ./Configure #{configure_flags.join(' ')}"]
  end

  #######
  # BUILD
  #######

  pkg.build do
    [
      "#{platform[:make]} depend",
      (platform[:make]).to_s
    ]
  end

  #########
  # INSTALL
  #########

  install_prefix = platform.is_windows? ? '' : 'INSTALL_PREFIX=/'
  install_commands = []

  install_commands << "#{platform[:make]} #{install_prefix} install"

  pkg.install do
    install_commands
  end

  pkg.install_file 'LICENSE', "#{settings[:prefix]}/share/doc/openssl-#{pkg.get_version}/LICENSE"
end
