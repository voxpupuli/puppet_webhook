# frozen_string_literal: true

component 'rubygem-database_cleaner-active_record' do |pkg, _settings, _platform|
  pkg.version '1.8.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
