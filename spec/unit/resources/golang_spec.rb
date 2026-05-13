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

    it 'downloads the Go binary archive' do
      expect(chef_run).to create_remote_file(binary_archive_path('go1.26.3.linux-amd64.tar.gz'))
    end

    it 'extracts the Go binary archive with stripped top-level directory' do
      is_expected.to extract_archive_file(binary_archive_path('go1.26.3.linux-amd64.tar.gz')).with(
        destination: '/usr/local/go-1.26.3',
        strip_components: 1
      )
    end

    it { is_expected.to create_link('/usr/local/go').with(to: '/usr/local/go-1.26.3') }
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

    it 'downloads the bootstrap Go archive' do
      expect(chef_run).to create_remote_file(binary_archive_path('go1.26.3.linux-amd64.tar.gz'))
    end

    it 'extracts the bootstrap Go archive with stripped top-level directory' do
      is_expected.to extract_archive_file(binary_archive_path('go1.26.3.linux-amd64.tar.gz')).with(
        destination: "#{cache_root}/go-bootstrap/go-bootstrap-1.26.3",
        strip_components: 1
      )
    end

    it { is_expected.to install_build_essential('') }

    it 'downloads the Go source archive' do
      expect(chef_run).to create_remote_file(binary_archive_path('go1.26.3.src.tar.gz'))
    end

    it 'extracts the Go source archive with stripped top-level directory' do
      is_expected.to extract_archive_file(binary_archive_path('go1.26.3.src.tar.gz')).with(
        destination: '/usr/local/go',
        strip_components: 1
      )
    end

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

  def cache_root
    chef_run.run_context.resource_collection
            .select { |resource| resource.resource_name == :directory }
            .find { |resource| resource.name.end_with?('/go') && resource.name != '/opt/go' }
            .path
            .delete_suffix('/go')
  end

  def binary_archive_path(filename)
    "#{cache_root}/go/#{filename}"
  end
end
