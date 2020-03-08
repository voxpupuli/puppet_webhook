# frozen_string_literal: true

component 'rubygem-thread_safe' do |pkg, _settings, _platform|
  pkg.version '0.3.6'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
