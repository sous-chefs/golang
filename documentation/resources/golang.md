# Resource: golang

## Actions

| Action | Description                |
| ------ | -------------------------- |
| install | Install golang from binary or source |

## Properties

| Properties     | Description                             | Type                     | Values and Default                 |
| -------------- | --------------------------------------- | ------------------------ | ---------------------------------- |
| install_dir    | Base directory for go product           | String                   | Default /usr/local                 |
| gopath         | User level go directory                 | String                   | Default /opt/go                    |
| gogin          | User level go bin directory             | String                   | Default /opt/go/bin                |
| owner          | Owner of the user directories           | String                   | Default root                       |
| group          | Group of the user directories           | String                   | Default root                       |
| directory_mode | mode for user directories               | String                   | Default 0755                       |
| version        | Version of go to install                | String                   | Default 1.14.4                     |
| source_version | Version of go to compile from source    | String                   | Default 1.14.4                     |
| url            | Location of the golang binary package for the target version  | String              | Default <https://golang.org/dl> and computed from the OS and version |
| from_source    | Install and compile golang from source  | True, False              | Default false                       |
| source_url     | Location of the golang source url for the source version      | String              | Default <https://golang.org/dl> and computed from the version |
| source_method  | Compile script in the golang source package | String              | Default all.bash                    |
| scm            | Install SCM packages, git and mercurial | True, False             | Default True                        |
| scm_packages   | Source control packages to install      | String, Array            | Default [git mercurial]            |

```ruby
golang "Install binary" do
  url 'https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz'
end
```

```ruby
golang "Install from source" do
  url 'https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz'
  source_url 'https://dl.google.com/go/go1.14.4.src.tar.gz
end
`````

## Notes

Go compile is bootstrapped using go. So a binary install is required before compiling the source.
