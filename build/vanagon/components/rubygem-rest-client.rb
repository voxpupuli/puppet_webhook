# frozen_string_literal: true

component 'rubygem-rest-client' do |pkg, _settings, _platform|
  pkg.version '1.6.7'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
