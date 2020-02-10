component 'rubygem-terminal-table' do |pkg, settings, platform|
  pkg.version '1.8.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
