component 'rubygem-i18n' do |pkg, settings, platform|
  pkg.version '0.9.5'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
