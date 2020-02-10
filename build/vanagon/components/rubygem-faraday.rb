component 'rubygem-faraday' do |pkg, settings, platform|
  pkg.version '0.9.2'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
