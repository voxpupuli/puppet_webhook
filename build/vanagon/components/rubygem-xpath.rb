component 'rubygem-xpath' do |pkg, settings, platform|
  pkg.version '3.2.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
