component 'rubygem-stomp' do |pkg, settings, platform|
  pkg.version '1.4.9'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
