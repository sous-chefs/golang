# CHANGELOG for golang

This file is used to list changes made in each version of golang.

## Unpublished

- Create a custom resource to install git from source or by downloading a package

## 4.0.0

- Update testing setup:
  - Use Chef Workstation instead of Rubygems
    - Includes dropping `foodcritic` in favor of current `cookstyle`
  - Add more recent & current distro versions
  - Add very basic unit tests
  - Use GitHub Actions instead of Travis CI
- Refactor minitest to Inspec
- Refactor to use current style of Chef Custom Resource
- Update default version to Go v1.14.4
- Use `build_essential` when building from source
  - Requires Chef >= 14.0.0
- Omit attempting to install `bzr` on CentOS 8, they do not have that package available
- Utilize default Chef order-of-operations instead of `notifies`
- Use `ark` resource to simplify download & installation of binary & source
- Clean up unnecessary env vars from source build
- Build from source per [official Go docs](https://golang.org/doc/install/source)
- Use native resources instead of shell commands when building from source
- Set `$PATH` in `golang.sh` so that the existing values are last, per general practice
- Tighten up `golang_package` so it does not perform actions at compile time, it uses `execute` in favor of `bash` resources, and in general is more Chef-y
- Update tests to validate that non-root users can install Go and Go packages
- Refactor attributes to add ability to install a version from source that differs from the packaged version (which is needed to build from source)

## 3.0.0

- rename to `chef-golang` so that metadata name matches repositoriy name

## 2.0.0

- change attribute namespace to `node['golang']`

## 1.7.2

- Better chef12,13 support
- Ruby 2.3
- Update gems, lint

## 1.7.1

- Create a temporary directory

## 1.7.0

- Golang 1.5

## 1.6.2

- Ability to install from source

## 1.6.0

- Removed support for Ruby 1.9.3

## 1.5.1

- Fix testing with Vagrant, Test-Kitchen
- Golang 1.4

## 1.5.0

- Golang 1.3

## 1.4.0

- Add build action to LWRP
- Update default go version to 1.2.2
- Add autodetection the platform architecture
- Change package location to `http://golang.org/dl/`

## 1.3.0

## 1.2.0

## 1.1.0

- Added package LWRP
- Configurable `gopath` & `gobin`

## 1.0.2

- Lets users easily specify another install dir

## 1.0.1

- Avoid extra unpacked copy of Go

## 1.0.0

- Initial release of golang
