bash "install-golang" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    rm -rf go
    rm -rf #{node['go']['install_dir']}/go
    tar -C #{node['go']['install_dir']} -xzf #{node["go"]["filename"]}
  EOH
  action :nothing
end

remote_file File.join(Chef::Config[:file_cache_path], node['go']['filename']) do
  source node['go']['url']
  owner "root"
  mode 0644
  notifies :run, resources(:bash => "install-golang"), :immediately
  not_if "#{node['go']['install_dir']}/go/bin/go version | grep #{node['go']['version']}"
end

template '/etc/profile.d/golang.sh' do
  cookbook 'golang'
  source 'golang.sh.erb'
  owner 'root'
  group 'root'
  mode 0755
  variables({
    install_dir: node['go']['install_dir']
  })
end
