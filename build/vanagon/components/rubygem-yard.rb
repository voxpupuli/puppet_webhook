component 'rubygem-yard' do |pkg, settings, platform|
  pkg.version '0.9.20'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
