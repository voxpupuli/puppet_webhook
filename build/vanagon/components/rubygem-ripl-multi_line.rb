# frozen_string_literal: true

component 'rubygem-ripl-multi_line' do |pkg, _settings, _platform|
  pkg.version '0.3.1'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
