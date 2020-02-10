component 'rubygem-daemons' do |pkg, settings, platform|
  pkg.version '1.3.1'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
