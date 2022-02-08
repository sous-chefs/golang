#
# Cookbook:: test
# Recipe:: default
#
# Copyright:: 2020-2022, Sous Chefs
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

user 'golang' do
  manage_home true
end

group 'golang' do
  members 'golang'
end

include_recipe 'golang'

package 'gcc' # required for the "go test" in the inspec tests

remote_directory '/tmp/helloWorld'

golang_package 'github.com/golang/example/hello' do
  action %i(install build)
end
