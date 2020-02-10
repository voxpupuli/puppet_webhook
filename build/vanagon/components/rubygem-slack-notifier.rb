component 'rubygem-slack-notifier' do |pkg, settings, platform|
  pkg.version '2.3.2'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
