use_inline_resources

action :install do
  tmp_dir_path = ::File.join Chef::Config[:file_cache_path], 'golang'
  tmp_file_path = ::File.join tmp_dir_path, new_resource.name.gsub(/\//, '-')

  directory tmp_dir_path do
    user node['golang']['owner']
    group node['golang']['group']
    mode '0775'
    action :nothing
  end.run_action(:create)

  bash "Installing package #{new_resource.name}" do
    code "#{node['golang']['install_dir']}/go/bin/go get -v #{new_resource.name} 2> >(grep -v '(download)$' | tee #{tmp_file_path})"
    action :nothing
    user node['golang']['owner']
    group node['golang']['group']
    environment(
      'GOPATH' => node['golang']['gopath'],
      'GOBIN' => node['golang']['gobin']
    )
  end.run_action(:run)

  f = file tmp_file_path do
    user node['golang']['owner']
    group node['golang']['group']
    content ''
  end
  f.run_action(:create)
end

action :update do
  tmp_file_path = ::File.join Chef::Config[:file_cache_path], new_resource.name.gsub(/\//, '-')

  bash "Updating package #{new_resource.name}" do
    code "#{node['golang']['install_dir']}/go/bin/go get -v -u #{new_resource.name} 2> >(grep -v '(download)$' | tee #{tmp_file_path})"
    action :nothing
    user node['golang']['owner']
    group node['golang']['group']
    environment(
      'GOPATH' => node['golang']['gopath'],
      'GOBIN' => node['golang']['gobin']
    )
  end.run_action(:run)

  f = file tmp_file_path do
    content ''
  end
  f.run_action(:create)
end

action :build do
  tmpdir = directory (::File.join Chef::Config[:file_cache_path], new_resource.name.gsub(/\//, '-') + '_BUILD') do
    action :nothing
    owner node['golang']['owner']
    group node['golang']['group']
    recursive true
  end

  # create temporary directory to executing the build in
  tmpdir.run_action(:create)

  b = bash "Build package #{new_resource.name}" do
    code "#{node['golang']['install_dir']}/go/bin/go build #{new_resource.name}"
    action :nothing
    cwd tmpdir.name
    user node['golang']['owner']
    group node['golang']['group']
    environment(
      'GOPATH' => node['golang']['gopath'],
      'GOBIN' => node['golang']['gobin']
    )
  end

  # execute the build
  b.run_action(:run)

  # remove temporary directory
  # tmpdir.run_action(:delete)
end
