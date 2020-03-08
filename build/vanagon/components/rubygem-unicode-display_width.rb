# frozen_string_literal: true

component 'rubygem-unicode-display_width' do |pkg, _settings, _platform|
  pkg.version '1.6.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
