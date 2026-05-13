# frozen_string_literal: true

control 'golang-default-01' do
  impact 1.0
  title 'Go is installed from the binary archive'

  describe command('/usr/local/go/bin/go version') do
    its('stdout') { should include '1.26.3' }
  end
end

control 'golang-default-02' do
  impact 1.0
  title 'Go can test local modules and install binaries'

  describe command('export GOPATH=/opt/go; cd /tmp/helloWorld && /usr/local/go/bin/go test') do
    its('exit_status') { should cmp 0 }
  end

  describe command('/opt/go/bin/hello') do
    its('stdout') { should include 'Hello, world!' }
  end
end

control 'golang-default-03' do
  impact 0.7
  title 'Go workspace directories are owned by the configured user'

  describe directory('/opt/go') do
    its('owner') { should eq 'golang' }
    its('group') { should eq 'golang' }
  end
end
