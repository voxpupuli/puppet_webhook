component 'rubygem-thread_safe' do |pkg, settings, platform|
  pkg.version '0.3.6'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
