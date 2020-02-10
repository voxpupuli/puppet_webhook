component 'rubygem-git' do |pkg, settings, platform|
  pkg.version '1.3.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
