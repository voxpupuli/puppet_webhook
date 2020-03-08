# frozen_string_literal: true

component 'rubygem-json' do |pkg, _settings, _platform|
  pkg.version '2.2.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
