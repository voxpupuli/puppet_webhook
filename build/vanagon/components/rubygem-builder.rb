# frozen_string_literal: true

component 'rubygem-builder' do |pkg, _settings, _platform|
  pkg.version '3.2.3'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
