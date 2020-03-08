# frozen_string_literal: true

component 'rubygem-mime-types-data' do |pkg, _settings, _platform|
  pkg.version '3.2019.1009'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
