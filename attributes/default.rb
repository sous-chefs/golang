#
# Cookbook:: golang
# Attribute:: default
#

default['golang']['scm'] = true
default['golang']['scm_packages'] = value_for_platform(
  'centos' => { '>= 8' => %w(git mercurial) },
  'default' => %w(git mercurial bzr)
)

default['golang']['install_dir'] = '/usr/local'
default['golang']['gopath'] = '/opt/go'
default['golang']['gobin'] = '/opt/go/bin'
default['golang']['packages'] = []
