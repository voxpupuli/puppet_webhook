# frozen_string_literal: true

component 'rubygem-packaging' do |pkg, _settings, _platform|
  pkg.version '0.99.49'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
