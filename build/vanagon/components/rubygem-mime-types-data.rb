component 'rubygem-mime-types-data' do |pkg, settings, platform|
  pkg.version '3.2019.1009'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
