# frozen_string_literal: true

require 'spec_helper'

describe 'golang_package' do
  step_into :golang_package
  platform 'ubuntu', '24.04'

  context 'with install action' do
    recipe do
      golang_package 'golang.org/x/example/hello' do
        owner 'golang'
        group 'golang'
      end
    end

    it { is_expected.to create_directory('/tmp/go').with(owner: 'golang', group: 'golang', mode: '0755') }

    it do
      is_expected.to run_execute('go install golang.org/x/example/hello@latest').with(
        user: 'golang',
        group: 'golang',
        environment: {
          PATH: '/usr/local/go/bin:/opt/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
          GOPATH: '/opt/go',
          GOBIN: '/opt/go/bin',
          GOCACHE: '/tmp/go',
          HOME: '/home/golang',
        }
      )
    end
  end

  context 'with build action' do
    recipe do
      golang_package 'golang.org/x/example/hello' do
        owner 'golang'
        group 'golang'
        action :build
      end
    end

    it { is_expected.to run_execute('go build -work -x golang.org/x/example/hello').with(cwd: '/tmp/go') }
  end

  context 'with remove action' do
    recipe do
      golang_package 'golang.org/x/example/hello' do
        action :remove
      end
    end

    it { is_expected.to delete_file('/opt/go/bin/hello') }
  end
end
