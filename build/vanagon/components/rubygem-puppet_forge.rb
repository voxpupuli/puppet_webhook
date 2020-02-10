component 'rubygem-puppet_forge' do |pkg, settings, platform|
  pkg.version '2.2.8'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
