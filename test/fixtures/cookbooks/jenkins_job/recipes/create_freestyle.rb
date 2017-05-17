include_recipe 'jenkins_server_wrapper::default'

chef_jenkins_freestyle 'simple-execute' do
  builders 'command' => { 'command_string' => 'echo "This is Jenkins! Hear me roar!"' }
end

chef_jenkins_freestyle 'execute-with-params' do
  properties 'parameters' => {
    'STRING_PARAM' => {
      'type' => 'hudson.model.StringParameterDefinition',
      'description' => 'A string parameter'
    },
    'BOOLEAN_PARAM' => {
      'type' => 'hudson.model.BooleanParameterDefinition',
      'description' => 'A boolean parameter',
      'defaultValue' => false
    }
  }
  builders 'command' => { 'command_string' => 'echo "The string param is $STRING_PARAM!" echo "The boolean param is $BOOLEAN_PARAM!"' }
end

chef_jenkins_freestyle 'test1/test2/simple-execute' do
  builders 'command' => { 'command_string' => 'echo "This is Jenkins! Hear me roar!"' }
end
