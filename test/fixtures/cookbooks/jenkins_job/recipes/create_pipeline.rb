include_recipe 'jenkins_server_wrapper::default'

chef_jenkins_pipeline 'test1/test2/pipeline-execute' do
  script 'node { echo "This is Jenkins! Hear me roar!"}'
end

chef_jenkins_pipeline 'test1/test2/pipeline-scm-execute' do
  scm 'git' => {
    'url' => 'https://github.com/ndobson/chef_jenkins',
    'extensions' => ['hudson.plugins.git.extensions.impl.CleanBeforeCheckout']
  }
end
