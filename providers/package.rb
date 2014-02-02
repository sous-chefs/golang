action :install do

  tmp_file_path = ::File.join Chef::Config[:file_cache_path], new_resource.name.gsub(/\//, '-')

  bash "#{node['go']['install_dir']}/go/bin/go get -v #{new_resource.name} 2> >(grep -v '(download)$' > #{tmp_file_path})" do
    code "#{node['go']['install_dir']}/go/bin/go get -v #{new_resource.name} 2> >(grep -v '(download)$' > #{tmp_file_path})"
    action :nothing
    user node['go']['owner']
    group node['go']['group']
    environment({
      'GOPATH' => node['go']['gopath'],
      'GOBIN' => node['go']['gobin']
    })
  end.run_action(:run)

  f = file tmp_file_path do
    content ''
  end
  f.run_action(:create)

  new_resource.updated_by_last_action(f.updated?)
end

action :update do

  tmp_file_path = ::File.join Chef::Config[:file_cache_path], new_resource.name.gsub(/\//, '-')

  bash "#{node['go']['install_dir']}/go/bin/go get -v -u #{new_resource.name} 2> >(grep -v '(download)$' > #{tmp_file_path})" do
    code "#{node['go']['install_dir']}/go/bin/go get -v -u #{new_resource.name} 2> >(grep -v '(download)$' > #{tmp_file_path})"
    action :nothing
    user node['go']['owner']
    group node['go']['group']
    environment({
      'GOPATH' => node['go']['gopath'],
      'GOBIN' => node['go']['gobin']
    })
  end.run_action(:run)

  f = file tmp_file_path do
    content ''
  end
  f.run_action(:create)

  new_resource.updated_by_last_action(f.updated?)
end
