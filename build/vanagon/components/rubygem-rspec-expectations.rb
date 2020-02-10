component 'rubygem-rspec-expectations' do |pkg, settings, platform|
  pkg.version '3.9.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
