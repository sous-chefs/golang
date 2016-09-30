# golang (Chef cookbook for Go)

## Description

Chef cookbook for [Go programming language](http://golang.org/).

##  Requirements

### Platform

* Ubuntu (12.04/13.04/14.10)
* Debian (6.0)
* CentOS (6.5)

**Notes**: This cookbook has been tested on the listed platforms. It
may work on other platforms with or without modification. Please
[report issues](https://github.com/NOX73/chef-golang/issues) any additional platforms so they can be added.


## Usage

#### golang::default

Just include `golang` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[golang]"
  ]
}
```

#### golang::packages

To install Go packages using node attributes, include `golang::packages` in your node's `run_list`, and use the `['go']['packages']` attribute:

```json
{
  "name":"my_node",
  "go": {
    "packages": [
      "launchpad.net/gocheck"
    ]
  },
  "run_list": [
    "recipe[golang::packages]"
  ]
}
```


## Attributes

#### golang::default


Key | Type | Description | Default
--- | ---- | ----------- | -------
`['go']['version']` | String | Go version | `1.5`
`['go']['platform']` | String | `amd64` or `i386` | `amd64`
`['go']['scm']` | Boolean | install SCM dependencies `git`, `hg`, and `bzr` | `true`
`['go']['packages']` | Array | Go packages to install when using the `golang::packages` recipe | `[]`
`['go']['owner']` | String | The user account that owns $GOPATH | `root`
`['go']['group']` | String | The group that owns $GOPATH | `root`
`['go']['mode']` | String | The mode of $GOPATH | `0755`
`['go']['from_source']` | Boolean | Install go from source | `false`
`['go']['os']` | String | Build go for which operating system | `linux`
`['go']['arch']` | String | Build go for which architecture | `arm`
`['go']['arm']` | String | Build go for which arm version | `6`
`['go']['source_method']` | String | Choose which install script should be used | `all.bash`

## Testing

This project have [foodcritic](https://github.com/acrmp/foodcritic) for syntax checking and
[test-kitchen](https://github.com/opscode/test-kitchen) for integration testing. You can run the test suite by
typing: `rake kitchen:all` (may be slow for the first time).

In order to run these tests, the following
[requirements](https://github.com/opscode/kitchen-vagrant#-requirements) must be
satisfied:

* [Vagrant](http://vagrantup.com/) (>= 1.1.0)
* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant Berkshelf Plugin](http://rubygems.org/gems/vagrant-berkshelf)

## Contributing

1. Fork the repository
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Test it by running `rake kitchen:all`
5. Submit a Pull Request
