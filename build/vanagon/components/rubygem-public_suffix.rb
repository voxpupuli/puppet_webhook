# frozen_string_literal: true

component 'rubygem-public_suffix' do |pkg, _settings, _platform|
  pkg.version '3.0.3'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
