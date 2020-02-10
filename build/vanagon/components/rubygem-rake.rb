component 'rubygem-rake' do |pkg, settings, platform|
  pkg.version '13.0.1'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
