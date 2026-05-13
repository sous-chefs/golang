# golang_package

Installs, updates, builds, or removes a Go package binary using a configured Go installation.

## Actions

| Action     | Description |
|------------|-------------|
| `:install` | Installs a Go package with `go install <package>@<version>`. |
| `:update`  | Re-runs the install command for the configured package and version. |
| `:build`   | Builds the package in the configured Go cache directory. |
| `:remove`  | Removes the installed binary from `gobin`. |

## Properties

| Property       | Type   | Default | Description |
|----------------|--------|---------|-------------|
| `package_name` | String | name property | Go module package path. |
| `version`      | String | `'latest'` | Module version passed to `go install`. |
| `install_dir`  | String | `'/usr/local'` | Base directory for the Go installation. |
| `gopath`       | String | `'/opt/go'` | Go workspace path. |
| `gobin`        | String | `'/opt/go/bin'` | Directory where package binaries are installed. |
| `gocache`      | String | `'/tmp/go'` | Go build cache directory. |
| `owner`        | String | `'root'` | User that runs Go commands. |
| `group`        | String | `'root'` | Group that runs Go commands. |
| `binary_name`  | String | basename of `package_name` | Binary name to remove in the `:remove` action. |

## Examples

### Install the latest package binary

```ruby
golang_package 'golang.org/x/example/hello'
```

### Install as a workspace user

```ruby
golang_package 'golang.org/x/example/hello' do
  owner 'golang'
  group 'golang'
end
```

### Remove a package binary

```ruby
golang_package 'golang.org/x/example/hello' do
  binary_name 'hello'
  action :remove
end
```
