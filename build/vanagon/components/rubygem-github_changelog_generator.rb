component 'rubygem-github_changelog_generator' do |pkg, settings, platform|
  pkg.version '1.15.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
