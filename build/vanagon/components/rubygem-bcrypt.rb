# frozen_string_literal: true

component 'rubygem-bcrypt' do |pkg, _settings, _platform|
  pkg.version '3.1.12'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
