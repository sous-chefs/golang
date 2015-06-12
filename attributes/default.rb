default['go']['version'] = '1.4'
default['go']['platform'] = node['kernel']['machine'] =~ /i.86/ ? '386' : 'amd64'
default['go']['filename'] = "go#{node['go']['version']}.#{node['os']}-#{node['go']['platform']}.tar.gz"
default['go']['url'] = "http://golang.org/dl/#{node['go']['filename']}"
default['go']['install_dir'] = '/usr/local'
default['go']['gopath'] = '/opt/go'
default['go']['gobin'] = '/opt/go/bin'
default['go']['scm'] = true
default['go']['packages'] = []
default['go']['owner'] = 'root'
default['go']['group'] = 'root'
default['go']['mode'] = 0755

# set proxy settings for apt cacher if needed
proxy = URI(ENV['https_proxy'])
default['apt']['cacher_ipaddress'] = proxy.host
default['apt']['cacher_port'] = proxy.port
default['apt']['cacher_ssl_support'] = true
