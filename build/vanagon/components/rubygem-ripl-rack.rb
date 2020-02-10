component 'rubygem-ripl-rack' do |pkg, settings, platform|
  pkg.version '0.2.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
