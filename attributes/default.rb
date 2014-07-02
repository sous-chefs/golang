default['golang']['version'] = '1.2.2'
default['golang']['platform'] = node['kernel']['machine'] =~ /i.86/ ? '386' : 'amd64'
default['golang']['filename'] = "go#{node['golang']['version']}.#{node['os']}-\
#{node['golang']['platform']}.tar.gz"
default['golang']['url'] = "http://golang.org/dl/#{node['golang']['filename']}"
default['golang']['install_dir'] = '/usr/local'
default['golang']['gopath'] = '/opt/go'
default['golang']['gobin'] = '/opt/go/bin'
default['golang']['scm'] = true
default['golang']['packages'] = []
default['golang']['owner'] = 'root'
default['golang']['group'] = 'root'
