component 'rubygem-r10k' do |pkg, settings, platform|
  pkg.version '3.3.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
