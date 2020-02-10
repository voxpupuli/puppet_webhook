component 'rubygem-connection_pool' do |pkg, settings, platform|
  pkg.version '2.2.2'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
