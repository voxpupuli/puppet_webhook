# frozen_string_literal: true

component 'rubygem-cri' do |pkg, _settings, _platform|
  pkg.version '2.15.10'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
