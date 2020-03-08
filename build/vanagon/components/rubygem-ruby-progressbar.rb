# frozen_string_literal: true

component 'rubygem-ruby-progressbar' do |pkg, _settings, _platform|
  pkg.version '1.10.1'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
