component 'rubygem-capybara' do |pkg, settings, platform|
  pkg.version '3.15.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
