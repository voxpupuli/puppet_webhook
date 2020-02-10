component 'rubygem-require_all' do |pkg, settings, platform|
  pkg.version '3.0.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
