component 'rubygem-safe_yaml' do |pkg, settings, platform|
  pkg.version '1.0.5'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
