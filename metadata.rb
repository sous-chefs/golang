name             'chef-golang'
source_url       'https://github.com/NOX73/chef-golang' if respond_to?(:source_url)
issues_url       'https://github.com/NOX73/chef-golang/issues' if respond_to?(:issues_url)
maintainer       'Alexander Rozhnov'
maintainer_email 'gnox73@gmail.com'
license          'Apache-2.0'
description      'Installs go programming language'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '3.0.1'
chef_version     '>= 12' if respond_to?(:chef_version)

recipe 'chef-golang', 'Installs go programing language.'
recipe 'chef-golang::packages', 'Installs go packages and SCM requirements.'

supports 'debian'
supports 'ubuntu'
supports 'centos'
