-- luacheck: no max comment line length

---
-- @module checks

local _global_deep_checks_mode = "with_deep_checks"

local checks = {}

--- ⚠️. Checks if the key and value checkers are ignored or not in the @{is_table|is_table()} and @{is_sequence|is_sequence()} functions.
-- @treturn "without_deep_checks"|"with_deep_checks"
function checks.get_global_deep_checks_mode()
  return _global_deep_checks_mode
end

--- ⚠️. Set whether or not to ignore the key and value checkers in the @{is_table|is_table()} and @{is_sequence|is_sequence()} functions.
-- @tparam "without_deep_checks"|"with_deep_checks" value
function checks.set_global_deep_checks_mode(value)
  assert(checks.is_deep_checks_mode(value))

  _global_deep_checks_mode = value
end

--- ⚠️. Checks that the value is "without\_deep\_checks" or "with\_deep\_checks".
-- @tparam any value
-- @treturn bool
function checks.is_deep_checks_mode(value)
  -- we cannot use `checks.is_enumeration()` due to recursion
  return value == "without_deep_checks" or value == "with_deep_checks"
end

--- ⚠️. Checks that the value is "without\_deep\_checks", "with\_deep\_checks", or nil.
-- @tparam any value
-- @treturn bool
function checks.is_deep_checks_mode_or_nil(value)
  return checks.is_deep_checks_mode(value) or value == nil
end

--- ⚠️. Checks that the value is "without\_assertions" or "with\_assertions".
-- @tparam any value
-- @treturn bool
function checks.is_assertions_mode(value)
  return checks.is_enumeration(value, {"without_assertions", "with_assertions"})
end

--- ⚠️. Checks that the value is "without\_assertions", "with\_assertions", or nil.
-- @tparam any value
-- @treturn bool
function checks.is_assertions_mode_or_nil(value)
  return checks.is_assertions_mode(value) or value == nil
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

--- ⚠️. Checks that the value is a number and equals to its integral part. Note that it doesn't use the @{math.type|math.type()} function from Lua 5.3.
-- @tparam any value
-- @treturn bool
function checks.is_integer(value)
  if not checks.is_number(value) then
    return false
  end

  local value_integral_part, _ = math.modf(value)
  return value == value_integral_part
end

--- ⚠️. Checks that the value is a number and equals to its integral part or is nil. Note that it doesn't use the @{math.type|math.type()} function from Lua 5.3.
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
  return checks.is_function(value) or checks.has_metamethods(value, {"__call"})
end

---
-- @tparam any value
-- @treturn bool
function checks.is_callable_or_nil(value)
  return checks.is_callable(value) or value == nil
end

---
-- @tparam any value
-- @tparam[opt] func key_checker `func(value: any): bool`
-- @tparam[optchain] func value_checker `func(value: any): bool`
-- @tparam[optchain="with_deep_checks"] "without_deep_checks"|"with_deep_checks" deep_checks_mode ignore or not the key and value checkers
-- @treturn bool
function checks.is_table(value, key_checker, value_checker, deep_checks_mode)
  deep_checks_mode = deep_checks_mode or "with_deep_checks"

  assert(checks.is_function_or_nil(key_checker))
  assert(checks.is_function_or_nil(value_checker))
  assert(checks.is_deep_checks_mode(deep_checks_mode))

  if type(value) ~= "table" then
    return false
  end
  if key_checker == nil and value_checker == nil then
    return true
  end
  if checks._without_deep_checks(deep_checks_mode) then
    return true
  end

  for key, value in pairs(value) do -- luacheck: no redefined
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
-- @tparam[opt] func key_checker `func(value: any): bool`
-- @tparam[optchain] func value_checker `func(value: any): bool`
-- @tparam[optchain="with_deep_checks"] "without_deep_checks"|"with_deep_checks" deep_checks_mode ignore or not the key and value checkers
-- @treturn func `func(value: any): bool`
function checks.make_table_checker(key_checker, value_checker, deep_checks_mode)
  return function(value)
    return checks.is_table(value, key_checker, value_checker, deep_checks_mode)
  end
end

---
-- @tparam any value
-- @tparam[opt] func key_checker `func(value: any): bool`
-- @tparam[optchain] func value_checker `func(value: any): bool`
-- @tparam[optchain="with_deep_checks"] "without_deep_checks"|"with_deep_checks" deep_checks_mode ignore or not the key and value checkers
-- @treturn bool
function checks.is_table_or_nil(
  value,
  key_checker,
  value_checker,
  deep_checks_mode
)
  return checks.is_table(value, key_checker, value_checker, deep_checks_mode)
    or value == nil
end

---
-- @tparam[opt] func key_checker `func(value: any): bool`
-- @tparam[optchain] func value_checker `func(value: any): bool`
-- @tparam[optchain="with_deep_checks"] "without_deep_checks"|"with_deep_checks" deep_checks_mode ignore or not the key and value checkers
-- @treturn func `func(value: any): bool`
function checks.make_table_or_nil_checker(
  key_checker,
  value_checker,
  deep_checks_mode
)
  return function(value)
    return checks.is_table_or_nil(
      value,
      key_checker,
      value_checker,
      deep_checks_mode
    )
  end
end

---
-- @tparam any value
-- @tparam[opt] func value_checker `func(value: any): bool`
-- @tparam[optchain="with_deep_checks"] "without_deep_checks"|"with_deep_checks" deep_checks_mode ignore or not the value checker
-- @treturn bool
function checks.is_sequence(value, value_checker, deep_checks_mode)
  deep_checks_mode = deep_checks_mode or "with_deep_checks"

  assert(checks.is_function_or_nil(value_checker))
  assert(checks.is_deep_checks_mode(deep_checks_mode))

  if not checks.is_table(
    value,
    checks.is_number,
    value_checker,
    deep_checks_mode
  ) then
    return false
  end
  if checks._without_deep_checks(deep_checks_mode) then
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
-- @tparam[opt] func value_checker `func(value: any): bool`
-- @tparam[optchain="with_deep_checks"] "without_deep_checks"|"with_deep_checks" deep_checks_mode ignore or not the value checker
-- @treturn func `func(value: any): bool`
function checks.make_sequence_checker(value_checker, deep_checks_mode)
  return function(value)
    return checks.is_sequence(value, value_checker, deep_checks_mode)
  end
end

---
-- @tparam any value
-- @tparam[opt] func value_checker `func(value: any): bool`
-- @tparam[optchain="with_deep_checks"] "without_deep_checks"|"with_deep_checks" deep_checks_mode ignore or not the value checker
-- @treturn bool
function checks.is_sequence_or_nil(value, value_checker, deep_checks_mode)
  return checks.is_sequence(value, value_checker, deep_checks_mode)
    or value == nil
end

---
-- @tparam[opt] func value_checker `func(value: any): bool`
-- @tparam[optchain="with_deep_checks"] "without_deep_checks"|"with_deep_checks" deep_checks_mode ignore or not the value checker
-- @treturn func `func(value: any): bool`
function checks.make_sequence_or_nil_checker(value_checker, deep_checks_mode)
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
-- @treturn func `func(value: any): bool`
function checks.make_enumeration_checker(enumeration)
  return function(value)
    return checks.is_enumeration(value, enumeration)
  end
end

---
-- @tparam any value
-- @tparam {any,...} enumeration
-- @treturn bool
function checks.is_enumeration_or_nil(value, enumeration)
  return checks.is_enumeration(value, enumeration) or value == nil
end

---
-- @tparam {any,...} enumeration
-- @treturn func `func(value: any): bool`
function checks.make_enumeration_or_nil_checker(enumeration)
  return function(value)
    return checks.is_enumeration_or_nil(value, enumeration)
  end
end

---
-- @tparam any value
-- @tparam {string,...} metamethod_names
-- @treturn bool
function checks.has_metamethods(value, metamethod_names)
  assert(checks.is_sequence(metamethod_names, checks.is_string))

  local metatable = getmetatable(value)
  if metatable == nil then
    return false
  end

  for _, metamethod_name in ipairs(metamethod_names) do
    local metamethod_instance = metatable[metamethod_name]
    if metamethod_instance == nil
      or not checks.is_callable(metamethod_instance) then
      return false
    end
  end

  return true
end

---
-- @tparam {string,...} metamethod_names
-- @treturn func `func(value: any): bool`
function checks.make_metamethods_checker(metamethod_names)
  return function(value)
    return checks.has_metamethods(value, metamethod_names)
  end
end

---
-- @tparam any value
-- @tparam {string,...} metamethod_names
-- @treturn bool
function checks.has_metamethods_or_is_nil(value, metamethod_names)
  return checks.has_metamethods(value, metamethod_names) or value == nil
end

---
-- @tparam {string,...} metamethod_names
-- @treturn func `func(value: any): bool`
function checks.make_metamethods_or_nil_checker(metamethod_names)
  return function(value)
    return checks.has_metamethods_or_is_nil(value, metamethod_names)
  end
end

--- ⚠️. Checks that the value has the specified methods. Note that it tries to get methods by regular indexing, it doesn't touch the value metatable.
-- @tparam any value
-- @tparam {string,...} method_names
-- @treturn bool
function checks.has_methods(value, method_names)
  assert(checks.is_sequence(method_names, checks.is_string))

  for _, method_name in ipairs(method_names) do
    local method_instance = value[method_name]
    if method_instance == nil or not checks.is_callable(method_instance) then
      return false
    end
  end

  return true
end

--- ⚠️. Creates a closure that checks that the value has the specified methods. Note that it tries to get methods by regular indexing, it doesn't touch the value metatable.
-- @tparam {string,...} method_names
-- @treturn func `func(value: any): bool`
function checks.make_methods_checker(method_names)
  return function(value)
    return checks.has_methods(value, method_names)
  end
end

--- ⚠️. Checks that the value has the specified methods or is nil. Note that it tries to get methods by regular indexing, it doesn't touch the value metatable.
-- @tparam any value
-- @tparam {string,...} method_names
-- @treturn bool
function checks.has_methods_or_is_nil(value, method_names)
  return checks.has_methods(value, method_names) or value == nil
end

--- ⚠️. Creates a closure that checks that the value has the specified methods or is nil. Note that it tries to get methods by regular indexing, it doesn't touch the value metatable.
-- @tparam {string,...} method_names
-- @treturn func `func(value: any): bool`
function checks.make_methods_or_nil_checker(method_names)
  return function(value)
    return checks.has_methods_or_is_nil(value, method_names)
  end
end

--- ⚠️. Unions the @{has_metamethods|has_metamethods()} and @{has_methods|has_methods()} functions. The method names are separated by prefix: if a method name starts with two underscores, it's passed to the @{has_metamethods|has_metamethods()} function, otherwise to the @{has_methods|has_methods()} function.
-- @tparam any value
-- @tparam {string,...} method_names
-- @treturn bool
function checks.has_methods_anywhere(value, method_names)
  assert(checks.is_sequence(method_names, checks.is_string))

  local metamethod_names = {}
  local regular_method_names = {}
  for _, method_name in ipairs(method_names) do
    if string.match(method_name, "^__") then
      table.insert(metamethod_names, method_name)
    else
      table.insert(regular_method_names, method_name)
    end
  end

  return (#metamethod_names == 0
    or checks.has_metamethods(value, metamethod_names))
    and checks.has_methods(value, regular_method_names)
end

--- ⚠️. Unions the @{make_metamethods_checker|make_metamethods_checker()} and @{make_methods_checker|make_methods_checker()} functions. The method names are separated by prefix: if a method name starts with two underscores, it's passed to the @{make_metamethods_checker|make_metamethods_checker()} function, otherwise to the @{make_methods_checker|make_methods_checker()} function.
-- @tparam {string,...} method_names
-- @treturn func `func(value: any): bool`
function checks.make_methods_anywhere_checker(method_names)
  return function(value)
    return checks.has_methods_anywhere(value, method_names)
  end
end

--- ⚠️. Unions the @{has_metamethods_or_is_nil|has_metamethods_or_is_nil()} and @{has_methods_or_is_nil|has_methods_or_is_nil()} functions. The method names are separated by prefix: if a method name starts with two underscores, it's passed to the @{has_metamethods_or_is_nil|has_metamethods_or_is_nil()} function, otherwise to the @{has_methods_or_is_nil|has_methods_or_is_nil()} function.
-- @tparam any value
-- @tparam {string,...} method_names
-- @treturn bool
function checks.has_methods_anywhere_or_is_nil(value, method_names)
  return checks.has_methods_anywhere(value, method_names) or value == nil
end

--- ⚠️. Unions the @{make_metamethods_or_nil_checker|make_metamethods_or_nil_checker()} and @{make_methods_or_nil_checker|make_methods_or_nil_checker()} functions. The method names are separated by prefix: if a method name starts with two underscores, it's passed to the @{make_metamethods_or_nil_checker|make_metamethods_or_nil_checker()} function, otherwise to the @{make_methods_or_nil_checker|make_methods_or_nil_checker()} function.
-- @tparam {string,...} method_names
-- @treturn func `func(value: any): bool`
function checks.make_methods_anywhere_or_nil_checker(method_names)
  return function(value)
    return checks.has_methods_anywhere_or_is_nil(value, method_names)
  end
end

--- ⚠️. Checks that the value is an instance of a class created by library [middleclass](https://github.com/kikito/middleclass).
-- @tparam any value
-- @tparam tab class a class created by library [middleclass](https://github.com/kikito/middleclass)
-- @treturn bool
function checks.is_instance(value, class)
  assert(checks.is_table(class))

  return checks.is_table(value)
    and checks.is_callable(value.isInstanceOf)
    and value:isInstanceOf(class)
end

--- ⚠️. Creates a closure that checks that the value is an instance of a class created by library [middleclass](https://github.com/kikito/middleclass).
-- @tparam tab class a class created by library [middleclass](https://github.com/kikito/middleclass)
-- @treturn func `func(value: any): bool`
function checks.make_instance_checker(class)
  return function(value)
    return checks.is_instance(value, class)
  end
end

--- ⚠️. Checks that the value is an instance of a class created by library [middleclass](https://github.com/kikito/middleclass) or is nil.
-- @tparam any value
-- @tparam tab class a class created by library [middleclass](https://github.com/kikito/middleclass)
-- @treturn bool
function checks.is_instance_or_nil(value, class)
  return checks.is_instance(value, class) or value == nil
end

--- ⚠️. Creates a closure that checks that the value is an instance of a class created by library [middleclass](https://github.com/kikito/middleclass) or is nil.
-- @tparam tab class a class created by library [middleclass](https://github.com/kikito/middleclass)
-- @treturn func `func(value: any): bool`
function checks.make_instance_or_nil_checker(class)
  return function(value)
    return checks.is_instance_or_nil(value, class)
  end
end

function checks._without_deep_checks(deep_checks_mode)
  assert(checks.is_deep_checks_mode(deep_checks_mode))

  return _global_deep_checks_mode == "without_deep_checks"
    or deep_checks_mode == "without_deep_checks"
end

-- we cannot check right away because at that moment the check function isn't defined
assert(checks.is_deep_checks_mode(_global_deep_checks_mode))

return checks
