component 'rubygem-packaging' do |pkg, settings, platform|
  pkg.version '0.99.49'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
