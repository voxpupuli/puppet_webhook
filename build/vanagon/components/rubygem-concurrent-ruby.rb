# frozen_string_literal: true

component 'rubygem-concurrent-ruby' do |pkg, _settings, _platform|
  pkg.version '1.1.5'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
