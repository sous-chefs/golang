# Golang (Go) Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/golang.svg?style=flat)](https://supermarket.chef.io/cookbooks/golang)
[![CI State](https://github.com/sous-chefs/golang/workflows/ci/badge.svg)](https://github.com/sous-chefs/golang/actions?query=workflow%3Aci)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

## Description

Chef cookbook for the [Go programming language](https://go.dev/).

## Requirements

### Chef

* Chef Infra Client >= 17.5

### Platform

* AlmaLinux >= 8
* Amazon Linux >= 2023
* CentOS Stream >= 9
* Debian >= 12
* Fedora latest
* Oracle Linux >= 8
* Red Hat Enterprise Linux >= 8
* Rocky Linux >= 8
* Ubuntu >= 22.04

## Usage

This cookbook no longer ships recipes or attributes. See [migration.md](migration.md) for the
breaking change from `recipe[golang]` and `node['golang']` attributes to custom resources.

### Install Go

```ruby
golang 'default'
```

### Install Go as a workspace user

```ruby
golang 'default' do
  owner 'golang'
  group 'golang'
end
```

### Install Go package binaries

```ruby
golang_package 'golang.org/x/example/hello' do
  owner 'golang'
  group 'golang'
end
```

## Resources

* [golang](documentation/golang_golang.md)
* [golang_package](documentation/golang_package.md)

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
