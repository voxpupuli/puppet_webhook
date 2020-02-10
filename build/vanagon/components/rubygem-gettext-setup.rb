component 'rubygem-gettext-setup' do |pkg, settings, platform|
  pkg.version '0.34'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
