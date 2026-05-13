# frozen_string_literal: true

require 'spec_helper'

describe 'golang' do
  step_into :golang
  platform 'ubuntu', '24.04'

  before do
    stub_command('/usr/local/go-1.26.3/bin/go version | grep 1.26.3').and_return(false)
  end

  context 'with default properties' do
    recipe do
      golang 'default'
    end

    it { is_expected.to create_directory('/opt/go').with(owner: 'root', group: 'root', mode: '0755') }
    it { is_expected.to create_directory('/opt/go/bin').with(owner: 'root', group: 'root', mode: '0755') }
    it { is_expected.to create_template('/etc/profile.d/golang.sh').with(mode: '0755') }
    it { is_expected.to install_package(%w(git mercurial)) }
    it { is_expected.to install_package('tar') }

    it do
      is_expected.to install_ark('go').with(
        path: '/usr/local',
        url: 'https://go.dev/dl/go1.26.3.linux-amd64.tar.gz',
        version: '1.26.3'
      )
    end
  end

  context 'with source installation' do
    before do
      stub_command('test -x /usr/local/go/bin/go && /usr/local/go/bin/go version | grep 1.26.3').and_return(false)
    end

    recipe do
      golang 'source' do
        from_source true
      end
    end

    it { is_expected.to install_ark('go-bootstrap') }
    it { is_expected.to install_build_essential('') }
    it { is_expected.to put_ark('go') }
    it { is_expected.to run_execute('build-golang') }
  end

  context 'with remove action' do
    recipe do
      golang 'default' do
        action :remove
      end
    end

    it { is_expected.to delete_file('/etc/profile.d/golang.sh') }
    it { is_expected.to delete_directory('/opt/go') }
    it { is_expected.to delete_file('/usr/local/go') }
    it { is_expected.to delete_directory('/usr/local/go-1.26.3') }
  end
end
