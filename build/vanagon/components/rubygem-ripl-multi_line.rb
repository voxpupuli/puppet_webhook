component 'rubygem-ripl-multi_line' do |pkg, settings, platform|
  pkg.version '0.3.1'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
