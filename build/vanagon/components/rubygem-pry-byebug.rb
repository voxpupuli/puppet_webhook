# frozen_string_literal: true

component 'rubygem-pry-byebug' do |pkg, _settings, _platform|
  pkg.version '3.7.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
