component 'rubygem-cri' do |pkg, settings, platform|
  pkg.version '2.15.3'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
