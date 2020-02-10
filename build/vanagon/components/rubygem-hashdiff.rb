component 'rubygem-hashdiff' do |pkg, settings, platform|
  pkg.version '1.0.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
