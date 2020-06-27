default_action :install

gocache = '/tmp/go'

action :install do
  execute "go get #{new_resource.name}" do
    user node['golang']['owner']
    group node['golang']['group']
    environment({
      PATH: "#{node['golang']['install_dir']}/go/bin:#{node['golang']['gobin']}:" \
            '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      GOPATH: node['golang']['gopath'],
      GOBIN: node['golang']['gobin'],
      GOCACHE: gocache,
    })
  end
end

action :update do
  execute "go get -u #{new_resource.name}" do
    user node['golang']['owner']
    group node['golang']['group']
    environment({
      PATH: "#{node['golang']['install_dir']}/go/bin:#{node['golang']['gobin']}:" \
            '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      GOPATH: node['golang']['gopath'],
      GOBIN: node['golang']['gobin'],
      GOCACHE: gocache,
    })
  end
end

action :build do
  execute "go build -work -x #{new_resource.name}" do
    user node['golang']['owner']
    group node['golang']['group']
    cwd gocache
    environment({
      PATH: "#{node['golang']['install_dir']}/go/bin:#{node['golang']['gobin']}:" \
            '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      HOME: "/home/#{node['golang']['owner']}",
      GOPATH: node['golang']['gopath'],
      GOBIN: node['golang']['gobin'],
      GOCACHE: gocache,
    })
  end
end
