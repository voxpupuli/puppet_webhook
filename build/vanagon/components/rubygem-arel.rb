# frozen_string_literal: true

component 'rubygem-arel' do |pkg, _settings, _platform|
  pkg.version '6.0.4'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
