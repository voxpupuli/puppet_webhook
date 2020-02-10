component 'rubygem-webmock' do |pkg, settings, platform|
  pkg.version '3.7.6'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
