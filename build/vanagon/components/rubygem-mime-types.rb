# frozen_string_literal: true

component 'rubygem-mime-types' do |pkg, _settings, _platform|
  pkg.version '3.3'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
