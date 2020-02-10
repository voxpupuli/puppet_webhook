component 'rubygem-octokit' do |pkg, settings, platform|
  pkg.version '4.16.0'
  instance_eval File.read('build/vanagon/components/_base-rubygem.rb')
end
