component 'rubygem-faraday-http-cache' do |pkg, settings, platform|
  pkg.version '2.0.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
