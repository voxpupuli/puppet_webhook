# frozen_string_literal: true

component 'rubygem-locale' do |pkg, _settings, _platform|
  pkg.version '2.1.3'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
