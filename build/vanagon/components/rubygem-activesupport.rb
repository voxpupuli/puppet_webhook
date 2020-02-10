component 'rubygem-activesupport' do |pkg, settings, platform|
  pkg.version '4.2.11'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
