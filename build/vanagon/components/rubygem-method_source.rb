# frozen_string_literal: true

component 'rubygem-method_source' do |pkg, _settings, _platform|
  pkg.version '0.9.2'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
