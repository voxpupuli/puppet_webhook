component 'rubygem-pry' do |pkg, settings, platform|
  pkg.version '0.12.2'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
