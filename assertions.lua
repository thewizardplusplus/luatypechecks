local checks = require("luatypechecks.checks")

---
-- @module assertions

local _assertions_mode = "with_assertions"

local assertions = {}

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
-- @tparam[opt] func key_checker func(value: any): bool
-- @tparam[optchain] func value_checker func(value: any): bool
-- @tparam[optchain="with_deep_checks"] "without_deep_checks"|"with_deep_checks" deep_checks_mode
-- @treturn bool
function assertions.is_table(value, key_checker, value_checker, deep_checks_mode)
  assert(checks.is_table(value, key_checker, value_checker, deep_checks_mode))
end

---
-- @tparam any value
-- @tparam[opt] func key_checker func(value: any): bool
-- @tparam[optchain] func value_checker func(value: any): bool
-- @tparam[optchain="with_deep_checks"] "without_deep_checks"|"with_deep_checks" deep_checks_mode
-- @treturn bool
function assertions.is_table_or_nil(value, key_checker, value_checker, deep_checks_mode)
  assert(checks.is_table_or_nil(value, key_checker, value_checker, deep_checks_mode))
end

---
-- @tparam any value
-- @tparam[opt] func value_checker func(value: any): bool
-- @tparam[optchain="with_deep_checks"] "without_deep_checks"|"with_deep_checks" deep_checks_mode
-- @treturn bool
function assertions.is_sequence(value, value_checker, deep_checks_mode)
  assert(checks.is_sequence(value, value_checker, deep_checks_mode))
end

---
-- @tparam any value
-- @tparam[opt] func value_checker func(value: any): bool
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
-- @tparam tab class a class created by library middleclass
-- @treturn bool
function assertions.is_instance(value, class)
  assert(checks.is_instance(value, class))
end

---
-- @tparam any value
-- @tparam tab class a class created by library middleclass
-- @treturn bool
function assertions.is_instance_or_nil(value, class)
  assert(checks.is_instance_or_nil(value, class))
end

-- we cannot check right away because at that moment the check function isn't defined
assertions.is_assertions_mode(_assertions_mode)

return assertions
