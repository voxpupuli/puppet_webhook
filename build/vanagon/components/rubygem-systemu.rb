component 'rubygem-systemu' do |pkg, settings, platform|
  pkg.version '2.6.5'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
