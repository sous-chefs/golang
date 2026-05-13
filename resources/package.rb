# frozen_string_literal: true

provides :golang_package
unified_mode true

default_action :install

property :package_name, String, name_property: true
property :version, String, default: 'latest'
property :install_dir, String, default: '/usr/local'
property :gopath, String, default: '/opt/go'
property :gobin, String, default: '/opt/go/bin'
property :gocache, String, default: '/tmp/go'
property :owner, String, default: 'root'
property :group, String, default: 'root'
property :binary_name, String, default: lazy { ::File.basename(package_name) }

action_class do
  def go_install_target
    "#{new_resource.package_name}@#{new_resource.version}"
  end

  def go_environment
    {
      PATH: "#{new_resource.install_dir}/go/bin:#{new_resource.gobin}:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
      GOPATH: new_resource.gopath,
      GOBIN: new_resource.gobin,
      GOCACHE: new_resource.gocache,
      HOME: "/home/#{new_resource.owner}",
    }
  end
end

action :install do
  directory new_resource.gocache do
    recursive true
    owner new_resource.owner
    group new_resource.group
    mode '0755'
  end

  execute "go install #{go_install_target}" do
    user new_resource.owner
    group new_resource.group
    environment go_environment
    not_if { ::File.exist?(::File.join(new_resource.gobin, new_resource.binary_name)) }
  end
end

action :update do
  directory new_resource.gocache do
    recursive true
    owner new_resource.owner
    group new_resource.group
    mode '0755'
  end

  execute "go install #{go_install_target}" do
    user new_resource.owner
    group new_resource.group
    environment go_environment
    not_if { ::File.exist?(::File.join(new_resource.gobin, new_resource.binary_name)) }
  end
end

action :build do
  directory new_resource.gocache do
    recursive true
    owner new_resource.owner
    group new_resource.group
    mode '0755'
  end

  execute "go build -work -x #{new_resource.package_name}" do
    user new_resource.owner
    group new_resource.group
    cwd new_resource.gocache
    environment go_environment
  end
end

action :remove do
  file ::File.join(new_resource.gobin, new_resource.binary_name) do
    action :delete
  end
end
