# frozen_string_literal: true

component 'rubygem-debase-ruby_core_source' do |pkg, _settings, _platform|
  pkg.version '0.10.6'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
