# frozen_string_literal: true

component 'rubygem-thin' do |pkg, _settings, _platform|
  pkg.version '1.7.2'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
