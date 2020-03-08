# frozen_string_literal: true

component 'rubygem-byebug' do |pkg, _settings, _platform|
  pkg.version '11.0.1'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
