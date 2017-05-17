require 'spec_helper'

describe jenkins_job('simple-execute') do
  it { should be_a_jenkins_job }
  it { should have_command('echo "This is Jenkins! Hear me roar!"') }
end

describe jenkins_job('test1/test2/simple-execute') do
  it { should be_a_jenkins_job }
  it { should have_command('echo "This is Jenkins! Hear me roar!"') }
end

describe jenkins_job('execute-with-params') do
  it { should be_a_jenkins_job }
  it { should have_command('echo "The string param is $STRING_PARAM!" echo "The boolean param is $BOOLEAN_PARAM!"') }
end
