apt_update 'update' if platform_family?('debian')

include_recipe 'java::default'
include_recipe 'jenkins::master'

jenkins_plugin 'cloudbees-folder' do
  notifies :restart, 'service[jenkins]', :immediately
end

=begin Get this list via script console
result = []
Jenkins.instance.pluginManager.plugins.each{
   plugin ->
   result << ("${plugin.getShortName()}:${plugin.getVersion()}")
}

result.sort().each{plugin -> println plugin}
=end
%w( ace-editor:1.1
    authentication-tokens:1.3
    bouncycastle-api:2.16.1
    branch-api:2.0.9
    cloudbees-folder:6.0.4
    credentials-binding:1.11
    credentials:2.1.13
    display-url-api:2.0
    docker-commons:1.6
    docker-workflow:1.11
    durable-task:1.13
    git-client:2.4.5
    git-server:1.7
    git:3.3.0
    github-api:1.85
    github-branch-source:2.0.5
    github:1.27.0
    handlebars:1.1.1
    icon-shim:2.0.3
    jquery-detached:1.2.1
    junit:1.20
    mailer:1.20
    matrix-project:1.11
    momentjs:1.1.1
    pipeline-build-step:2.5
    pipeline-graph-analysis:1.3
    pipeline-input-step:2.7
    pipeline-milestone-step:1.3.1
    pipeline-model-api:1.1.4
    pipeline-model-declarative-agent:1.1.1
    pipeline-model-definition:1.1.4
    pipeline-model-extensions:1.1.4
    pipeline-rest-api:2.6
    pipeline-stage-step:2.2
    pipeline-stage-tags-metadata:1.1.4
    pipeline-stage-view:2.6
    plain-credentials:1.4
    scm-api:2.1.1
    script-security:1.27
    ssh-credentials:1.13
    structs:1.6
    token-macro:2.1
    workflow-aggregator:2.5
    workflow-api:2.13
    workflow-basic-steps:2.4
    workflow-cps-global-lib:2.8
    workflow-cps:2.30
    workflow-durable-task-step:2.11
    workflow-job:2.11
    workflow-multibranch:2.14
    workflow-scm-step:2.4
    workflow-step-api:2.9
    workflow-support:2.14 ).each do |plugin|
  jenkins_plugin plugin.split(':').first do
    version plugin.split(':').last
    install_deps false
    notifies :touch, "file[#{Chef::Config[:file_cache_path]}/jenkins_plugin_updated]", :immediately
  end

  file "#{Chef::Config[:file_cache_path]}/jenkins_plugin_updated" do
    action :nothing
  end

  service 'jenkins_plugin_updated' do
    service_name 'jenkins'
    action :restart
    only_if { ::File.exist?("#{Chef::Config[:file_cache_path]}/jenkins_plugin_updated") }
    notifies :delete, "file[#{Chef::Config[:file_cache_path]}/jenkins_plugin_updated]", :immediately
  end
end
