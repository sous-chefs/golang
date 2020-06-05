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

if node['golang']['scm']
  apt_update do
    only_if { platform_family? 'debian' }
  end

  node['golang']['scm_packages'].each do |scm|
    package scm
  end
end

ark 'go' do
  url node['golang']['url']
  version node['golang']['version']
end

build_essential do
  only_if { node['golang']['from_source'] }
end

file "#{node['golang']['install_dir']}/go" do
  action :delete
  only_if do
    node['golang']['from_source'] &&
      # Create idempotency by not deleting symlink if it points to source build
      File.readlink("#{node['golang']['install_dir']}/go") != "#{node['golang']['install_dir']}/go-source"
  end
end

ark 'go' do
  url node['golang']['source_url']
  version 'source'
  action :put
  only_if { node['golang']['from_source'] }
end

directory "#{node['golang']['install_dir']}/go/bin" do
  only_if { node['golang']['from_source'] }
end

execute 'build-golang' do
  cwd "#{node['golang']['install_dir']}/go/src"
  command "./#{node['golang']['source_method']}"
  environment({
    # Use the package-installed Go as the bootstrap version b/c Go is built with Go
    GOROOT_BOOTSTRAP: "#{node['golang']['install_dir']}/go-#{node['golang']['version']}",
    GOROOT: "#{node['golang']['install_dir']}/go",
    GOBIN: "#{node['golang']['install_dir']}/go/bin",
  })
  only_if { node['golang']['from_source'] }
end
