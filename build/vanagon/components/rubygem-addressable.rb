component 'rubygem-addressable' do |pkg, settings, platform|
  pkg.version '2.5.2'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
