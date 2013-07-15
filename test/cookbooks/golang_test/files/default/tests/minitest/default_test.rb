require File.expand_path('../support/helpers', __FILE__)

describe 'golang::default' do
  include Helpers::Golang

  it 'can execute go version' do
    go = shell_out("/usr/local/go/bin/go version")
    assert_includes(go.stdout,'1.0.3')
  end

  it 'can run hello_world' do
    shell_out!("export GOPATH=/opt/go; cd /tmp/hello_world && /usr/local/go/bin/go test")
  end

end