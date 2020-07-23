# frozen_string_literal: true

component 'rubygem-faraday_middleware' do |pkg, _settings, _platform|
  pkg.version '0.14.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
