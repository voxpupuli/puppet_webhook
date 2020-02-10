component 'rubygem-sinatra-activerecord' do |pkg, settings, platform|
  pkg.version '2.0.14'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
