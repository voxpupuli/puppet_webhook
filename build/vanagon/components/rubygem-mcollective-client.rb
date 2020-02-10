component 'rubygem-mcollective-client' do |pkg, settings, platform|
  pkg.version '2.12.5'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
