component 'rubygem-bcrypt' do |pkg, settings, platform|
  pkg.version '3.1.12'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
