apt_update 'update' if platform_family?('debian')

include_recipe 'java'
include_recipe 'jenkins::master'

chef_jenkins_freestyle 'nested folder/folder/test' do
  builders 'command' => { 'command_string' => 'echo hello' }
end

# chef_jenkins_freestyle_job 'nested folder' do
#   action :delete
# end

chef_jenkins_pipeline 'nested folder/folder/test-pipeline' do
  script "node { echo 'hello world'}"
end

chef_jenkins_github_org 'github/test-github' do
  org 'ndobson'
end

chef_jenkins_multibranch_pipeline 'nested folder/folder/test-multibranch'
