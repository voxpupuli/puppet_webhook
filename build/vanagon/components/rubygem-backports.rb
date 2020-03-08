# frozen_string_literal: true

component 'rubygem-backports' do |pkg, _settings, _platform|
  pkg.version '3.12.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
