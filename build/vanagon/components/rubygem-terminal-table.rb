# frozen_string_literal: true

component 'rubygem-terminal-table' do |pkg, _settings, _platform|
  pkg.version '1.8.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
