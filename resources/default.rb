#
# Cookbook:: golang
# Resource:: default
#
# Copyright:: 2020, Sous-chefs
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy
# of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#

# Install golang by compiling from source
property :from_source, [true, false], default: false

# Base directory for go
property :install_dir, String, default: '/usr/local'
property :gopath, String, default: '/opt/go'
property :gobin, String, default: '/opt/go/bin'

# Directory and file attributes
property :owner, String, default: 'root'
property :group, String, default: 'root'
property :directory_mode, String, default: '0755'

# version to install
# ark input binaries and stuff download
# e.g.  https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz
#       https://dl.google.com/go/go1.14.4/linux-amd64.tar.gz
#       https://golang.org/dl/go1.14.6.darwin-amd64.tar.gz
#       https://golang.org/dl/go1.14.6.linux-amd64.tar.gz
property :url, String, default: 'https://golang.org/dl/goVERSION.OS-PLATFORM.tar.gz'
property :version, String, default: '1.14.4'

# ark input source
# e.g.  https://dl.google.com/go/go1.14.4.src.tar.gz
property :source_url, String, default: 'https://golang.org/dl/goVERSION.src.tar.gz'
property :source_version, String, default: '1.14.4'

# installation script from the source repository
property :source_method, String, default: 'all.bash'

# install SCM packages
property :scm, [true, false], default: true
property :scm_packages, [String, Array], default: %w(git mercurial)

action_class do
  def bin_url
    return new_resource.url if property_is_set?(:url)
    new_resource.url.sub(/PLATFORM/, platform).sub(/OS/, os).sub(/VERSION/, new_resource.version)
  end

  def source_url
    return new_resource.source_url if property_is_set?(:source_url)
    new_resource.source_url.sub(/VERSION/, new_resource.source_version)
  end

  def os
    node['os']
  end

  def platform
    node['kernel']['machine'] =~ /i.86/ ? '386' : 'amd64'
  end
end

action :install do
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
    source 'golang.sh.erb'
    mode new_resource.directory_mode
    variables gobin: new_resource.gobin,
              gopath:  new_resource.gobin,
              install_dir: new_resource.install_dir
  end

  if new_resource.scm
    apt_update do
      only_if { platform_family? 'debian' }
    end
    package new_resource.scm_packages
  end

  # pgk to install go binaries, doc, base packages
  # ark is not idempotent by itself. Check to see if the go binary is the correct version
  url = bin_url
  ark 'go' do
    url url
    version new_resource.version
    not_if "/usr/local/go-#{new_resource.version}/bin/go version | grep #{new_resource.version}"
  end

  ##### SOURCE BUILD

  if new_resource.from_source

    directory ::File.join(new_resource.install_dir, 'go', 'bin') do
      recursive true
      mode new_resource.directory_mode
    end

    build_essential

    file "#{new_resource.install_dir}/go" do
      manage_symlink_source true
      action :delete
      only_if do
        # Create idempotency by not deleting symlink if it points to source build
        ::File.exist?("#{new_resource.install_dir}/go") &&
          ::File.ftype("#{new_resource.install_dir}/go") == 'link' &&
          ::File.readlink("#{new_resource.install_dir}/go") != "#{new_resource.install_dir}/go-source"
      end
    end

    url = source_url
    ark 'go' do # resource with the same name, that's an issue.  Source install
      url url
      version 'source'
      action :put
      release_file '/tmp/ark_release_file'
      not_if "test -x #{::File.join(new_resource.install_dir, 'go', 'bin', 'go')}  && #{::File.join(new_resource.install_dir, 'go', 'bin', 'go')}  version | grep #{new_resource.source_version}"
    end

    # see if build already done
    # converge_by if not done
    execute 'build-golang' do
      cwd "#{new_resource.install_dir}/go/src"
      command "./#{new_resource.source_method}"
      environment({
        # Use the package-installed Go as the bootstrap version b/c Go is built with Go
        GOROOT_BOOTSTRAP: "#{new_resource.install_dir}/go-#{new_resource.version}",
        GOROOT: "#{new_resource.install_dir}/go",
        GOBIN: "#{new_resource.install_dir}/go/bin",
      })
      not_if "test -x #{::File.join(new_resource.install_dir, 'go', 'bin', 'go')}  && #{::File.join(new_resource.install_dir, 'go', 'bin', 'go')}  version | grep #{new_resource.source_version}"
    end
  end
end
