default['golang']['version'] = '1.5'
default['golang']['platform'] = node['kernel']['machine'] =~ /i.86/ ? '386' : 'amd64'
default['golang']['filename'] = "go#{node['golang']['version']}.#{node['os']}-#{node['golang']['platform']}.tar.gz"
default['golang']['from_source'] = false
if node['golang']['from_source']
  default['golang']['filename'] = "go#{node['golang']['version']}.src.tar.gz"
  default['golang']['os'] = 'linux'
  default['golang']['arch'] = 'arm'
  default['golang']['arm'] = '6'
  default['golang']['source_method'] = 'all.bash'
end
default['golang']['url'] = "http://golang.org/dl/#{node['golang']['filename']}"
default['golang']['install_dir'] = '/usr/local'
default['golang']['gopath'] = '/opt/go'
default['golang']['gobin'] = '/opt/go/bin'
default['golang']['scm'] = true
default['golang']['packages'] = []
default['golang']['owner'] = 'root'
default['golang']['group'] = 'root'
default['golang']['mode'] = 0o755
