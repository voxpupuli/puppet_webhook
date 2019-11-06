component 'ruby-2.6' do |pkg, settings, platform|
  pkg.version "2.6.5"
  pkg.url "https://cache.ruby-lang.org/pub/ruby/2.6/ruby-2.6.5.tar.gz"
  pkg.sha256sum "66976b716ecc1fd34f9b7c3c2b07bbd37631815377a2e3e85a5b194cfdcbed7d"

  pkg.configure do
    [ "bash configure --prefix /opt/voxpupuli/webhook --with-readline-dir=/opt/voxpupuli/webhook/lib" ]
  end

  pkg.build do
    [ "make" ]
  end

  pkg.install do
    [ "make install" ]
  end
end
