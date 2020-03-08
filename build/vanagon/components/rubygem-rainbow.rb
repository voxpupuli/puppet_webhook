# frozen_string_literal: true

component 'rubygem-rainbow' do |pkg, _settings, _platform|
  pkg.version '3.0.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
