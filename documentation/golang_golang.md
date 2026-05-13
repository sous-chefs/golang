# golang

Installs the Go programming language from official binary archives or by building from source.

This resource requires Chef Infra Client 17.5 or later so it can use the built-in `archive_file`
resource with `strip_components` when expanding Go archives.

## Actions

| Action     | Description |
|------------|-------------|
| `:install` | Installs Go, configures profile environment variables, and optionally installs SCM packages. |
| `:remove`  | Removes the installed Go archive, profile script, cache directory, and configured workspace directories. |

## Properties

| Property         | Type           | Default | Description |
|------------------|----------------|---------|-------------|
| `from_source`    | true, false    | `false` | Build Go from source after downloading a bootstrap binary archive. |
| `install_dir`    | String         | `'/usr/local'` | Base directory for the Go installation. |
| `gopath`         | String         | `'/opt/go'` | Go workspace path. |
| `gobin`          | String         | `'/opt/go/bin'` | Directory where installed Go binaries are written. |
| `owner`          | String         | `'root'` | Owner for workspace directories. |
| `group`          | String         | `'root'` | Group for workspace directories. |
| `directory_mode` | String         | `'0755'` | Mode for managed directories and profile script. |
| `url`            | String         | Go download URL pattern | Binary archive URL pattern. |
| `version`        | String         | `'1.26.3'` | Go binary version to install. |
| `source_url`     | String         | Go source URL pattern | Source archive URL pattern. |
| `source_version` | String         | `'1.26.3'` | Go source version to build. |
| `source_method`  | String         | `'all.bash'` | Build script under the Go source `src` directory. |
| `scm`            | true, false    | `true` | Whether to install source control packages. |
| `scm_packages`   | String, Array  | `%w(git mercurial)` | Source control packages to install. |
| `arch`           | String         | detected from node | Go archive architecture. |

## Examples

### Binary install

```ruby
golang 'default'
```

### Install with a custom workspace owner

```ruby
golang 'default' do
  owner 'golang'
  group 'golang'
end
```

### Build from source

```ruby
golang 'source' do
  from_source true
  source_version '1.26.3'
end
```
