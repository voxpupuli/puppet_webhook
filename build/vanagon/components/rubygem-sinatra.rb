component 'rubygem-sinatra' do |pkg, settings, platform|
  pkg.version '2.0.8.1'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
