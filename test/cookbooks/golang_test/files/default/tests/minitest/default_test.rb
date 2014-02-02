require File.expand_path('../support/helpers', __FILE__)

describe 'golang::default' do
  include Helpers::Golang

  it 'can execute go version' do
    go = shell_out("/usr/local/go/bin/go version")
    assert_includes(go.stdout,'1.2')
  end

  it 'can run hello_world' do
    shell_out!("export GOPATH=/opt/go; cd /tmp/hello_world && /usr/local/go/bin/go test")
  end

  it 'sets gopath owner to vagrant' do
    user = shell_out('stat -c "%U" /opt/go')
    assert_equal('vagrant', user.stdout.chomp)
  end

  it 'sets gopath group to vagrant' do
    group = shell_out('stat -c "%G" /opt/go')
    assert_equal('vagrant', group.stdout.chomp)
  end

end
