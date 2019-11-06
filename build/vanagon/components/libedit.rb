component 'libedit' do |pkg, settings, platform|
  pkg.version '20150325-3.1'
  pkg.md5sum '43cdb5df3061d78b5e9d59109871b4f6'
  pkg.url "http://thrysoee.dk/editline/libedit-#{pkg.get_version}.tar.gz"

  pkg.configure do
    "bash configure --prefix=/opt/voxpupuli/webhook/lib"
  end

  pkg.build do
    "make"
  end

  pkg.install do
    "make install"
  end

  pkg.link File.join(settings[:libdir], 'libedit.so'), File.join(settings[:libdir], 'libreadline.so')
  pkg.link File.join(settings[:includedir], 'editline', 'readline.h'), File.join(settings[:includedir], 'readline', 'readline.h')
  pkg.link File.join(settings[:includedir], 'editline', 'readline.h'), File.join(settings[:includedir], 'readline', 'history.h')
end
