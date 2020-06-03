# golang_test Cookbook

Testing cookbook for `golang`.

## Requirements

Depends on `golang`.

## Usage

### golang_test::default

Just include `golang_test` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[golang_test]"
  ]
}
```
