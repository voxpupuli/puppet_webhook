component 'rubygem-simplecov-console' do |pkg, settings, platform|
  pkg.version '0.5.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
