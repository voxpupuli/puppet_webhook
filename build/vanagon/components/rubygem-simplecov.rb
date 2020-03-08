# frozen_string_literal: true

component 'rubygem-simplecov' do |pkg, _settings, _platform|
  pkg.version '0.16.1'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
