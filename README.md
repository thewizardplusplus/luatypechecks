# luatypechecks

[![lint](https://github.com/thewizardplusplus/luatypechecks/actions/workflows/lint.yaml/badge.svg)](https://github.com/thewizardplusplus/luatypechecks/actions/workflows/lint.yaml)
[![test](https://github.com/thewizardplusplus/luatypechecks/actions/workflows/test.yaml/badge.svg)](https://github.com/thewizardplusplus/luatypechecks/actions/workflows/test.yaml)

The library that implements various type checks in order to simulate static typing in the Lua language.

Note that this library isn't designed to validate input data, but only to simulate static typing for function parameters.

_**Disclaimer:** this library was written directly on an Android smartphone with the [QLua](https://play.google.com/store/apps/details?id=com.quseit.qlua5pro2) IDE._

## Features

- checking:
  - checks:
    - `checks.is_boolean(value)`;
    - `checks.is_number(value)`:
      - `checks.is_integer(value)`;
    - `checks.is_string(value)`;
    - `checks.is_function(value)`:
      - `checks.is_callable(value)`;
    - `checks.is_table(value[, key_checker[, value_checker[, deep_checks_mode="with_deep_checks"]]])`:
      - `checks.is_sequence(value[, value_checker[, deep_checks_mode="with_deep_checks"]])`;
    - `checks.is_enumeration(value, enumeration)`;
    - property checks:
      - `checks.has_metaproperties(value, metaproperty_names)`;
      - `checks.has_properties(value, property_names)`;
      - `checks.has_properties_anywhere(value, property_names)`;
    - method checks:
      - `checks.has_metamethods(value, metamethod_names)`;
      - `checks.has_methods(value, method_names)`;
      - `checks.has_methods_anywhere(value, method_names)`;
    - `checks.is_instance(value, class)`;
  - for each check:
    - there is a variant that allows the value `nil` &mdash; `checks.is_*_or_nil(value, ...)` / `checks.has_*_or_is_nil(value, ...)`;
    - if the check accepts additional parameters, there is a constructor that creates a closure with these parameters (i.e., performs currying) &mdash; `checks.make_*_checker(...)`;
- asserting:
  - assertions:
    - `assertions.is_true(value)`;
    - `assertions.is_false(value)`;
  - for each check, there is a variant wrapped in an `assert()` function call &mdash; see package `assertions`;
- optimization:
  - it's possible to disable checking of table key types and table value types:
    - individually for a particular check;
    - globally for the whole package `checks`;
  - it's possible to disable asserting globally for the whole package `assertions`.

## Installation

```
$ luarocks install luatypechecks
```

## License

The MIT License (MIT)

Copyright &copy; 2023-2024 thewizardplusplus
