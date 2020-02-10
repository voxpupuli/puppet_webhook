component 'rubygem-puma' do |pkg, settings, platform|
  pkg.version '4.3.3'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
