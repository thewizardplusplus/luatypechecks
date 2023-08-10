-- luacheck: no max comment line length

---
-- @module assertions

local checks = require("luatypechecks.checks")

local _assertions_mode = "with_assertions"

local assertions = {}
local _assertions_backup = {}

---
-- @treturn "without_assertions"|"with_assertions"
function assertions.get_assertions_mode()
  return _assertions_mode
end

---
-- @tparam "without_assertions"|"with_assertions" value
function assertions.set_assertions_mode(value)
  assertions.is_assertions_mode(value)

  _assertions_mode = value

  -- switch on/off functions that start with "is_" or "has_"
  for key, _ in pairs(_assertions_backup) do
    if not string.match(key, "^is_") and not string.match(key, "^has_") then
      goto end_of_iteration
    end

    local value = _assertions_backup[key] -- luacheck: no redefined
    if _assertions_mode == "without_assertions" then
      value = function() end
    end

    assertions[key] = value

    ::end_of_iteration::
  end
end

---
-- @tparam any value
-- @treturn bool
function assertions.is_deep_checks_mode(value)
  assert(checks.is_deep_checks_mode(value))
end

---
-- @tparam any value
-- @treturn bool
function assertions.is_deep_checks_mode_or_nil(value)
  assert(checks.is_deep_checks_mode_or_nil(value))
end

---
-- @tparam any value
-- @treturn bool
function assertions.is_assertions_mode(value)
  assert(checks.is_assertions_mode(value))
end

---
-- @tparam any value
-- @treturn bool
function assertions.is_assertions_mode_or_nil(value)
  assert(checks.is_assertions_mode_or_nil(value))
end

---
-- @tparam any value
-- @treturn bool
function assertions.is_boolean(value)
  assert(checks.is_boolean(value))
end

---
-- @tparam any value
-- @treturn bool
function assertions.is_boolean_or_nil(value)
  assert(checks.is_boolean_or_nil(value))
end

---
-- @tparam any value
-- @treturn bool
function assertions.is_number(value)
  assert(checks.is_number(value))
end

---
-- @tparam any value
-- @treturn bool
function assertions.is_number_or_nil(value)
  assert(checks.is_number_or_nil(value))
end

---
-- @tparam any value
-- @treturn bool
function assertions.is_integer(value)
  assert(checks.is_integer(value))
end

---
-- @tparam any value
-- @treturn bool
function assertions.is_integer_or_nil(value)
  assert(checks.is_integer_or_nil(value))
end

---
-- @tparam any value
-- @treturn bool
function assertions.is_string(value)
  assert(checks.is_string(value))
end

---
-- @tparam any value
-- @treturn bool
function assertions.is_string_or_nil(value)
  assert(checks.is_string_or_nil(value))
end

---
-- @tparam any value
-- @treturn bool
function assertions.is_function(value)
  assert(checks.is_function(value))
end

---
-- @tparam any value
-- @treturn bool
function assertions.is_function_or_nil(value)
  assert(checks.is_function_or_nil(value))
end

---
-- @tparam any value
-- @treturn bool
function assertions.is_callable(value)
  assert(checks.is_callable(value))
end

---
-- @tparam any value
-- @treturn bool
function assertions.is_callable_or_nil(value)
  assert(checks.is_callable_or_nil(value))
end

---
-- @tparam any value
-- @tparam[opt] func key_checker `func(value: any): bool`
-- @tparam[optchain] func value_checker `func(value: any): bool`
-- @tparam[optchain="with_deep_checks"] "without_deep_checks"|"with_deep_checks" deep_checks_mode
-- @treturn bool
function assertions.is_table(
  value,
  key_checker,
  value_checker,
  deep_checks_mode
)
  assert(checks.is_table(value, key_checker, value_checker, deep_checks_mode))
end

---
-- @tparam any value
-- @tparam[opt] func key_checker `func(value: any): bool`
-- @tparam[optchain] func value_checker `func(value: any): bool`
-- @tparam[optchain="with_deep_checks"] "without_deep_checks"|"with_deep_checks" deep_checks_mode
-- @treturn bool
function assertions.is_table_or_nil(
  value,
  key_checker,
  value_checker,
  deep_checks_mode
)
  assert(checks.is_table_or_nil(
    value,
    key_checker,
    value_checker,
    deep_checks_mode
  ))
end

---
-- @tparam any value
-- @tparam[opt] func value_checker `func(value: any): bool`
-- @tparam[optchain="with_deep_checks"] "without_deep_checks"|"with_deep_checks" deep_checks_mode
-- @treturn bool
function assertions.is_sequence(value, value_checker, deep_checks_mode)
  assert(checks.is_sequence(value, value_checker, deep_checks_mode))
end

---
-- @tparam any value
-- @tparam[opt] func value_checker `func(value: any): bool`
-- @tparam[optchain="with_deep_checks"] "without_deep_checks"|"with_deep_checks" deep_checks_mode
-- @treturn bool
function assertions.is_sequence_or_nil(value, value_checker, deep_checks_mode)
  assert(checks.is_sequence_or_nil(value, value_checker, deep_checks_mode))
end

---
-- @tparam any value
-- @tparam {any,...} enumeration
-- @treturn bool
function assertions.is_enumeration(value, enumeration)
  assert(checks.is_enumeration(value, enumeration))
end

---
-- @tparam any value
-- @tparam {any,...} enumeration
-- @treturn bool
function assertions.is_enumeration_or_nil(value, enumeration)
  assert(checks.is_enumeration_or_nil(value, enumeration))
end

---
-- @tparam any value
-- @tparam {string,...} metamethod_names
-- @treturn bool
function assertions.has_metamethods(value, metamethod_names)
  assert(checks.has_metamethods(value, metamethod_names))
end

---
-- @tparam any value
-- @tparam {string,...} metamethod_names
-- @treturn bool
function assertions.has_metamethods_or_is_nil(value, metamethod_names)
  assert(checks.has_metamethods_or_is_nil(value, metamethod_names))
end

---
-- @tparam any value
-- @tparam {string,...} method_names
-- @treturn bool
function assertions.has_methods(value, method_names)
  assert(checks.has_methods(value, method_names))
end

---
-- @tparam any value
-- @tparam {string,...} method_names
-- @treturn bool
function assertions.has_methods_or_is_nil(value, method_names)
  assert(checks.has_methods_or_is_nil(value, method_names))
end

---
-- @tparam any value
-- @tparam tab class a class created by library [middleclass](https://github.com/kikito/middleclass)
-- @treturn bool
function assertions.is_instance(value, class)
  assert(checks.is_instance(value, class))
end

---
-- @tparam any value
-- @tparam tab class a class created by library [middleclass](https://github.com/kikito/middleclass)
-- @treturn bool
function assertions.is_instance_or_nil(value, class)
  assert(checks.is_instance_or_nil(value, class))
end

-- we cannot check right away because at that moment the check function isn't defined
assertions.is_assertions_mode(_assertions_mode)

-- after filling module `assertions`, we make a backup of it
for key, value in pairs(assertions) do
  _assertions_backup[key] = value
end

return assertions
