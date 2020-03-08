# frozen_string_literal: true

component 'rubygem-faraday_middleware' do |pkg, _settings, _platform|
  pkg.version '0.10.1'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
