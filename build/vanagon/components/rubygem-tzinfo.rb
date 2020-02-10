component 'rubygem-tzinfo' do |pkg, settings, platform|
  pkg.version '1.2.5'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
