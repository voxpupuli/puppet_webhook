# frozen_string_literal: true

component 'rubygem-ruby-debug-ide' do |pkg, _settings, _platform|
  pkg.version '0.7.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
