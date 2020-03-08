# frozen_string_literal: true

component 'rubygem-multipart-post' do |pkg, _settings, _platform|
  pkg.version '2.1.1'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
