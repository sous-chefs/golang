#
# Cookbook:: golang
# Recipe:: default
#
# Copyright:: 2013-2021, Alexander Rozhnov
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

golang 'Install go' do
  from_source node['golang']['from_source']
  version node['golang']['version'] if node['golang']['version'] # go version
  install_dir node['golang']['install_dir'] if node['golang']['install_dir'] # go install_dir - e.g. /opt or /usr/local
  source_version node['golang']['source_version'] if node['golang']['source_version'] # go version from source
  scm node['golang']['scm']
  scm_packages node['golang']['scm_packages']
  owner node['golang']['owner'] if node['golang']['owner']
  group node['golang']['group'] if node['golang']['group']
end

node['golang']['packages'].each do |package|
  golang_package package
end
