# luatypechecks

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
    - `checks.is_instance(value, class)`;
  - for each check:
    - there is a variant that allows the value `nil` &mdash; `checks.is_*_or_nil(value, ...)`;
    - if the check accepts additional parameters, there is a constructor that creates a closure with these parameters (i.e., performs currying) &mdash; `checks.make_*_checker(value, ...)`;
- asserting:
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

Copyright &copy; 2023 thewizardplusplus
