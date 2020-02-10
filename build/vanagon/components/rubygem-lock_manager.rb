component 'rubygem-lock_manager' do |pkg, settings, platform|
  pkg.version '0.1.4'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
