# frozen_string_literal: true

component 'rubygem-term-ansicolor' do |pkg, _settings, _platform|
  pkg.version '1.7.1'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
