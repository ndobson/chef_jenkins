name 'chef_jenkins'
maintainer 'Nick Dobson'
maintainer_email 'nick.dobson@me.com'
license 'Apache-2.0'
description 'Installs/Configures chef_jenkins'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.2.2'
chef_version '>= 12.5' if respond_to?(:chef_version)
issues_url 'https://github.com/ndobson/chef_jenkins/issues'
source_url 'https://github.com/ndobson/chef_jenkins'

%w(ubuntu debian redhat centos scientific oracle amazon).each do |os|
  supports os
end

depends 'jenkins'
