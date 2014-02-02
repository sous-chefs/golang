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
    uid = File.stat('/opt/go').uid 
    gid = File.stat('/opt/go').gid 

    require 'etc'

    user = Etc.getpwuid(uid).name
    group = Etc.getgrgid(gid).name

    assert_equal('vagrant', user)
    assert_equal('vagrant', group)
  end

end
