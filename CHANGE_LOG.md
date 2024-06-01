# Change Log

## [v1.3.4](https://github.com/thewizardplusplus/luatypechecks/tree/v1.3.4) (2024-06-02)

Fix the bug with checking non-table values.

- fix the `checks._are_properties_existing_and_valid()` function:
  - fix the bug with checking non-table values;
  - indirectly affected functions:
    - property checks:
      - `checks.has_properties()`;
      - `checks.make_properties_checker()`;
      - `checks.has_properties_or_is_nil()`;
      - `checks.make_properties_or_nil_checker()`;
      - `checks.has_properties_anywhere()`;
      - `checks.make_properties_anywhere_checker()`;
      - `checks.has_properties_anywhere_or_is_nil()`;
      - `checks.make_properties_anywhere_or_nil_checker()`;
    - method checks:
      - `checks.has_methods()`;
      - `checks.make_methods_checker()`;
      - `checks.has_methods_or_is_nil()`;
      - `checks.make_methods_or_nil_checker()`;
      - `checks.has_methods_anywhere()`;
      - `checks.make_methods_anywhere_checker()`;
      - `checks.has_methods_anywhere_or_is_nil()`;
      - `checks.make_methods_anywhere_or_nil_checker()`;
- fix the tests of regular and metaproperties/methods:
  - add the test cases with checking non-table values against a list of regular and metaproperties/methods.

## [v1.3.3](https://github.com/thewizardplusplus/luatypechecks/tree/v1.3.3) (2024-03-24)

Add the `lint` and `doc` workflows for GitHub Actions; improve the documentation.

- add the workflows for GitHub Actions:
  - add the `lint` workflow for GitHub Actions;
  - add the `doc` workflow for GitHub Actions:
    - fix the display of nested lists in the documentation (only for GitHub Actions);
- improve the documentation:
  - improve the index page in the documentation;
  - add the change log to the documentation;
  - add the [GitHub corner](https://github.com/tholman/github-corners) to the documentation;
- add the LuaRocks link to the `README.md` file.

## [v1.3.2](https://github.com/thewizardplusplus/luatypechecks/tree/v1.3.2) (2024-03-22)

Fix an assertion stack trace level.

- fix an assertion stack trace level.

## [v1.3.1](https://github.com/thewizardplusplus/luatypechecks/tree/v1.3.1) (2023-12-19)

Support for Lua 5.1; the `test` workflow for GitHub Actions.

- remove the use of the `goto` statement to support Lua 5.1;
- add the `test` workflow for GitHub Actions.

## [v1.3.0](https://github.com/thewizardplusplus/luatypechecks/tree/v1.3.0) (2023-12-17)

Added checks for the presence of metaproperties and regular properties; performed refactoring.

- checking:
  - checks:
    - property checks:
      - `checks.has_metaproperties(value, metaproperty_names)`;
      - `checks.has_properties(value, property_names)`;
      - `checks.has_properties_anywhere(value, property_names)`;
- perform refactoring:
  - add the `checks._divide_properties_into_meta_and_regular()` function;
  - add the `checks._are_properties_existing_and_valid()` function;
  - add the `checks._are_metaproperties_existing_and_valid()` function.

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
