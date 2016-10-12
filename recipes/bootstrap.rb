remote_file File.join(Chef::Config[:file_cache_path], 'bootstrap.tbz') do
  source node['go']['bootstrap_url']
  owner 'root'
  mode 0644
end

bootstrap_root = "#{node['go']['install_dir']}/go-bootstrap/go-#{node['go']['os']}-#{node['go']['arch']}-bootstrap"

bash "extract golang bootstrap" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    rm -rf go-bootstrap
    rm -rf #{node['go']['install_dir']}/go-bootstrap
    mkdir -p #{node['go']['install_dir']}/go-bootstrap
    tar -C #{node['go']['install_dir']}/go-bootstrap -xvjf bootstrap.tbz
  EOH
  environment ({
    'GOROOT' => bootstrap_root
  })
  not_if "#{bootstrap_root}/bin/go version | grep \"go#{node['go']['version']} \""
end
