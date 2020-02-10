component 'rubygem-multi_json' do |pkg, settings, platform|
  pkg.version '1.14.1'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
