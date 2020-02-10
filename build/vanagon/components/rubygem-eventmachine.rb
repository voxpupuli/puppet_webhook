component 'rubygem-eventmachine' do |pkg, settings, platform|
  pkg.version '1.2.7'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
