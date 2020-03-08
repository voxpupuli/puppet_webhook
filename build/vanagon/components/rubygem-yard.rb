# frozen_string_literal: true

component 'rubygem-yard' do |pkg, _settings, _platform|
  pkg.version '0.9.20'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
