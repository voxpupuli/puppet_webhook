component 'rubygem-rubocop' do |pkg, settings, platform|
  pkg.version '0.76.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
