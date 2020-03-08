# frozen_string_literal: true

component 'rubygem-diff-lcs' do |pkg, _settings, _platform|
  pkg.version '1.3'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
