component 'rubygem-pry-byebug' do |pkg, settings, platform|
  pkg.version '3.7.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
