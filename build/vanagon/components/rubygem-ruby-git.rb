component 'rubygem-ruby-git' do |pkg, settings, platform|
  pkg.version '0.2.2'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
