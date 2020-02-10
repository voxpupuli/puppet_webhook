component 'rubygem-debase' do |pkg, settings, platform|
  pkg.version '0.2.4.1'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
