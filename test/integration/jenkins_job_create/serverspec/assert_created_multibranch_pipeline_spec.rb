require 'spec_helper'

describe jenkins_job('test1/test2/simple-multibranch') do
  it { should be_a_jenkins_job }
  it { should have_plugin_like(/^workflow-multibranch/) }
end
