component 'rubygem-bond' do |pkg, settings, platform|
  pkg.version '0.5.1'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
