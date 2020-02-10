component 'rubygem-arel' do |pkg, settings, platform|
  pkg.version '6.0.4'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
