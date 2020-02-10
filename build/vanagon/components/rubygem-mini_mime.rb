component 'rubygem-mini_mime' do |pkg, settings, platform|
  pkg.version '1.0.1'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
