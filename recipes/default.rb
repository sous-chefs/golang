#
# Cookbook:: golang
# Recipe:: default
#
# Copyright:: 2013, Alexander Rozhnov
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy
# of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#

bash 'install-golang' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    rm -rf go
    rm -rf #{node['golang']['install_dir']}/go
    tar -C #{node['golang']['install_dir']} -xzf #{node['golang']['filename']}
  EOH
  not_if { node['golang']['from_source'] }
  action :nothing
end

bash 'build-golang' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    rm -rf go
    rm -rf #{node['golang']['install_dir']}/go
    tar -C #{node['golang']['install_dir']} -xzf #{node['golang']['filename']}
    cd #{node['golang']['install_dir']}/go/src
    mkdir -p $GOBIN
    ./#{node['golang']['source_method']}
  EOH
  environment({
    'GOROOT' => "#{node['golang']['install_dir']}/go",
    'GOBIN'  => '$GOROOT/bin',
    'GOOS'   => node['golang']['os'],
    'GOARCH' => node['golang']['arch'],
    'GOARM'  => node['golang']['arm'],
  })
  only_if { node['golang']['from_source'] }
  action :nothing
end

if node['golang']['from_source']
  case node['platform']
  when 'debian', 'ubuntu'
    packages = %w(build-essential)
  when 'redhat', 'centos', 'fedora'
    packages = %w(gcc glibc-devel)
  end
  packages.each do |dev_package|
    package dev_package do
      action :install
    end
  end
end

remote_file File.join(Chef::Config[:file_cache_path], node['golang']['filename']) do
  source node['golang']['url']
  owner 'root'
  mode '0644'
  notifies :run, 'bash[install-golang]', :immediately
  notifies :run, 'bash[build-golang]', :immediately
  not_if "#{node['golang']['install_dir']}/go/bin/go version | grep \"go#{node['golang']['version']} \""
end

directory node['golang']['gopath'] do
  action :create
  recursive true
  owner node['golang']['owner']
  group node['golang']['group']
  mode node['golang']['mode']
end

directory node['golang']['gobin'] do
  action :create
  recursive true
  owner node['golang']['owner']
  group node['golang']['group']
  mode node['golang']['mode']
end

template '/etc/profile.d/golang.sh' do
  source 'golang.sh.erb'
  owner node['golang']['owner']
  group node['golang']['group']
  mode node['golang']['mode']
end

%w(git mercurial bzr).each do |scm|
  package scm do
    only_if { node['golang']['scm'] }
  end
end
