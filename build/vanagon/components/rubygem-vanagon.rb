# frozen_string_literal: true

component 'rubygem-vanagon' do |pkg, _settings, _platform|
  pkg.version '0.15.25'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
