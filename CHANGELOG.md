# CHANGELOG for golang

This file is used to list changes made in each version of golang.

## 5.4.13 - *2023-05-17*

## 5.4.12 - *2023-04-17*

## 5.4.11 - *2023-04-07*

Standardise files with files in sous-chefs/repo-management

## 5.4.10 - *2023-04-01*

## 5.4.9 - *2023-04-01*

## 5.4.8 - *2023-04-01*

Standardise files with files in sous-chefs/repo-management

## 5.4.7 - *2023-03-20*

Standardise files with files in sous-chefs/repo-management

## 5.4.6 - *2023-03-15*

Standardise files with files in sous-chefs/repo-management

## 5.4.5 - *2023-03-02*

## 5.4.4 - *2023-02-23*

Standardise files with files in sous-chefs/repo-management

## 5.4.3 - *2023-02-15*

## 5.4.2 - *2023-02-15*

Standardise files with files in sous-chefs/repo-management

## 5.4.1 - *2022-12-15*

Standardise files with files in sous-chefs/repo-management

## 5.4.0 - *2022-08-08*

- Use `node['golang']['install_dir']` attribute in default recipe.
- Fix source installation issues

## 5.3.3 - *2022-08-07*

Standardise files with files in sous-chefs/repo-management

## 5.3.2 - *2022-02-09*

- Remove delivery and move to calling RSpec directly via a reusable workflow
- Update tested platforms
- Standardise files with files in sous-chefs/repo-management

## 5.3.1 - *2021-08-30*

- Standardise files with files in sous-chefs/repo-management

## 5.3.0 - *2021-07-15*

- Fix `unified_mode` declaration
- Bump `ark` dependency to one with `unified_mode` set

## 5.2.0 - *2021-06-04*

- Update example package to adhere with modern Go standards

## 5.1.0 - *2021-06-03*

- Fix resource to use the correct path in GOPATH profile.d template

## 5.0.1 - *2021-06-01*

- Standardise files with files in sous-chefs/repo-management

## 5.0.0 - *2021-05-21*

- Require chef 15.3 or greater
- Use unified_mode for chef 17 support

## 4.1.1 - *2021-02-03*

- Use `node['golang']['scm']` and `node['golang']['scm_packages']` attributes in default recipe.

## 4.1.0

- Create a custom resource to install Go from source or by downloading a package

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
