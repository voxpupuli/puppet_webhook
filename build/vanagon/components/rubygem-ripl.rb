component 'rubygem-ripl' do |pkg, settings, platform|
  pkg.version '0.7.1'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
