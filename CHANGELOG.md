# CHANGELOG for golang

This file is used to list changes made in each version of golang.

Standardise files with files in sous-chefs/repo-management
Standardise files with files in sous-chefs/repo-management

## [6.0.0](https://github.com/sous-chefs/golang/compare/v5.4.23...v6.0.0) (2026-05-13)


### ⚠ BREAKING CHANGES

* migrate golang to custom resources ([#153](https://github.com/sous-chefs/golang/issues/153))
* Requires Chef >= 14.0.0

### Features

* Allow different versions for source/package ([06bde5e](https://github.com/sous-chefs/golang/commit/06bde5e6c94771b917a1c53b205ba3a3a8d9aadd))
* Install binary w/ ark, simplify source build ([59abc22](https://github.com/sous-chefs/golang/commit/59abc224d094c5ebef2b94b0ae4850784fe84631))
* migrate golang to custom resources ([#153](https://github.com/sous-chefs/golang/issues/153)) ([04c8575](https://github.com/sous-chefs/golang/commit/04c8575c388df8c89967a53c5ffad4e47fdf189f))
* Update default to Golang 1.14.4 ([96e1dad](https://github.com/sous-chefs/golang/commit/96e1dadf4fdf1f96306410f1b4145f56401feaf7))
* Use build_essential resource ([779a9c5](https://github.com/sous-chefs/golang/commit/779a9c5a707b2a26b0d07eb89ce7e9ccb081b604))


### Bug Fixes

* Add final step to CI GH Actions ([3a45ae1](https://github.com/sous-chefs/golang/commit/3a45ae16a48ca663a0d6fa1e423b2a3bc7b49eba))
* **ci:** Update workflows to use release pipeline ([#147](https://github.com/sous-chefs/golang/issues/147)) ([71b56a8](https://github.com/sous-chefs/golang/commit/71b56a841d4e0c21b249b74da70aa8ac359862da))
* Clean up code per cookstyle ([89e8fcd](https://github.com/sous-chefs/golang/commit/89e8fcd65dec14f681036e9e2a67c231fda2424f))
* Drop unnecessary default actions ([ae264c6](https://github.com/sous-chefs/golang/commit/ae264c6481ab36cdea721740a4f89a12edd9b319))
* Omit SCM package bzr on CentOS 8 ([613f4c8](https://github.com/sous-chefs/golang/commit/613f4c819f7dd95600471e6db4d5de565068a535))
* Remove deleted attribute from Kitchen config ([f9d65c4](https://github.com/sous-chefs/golang/commit/f9d65c4b9b54d4cfe67b8afd82995bae68d4f124))
* Remove duplicate attribute declarations ([462f75f](https://github.com/sous-chefs/golang/commit/462f75f07c7acc2a7d5e66144f1d5e26ec3fa298))
* Remove symlink to de-dupe tests ([113fa2e](https://github.com/sous-chefs/golang/commit/113fa2ec9b041bcf52dc8ab2448cea06bd0a2ba9))
* Set $PATH so defaults are last ([3e40918](https://github.com/sous-chefs/golang/commit/3e40918ff10543a70739c87a5ee4939ba393267b))
* Set SCM packages via attribute & update apt ([2a7d333](https://github.com/sous-chefs/golang/commit/2a7d333f209176dfd666dc6da075b90e241664bf))
* Update locations of hello example & go-check ([f9a3af1](https://github.com/sous-chefs/golang/commit/f9a3af1d6fea5deacef003eaa9a5c4d19e56e327))
* Update URL for Golang itself ([86c22bd](https://github.com/sous-chefs/golang/commit/86c22bd6f98bd9a30067906f49e5b186283cebb0))
* Use cookbook name consistently ([b44e332](https://github.com/sous-chefs/golang/commit/b44e3328070adbad58ae28c57299f7bed2084dcd))

## [5.4.23](https://github.com/sous-chefs/golang/compare/5.4.22...v5.4.23) (2025-10-15)


### Bug Fixes

* **ci:** Update workflows to use release pipeline ([#147](https://github.com/sous-chefs/golang/issues/147)) ([71b56a8](https://github.com/sous-chefs/golang/commit/71b56a841d4e0c21b249b74da70aa8ac359862da))

## 5.4.21 - *2024-11-18*

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

## 5.4.20 - *2024-07-15*

Standardise files with files in sous-chefs/repo-management

## 5.4.19 - *2024-05-23*

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

## 5.4.11 - *2023-04-07*

Standardise files with files in sous-chefs/repo-management

## 5.4.8 - *2023-04-01*

Standardise files with files in sous-chefs/repo-management

## 5.4.7 - *2023-03-20*

Standardise files with files in sous-chefs/repo-management

## 5.4.6 - *2023-03-15*

Standardise files with files in sous-chefs/repo-management

## 5.4.4 - *2023-02-23*

Standardise files with files in sous-chefs/repo-management

## 5.4.2 - *2023-02-15*

Standardise files with files in sous-chefs/repo-management

## 5.4.1 - *2022-12-15*

Standardise files with files in sous-chefs/repo-management

## 5.4.0 - *2022-08-08*

* Use `node['golang']['install_dir']` attribute in default recipe.
* Fix source installation issues

## 5.3.3 - *2022-08-07*

Standardise files with files in sous-chefs/repo-management

## 5.3.2 - *2022-02-09*

* Remove delivery and move to calling RSpec directly via a reusable workflow
* Update tested platforms
* Standardise files with files in sous-chefs/repo-management

## 5.3.1 - *2021-08-30*

* Standardise files with files in sous-chefs/repo-management

## 5.3.0 - *2021-07-15*

* Fix `unified_mode` declaration
* Bump `ark` dependency to one with `unified_mode` set

## 5.2.0 - *2021-06-04*

* Update example package to adhere with modern Go standards

## 5.1.0 - *2021-06-03*

* Fix resource to use the correct path in GOPATH profile.d template

## 5.0.1 - *2021-06-01*

* Standardise files with files in sous-chefs/repo-management

## 5.0.0 - *2021-05-21*

* Require chef 15.3 or greater
* Use unified_mode for chef 17 support

## 4.1.1 - *2021-02-03*

* Use `node['golang']['scm']` and `node['golang']['scm_packages']` attributes in default recipe.

## 4.1.0

* Create a custom resource to install Go from source or by downloading a package

## 4.0.0

* Update testing setup:
  * Use Chef Workstation instead of Rubygems
    * Includes dropping `foodcritic` in favor of current `cookstyle`
  * Add more recent & current distro versions
  * Add very basic unit tests
  * Use GitHub Actions instead of Travis CI
* Refactor minitest to Inspec
* Refactor to use current style of Chef Custom Resource
* Update default version to Go v1.14.4
* Use `build_essential` when building from source
  * Requires Chef >= 14.0.0
* Omit attempting to install `bzr` on CentOS 8, they do not have that package available
* Utilize default Chef order-of-operations instead of `notifies`
* Use `ark` resource to simplify download & installation of binary & source
* Clean up unnecessary env vars from source build
* Build from source per [official Go docs](https://golang.org/doc/install/source)
* Use native resources instead of shell commands when building from source
* Set `$PATH` in `golang.sh` so that the existing values are last, per general practice
* Tighten up `golang_package` so it does not perform actions at compile time, it uses `execute` in favor of `bash` resources, and in general is more Chef-y
* Update tests to validate that non-root users can install Go and Go packages
* Refactor attributes to add ability to install a version from source that differs from the packaged version (which is needed to build from source)

## 3.0.0

* rename to `chef-golang` so that metadata name matches repositoriy name

## 2.0.0

* change attribute namespace to `node['golang']`

## 1.7.2

* Better chef12,13 support
* Ruby 2.3
* Update gems, lint

## 1.7.1

* Create a temporary directory

## 1.7.0

* Golang 1.5

## 1.6.2

* Ability to install from source

## 1.6.0

* Removed support for Ruby 1.9.3

## 1.5.1

* Fix testing with Vagrant, Test-Kitchen
* Golang 1.4

## 1.5.0

* Golang 1.3

## 1.4.0

* Add build action to LWRP
* Update default go version to 1.2.2
* Add autodetection the platform architecture
* Change package location to `http://golang.org/dl/`

## 1.1.0

* Added package LWRP
* Configurable `gopath` & `gobin`

## 1.0.2

* Lets users easily specify another install dir

## 1.0.1

* Avoid extra unpacked copy of Go

## 1.0.0

* Initial release of golang
