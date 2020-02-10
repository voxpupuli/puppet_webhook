component 'rubygem-coveralls' do |pkg, settings, platform|
  pkg.version '0.8.22'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
