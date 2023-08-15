# Change Log

## [v1.2.0](https://github.com/thewizardplusplus/luatypechecks/tree/v1.2.0) (2023-08-15)

Added checks for the presence of metamethods and regular methods; added switchable analogues of the `assert()` function; supplemented the documentation with descriptions of functions that are not obvious.

- checking:
  - checks:
    - `checks.has_metamethods(value, metamethod_names)`;
    - `checks.has_methods(value, method_names)`;
    - `checks.has_methods_anywhere(value, method_names)`;
  - for each check:
    - there is a variant that allows the value `nil` &mdash; `checks.has_*_or_is_nil(value, ...)`;
- asserting:
  - assertions:
    - `assertions.is_true(value)`;
    - `assertions.is_false(value)`;
- supplemented the documentation with descriptions of functions that are not obvious.

## [v1.1.0](https://github.com/thewizardplusplus/luatypechecks/tree/v1.1.0) (2023-07-23)

For each check, implemented a variant wrapped in an `assert()` function call.

- asserting:
  - for each check, there is a variant wrapped in an `assert()` function call &mdash; see package `assertions`;
- optimization:
  - it's possible to disable asserting globally for the whole package `assertions`.

## [v1.0.0](https://github.com/thewizardplusplus/luatypechecks/tree/v1.0.0) (2023-07-19)

Major version. Implemented checks for base types, including the ability to check table key types and table value types, as well as checks for classes created by library [middleclass](https://github.com/kikito/middleclass).
