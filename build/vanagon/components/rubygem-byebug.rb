component 'rubygem-byebug' do |pkg, settings, platform|
  pkg.version '11.0.1'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
