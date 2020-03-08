# frozen_string_literal: true

component 'rubygem-simplecov-console' do |pkg, _settings, _platform|
  pkg.version '0.5.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
