# frozen_string_literal: true

component 'rubygem-parser' do |pkg, _settings, _platform|
  pkg.version '2.6.5.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
