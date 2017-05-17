include_recipe 'jenkins_server_wrapper::default'

chef_jenkins_multibranch_pipeline 'test1/test2/simple-multibranch'
