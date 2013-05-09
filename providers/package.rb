action :install do

  execute "#{node['go']['install_dir']}/go/bin/go get #{new_resource.name}" do
    environment({
      'GOPATH' => node['go']['gopath'],
      'GOBIN' => node['go']['gobin']
    })
  end
end

action :update do

  execute "#{node['go']['install_dir']}/go/bin/go get -u #{new_resource.name}" do
    environment({
      'GOPATH' => node['go']['gopath'],
      'GOBIN' => node['go']['gobin']
    })
  end
end
