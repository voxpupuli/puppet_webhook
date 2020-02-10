component 'rubygem-nokogiri' do |pkg, settings, platform|
  pkg.version '1.10.5'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
