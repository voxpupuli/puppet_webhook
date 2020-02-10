component 'rubygem-concurrent-ruby' do |pkg, settings, platform|
  pkg.version '1.1.5'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
