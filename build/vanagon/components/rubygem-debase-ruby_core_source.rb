component 'rubygem-debase-ruby_core_source' do |pkg, settings, platform|
  pkg.version '0.10.6'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
