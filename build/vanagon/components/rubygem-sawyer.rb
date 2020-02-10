component 'rubygem-sawyer' do |pkg, settings, platform|
  pkg.version '0.8.2'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
