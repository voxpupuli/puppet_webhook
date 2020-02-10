component 'rubygem-tux' do |pkg, settings, platform|
  pkg.version '0.3.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
