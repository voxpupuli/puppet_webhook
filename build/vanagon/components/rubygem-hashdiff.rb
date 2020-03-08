# frozen_string_literal: true

component 'rubygem-hashdiff' do |pkg, _settings, _platform|
  pkg.version '1.0.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
