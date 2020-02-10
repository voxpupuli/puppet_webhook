component 'rubygem-rocket-chat-notifier' do |pkg, settings, platform|
  pkg.version '0.1.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
