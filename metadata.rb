name             'golang'
source_url       'https://github.com/NOX73/chef-golang'
issues_url       'https://github.com/NOX73/chef-golang/issues'
maintainer       'Alexander Rozhnov'
maintainer_email 'gnox73@gmail.com'
license          'Apache-2.0'
description      'Installs go programming language'
version          '3.0.1'
chef_version     '>= 12' if respond_to?(:chef_version)

supports 'debian'
supports 'ubuntu'
supports 'centos'
