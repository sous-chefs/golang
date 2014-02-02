#
# Cookbook Name:: chef_golang_test
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "golang::packages"

golang_package "launchpad.net/gocheck" do
  action :install
end

remote_directory "/tmp/hello_world" do
  name "hello_world"
end
