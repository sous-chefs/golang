#
# Cookbook:: golang
# Attribute:: default
#

default['golang']['scm'] = true
default['golang']['scm_packages'] = %w(git)
default['golang']['install_dir'] = '/usr/local'
default['golang']['gopath'] = '/opt/go'
default['golang']['gobin'] = '/opt/go/bin'
default['golang']['packages'] = []
