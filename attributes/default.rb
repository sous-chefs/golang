#
# Cookbook:: golang
# Attribute:: default
#

default['golang']['version'] = '1.14.4'
default['golang']['platform'] = node['kernel']['machine'] =~ /i.86/ ? '386' : 'amd64'
default['golang']['filename'] = "go#{node['golang']['version']}.#{node['os']}-#{node['golang']['platform']}.tar.gz"
# E.g., https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz
default['golang']['url'] = "https://dl.google.com/go/#{node['golang']['filename']}"

default['golang']['source_version'] = node['golang']['version']
default['golang']['source_filename'] = "go#{node['golang']['source_version']}.src.tar.gz"
default['golang']['source_url'] = "https://dl.google.com/go/#{node['golang']['source_filename']}"

default['golang']['scm'] = true
default['golang']['scm_packages'] = value_for_platform(
  'centos' => { '>= 8' => %w(git mercurial) },
  'default' => %w(git mercurial bzr)
)

default['golang']['install_dir'] = '/usr/local'
default['golang']['gopath'] = '/opt/go'
default['golang']['gobin'] = '/opt/go/bin'
default['golang']['packages'] = []
