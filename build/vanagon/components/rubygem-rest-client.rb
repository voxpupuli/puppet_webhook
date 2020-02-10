component 'rubygem-rest-client' do |pkg, settings, platform|
  pkg.version '1.6.7'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
