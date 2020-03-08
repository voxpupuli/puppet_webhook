# frozen_string_literal: true

component 'rubygem-docile' do |pkg, _settings, _platform|
  pkg.version '1.3.1'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
