#
# Cookbook:: golang
# Resource:: default
#
# Copyright:: 2020-2021, Sous-chefs
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

unified_mode true

default_action :install

gocache = '/tmp/go'

action :install do
  execute "go install #{new_resource.name}" do
    user node['golang']['owner']
    group node['golang']['group']
    environment({
      PATH: "#{node['golang']['install_dir']}/go/bin:#{node['golang']['gobin']}:" \
            '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      GOPATH: node['golang']['gopath'],
      GOBIN: node['golang']['gobin'],
      GOCACHE: gocache,
    })
  end
end

action :update do
  execute "go get -u #{new_resource.name}" do
    user node['golang']['owner']
    group node['golang']['group']
    environment({
      PATH: "#{node['golang']['install_dir']}/go/bin:#{node['golang']['gobin']}:" \
            '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      GOPATH: node['golang']['gopath'],
      GOBIN: node['golang']['gobin'],
      GOCACHE: gocache,
    })
  end
end

action :build do
  execute "go build -work -x #{new_resource.name}" do
    user node['golang']['owner']
    group node['golang']['group']
    cwd gocache
    environment({
      PATH: "#{node['golang']['install_dir']}/go/bin:#{node['golang']['gobin']}:" \
            '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      HOME: "/home/#{node['golang']['owner']}",
      GOPATH: node['golang']['gopath'],
      GOBIN: node['golang']['gobin'],
      GOCACHE: gocache,
    })
  end
end
