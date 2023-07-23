# Change Log

## [v1.1.0](https://github.com/thewizardplusplus/luatypechecks/tree/v1.1.0) (2023-07-23)

For each check, implemented a variant wrapped in an `assert()` function call.

- asserting:
  - for each check, there is a variant wrapped in an `assert()` function call &mdash; see package `assertions`;
- optimization:
  - it's possible to disable asserting globally for the whole package `assertions`.

## [v1.0.0](https://github.com/thewizardplusplus/luatypechecks/tree/v1.0.0) (2023-07-19)

Major version. Implemented checks for base types, including the ability to check table key types and table value types, as well as checks for classes created by library [middleclass](https://github.com/kikito/middleclass).
