component 'rubygem-sidekiq' do |pkg, settings, platform|
  pkg.version '5.2.8'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
