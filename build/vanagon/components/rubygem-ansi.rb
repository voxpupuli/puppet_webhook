component 'rubygem-ansi' do |pkg, settings, platform|
  pkg.version '1.5.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
