# frozen_string_literal: true

component 'rubygem-tins' do |pkg, _settings, _platform|
  pkg.version '1.20.2'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
