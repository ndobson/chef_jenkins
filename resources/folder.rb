property :folder_name, String, name_property: true
property :description, String, default: 'Generated by Chef'
property :display_name, String
property :template, String, default: 'folder-config.xml.erb'
property :cookbook, String, default: 'chef_jenkins'
property :recursive, [true, false], default: true

action :create do
  parent_dir = ::File.dirname(new_resource.folder_name)
  if new_resource.recursive && !parent_dir.eql?('.')
    chef_jenkins_folder parent_dir unless parent_dir.eql?('.')
  end

  xml = "#{Chef::Config[:file_cache_path]}/#{new_resource.folder_name}.xml"

  directory ::File.dirname(xml) do
    recursive true
  end

  declare_resource(:template, xml) do
    source new_resource.template
    variables(
      description: new_resource.description,
      display_name: new_resource.display_name
    )
    cookbook new_resource.cookbook
  end

  jenkins_job new_resource.folder_name do
    config xml
  end
end

action :delete do
  jenkins_job new_resource.folder_name do
    action :delete
  end
end
