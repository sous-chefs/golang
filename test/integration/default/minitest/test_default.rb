require 'minitest/autorun'

describe 'golang::default' do

  it 'downloaded Golang installer' do
    assert File.exists?('/tmp/kitchen/cache/go1.2.2.linux-amd64.tar.gz')
  end

  it 'installed Golang' do
    assert system('/usr/local/go/bin/go version | grep go1.2.2')
  end

end
