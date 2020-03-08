# frozen_string_literal: true

component 'rubygem-nio4r' do |pkg, _settings, _platform|
  pkg.version '2.5.2'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
