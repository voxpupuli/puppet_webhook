# frozen_string_literal: true

component 'rubygem-coveralls' do |pkg, _settings, _platform|
  pkg.version '0.8.22'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
