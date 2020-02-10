component 'rubygem-thor' do |pkg, settings, platform|
  pkg.version '0.19.4'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
