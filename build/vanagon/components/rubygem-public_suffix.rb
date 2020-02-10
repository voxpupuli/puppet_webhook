component 'rubygem-public_suffix' do |pkg, settings, platform|
  pkg.version '3.0.3'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
