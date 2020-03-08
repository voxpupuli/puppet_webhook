# frozen_string_literal: true

component 'rubygem-rspec-core' do |pkg, _settings, _platform|
  pkg.version '3.9.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
