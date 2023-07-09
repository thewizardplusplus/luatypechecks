---
-- @module checks

local checks = {}

local function _is_nil(value)
  return type(value) == "nil"
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
  return checks.is_boolean(value) or _is_nil(value)
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
  return checks.is_number(value) or _is_nil(value)
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
  return checks.is_string(value) or _is_nil(value)
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
  return checks.is_function(value) or _is_nil(value)
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
-- @tparam any value
-- @tparam[opt] func key_checker func(value: any): bool
-- @tparam[optchain] func value_checker func(value: any): bool
-- @treturn bool
function checks.is_table_or_nil(value, key_checker, value_checker)
  assert(checks.is_function_or_nil(key_checker))
  assert(checks.is_function_or_nil(value_checker))

  return checks.is_table(value, key_checker, value_checker) or _is_nil(value)
end

return checks
