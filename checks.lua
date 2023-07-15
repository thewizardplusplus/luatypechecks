---
-- @module checks

local _global_deep_checks_mode = "with_deep_checks"

local checks = {}

---
-- @treturn "without_deep_checks"|"with_deep_checks"
function checks.get_global_deep_checks_mode()
  return _global_deep_checks_mode
end

---
-- @tparam "without_deep_checks"|"with_deep_checks" value
function checks.set_global_deep_checks_mode(value)
  assert(checks.is_enumeration(value, {"without_deep_checks", "with_deep_checks"}))

  _global_deep_checks_mode = value
end

---
-- @tparam any value
-- @treturn bool
function checks.is_boolean(value)
  return type(value) == "boolean"
end

---
-- @tparam any value
-- @treturn bool
function checks.is_boolean_or_nil(value)
  return checks.is_boolean(value) or value == nil
end

---
-- @tparam any value
-- @treturn bool
function checks.is_number(value)
  return type(value) == "number"
end

---
-- @tparam any value
-- @treturn bool
function checks.is_number_or_nil(value)
  return checks.is_number(value) or value == nil
end

---
-- @tparam any value
-- @treturn bool
function checks.is_integer(value)
  if not checks.is_number(value) then
    return false
  end

  local value_integral_part, _ = math.modf(value)
  return value == value_integral_part
end

---
-- @tparam any value
-- @treturn bool
function checks.is_integer_or_nil(value)
  return checks.is_integer(value) or value == nil
end

---
-- @tparam any value
-- @treturn bool
function checks.is_string(value)
  return type(value) == "string"
end

---
-- @tparam any value
-- @treturn bool
function checks.is_string_or_nil(value)
  return checks.is_string(value) or value == nil
end

---
-- @tparam any value
-- @treturn bool
function checks.is_function(value)
  return type(value) == "function"
end

---
-- @tparam any value
-- @treturn bool
function checks.is_function_or_nil(value)
  return checks.is_function(value) or value == nil
end

---
-- @tparam any value
-- @treturn bool
function checks.is_callable(value)
  if checks.is_function(value) then
    return true
  end

  local metatable = getmetatable(value)
  return metatable ~= nil
    and metatable.__call ~= nil
    and checks.is_callable(metatable.__call)
end

---
-- @tparam any value
-- @treturn bool
function checks.is_callable_or_nil(value)
  return checks.is_callable(value) or value == nil
end

---
-- @tparam any value
-- @tparam[opt] func key_checker func(value: any): bool
-- @tparam[optchain] func value_checker func(value: any): bool
-- @tparam[optchain="with_deep_checks"] "without_deep_checks"|"with_deep_checks" deep_checks_mode
-- @treturn bool
function checks.is_table(value, key_checker, value_checker, deep_checks_mode)
  assert(checks.is_function_or_nil(key_checker))
  assert(checks.is_function_or_nil(value_checker))
  -- we cannot use `checks.is_enumeration_or_nil()` due to recursion
  assert(deep_checks_mode == "without_deep_checks"
    or deep_checks_mode == "with_deep_checks"
    or deep_checks_mode == nil)

  deep_checks_mode = deep_checks_mode or "with_deep_checks"

  if type(value) ~= "table" then
    return false
  end
  if key_checker == nil and value_checker == nil then
    return true
  end
  if _global_deep_checks_mode == "without_deep_checks" or deep_checks_mode == "without_deep_checks" then
    return true
  end

  for key, value in pairs(value) do
    if key_checker ~= nil and not key_checker(key) then
      return false
    end
    if value_checker ~= nil and not value_checker(value) then
      return false
    end
  end

  return true
end

---
-- @tparam[opt] func key_checker func(value: any): bool
-- @tparam[optchain] func value_checker func(value: any): bool
-- @tparam[optchain="with_deep_checks"] "without_deep_checks"|"with_deep_checks" deep_checks_mode
-- @treturn func func(value: any): bool
function checks.make_table_checker(key_checker, value_checker, deep_checks_mode)
  assert(checks.is_function_or_nil(key_checker))
  assert(checks.is_function_or_nil(value_checker))
  -- we cannot use `checks.is_enumeration_or_nil()` due to recursion
  assert(deep_checks_mode == "without_deep_checks"
    or deep_checks_mode == "with_deep_checks"
    or deep_checks_mode == nil)

  deep_checks_mode = deep_checks_mode or "with_deep_checks"

  return function(value)
    return checks.is_table(value, key_checker, value_checker, deep_checks_mode)
  end
end

---
-- @tparam any value
-- @tparam[opt] func key_checker func(value: any): bool
-- @tparam[optchain] func value_checker func(value: any): bool
-- @tparam[optchain="with_deep_checks"] "without_deep_checks"|"with_deep_checks" deep_checks_mode
-- @treturn bool
function checks.is_table_or_nil(value, key_checker, value_checker, deep_checks_mode)
  assert(checks.is_function_or_nil(key_checker))
  assert(checks.is_function_or_nil(value_checker))
  -- we cannot use `checks.is_enumeration_or_nil()` due to recursion
  assert(deep_checks_mode == "without_deep_checks"
    or deep_checks_mode == "with_deep_checks"
    or deep_checks_mode == nil)

  deep_checks_mode = deep_checks_mode or "with_deep_checks"

  return checks.is_table(value, key_checker, value_checker, deep_checks_mode) or value == nil
end

---
-- @tparam[opt] func key_checker func(value: any): bool
-- @tparam[optchain] func value_checker func(value: any): bool
-- @tparam[optchain="with_deep_checks"] "without_deep_checks"|"with_deep_checks" deep_checks_mode
-- @treturn func func(value: any): bool
function checks.make_table_or_nil_checker(key_checker, value_checker, deep_checks_mode)
  assert(checks.is_function_or_nil(key_checker))
  assert(checks.is_function_or_nil(value_checker))
  -- we cannot use `checks.is_enumeration_or_nil()` due to recursion
  assert(deep_checks_mode == "without_deep_checks"
    or deep_checks_mode == "with_deep_checks"
    or deep_checks_mode == nil)

  deep_checks_mode = deep_checks_mode or "with_deep_checks"

  return function(value)
    return checks.is_table_or_nil(value, key_checker, value_checker, deep_checks_mode)
  end
end

---
-- @tparam any value
-- @tparam[opt] func value_checker func(value: any): bool
-- @tparam[optchain="with_deep_checks"] "without_deep_checks"|"with_deep_checks" deep_checks_mode
-- @treturn bool
function checks.is_sequence(value, value_checker, deep_checks_mode)
  assert(checks.is_function_or_nil(value_checker))
  -- we cannot use `checks.is_enumeration_or_nil()` due to recursion
  assert(deep_checks_mode == "without_deep_checks"
    or deep_checks_mode == "with_deep_checks"
    or deep_checks_mode == nil)

  deep_checks_mode = deep_checks_mode or "with_deep_checks"

  if not checks.is_table(value, checks.is_number, value_checker, deep_checks_mode) then
    return false
  end
  if _global_deep_checks_mode == "without_deep_checks" or deep_checks_mode == "without_deep_checks" then
    return true
  end

  local indices = {}
  for index, _ in pairs(value) do
    table.insert(indices, index)
  end
  table.sort(indices)

  local expected_index = 1
  for _, actual_index in ipairs(indices) do
    if actual_index ~= expected_index then
      return false
    end

    expected_index = expected_index + 1
  end

  return true
end

---
-- @tparam[opt] func value_checker func(value: any): bool
-- @tparam[optchain="with_deep_checks"] "without_deep_checks"|"with_deep_checks" deep_checks_mode
-- @treturn func func(value: any): bool
function checks.make_sequence_checker(value_checker, deep_checks_mode)
  assert(checks.is_function_or_nil(value_checker))
  -- we cannot use `checks.is_enumeration_or_nil()` due to recursion
  assert(deep_checks_mode == "without_deep_checks"
    or deep_checks_mode == "with_deep_checks"
    or deep_checks_mode == nil)

  deep_checks_mode = deep_checks_mode or "with_deep_checks"

  return function(value)
    return checks.is_sequence(value, value_checker, deep_checks_mode)
  end
end

---
-- @tparam any value
-- @tparam[opt] func value_checker func(value: any): bool
-- @tparam[optchain="with_deep_checks"] "without_deep_checks"|"with_deep_checks" deep_checks_mode
-- @treturn bool
function checks.is_sequence_or_nil(value, value_checker, deep_checks_mode)
  assert(checks.is_function_or_nil(value_checker))
  -- we cannot use `checks.is_enumeration_or_nil()` due to recursion
  assert(deep_checks_mode == "without_deep_checks"
    or deep_checks_mode == "with_deep_checks"
    or deep_checks_mode == nil)

  deep_checks_mode = deep_checks_mode or "with_deep_checks"

  return checks.is_sequence(value, value_checker, deep_checks_mode) or value == nil
end

---
-- @tparam[opt] func value_checker func(value: any): bool
-- @tparam[optchain="with_deep_checks"] "without_deep_checks"|"with_deep_checks" deep_checks_mode
-- @treturn func func(value: any): bool
function checks.make_sequence_or_nil_checker(value_checker, deep_checks_mode)
  assert(checks.is_function_or_nil(value_checker))
  -- we cannot use `checks.is_enumeration_or_nil()` due to recursion
  assert(deep_checks_mode == "without_deep_checks"
    or deep_checks_mode == "with_deep_checks"
    or deep_checks_mode == nil)

  deep_checks_mode = deep_checks_mode or "with_deep_checks"

  return function(value)
    return checks.is_sequence_or_nil(value, value_checker, deep_checks_mode)
  end
end

---
-- @tparam any value
-- @tparam {any,...} enumeration
-- @treturn bool
function checks.is_enumeration(value, enumeration)
  assert(checks.is_sequence(enumeration))

  for _, element in ipairs(enumeration) do
    if value == element then
      return true
    end
  end

  return false
end

---
-- @tparam {any,...} enumeration
-- @treturn func func(value: any): bool
function checks.make_enumeration_checker(enumeration)
  assert(checks.is_sequence(enumeration))

  return function(value)
    return checks.is_enumeration(value, enumeration)
  end
end

---
-- @tparam any value
-- @tparam {any,...} enumeration
-- @treturn bool
function checks.is_enumeration_or_nil(value, enumeration)
  assert(checks.is_sequence(enumeration))

  return checks.is_enumeration(value, enumeration) or value == nil
end

---
-- @tparam {any,...} enumeration
-- @treturn func func(value: any): bool
function checks.make_enumeration_or_nil_checker(enumeration)
  assert(checks.is_sequence(enumeration))

  return function(value)
    return checks.is_enumeration_or_nil(value, enumeration)
  end
end

---
-- @tparam any value
-- @tparam tab class a class created by library middleclass
-- @treturn bool
function checks.is_instance(value, class)
  assert(checks.is_table(class))

  return checks.is_table(value)
    and checks.is_callable(value.isInstanceOf)
    and value:isInstanceOf(class)
end

---
-- @tparam tab class a class created by library middleclass
-- @treturn func func(value: any): bool
function checks.make_instance_checker(class)
  assert(checks.is_table(class))

  return function(value)
    return checks.is_instance(value, class)
  end
end

---
-- @tparam any value
-- @tparam tab class a class created by library middleclass
-- @treturn bool
function checks.is_instance_or_nil(value, class)
  assert(checks.is_table(class))

  return checks.is_instance(value, class) or value == nil
end

---
-- @tparam tab class a class created by library middleclass
-- @treturn func func(value: any): bool
function checks.make_instance_or_nil_checker(class)
  assert(checks.is_table(class))

  return function(value)
    return checks.is_instance_or_nil(value, class)
  end
end

return checks
