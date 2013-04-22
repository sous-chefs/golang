golang Cookbook
====================

Requirements
============

Platform
--------

Tested on:

* Debian GNU/Linux 6.0

**Notes**: This cookbook has been tested on the listed platforms. It
  may work on other platforms with or without modification.

Attributes
----------

#### golang::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['go']['version']</tt></td>
    <td>String</td>
    <td>Go version</td>
    <td><tt>1.0.3</tt></td>
  </tr>
  <tr>
    <td><tt>['go']['platform']</tt></td>
    <td>String</td>
    <td>`amd64` or `i386`</td>
    <td><tt>amd64</tt></td>
  </tr>
</table>

Usage
-----
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

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
6. Submit a Pull Request using Github

Contributors
-------------------

* **[@xaprb](https://github.com/xaprb)**

