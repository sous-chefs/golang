# Migrating to Custom Resources

This release removes the legacy `golang::default` recipe and `node['golang']` attributes. Wrapper
cookbooks should now declare `golang` and `golang_package` resources directly.

## Recipe Migration

Replace this legacy run list entry:

```json
{
  "run_list": ["recipe[golang]"]
}
```

with an explicit resource declaration in a wrapper cookbook recipe:

```ruby
golang 'default'
```

## Attribute Migration

Move former `node['golang']` attributes to resource properties:

| Legacy attribute | Resource property |
|------------------|-------------------|
| `node['golang']['from_source']` | `golang#from_source` |
| `node['golang']['version']` | `golang#version` |
| `node['golang']['source_version']` | `golang#source_version` |
| `node['golang']['install_dir']` | `golang#install_dir` |
| `node['golang']['gopath']` | `golang#gopath` |
| `node['golang']['gobin']` | `golang#gobin` |
| `node['golang']['owner']` | `golang#owner` |
| `node['golang']['group']` | `golang#group` |
| `node['golang']['scm']` | `golang#scm` |
| `node['golang']['scm_packages']` | `golang#scm_packages` |

Legacy `node['golang']['packages']` entries should become one `golang_package` resource per module:

```ruby
golang 'default' do
  owner 'golang'
  group 'golang'
end

golang_package 'golang.org/x/example/hello' do
  owner 'golang'
  group 'golang'
end
```

See the test cookbook under `test/cookbooks/test/recipes/` for complete examples.
