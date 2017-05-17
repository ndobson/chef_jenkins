require 'spec_helper'

describe jenkins_job('github/test-github') do
  it { should be_a_jenkins_job }
  it { should have_plugin_like(/^branch-api/) }
end
