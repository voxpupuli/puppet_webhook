# frozen_string_literal: true

component 'rubygem-simplecov-html' do |pkg, _settings, _platform|
  pkg.version '0.10.2'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
