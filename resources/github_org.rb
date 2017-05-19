property :job_name, String, name_property: true

property :description, String, default: 'Generated by Chef'
property :display_name, String

# These library definitions can be huge, so you'll have to put them in your own partial templates
property :libraries, Hash, default: {}
property :docker_label, String, default: ''
property :docker_url, String, default: ''
property :docker_creds_id, String, default: ''
property :auto_build_branch_names, String, default: '.*'

property :discard_old_items, [true, false], default: true
property :days_to_keep, Integer, default: 0
property :num_to_keep, Integer, default: 0

property :periodic_scan, [true, false], default: true
property :scan_spec, String, default: 'H H * * *' # Defaults to once a day
property :scan_interval, String, default: '86400000'

property :org, String, required: true
property :scan_creds_id, String
property :checkout_creds_id, String, default: 'SAME' # Can be SAME, ANONYMOUS, a credentials id, or empty (for none)
property :api_url, String
property :pattern, String, default: '.*'
property :includes, String
property :excludes, String
property :build_origin_branch, [true, false], default: true
property :build_origin_branch_with_pr, [true, false], default: true
property :build_origin_pr_merge, [true, false], default: false
property :build_origin_pr_head, [true, false], default: false
property :build_fork_pr_merge, [true, false], default: true
property :build_fork_pr_head, [true, false], default: false

property :template, String, default: 'github-org-config.xml.erb'
property :include_templates, Array, default: []
property :auto_create_folders, [true, false], default: true

action :create do
  folder_name = ::File.dirname(new_resource.job_name)
  if new_resource.auto_create_folders && !folder_name.eql?('.')
    folder_name = ::File.dirname(new_resource.job_name)
    chef_jenkins_folder folder_name
  end

  xml = "#{Chef::Config[:file_cache_path]}/#{new_resource.job_name}.xml"

  directory ::File.dirname(xml) do
    recursive true
  end

  declare_resource(:template, xml) do
    source new_resource.template
    variables(
      description: new_resource.description,
      display_name: new_resource.display_name,

      libraries: new_resource.libraries,
      docker_label: new_resource.docker_label,
      docker_url: new_resource.docker_url,
      docker_creds_id: new_resource.docker_creds_id,
      auto_build_branch_names: new_resource.auto_build_branch_names,

      discard_old_items: new_resource.discard_old_items,
      days_to_keep: new_resource.days_to_keep,
      num_to_keep: new_resource.num_to_keep,

      periodic_scan: new_resource.periodic_scan,
      scan_spec: new_resource.scan_spec,
      scan_interval: new_resource.scan_interval,

      org: new_resource.org,
      scan_creds_id: new_resource.scan_creds_id,
      checkout_creds_id: new_resource.checkout_creds_id,
      api_url: new_resource.api_url,
      pattern: new_resource.pattern,
      includes: new_resource.includes,
      excludes: new_resource.excludes,
      build_origin_branch: new_resource.build_origin_branch,
      build_origin_branch_with_pr: new_resource.build_origin_branch_with_pr,
      build_origin_pr_merge: new_resource.build_origin_pr_merge,
      build_origin_pr_head: new_resource.build_origin_pr_head,
      build_fork_pr_merge: new_resource.build_fork_pr_merge,
      build_fork_pr_head: new_resource.build_fork_pr_head,

      cookbook: new_resource.cookbook_name,
      include_templates: new_resource.include_templates
    )
    helpers(ChefJenkins::Helper)
    cookbook include_templates.include?(new_resource.template) ? new_resource.cookbook_name : 'chef_jenkins'
  end

  jenkins_job new_resource.job_name do
    config xml
  end
end

action :delete do
  jenkins_job new_resource.job_name do
    action :delete
  end
end
