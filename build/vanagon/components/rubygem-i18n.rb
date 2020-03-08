# frozen_string_literal: true

component 'rubygem-i18n' do |pkg, _settings, _platform|
  pkg.version '0.9.5'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
