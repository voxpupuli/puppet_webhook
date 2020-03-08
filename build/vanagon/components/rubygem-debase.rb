# frozen_string_literal: true

component 'rubygem-debase' do |pkg, _settings, _platform|
  pkg.version '0.2.4.1'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
