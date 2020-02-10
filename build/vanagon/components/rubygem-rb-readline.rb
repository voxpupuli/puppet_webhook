component 'rubygem-rb-readline' do |pkg, settings, platform|
  pkg.version '0.5.5'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
