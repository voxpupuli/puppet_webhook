component 'rubygem-sqlite3' do |pkg, settings, platform|
  pkg.version '1.3.13'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
