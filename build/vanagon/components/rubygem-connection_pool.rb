# frozen_string_literal: true

component 'rubygem-connection_pool' do |pkg, _settings, _platform|
  pkg.version '2.2.2'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
