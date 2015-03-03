#
# Cookbook Name:: golang_test
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

golang_package "code.google.com/p/go.example/hello" do
  action [:install,:build]
end
