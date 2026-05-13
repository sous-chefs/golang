# frozen_string_literal: true

provides :golang
unified_mode true

default_action :install

property :from_source, [true, false], default: false
property :install_dir, String, default: '/usr/local'
property :gopath, String, default: '/opt/go'
property :gobin, String, default: '/opt/go/bin'
property :owner, String, default: 'root'
property :group, String, default: 'root'
property :directory_mode, String, default: '0755'
property :url, String, default: 'https://go.dev/dl/goVERSION.OS-ARCH.tar.gz'
property :version, String, default: '1.26.3'
property :source_url, String, default: 'https://go.dev/dl/goVERSION.src.tar.gz'
property :source_version, String, default: '1.26.3'
property :source_method, String, default: 'all.bash'
property :scm, [true, false], default: true
property :scm_packages, [String, Array], default: %w(git mercurial)
property :arch, String, default: lazy {
  case node['kernel']['machine']
  when 'x86_64'
    'amd64'
  when 'aarch64'
    'arm64'
  when /i.86/
    '386'
  else
    node['kernel']['machine']
  end
}

action_class do
  def bin_url
    return new_resource.url if property_is_set?(:url)

    new_resource.url
                .sub('ARCH', new_resource.arch)
                .sub('OS', node['os'])
                .sub('VERSION', new_resource.version)
  end

  def source_url
    return new_resource.source_url if property_is_set?(:source_url)

    new_resource.source_url.sub('VERSION', new_resource.source_version)
  end

  def go_root
    ::File.join(new_resource.install_dir, 'go')
  end

  def go_version_root(version = new_resource.version)
    ::File.join(new_resource.install_dir, "go-#{version}")
  end

  def go_bin(version = new_resource.version)
    ::File.join(go_version_root(version), 'bin', 'go')
  end

  def archive_path(url)
    ::File.join(Chef::Config[:file_cache_path], 'go', ::File.basename(url))
  end

  def bootstrap_root
    ::File.join(Chef::Config[:file_cache_path], 'go-bootstrap', "go-bootstrap-#{new_resource.version}")
  end

  def set_archive_locale
    require 'ffi'

    locale = Module.new do
      extend FFI::Library
      ffi_lib FFI::Library::LIBC
      attach_function :setlocale, %i(int string), :string
    end

    %w(C.UTF-8 C.utf8 en_US.UTF-8).find do |candidate|
      ENV['LANG'] = candidate
      ENV['LC_ALL'] = candidate
      locale.setlocale(6, candidate)
    end
  end
end

action :install do
  set_archive_locale

  directory new_resource.gopath do
    recursive true
    owner new_resource.owner
    group new_resource.group
    mode new_resource.directory_mode
  end

  directory new_resource.gobin do
    recursive true
    owner new_resource.owner
    group new_resource.group
    mode new_resource.directory_mode
  end

  directory new_resource.install_dir do
    recursive true
    mode new_resource.directory_mode
  end

  directory ::File.join(Chef::Config[:file_cache_path], 'go') do
    recursive true
  end

  template '/etc/profile.d/golang.sh' do
    cookbook 'golang'
    source 'golang.sh.erb'
    mode new_resource.directory_mode
    variables gobin: new_resource.gobin,
              gopath: new_resource.gopath,
              install_dir: new_resource.install_dir
  end

  if new_resource.scm
    apt_update do
      only_if { platform_family? 'debian' }
    end

    package new_resource.scm_packages
  end

  url = bin_url

  unless new_resource.from_source
    binary_archive = archive_path(url)

    remote_file binary_archive do
      source url
    end

    archive_file binary_archive do
      destination go_version_root
      strip_components 1
      not_if "#{go_bin} version | grep #{new_resource.version}"
    end

    link go_root do
      to go_version_root
    end
  end

  if new_resource.from_source
    bootstrap_archive = archive_path(url)

    remote_file bootstrap_archive do
      source url
      not_if "test -x #{go_root}/bin/go && #{go_root}/bin/go version | grep #{new_resource.source_version}"
    end

    archive_file bootstrap_archive do
      destination bootstrap_root
      strip_components 1
      not_if "test -x #{go_root}/bin/go && #{go_root}/bin/go version | grep #{new_resource.source_version}"
    end

    build_essential

    file go_root do
      manage_symlink_source true
      action :delete
      only_if do
        ::File.exist?(go_root) &&
          ::File.ftype(go_root) == 'link' &&
          ::File.readlink(go_root) != "#{new_resource.install_dir}/go-source"
      end
    end

    url = source_url
    source_archive = archive_path(url)

    remote_file source_archive do
      source url
      not_if "test -x #{go_root}/bin/go && #{go_root}/bin/go version | grep #{new_resource.source_version}"
    end

    archive_file source_archive do
      destination go_root
      strip_components 1
      not_if "test -x #{go_root}/bin/go && #{go_root}/bin/go version | grep #{new_resource.source_version}"
    end

    execute 'build-golang' do
      cwd "#{go_root}/src"
      command "./#{new_resource.source_method}"
      environment(
        GOROOT_BOOTSTRAP: bootstrap_root,
        GOROOT: go_root,
        GOBIN: "#{go_root}/bin"
      )
      not_if "test -x #{go_root}/bin/go && #{go_root}/bin/go version | grep #{new_resource.source_version}"
    end

    directory ::File.join(Chef::Config[:file_cache_path], 'go-bootstrap') do
      recursive true
      action :delete
      only_if "test -x #{go_root}/bin/go && #{go_root}/bin/go version | grep #{new_resource.source_version}"
    end
  end
end

action :remove do
  file '/etc/profile.d/golang.sh' do
    action :delete
  end

  directory new_resource.gobin do
    recursive true
    action :delete
  end

  directory new_resource.gopath do
    recursive true
    action :delete
  end

  directory ::File.join(Chef::Config[:file_cache_path], 'go') do
    recursive true
    action :delete
  end

  file go_root do
    manage_symlink_source true
    action :delete
  end

  directory go_version_root do
    recursive true
    action :delete
  end
end
