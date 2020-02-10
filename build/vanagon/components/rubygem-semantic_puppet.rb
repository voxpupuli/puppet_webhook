component 'rubygem-semantic_puppet' do |pkg, settings, platform|
  pkg.version '1.0.2'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
