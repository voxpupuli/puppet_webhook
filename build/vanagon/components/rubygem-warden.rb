component 'rubygem-warden' do |pkg, settings, platform|
  pkg.version '1.2.8'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
