require 'spec_helper'

describe jenkins_job('test1/test2/pipeline-execute') do
  it { should be_a_jenkins_job }
  it { should have_plugin_like(/^workflow-job/) }
  it { should have_script('node { echo "This is Jenkins! Hear me roar!"}') }
end

describe jenkins_job('test1/test2/pipeline-scm-execute') do
  it { should be_a_jenkins_job }
  it { should have_plugin_like(/^workflow-job/) }
  it { should have_element_with_value('scriptPath', 'Jenkinsfile') }
end
