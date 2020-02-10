component 'rubygem-gettext' do |pkg, settings, platform|
  pkg.version '3.2.9'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
