# frozen_string_literal: true

component 'rubygem-gettext-setup' do |pkg, _settings, _platform|
  pkg.version '0.34'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
