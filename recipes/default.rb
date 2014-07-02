#
# Cookbook Name:: golang
# Recipe:: default
#
# Copyright 2013, Alexander Rozhnov
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

bash "install-golang" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    rm -rf go
    rm -rf #{node['golang']['install_dir']}/go
    tar -C #{node['golang']['install_dir']} -xzf #{node["golang"]["filename"]}
  EOH
  action :nothing
end

remote_file File.join(Chef::Config[:file_cache_path], node['golang']['filename']) do
  source node['golang']['url']
  owner 'root'
  mode 0644
  notifies :run, 'bash[install-golang]', :immediately
  not_if \
    "#{node['golang']['install_dir']}/go/bin/go version | grep \"go#{node['golang']['version']} \""
end

directory node['golang']['gopath'] do
  action :create
  recursive true
  owner node['golang']['owner']
  group node['golang']['group']
  mode 0755
end

directory node['golang']['gobin'] do
  action :create
  recursive true
  owner node['golang']['owner']
  group node['golang']['group']
  mode 0755
end

template "/etc/profile.d/golang.sh" do
  source "golang.sh.erb"
  owner 'root'
  group 'root'
  mode 0755
end

if node['golang']['scm']
  %w(git mercurial bzr).each do |scm|
    package scm
  end
end
