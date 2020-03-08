# frozen_string_literal: true

component 'rubygem-mini_mime' do |pkg, _settings, _platform|
  pkg.version '1.0.1'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
