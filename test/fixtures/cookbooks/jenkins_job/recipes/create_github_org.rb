include_recipe 'jenkins_server_wrapper::default'

chef_jenkins_github_org 'github/test-github' do
  org 'chef-jenkins-test'
end
