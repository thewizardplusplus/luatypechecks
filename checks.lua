---
-- @module checks

local checks = {}

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
-- @tparam[opt] func key_checker func(value: any): bool
-- @tparam[optchain] func value_checker func(value: any): bool
-- @treturn bool
function checks.is_table(value, key_checker, value_checker)
  assert(checks.is_function_or_nil(key_checker))
  assert(checks.is_function_or_nil(value_checker))

  if type(value) ~= "table" then
    return false
  end
  if key_checker == nil and value_checker == nil then
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
-- @treturn func func(value: any): bool
function checks.make_table_checker(key_checker, value_checker)
  assert(checks.is_function_or_nil(key_checker))
  assert(checks.is_function_or_nil(value_checker))

  return function(value)
    return checks.is_table(value, key_checker, value_checker)
  end
end

---
-- @tparam any value
-- @tparam[opt] func key_checker func(value: any): bool
-- @tparam[optchain] func value_checker func(value: any): bool
-- @treturn bool
function checks.is_table_or_nil(value, key_checker, value_checker)
  assert(checks.is_function_or_nil(key_checker))
  assert(checks.is_function_or_nil(value_checker))

  return checks.is_table(value, key_checker, value_checker) or value == nil
end

---
-- @tparam[opt] func key_checker func(value: any): bool
-- @tparam[optchain] func value_checker func(value: any): bool
-- @treturn func func(value: any): bool
function checks.make_table_or_nil_checker(key_checker, value_checker)
  assert(checks.is_function_or_nil(key_checker))
  assert(checks.is_function_or_nil(value_checker))

  return function(value)
    return checks.is_table_or_nil(value, key_checker, value_checker)
  end
end

---
-- @tparam any value
-- @tparam[opt] func value_checker func(value: any): bool
-- @treturn bool
function checks.is_sequence(value, value_checker)
  assert(checks.is_function_or_nil(value_checker))

  if not checks.is_table(value, checks.is_number, value_checker) then
    return false
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
-- @treturn func func(value: any): bool
function checks.make_sequence_checker(value_checker)
  assert(checks.is_function_or_nil(value_checker))

  return function(value)
    return checks.is_sequence(value, value_checker)
  end
end

---
-- @tparam any value
-- @tparam[opt] func value_checker func(value: any): bool
-- @treturn bool
function checks.is_sequence_or_nil(value, value_checker)
  assert(checks.is_function_or_nil(value_checker))

  return checks.is_sequence(value, value_checker) or value == nil
end

---
-- @tparam[opt] func value_checker func(value: any): bool
-- @treturn func func(value: any): bool
function checks.make_sequence_or_nil_checker(value_checker)
  assert(checks.is_function_or_nil(value_checker))

  return function(value)
    return checks.is_sequence_or_nil(value, value_checker)
  end
end

return checks
