# frozen_string_literal: true

component 'rubygem-webmock' do |pkg, _settings, _platform|
  pkg.version '3.7.6'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
