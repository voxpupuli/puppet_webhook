component 'rubygem-vanagon' do |pkg, settings, platform|
  pkg.version '0.15.25'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
