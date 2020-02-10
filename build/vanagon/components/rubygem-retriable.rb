component 'rubygem-retriable' do |pkg, settings, platform|
  pkg.version '3.1.2'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
