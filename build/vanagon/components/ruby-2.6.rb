# frozen_string_literal: true

component 'ruby-2.6' do |pkg, settings, _platform|
  pkg.version '2.6.5'
  pkg.sha256sum '66976b716ecc1fd34f9b7c3c2b07bbd37631815377a2e3e85a5b194cfdcbed7d'

  ruby_dir = settings[:ruby_dir]
  ruby_bindir = settings[:ruby_bindir]
  host_ruby = settings[:host_ruby]
  settings = settings

  instance_eval File.read('build/vanagon/components/_base-ruby.rb')

  pkg.environment 'optflags', '-O2'

  special_flags = " --prefix=#{ruby_dir} --with-opt-dir=#{settings[:prefix]} --enable-dtrace --with-baseruby=#{host_ruby}"

  pkg.configure do
    [
      "bash configure \
        --enable-shared \
        --enable-bundled-libyaml \
        --disable-install-doc \
        --disable-install-rdoc \
        #{special_flags}
      "
    ]
  end
end
