describe command '/usr/local/go/bin/go version' do
  its('stdout') { should include '1.14.4' }
end

describe command 'export GOPATH=/opt/go; cd /tmp/hello_world && /usr/local/go/bin/go test' do
  its('exit_status') { should cmp 0 }
end

describe directory '/opt/go' do
  its('owner') { should eq 'golang' }
  its('group') { should eq 'golang' }
end

describe command '/opt/go/bin/hello' do
  its('stdout') { should include 'Hello, Go examples!' }
end
