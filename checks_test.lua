local luaunit = require("luaunit")
local checks = require("luatypechecks.checks")
local middleclass = require("middleclass")

local Object = {}

function Object:new(id)
  assert(checks.is_integer(id))

  local object = setmetatable({}, self)
  object.id = id

  return object
end

function Object:__eq(another_object)
  assert(checks.is_table(another_object))

  return self.id == another_object.id
end

function Object.__call() end

local MiddleclassBaseObject = middleclass("MiddleclassBaseObject")

local MiddleclassObject = middleclass(
  "MiddleclassObject",
  MiddleclassBaseObject
)

-- luacheck: globals TestChecks
TestChecks = {}

-- checks.set_global_deep_checks_mode()
for _, data in ipairs({
  {
    name = "test_set_global_deep_checks_mode/with_deep_checks",
    args = { value = "with_deep_checks" },
    want = "with_deep_checks",
  },
  {
    name = "test_set_global_deep_checks_mode/without_deep_checks",
    args = { value = "without_deep_checks" },
    want = "without_deep_checks",
  },
}) do
  TestChecks[data.name] = function()
    local previous_global_deep_checks_mode =
      checks.get_global_deep_checks_mode()
    checks.set_global_deep_checks_mode(data.args.value)

    local result = checks.get_global_deep_checks_mode()
    luaunit.assert_is_string(result)
    luaunit.assert_equals(result, data.want)

    checks.set_global_deep_checks_mode(previous_global_deep_checks_mode)
  end
end

-- checks.is_deep_checks_mode()
for _, data in ipairs({
  {
    name = "test_is_deep_checks_mode/nil",
    args = { value = nil },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_deep_checks_mode/boolean",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_deep_checks_mode/number/integer",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_deep_checks_mode/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_deep_checks_mode/string",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_deep_checks_mode"
      .. "/string"
      .. "/deep_checks_mode/without_deep_checks",
    args = { value = "without_deep_checks" },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_deep_checks_mode/string/deep_checks_mode/with_deep_checks",
    args = { value = "with_deep_checks" },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_deep_checks_mode/function",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_deep_checks_mode/table",
    args = { value = {} },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_deep_checks_mode(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.is_deep_checks_mode_or_nil()
for _, data in ipairs({
  {
    name = "test_is_deep_checks_mode_or_nil/nil",
    args = { value = nil },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_deep_checks_mode_or_nil/boolean",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_deep_checks_mode_or_nil/number/integer",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_deep_checks_mode_or_nil/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_deep_checks_mode_or_nil/string",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_deep_checks_mode_or_nil"
      .. "/string"
      .. "/deep_checks_mode/without_deep_checks",
    args = { value = "without_deep_checks" },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_deep_checks_mode_or_nil"
      .. "/string"
      .. "/deep_checks_mode/with_deep_checks",
    args = { value = "with_deep_checks" },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_deep_checks_mode_or_nil/function",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_deep_checks_mode_or_nil/table",
    args = { value = {} },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_deep_checks_mode_or_nil(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.is_assertions_mode()
for _, data in ipairs({
  {
    name = "test_is_assertions_mode/nil",
    args = { value = nil },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_assertions_mode/boolean",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_assertions_mode/number/integer",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_assertions_mode/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_assertions_mode/string",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_assertions_mode/string/assertions_mode/without_assertions",
    args = { value = "without_assertions" },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_assertions_mode/string/assertions_mode/with_assertions",
    args = { value = "with_assertions" },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_assertions_mode/function",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_assertions_mode/table",
    args = { value = {} },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_assertions_mode(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.is_assertions_mode_or_nil()
for _, data in ipairs({
  {
    name = "test_is_assertions_mode_or_nil/nil",
    args = { value = nil },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_assertions_mode_or_nil/boolean",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_assertions_mode_or_nil/number/integer",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_assertions_mode_or_nil/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_assertions_mode_or_nil/string",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_assertions_mode_or_nil"
      .. "/string"
      .. "/assertions_mode/without_assertions",
    args = { value = "without_assertions" },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_assertions_mode_or_nil"
      .. "/string"
      .. "/assertions_mode/with_assertions",
    args = { value = "with_assertions" },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_assertions_mode_or_nil/function",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_assertions_mode_or_nil/table",
    args = { value = {} },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_assertions_mode_or_nil(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.is_boolean()
for _, data in ipairs({
  {
    name = "test_is_boolean/nil",
    args = { value = nil },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_boolean/boolean",
    args = { value = true },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_boolean/number/integer",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_boolean/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_boolean/string",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_boolean/function",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_boolean/table",
    args = { value = {} },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_boolean(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.is_boolean_or_nil()
for _, data in ipairs({
  {
    name = "test_is_boolean_or_nil/nil",
    args = { value = nil },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_boolean_or_nil/boolean",
    args = { value = true },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_boolean_or_nil/number/integer",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_boolean_or_nil/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_boolean_or_nil/string",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_boolean_or_nil/function",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_boolean_or_nil/table",
    args = { value = {} },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_boolean_or_nil(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.is_number()
for _, data in ipairs({
  {
    name = "test_is_number/nil",
    args = { value = nil },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_number/boolean",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_number/number/integer",
    args = { value = 23 },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_number/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_number/string",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_number/function",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_number/table",
    args = { value = {} },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_number(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.is_number_or_nil()
for _, data in ipairs({
  {
    name = "test_is_number_or_nil/nil",
    args = { value = nil },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_number_or_nil/boolean",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_number_or_nil/number/integer",
    args = { value = 23 },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_number_or_nil/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_number_or_nil/string",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_number_or_nil/function",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_number_or_nil/table",
    args = { value = {} },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_number_or_nil(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.is_integer()
for _, data in ipairs({
  {
    name = "test_is_integer/nil",
    args = { value = nil },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_integer/boolean",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_integer/number/integer",
    args = { value = 23 },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_integer/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_integer/string",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_integer/function",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_integer/table",
    args = { value = {} },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_integer(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.is_integer_or_nil()
for _, data in ipairs({
  {
    name = "test_is_integer_or_nil/nil",
    args = { value = nil },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_integer_or_nil/boolean",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_integer_or_nil/number/integer",
    args = { value = 23 },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_integer_or_nil/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_integer_or_nil/string",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_integer_or_nil/function",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_integer_or_nil/table",
    args = { value = {} },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_integer_or_nil(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.is_string()
for _, data in ipairs({
  {
    name = "test_is_string/nil",
    args = { value = nil },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_string/boolean",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_string/number/integer",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_string/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_string/string",
    args = { value = "test" },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_string/function",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_string/table",
    args = { value = {} },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_string(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.is_string_or_nil()
for _, data in ipairs({
  {
    name = "test_is_string_or_nil/nil",
    args = { value = nil },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_string_or_nil/boolean",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_string_or_nil/number/integer",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_string_or_nil/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_string_or_nil/string",
    args = { value = "test" },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_string_or_nil/function",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_string_or_nil/table",
    args = { value = {} },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_string_or_nil(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.is_function()
for _, data in ipairs({
  {
    name = "test_is_function/nil",
    args = { value = nil },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_function/boolean",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_function/number/integer",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_function/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_function/string",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_function/function",
    args = { value = function() end },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_function/table",
    args = { value = {} },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_function(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.is_function_or_nil()
for _, data in ipairs({
  {
    name = "test_is_function_or_nil/nil",
    args = { value = nil },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_function_or_nil/boolean",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_function_or_nil/number/integer",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_function_or_nil/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_function_or_nil/string",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_function_or_nil/function",
    args = { value = function() end },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_function_or_nil/table",
    args = { value = {} },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_function_or_nil(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.is_callable()
for _, data in ipairs({
  {
    name = "test_is_callable/nil",
    args = { value = nil },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_callable/boolean",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_callable/number/integer",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_callable/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_callable/string",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_callable/function",
    args = { value = function() end },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_callable/table",
    args = { value = {} },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_callable/table/__call_metamethod/function",
    args = { value = Object:new(23) },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_callable/table/__call_metamethod/table",
    args = {
      value = (function()
        return setmetatable({}, { __call = Object:new(23) })
      end)(),
    },
    want = luaunit.assert_true,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_callable(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.is_callable_or_nil()
for _, data in ipairs({
  {
    name = "test_is_callable_or_nil/nil",
    args = { value = nil },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_callable_or_nil/boolean",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_callable_or_nil/number/integer",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_callable_or_nil/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_callable_or_nil/string",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_callable_or_nil/function",
    args = { value = function() end },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_callable_or_nil/table",
    args = { value = {} },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_callable_or_nil/table/__call_metamethod/function",
    args = { value = Object:new(23) },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_callable_or_nil/table/__call_metamethod/table",
    args = {
      value = (function()
        return setmetatable({}, { __call = Object:new(23) })
      end)(),
    },
    want = luaunit.assert_true,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_callable_or_nil(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.is_table()
for _, data in ipairs({
  {
    name = "test_is_table/nil",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = nil },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table/boolean",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table/number/integer",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table/number/float",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table/string",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table/function",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table/table",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = {} },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table/table/key_checker/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table/table/key_checker/false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table/table/value_checker/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table/table/value_checker/false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_string,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table/table/key_and_value_checkers/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table/table/key_and_value_checkers/key_checker_false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_boolean,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table/table/key_and_value_checkers/value_checker_false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_boolean,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table/table/key_checker/true/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table/table/key_checker/false/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table/table/value_checker/true/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table/table/value_checker/false/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table"
      .. "/table"
      .. "/key_and_value_checkers/true"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table"
      .. "/table"
      .. "/key_and_value_checkers/key_checker_false"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_boolean,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table"
      .. "/table"
      .. "/key_and_value_checkers/value_checker_false"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_boolean,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table"
      .. "/table"
      .. "/key_checker/true"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table"
      .. "/table"
      .. "/key_checker/false"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table"
      .. "/table"
      .. "/value_checker/true"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table"
      .. "/table"
      .. "/value_checker/false"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_string,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table"
      .. "/table"
      .. "/key_and_value_checkers/true"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table"
      .. "/table"
      .. "/key_and_value_checkers/key_checker_false"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_boolean,
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table"
      .. "/table"
      .. "/key_and_value_checkers/value_checker_false"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_boolean,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
}) do
  TestChecks[data.name] = function()
    local previous_global_deep_checks_mode =
      checks.get_global_deep_checks_mode()
    checks.set_global_deep_checks_mode(data.global_deep_checks_mode)

    local result = checks.is_table(
      data.args.value,
      data.args.key_checker,
      data.args.value_checker,
      data.args.deep_checks_mode
    )

    luaunit.assert_is_boolean(result)
    data.want(result)

    checks.set_global_deep_checks_mode(previous_global_deep_checks_mode)
  end
end

-- checks.make_table_checker()
for _, data in ipairs({
  {
    name = "test_make_table_checker/nil",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = nil },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_checker/boolean",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_checker/number/integer",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_checker/number/float",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_checker/string",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_checker/function",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_checker/table",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = {} },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_checker/table/key_checker/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_checker/table/key_checker/false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_checker/table/value_checker/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_checker/table/value_checker/false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_string,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_checker/table/key_and_value_checkers/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_checker"
      .. "/table"
      .. "/key_and_value_checkers/key_checker_false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_boolean,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_checker"
      .. "/table"
      .. "/key_and_value_checkers/value_checker_false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_boolean,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_checker/table/key_checker/true/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_checker"
      .. "/table"
      .. "/key_checker/false"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_checker"
      .. "/table"
      .. "/value_checker/true"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_checker"
      .. "/table"
      .. "/value_checker/false"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_checker"
      .. "/table"
      .. "/key_and_value_checkers/true"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_checker"
      .. "/table"
      .. "/key_and_value_checkers/key_checker_false"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_boolean,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_checker"
      .. "/table"
      .. "/key_and_value_checkers/value_checker_false"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_boolean,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_checker"
      .. "/table"
      .. "/key_checker/true"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_checker"
      .. "/table"
      .. "/key_checker/false"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_checker"
      .. "/table"
      .. "/value_checker/true"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_checker"
      .. "/table"
      .. "/value_checker/false"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_string,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_checker"
      .. "/table"
      .. "/key_and_value_checkers/true"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_checker"
      .. "/table"
      .. "/key_and_value_checkers/key_checker_false"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_boolean,
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_checker"
      .. "/table"
      .. "/key_and_value_checkers/value_checker_false"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_boolean,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
}) do
  TestChecks[data.name] = function()
    local previous_global_deep_checks_mode =
      checks.get_global_deep_checks_mode()
    checks.set_global_deep_checks_mode(data.global_deep_checks_mode)

    local checker = checks.make_table_checker(
      data.args.key_checker,
      data.args.value_checker,
      data.args.deep_checks_mode
    )

    luaunit.assert_is_function(checker)

    local result = checker(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)

    checks.set_global_deep_checks_mode(previous_global_deep_checks_mode)
  end
end

-- checks.is_table_or_nil()
for _, data in ipairs({
  {
    name = "test_is_table_or_nil/nil",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = nil },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table_or_nil/boolean",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table_or_nil/number/integer",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table_or_nil/number/float",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table_or_nil/string",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table_or_nil/function",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table_or_nil/table",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = {} },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table_or_nil/table/key_checker/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table_or_nil/table/key_checker/false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table_or_nil/table/value_checker/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table_or_nil/table/value_checker/false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_string,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table_or_nil/table/key_and_value_checkers/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table_or_nil"
      .. "/table"
      .. "/key_and_value_checkers/key_checker_false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_boolean,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table_or_nil"
      .. "/table"
      .. "/key_and_value_checkers/value_checker_false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_boolean,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table_or_nil/table/key_checker/true/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table_or_nil/table/key_checker/false/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table_or_nil/table/value_checker/true/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table_or_nil/table/value_checker/false/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table_or_nil"
      .. "/table"
      .. "/key_and_value_checkers/true"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table_or_nil"
      .. "/table"
      .. "/key_and_value_checkers/key_checker_false"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_boolean,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table_or_nil"
      .. "/table"
      .. "/key_and_value_checkers/value_checker_false"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_boolean,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table_or_nil"
      .. "/table"
      .. "/key_checker/true"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table_or_nil"
      .. "/table"
      .. "/key_checker/false"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table_or_nil"
      .. "/table"
      .. "/value_checker/true"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table_or_nil"
      .. "/table"
      .. "/value_checker/false"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_string,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table_or_nil"
      .. "/table"
      .. "/key_and_value_checkers/true"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table_or_nil"
      .. "/table"
      .. "/key_and_value_checkers/key_checker_false"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_boolean,
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table_or_nil"
      .. "/table"
      .. "/key_and_value_checkers/value_checker_false"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_boolean,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
}) do
  TestChecks[data.name] = function()
    local previous_global_deep_checks_mode =
      checks.get_global_deep_checks_mode()
    checks.set_global_deep_checks_mode(data.global_deep_checks_mode)

    local result = checks.is_table_or_nil(
      data.args.value,
      data.args.key_checker,
      data.args.value_checker,
      data.args.deep_checks_mode
    )

    luaunit.assert_is_boolean(result)
    data.want(result)

    checks.set_global_deep_checks_mode(previous_global_deep_checks_mode)
  end
end

-- checks.make_table_or_nil_checker()
for _, data in ipairs({
  {
    name = "test_make_table_or_nil_checker/nil",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = nil },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_or_nil_checker/boolean",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_or_nil_checker/number/integer",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_or_nil_checker/number/float",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_or_nil_checker/string",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_or_nil_checker/function",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_or_nil_checker/table",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = {} },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_or_nil_checker/table/key_checker/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_or_nil_checker/table/key_checker/false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_or_nil_checker/table/value_checker/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_or_nil_checker/table/value_checker/false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_string,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_or_nil_checker/table/key_and_value_checkers/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_or_nil_checker"
      .. "/table"
      .. "/key_and_value_checkers/key_checker_false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_boolean,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_or_nil_checker"
      .. "/table"
      .. "/key_and_value_checkers/value_checker_false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_boolean,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_or_nil_checker"
      .. "/table"
      .. "/key_checker/true"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_or_nil_checker"
      .. "/table"
      .. "/key_checker/false"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_or_nil_checker"
      .. "/table"
      .. "/value_checker/true"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_or_nil_checker"
      .. "/table"
      .. "/value_checker/false"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_or_nil_checker"
      .. "/table"
      .. "/key_and_value_checkers/true"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_or_nil_checker"
      .. "/table"
      .. "/key_and_value_checkers/key_checker_false"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_boolean,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_or_nil_checker"
      .. "/table"
      .. "/key_and_value_checkers/value_checker_false"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_boolean,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_or_nil_checker"
      .. "/table"
      .. "/key_checker/true"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_or_nil_checker"
      .. "/table"
      .. "/key_checker/false"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_or_nil_checker"
      .. "/table"
      .. "/value_checker/true"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_or_nil_checker"
      .. "/table"
      .. "/value_checker/false"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_string,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_or_nil_checker"
      .. "/table"
      .. "/key_and_value_checkers/true"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_or_nil_checker"
      .. "/table"
      .. "/key_and_value_checkers/key_checker_false"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_boolean,
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_or_nil_checker"
      .. "/table"
      .. "/key_and_value_checkers/value_checker_false"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_boolean,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
}) do
  TestChecks[data.name] = function()
    local previous_global_deep_checks_mode =
      checks.get_global_deep_checks_mode()
    checks.set_global_deep_checks_mode(data.global_deep_checks_mode)

    local checker = checks.make_table_or_nil_checker(
      data.args.key_checker,
      data.args.value_checker,
      data.args.deep_checks_mode
    )

    luaunit.assert_is_function(checker)

    local result = checker(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)

    checks.set_global_deep_checks_mode(previous_global_deep_checks_mode)
  end
end

-- checks.is_sequence()
for _, data in ipairs({
  {
    name = "test_is_sequence/nil",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = nil },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence/boolean",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence/number/integer",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence/number/float",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence/string",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence/function",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence/table/empty",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = {} },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence/table/sequence",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = {"one", "two"} },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence/table/sequence/value_checker/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence/table/sequence/value_checker/false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence/table/not_sequence/not_integer_indices",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { one = 1, two = 2 } },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence/table/not_sequence/absent_indices",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { [1] = "one", [3] = "two" } },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence/table/not_sequence/indices_not_starting_with_one",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { [2] = "one", [3] = "two"} },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence"
      .. "/table/sequence"
      .. "/value_checker/true"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence"
      .. "/table/sequence"
      .. "/value_checker/false"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence"
      .. "/table/not_sequence"
      .. "/not_integer_indices"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { one = 1, two = 2 } },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence"
      .. "/table/not_sequence"
      .. "/absent_indices"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { [1] = "one", [3] = "two" } },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence"
      .. "/table/not_sequence"
      .. "/indices_not_starting_with_one"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { [2] = "one", [3] = "two"} },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence"
      .. "/table/sequence"
      .. "/value_checker/true"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_string,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence"
      .. "/table/sequence"
      .. "/value_checker/false"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence"
      .. "/table/not_sequence"
      .. "/not_integer_indices"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence"
      .. "/table/not_sequence"
      .. "/absent_indices"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { [1] = "one", [3] = "two" },
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence"
      .. "/table/not_sequence"
      .. "/indices_not_starting_with_one"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { [2] = "one", [3] = "two"},
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
}) do
  TestChecks[data.name] = function()
    local previous_global_deep_checks_mode =
      checks.get_global_deep_checks_mode()
    checks.set_global_deep_checks_mode(data.global_deep_checks_mode)

    local result = checks.is_sequence(
      data.args.value,
      data.args.value_checker,
      data.args.deep_checks_mode
    )

    luaunit.assert_is_boolean(result)
    data.want(result)

    checks.set_global_deep_checks_mode(previous_global_deep_checks_mode)
  end
end

-- checks.make_sequence_checker()
for _, data in ipairs({
  {
    name = "test_make_sequence_checker/nil",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = nil },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_checker/boolean",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_checker/number/integer",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_checker/number/float",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_checker/string",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_checker/function",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_checker/table/empty",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = {} },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_checker/table/sequence",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = {"one", "two"} },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_checker/table/sequence/value_checker/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_checker/table/sequence/value_checker/false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_checker/table/not_sequence/not_integer_indices",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { one = 1, two = 2 } },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_checker/table/not_sequence/absent_indices",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { [1] = "one", [3] = "two" } },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_checker"
      .. "/table/not_sequence"
      .. "/indices_not_starting_with_one",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { [2] = "one", [3] = "two"} },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_checker"
      .. "/table/sequence"
      .. "/value_checker/true"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_checker"
      .. "/table/sequence"
      .. "/value_checker/false"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_checker"
      .. "/table/not_sequence"
      .. "/not_integer_indices"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { one = 1, two = 2 } },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_checker"
      .. "/table/not_sequence"
      .. "/absent_indices"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { [1] = "one", [3] = "two" } },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_checker"
      .. "/table/not_sequence"
      .. "/indices_not_starting_with_one"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { [2] = "one", [3] = "two"} },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_checker"
      .. "/table/sequence"
      .. "/value_checker/true"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_string,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_checker"
      .. "/table/sequence"
      .. "/value_checker/false"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_checker"
      .. "/table/not_sequence"
      .. "/not_integer_indices"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_checker"
      .. "/table/not_sequence"
      .. "/absent_indices"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { [1] = "one", [3] = "two" },
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_checker"
      .. "/table/not_sequence"
      .. "/indices_not_starting_with_one"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { [2] = "one", [3] = "two"},
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
}) do
  TestChecks[data.name] = function()
    local previous_global_deep_checks_mode =
      checks.get_global_deep_checks_mode()
    checks.set_global_deep_checks_mode(data.global_deep_checks_mode)

    local checker = checks.make_sequence_checker(
      data.args.value_checker,
      data.args.deep_checks_mode
    )

    luaunit.assert_is_function(checker)

    local result = checker(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)

    checks.set_global_deep_checks_mode(previous_global_deep_checks_mode)
  end
end

-- checks.is_sequence_or_nil()
for _, data in ipairs({
  {
    name = "test_is_sequence_or_nil/nil",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = nil },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence_or_nil/boolean",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence_or_nil/number/integer",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence_or_nil/number/float",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence_or_nil/string",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence_or_nil/function",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence_or_nil/table/empty",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = {} },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence_or_nil/table/sequence",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = {"one", "two"} },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence_or_nil/table/sequence/value_checker/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence_or_nil/table/sequence/value_checker/false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence_or_nil/table/not_sequence/not_integer_indices",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { one = 1, two = 2 } },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence_or_nil/table/not_sequence/absent_indices",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { [1] = "one", [3] = "two" } },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence_or_nil"
      .. "/table/not_sequence"
      .. "/indices_not_starting_with_one",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { [2] = "one", [3] = "two"} },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence_or_nil"
      .. "/table/sequence"
      .. "/value_checker/true"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence_or_nil"
      .. "/table/sequence"
      .. "/value_checker/false"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence_or_nil"
      .. "/table/not_sequence"
      .. "/not_integer_indices"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { one = 1, two = 2 } },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence_or_nil"
      .. "/table/not_sequence"
      .. "/absent_indices"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { [1] = "one", [3] = "two" } },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence_or_nil"
      .. "/table/not_sequence"
      .. "/indices_not_starting_with_one"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { [2] = "one", [3] = "two"} },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence_or_nil"
      .. "/table/sequence"
      .. "/value_checker/true"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_string,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence_or_nil"
      .. "/table/sequence"
      .. "/value_checker/false"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence_or_nil"
      .. "/table/not_sequence"
      .. "/not_integer_indices"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence_or_nil"
      .. "/table/not_sequence"
      .. "/absent_indices"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { [1] = "one", [3] = "two" },
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence_or_nil"
      .. "/table/not_sequence"
      .. "/indices_not_starting_with_one"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { [2] = "one", [3] = "two"},
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
}) do
  TestChecks[data.name] = function()
    local previous_global_deep_checks_mode =
      checks.get_global_deep_checks_mode()
    checks.set_global_deep_checks_mode(data.global_deep_checks_mode)

    local result = checks.is_sequence_or_nil(
      data.args.value,
      data.args.value_checker,
      data.args.deep_checks_mode
    )

    luaunit.assert_is_boolean(result)
    data.want(result)

    checks.set_global_deep_checks_mode(previous_global_deep_checks_mode)
  end
end

-- checks.make_sequence_or_nil_checker()
for _, data in ipairs({
  {
    name = "test_make_sequence_or_nil_checker/nil",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = nil },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_or_nil_checker/boolean",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_or_nil_checker/number/integer",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_or_nil_checker/number/float",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_or_nil_checker/string",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_or_nil_checker/function",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_or_nil_checker/table/empty",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = {} },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_or_nil_checker/table/sequence",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = {"one", "two"} },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_or_nil_checker"
      .. "/table/sequence"
      .. "/value_checker/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_or_nil_checker"
      .. "/table/sequence"
      .. "/value_checker/false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_or_nil_checker"
      .. "/table/not_sequence"
      .. "/not_integer_indices",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { one = 1, two = 2 } },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_or_nil_checker"
      .. "/table/not_sequence"
      .. "/absent_indices",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { [1] = "one", [3] = "two" } },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_or_nil_checker"
      .. "/table/not_sequence"
      .. "/indices_not_starting_with_one",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { [2] = "one", [3] = "two"} },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_or_nil_checker"
      .. "/table/sequence"
      .. "/value_checker/true"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_or_nil_checker"
      .. "/table/sequence"
      .. "/value_checker/false"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_or_nil_checker"
      .. "/table/not_sequence"
      .. "/not_integer_indices"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { one = 1, two = 2 } },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_or_nil_checker"
      .. "/table/not_sequence"
      .. "/absent_indices"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { [1] = "one", [3] = "two" } },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_or_nil_checker"
      .. "/table/not_sequence"
      .. "/indices_not_starting_with_one"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { [2] = "one", [3] = "two"} },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_or_nil_checker"
      .. "/table/sequence"
      .. "/value_checker/true"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_string,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_or_nil_checker"
      .. "/table/sequence"
      .. "/value_checker/false"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_or_nil_checker"
      .. "/table/not_sequence"
      .. "/not_integer_indices"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_or_nil_checker"
      .. "/table/not_sequence"
      .. "/absent_indices"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { [1] = "one", [3] = "two" },
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_or_nil_checker"
      .. "/table/not_sequence"
      .. "/indices_not_starting_with_one"
      .. "/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { [2] = "one", [3] = "two"},
      deep_checks_mode = "without_deep_checks",
    },
    want = luaunit.assert_true,
  },
}) do
  TestChecks[data.name] = function()
    local previous_global_deep_checks_mode =
      checks.get_global_deep_checks_mode()
    checks.set_global_deep_checks_mode(data.global_deep_checks_mode)

    local checker = checks.make_sequence_or_nil_checker(
      data.args.value_checker,
      data.args.deep_checks_mode
    )

    luaunit.assert_is_function(checker)

    local result = checker(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)

    checks.set_global_deep_checks_mode(previous_global_deep_checks_mode)
  end
end

-- checks.is_enumeration()
for _, data in ipairs({
  {
    name = "test_is_enumeration/nil",
    args = {
      value = nil,
      enumeration = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_enumeration/boolean",
    args = {
      value = true,
      enumeration = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_enumeration/number/integer/true",
    args = {
      value = 12,
      enumeration = {5, 12},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_enumeration/number/integer/false",
    args = {
      value = 23,
      enumeration = {5, 12},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_enumeration/number/float",
    args = {
      value = 2.3,
      enumeration = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_enumeration/string/true",
    args = {
      value = "two",
      enumeration = {"one", "two"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_enumeration/string/false",
    args = {
      value = "three",
      enumeration = {"one", "two"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_enumeration/function",
    args = {
      value = function() end,
      enumeration = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_enumeration/table",
    args = {
      value = {},
      enumeration = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_enumeration/table/__eq_metamethod/true",
    args = {
      value = Object:new(12),
      enumeration = {Object:new(5), Object:new(12)},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_enumeration/table/__eq_metamethod/false",
    args = {
      value = Object:new(23),
      enumeration = {Object:new(5), Object:new(12)},
    },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_enumeration(
      data.args.value,
      data.args.enumeration
    )

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.make_enumeration_checker()
for _, data in ipairs({
  {
    name = "test_make_enumeration_checker/nil",
    args = {
      value = nil,
      enumeration = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_enumeration_checker/boolean",
    args = {
      value = true,
      enumeration = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_enumeration_checker/number/integer/true",
    args = {
      value = 12,
      enumeration = {5, 12},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_enumeration_checker/number/integer/false",
    args = {
      value = 23,
      enumeration = {5, 12},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_enumeration_checker/number/float",
    args = {
      value = 2.3,
      enumeration = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_enumeration_checker/string/true",
    args = {
      value = "two",
      enumeration = {"one", "two"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_enumeration_checker/string/false",
    args = {
      value = "three",
      enumeration = {"one", "two"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_enumeration_checker/function",
    args = {
      value = function() end,
      enumeration = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_enumeration_checker/table",
    args = {
      value = {},
      enumeration = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_enumeration_checker/table/__eq_metamethod/true",
    args = {
      value = Object:new(12),
      enumeration = {Object:new(5), Object:new(12)},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_enumeration_checker/table/__eq_metamethod/false",
    args = {
      value = Object:new(23),
      enumeration = {Object:new(5), Object:new(12)},
    },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local checker = checks.make_enumeration_checker(data.args.enumeration)

    luaunit.assert_is_function(checker)

    local result = checker(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.is_enumeration_or_nil()
for _, data in ipairs({
  {
    name = "test_is_enumeration_or_nil/nil",
    args = {
      value = nil,
      enumeration = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_enumeration_or_nil/boolean",
    args = {
      value = true,
      enumeration = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_enumeration_or_nil/number/integer/true",
    args = {
      value = 12,
      enumeration = {5, 12},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_enumeration_or_nil/number/integer/false",
    args = {
      value = 23,
      enumeration = {5, 12},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_enumeration_or_nil/number/float",
    args = {
      value = 2.3,
      enumeration = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_enumeration_or_nil/string/true",
    args = {
      value = "two",
      enumeration = {"one", "two"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_enumeration_or_nil/string/false",
    args = {
      value = "three",
      enumeration = {"one", "two"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_enumeration_or_nil/function",
    args = {
      value = function() end,
      enumeration = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_enumeration_or_nil/table",
    args = {
      value = {},
      enumeration = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_enumeration_or_nil/table/__eq_metamethod/true",
    args = {
      value = Object:new(12),
      enumeration = {Object:new(5), Object:new(12)},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_enumeration_or_nil/table/__eq_metamethod/false",
    args = {
      value = Object:new(23),
      enumeration = {Object:new(5), Object:new(12)},
    },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_enumeration_or_nil(
      data.args.value,
      data.args.enumeration
    )

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.make_enumeration_or_nil_checker()
for _, data in ipairs({
  {
    name = "test_make_enumeration_or_nil_checker/nil",
    args = {
      value = nil,
      enumeration = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_enumeration_or_nil_checker/boolean",
    args = {
      value = true,
      enumeration = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_enumeration_or_nil_checker/number/integer/true",
    args = {
      value = 12,
      enumeration = {5, 12},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_enumeration_or_nil_checker/number/integer/false",
    args = {
      value = 23,
      enumeration = {5, 12},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_enumeration_or_nil_checker/number/float",
    args = {
      value = 2.3,
      enumeration = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_enumeration_or_nil_checker/string/true",
    args = {
      value = "two",
      enumeration = {"one", "two"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_enumeration_or_nil_checker/string/false",
    args = {
      value = "three",
      enumeration = {"one", "two"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_enumeration_or_nil_checker/function",
    args = {
      value = function() end,
      enumeration = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_enumeration_or_nil_checker/table",
    args = {
      value = {},
      enumeration = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_enumeration_or_nil_checker/table/__eq_metamethod/true",
    args = {
      value = Object:new(12),
      enumeration = {Object:new(5), Object:new(12)},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_enumeration_or_nil_checker/table/__eq_metamethod/false",
    args = {
      value = Object:new(23),
      enumeration = {Object:new(5), Object:new(12)},
    },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local checker = checks.make_enumeration_or_nil_checker(
      data.args.enumeration
    )

    luaunit.assert_is_function(checker)

    local result = checker(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.has_metamethods()
for _, data in ipairs({
  {
    name = "test_has_metamethods/nil",
    args = {
      value = nil,
      metamethod_names = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_metamethods/boolean",
    args = {
      value = true,
      metamethod_names = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_metamethods/number/integer",
    args = {
      value = 23,
      metamethod_names = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_metamethods/number/float",
    args = {
      value = 2.3,
      metamethod_names = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_metamethods/string",
    args = {
      value = "test",
      metamethod_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_metamethods/function",
    args = {
      value = function() end,
      metamethod_names = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_metamethods/table/without_metatable",
    args = {
      value = {},
      metamethod_names = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_metamethods/table/without_metamethods",
    args = {
      value = (function()
        return setmetatable({}, {})
      end)(),
      metamethod_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_metamethods/table/with_metamethods/functions",
    args = {
      value = Object:new(23),
      metamethod_names = {"__eq", "__call"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_metamethods/table/with_metamethods/tables",
    args = {
      value = (function()
        return setmetatable({}, {
          __eq = Object:new(23),
          __call = Object:new(42),
        })
      end)(),
      metamethod_names = {"__eq", "__call"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_metamethods/table/with_missed_metamethods/all",
    args = {
      value = Object:new(23),
      metamethod_names = {"__add", "__sub"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_metamethods/table/with_missed_metamethods/some",
    args = {
      value = Object:new(23),
      metamethod_names = {"__eq", "__add"},
    },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.has_metamethods(
      data.args.value,
      data.args.metamethod_names
    )

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.make_metamethods_checker()
for _, data in ipairs({
  {
    name = "test_make_metamethods_checker/nil",
    args = {
      value = nil,
      metamethod_names = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_metamethods_checker/boolean",
    args = {
      value = true,
      metamethod_names = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_metamethods_checker/number/integer",
    args = {
      value = 23,
      metamethod_names = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_metamethods_checker/number/float",
    args = {
      value = 2.3,
      metamethod_names = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_metamethods_checker/string",
    args = {
      value = "test",
      metamethod_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_metamethods_checker/function",
    args = {
      value = function() end,
      metamethod_names = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_metamethods_checker/table/without_metatable",
    args = {
      value = {},
      metamethod_names = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_metamethods_checker/table/without_metamethods",
    args = {
      value = (function()
        return setmetatable({}, {})
      end)(),
      metamethod_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_metamethods_checker/table/with_metamethods/functions",
    args = {
      value = Object:new(23),
      metamethod_names = {"__eq", "__call"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_metamethods_checker/table/with_metamethods/tables",
    args = {
      value = (function()
        return setmetatable({}, {
          __eq = Object:new(23),
          __call = Object:new(42),
        })
      end)(),
      metamethod_names = {"__eq", "__call"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_metamethods_checker/table/with_missed_metamethods/all",
    args = {
      value = Object:new(23),
      metamethod_names = {"__add", "__sub"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_metamethods_checker/table/with_missed_metamethods/some",
    args = {
      value = Object:new(23),
      metamethod_names = {"__eq", "__add"},
    },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local checker = checks.make_metamethods_checker(data.args.metamethod_names)

    luaunit.assert_is_function(checker)

    local result = checker(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.has_metamethods_or_is_nil()
for _, data in ipairs({
  {
    name = "test_has_metamethods_or_is_nil/nil",
    args = {
      value = nil,
      metamethod_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_metamethods_or_is_nil/boolean",
    args = {
      value = true,
      metamethod_names = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_metamethods_or_is_nil/number/integer",
    args = {
      value = 23,
      metamethod_names = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_metamethods_or_is_nil/number/float",
    args = {
      value = 2.3,
      metamethod_names = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_metamethods_or_is_nil/string",
    args = {
      value = "test",
      metamethod_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_metamethods_or_is_nil/function",
    args = {
      value = function() end,
      metamethod_names = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_metamethods_or_is_nil/table/without_metatable",
    args = {
      value = {},
      metamethod_names = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_metamethods_or_is_nil/table/without_metamethods",
    args = {
      value = (function()
        return setmetatable({}, {})
      end)(),
      metamethod_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_metamethods_or_is_nil/table/with_metamethods/functions",
    args = {
      value = Object:new(23),
      metamethod_names = {"__eq", "__call"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_metamethods_or_is_nil/table/with_metamethods/tables",
    args = {
      value = (function()
        return setmetatable({}, {
          __eq = Object:new(23),
          __call = Object:new(42),
        })
      end)(),
      metamethod_names = {"__eq", "__call"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_metamethods_or_is_nil/table/with_missed_metamethods/all",
    args = {
      value = Object:new(23),
      metamethod_names = {"__add", "__sub"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_metamethods_or_is_nil/table/with_missed_metamethods/some",
    args = {
      value = Object:new(23),
      metamethod_names = {"__eq", "__add"},
    },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.has_metamethods_or_is_nil(
      data.args.value,
      data.args.metamethod_names
    )

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.make_metamethods_or_nil_checker()
for _, data in ipairs({
  {
    name = "test_make_metamethods_or_nil_checker/nil",
    args = {
      value = nil,
      metamethod_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_metamethods_or_nil_checker/boolean",
    args = {
      value = true,
      metamethod_names = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_metamethods_or_nil_checker/number/integer",
    args = {
      value = 23,
      metamethod_names = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_metamethods_or_nil_checker/number/float",
    args = {
      value = 2.3,
      metamethod_names = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_metamethods_or_nil_checker/string",
    args = {
      value = "test",
      metamethod_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_metamethods_or_nil_checker/function",
    args = {
      value = function() end,
      metamethod_names = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_metamethods_or_nil_checker/table/without_metatable",
    args = {
      value = {},
      metamethod_names = {},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_metamethods_or_nil_checker/table/without_metamethods",
    args = {
      value = (function()
        return setmetatable({}, {})
      end)(),
      metamethod_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_metamethods_or_nil_checker/table/with_metamethods/functions",
    args = {
      value = Object:new(23),
      metamethod_names = {"__eq", "__call"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_metamethods_or_nil_checker/table/with_metamethods/tables",
    args = {
      value = (function()
        return setmetatable({}, {
          __eq = Object:new(23),
          __call = Object:new(42),
        })
      end)(),
      metamethod_names = {"__eq", "__call"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_metamethods_or_nil_checker/table/with_missed_metamethods/all",
    args = {
      value = Object:new(23),
      metamethod_names = {"__add", "__sub"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_metamethods_or_nil_checker/table/with_missed_metamethods/some",
    args = {
      value = Object:new(23),
      metamethod_names = {"__eq", "__add"},
    },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local checker = checks.make_metamethods_or_nil_checker(
      data.args.metamethod_names
    )

    luaunit.assert_is_function(checker)

    local result = checker(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.has_methods()
for _, data in ipairs({
  {
    name = "test_has_methods/nil",
    args = {
      value = nil,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods/boolean",
    args = {
      value = true,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods/number/integer",
    args = {
      value = 23,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods/number/float",
    args = {
      value = 2.3,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods/string",
    args = {
      value = "test",
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods/function",
    args = {
      value = function() end,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods/table/empty",
    args = {
      value = {},
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods/table/with_non-callable_values",
    args = {
      value = { one = 23, two = 42 },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_methods/table/with_callable_values/functions",
    args = {
      value = {
        one = function() end,
        two = function() end,
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods/table/with_callable_values/tables",
    args = {
      value = {
        one = Object:new(23),
        two = Object:new(42),
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods/table/with_metamethods/functions",
    args = {
      value = Object:new(23),
      method_names = {"__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_methods/table/with_metamethods/tables",
    args = {
      value = (function()
        return setmetatable({}, {
          __eq = Object:new(23),
          __call = Object:new(42),
        })
      end)(),
      method_names = {"__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_methods/table/with_missed_methods/all",
    args = {
      value = {
        three = function() end,
        four = function() end,
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_methods/table/with_missed_methods/some",
    args = {
      value = {
        one = function() end,
        three = function() end,
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.has_methods(
      data.args.value,
      data.args.method_names
    )

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.make_methods_checker()
for _, data in ipairs({
  {
    name = "test_make_methods_checker/nil",
    args = {
      value = nil,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_checker/boolean",
    args = {
      value = true,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_checker/number/integer",
    args = {
      value = 23,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_checker/number/float",
    args = {
      value = 2.3,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_checker/string",
    args = {
      value = "test",
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_checker/function",
    args = {
      value = function() end,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_checker/table/empty",
    args = {
      value = {},
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_checker/table/with_non-callable_values",
    args = {
      value = { one = 23, two = 42 },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_methods_checker/table/with_callable_values/functions",
    args = {
      value = {
        one = function() end,
        two = function() end,
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_checker/table/with_callable_values/tables",
    args = {
      value = {
        one = Object:new(23),
        two = Object:new(42),
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_checker/table/with_metamethods/functions",
    args = {
      value = Object:new(23),
      method_names = {"__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_methods_checker/table/with_metamethods/tables",
    args = {
      value = (function()
        return setmetatable({}, {
          __eq = Object:new(23),
          __call = Object:new(42),
        })
      end)(),
      method_names = {"__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_methods_checker/table/with_missed_methods/all",
    args = {
      value = {
        three = function() end,
        four = function() end,
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_methods_checker/table/with_missed_methods/some",
    args = {
      value = {
        one = function() end,
        three = function() end,
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local checker = checks.make_methods_checker(data.args.method_names)

    luaunit.assert_is_function(checker)

    local result = checker(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.has_methods_or_is_nil()
for _, data in ipairs({
  {
    name = "test_has_methods_or_is_nil/nil",
    args = {
      value = nil,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_or_is_nil/boolean",
    args = {
      value = true,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_or_is_nil/number/integer",
    args = {
      value = 23,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_or_is_nil/number/float",
    args = {
      value = 2.3,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_or_is_nil/string",
    args = {
      value = "test",
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_or_is_nil/function",
    args = {
      value = function() end,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_or_is_nil/table/empty",
    args = {
      value = {},
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_or_is_nil/table/with_non-callable_values",
    args = {
      value = { one = 23, two = 42 },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_methods_or_is_nil/table/with_callable_values/functions",
    args = {
      value = {
        one = function() end,
        two = function() end,
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_or_is_nil/table/with_callable_values/tables",
    args = {
      value = {
        one = Object:new(23),
        two = Object:new(42),
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_or_is_nil/table/with_metamethods/functions",
    args = {
      value = Object:new(23),
      method_names = {"__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_methods_or_is_nil/table/with_metamethods/tables",
    args = {
      value = (function()
        return setmetatable({}, {
          __eq = Object:new(23),
          __call = Object:new(42),
        })
      end)(),
      method_names = {"__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_methods_or_is_nil/table/with_missed_methods/all",
    args = {
      value = {
        three = function() end,
        four = function() end,
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_methods_or_is_nil/table/with_missed_methods/some",
    args = {
      value = {
        one = function() end,
        three = function() end,
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.has_methods_or_is_nil(
      data.args.value,
      data.args.method_names
    )

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.make_methods_or_nil_checker()
for _, data in ipairs({
  {
    name = "test_make_methods_or_nil_checker/nil",
    args = {
      value = nil,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_or_nil_checker/boolean",
    args = {
      value = true,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_or_nil_checker/number/integer",
    args = {
      value = 23,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_or_nil_checker/number/float",
    args = {
      value = 2.3,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_or_nil_checker/string",
    args = {
      value = "test",
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_or_nil_checker/function",
    args = {
      value = function() end,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_or_nil_checker/table/empty",
    args = {
      value = {},
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_or_nil_checker/table/with_non-callable_values",
    args = {
      value = { one = 23, two = 42 },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_methods_or_nil_checker/table/with_callable_values/functions",
    args = {
      value = {
        one = function() end,
        two = function() end,
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_or_nil_checker/table/with_callable_values/tables",
    args = {
      value = {
        one = Object:new(23),
        two = Object:new(42),
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_or_nil_checker/table/with_metamethods/functions",
    args = {
      value = Object:new(23),
      method_names = {"__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_methods_or_nil_checker/table/with_metamethods/tables",
    args = {
      value = (function()
        return setmetatable({}, {
          __eq = Object:new(23),
          __call = Object:new(42),
        })
      end)(),
      method_names = {"__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_methods_or_nil_checker/table/with_missed_methods/all",
    args = {
      value = {
        three = function() end,
        four = function() end,
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_methods_or_nil_checker/table/with_missed_methods/some",
    args = {
      value = {
        one = function() end,
        three = function() end,
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local checker = checks.make_methods_or_nil_checker(
      data.args.method_names
    )

    luaunit.assert_is_function(checker)

    local result = checker(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.has_methods_anywhere()
for _, data in ipairs({
  {
    name = "test_has_methods_anywhere/nil",
    args = {
      value = nil,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_anywhere/boolean",
    args = {
      value = true,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_anywhere/number/integer",
    args = {
      value = 23,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_anywhere/number/float",
    args = {
      value = 2.3,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_anywhere/string",
    args = {
      value = "test",
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_anywhere/function",
    args = {
      value = function() end,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_anywhere/table/empty",
    args = {
      value = {},
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_anywhere/table/with_regular_methods",
    args = {
      value = {
        one = function() end,
        two = function() end,
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_anywhere/table/with_regular_methods/with_underscores",
    args = {
      value = {
        __one = function() end,
        __two = function() end,
      },
      method_names = {"__one", "__two"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_methods_anywhere/table/with_regular_methods/missed",
    args = {
      value = {
        three = function() end,
        four = function() end,
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_methods_anywhere/table/with_metamethods",
    args = {
      value = (function()
        return setmetatable({}, {
          __eq = function() end,
          __call = function() end,
        })
      end)(),
      method_names = {"__eq", "__call"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_anywhere/table/with_metamethods/without_underscores",
    args = {
      value = (function()
        return setmetatable({}, {
          eq = function() end,
          call = function() end,
        })
      end)(),
      method_names = {"eq", "call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_methods_anywhere/table/with_metamethods/missed",
    args = {
      value = (function()
        return setmetatable({}, {
          __add = function() end,
          __sub = function() end,
        })
      end)(),
      method_names = {"__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_methods_anywhere/table/with_regular_and_metamethods",
    args = {
      value = (function()
        return setmetatable(
          {
            one = function() end,
            two = function() end,
          },
          {
            __eq = function() end,
            __call = function() end,
          }
        )
      end)(),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_anywhere/table/with_regular_and_metamethods/with_missed_regular_methods",
    args = {
      value = (function()
        return setmetatable(
          {
            three = function() end,
            four = function() end,
          },
          {
            __eq = function() end,
            __call = function() end,
          }
        )
      end)(),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_methods_anywhere/table/with_regular_and_metamethods/with_missed_metamethods",
    args = {
      value = (function()
        return setmetatable(
          {
            one = function() end,
            two = function() end,
          },
          {
            __add = function() end,
            __sub = function() end,
          }
        )
      end)(),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_methods_anywhere/table/with_regular_and_metamethods/with_missed_all_methods",
    args = {
      value = (function()
        return setmetatable(
          {
            three = function() end,
            four = function() end,
          },
          {
            __add = function() end,
            __sub = function() end,
          }
        )
      end)(),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.has_methods_anywhere(
      data.args.value,
      data.args.method_names
    )

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.make_methods_anywhere_checker()
for _, data in ipairs({
  {
    name = "test_make_methods_anywhere_checker/nil",
    args = {
      value = nil,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_anywhere_checker/boolean",
    args = {
      value = true,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_anywhere_checker/number/integer",
    args = {
      value = 23,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_anywhere_checker/number/float",
    args = {
      value = 2.3,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_anywhere_checker/string",
    args = {
      value = "test",
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_anywhere_checker/function",
    args = {
      value = function() end,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_anywhere_checker/table/empty",
    args = {
      value = {},
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_anywhere_checker/table/with_regular_methods",
    args = {
      value = {
        one = function() end,
        two = function() end,
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_anywhere_checker/table/with_regular_methods/with_underscores",
    args = {
      value = {
        __one = function() end,
        __two = function() end,
      },
      method_names = {"__one", "__two"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_methods_anywhere_checker/table/with_regular_methods/missed",
    args = {
      value = {
        three = function() end,
        four = function() end,
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_methods_anywhere_checker/table/with_metamethods",
    args = {
      value = (function()
        return setmetatable({}, {
          __eq = function() end,
          __call = function() end,
        })
      end)(),
      method_names = {"__eq", "__call"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_anywhere_checker/table/with_metamethods/without_underscores",
    args = {
      value = (function()
        return setmetatable({}, {
          eq = function() end,
          call = function() end,
        })
      end)(),
      method_names = {"eq", "call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_methods_anywhere_checker/table/with_metamethods/missed",
    args = {
      value = (function()
        return setmetatable({}, {
          __add = function() end,
          __sub = function() end,
        })
      end)(),
      method_names = {"__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_methods_anywhere_checker/table/with_regular_and_metamethods",
    args = {
      value = (function()
        return setmetatable(
          {
            one = function() end,
            two = function() end,
          },
          {
            __eq = function() end,
            __call = function() end,
          }
        )
      end)(),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_anywhere_checker/table/with_regular_and_metamethods/with_missed_regular_methods",
    args = {
      value = (function()
        return setmetatable(
          {
            three = function() end,
            four = function() end,
          },
          {
            __eq = function() end,
            __call = function() end,
          }
        )
      end)(),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_methods_anywhere_checker/table/with_regular_and_metamethods/with_missed_metamethods",
    args = {
      value = (function()
        return setmetatable(
          {
            one = function() end,
            two = function() end,
          },
          {
            __add = function() end,
            __sub = function() end,
          }
        )
      end)(),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_methods_anywhere_checker/table/with_regular_and_metamethods/with_missed_all_methods",
    args = {
      value = (function()
        return setmetatable(
          {
            three = function() end,
            four = function() end,
          },
          {
            __add = function() end,
            __sub = function() end,
          }
        )
      end)(),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local checker = checks.make_methods_anywhere_checker(data.args.method_names)

    luaunit.assert_is_function(checker)

    local result = checker(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.has_methods_anywhere_or_is_nil()
for _, data in ipairs({
  {
    name = "test_has_methods_anywhere_or_is_nil/nil",
    args = {
      value = nil,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/boolean",
    args = {
      value = true,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/number/integer",
    args = {
      value = 23,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/number/float",
    args = {
      value = 2.3,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/string",
    args = {
      value = "test",
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/function",
    args = {
      value = function() end,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/table/empty",
    args = {
      value = {},
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/table/with_regular_methods",
    args = {
      value = {
        one = function() end,
        two = function() end,
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/table/with_regular_methods/with_underscores",
    args = {
      value = {
        __one = function() end,
        __two = function() end,
      },
      method_names = {"__one", "__two"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/table/with_regular_methods/missed",
    args = {
      value = {
        three = function() end,
        four = function() end,
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/table/with_metamethods",
    args = {
      value = (function()
        return setmetatable({}, {
          __eq = function() end,
          __call = function() end,
        })
      end)(),
      method_names = {"__eq", "__call"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/table/with_metamethods/without_underscores",
    args = {
      value = (function()
        return setmetatable({}, {
          eq = function() end,
          call = function() end,
        })
      end)(),
      method_names = {"eq", "call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/table/with_metamethods/missed",
    args = {
      value = (function()
        return setmetatable({}, {
          __add = function() end,
          __sub = function() end,
        })
      end)(),
      method_names = {"__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/table/with_regular_and_metamethods",
    args = {
      value = (function()
        return setmetatable(
          {
            one = function() end,
            two = function() end,
          },
          {
            __eq = function() end,
            __call = function() end,
          }
        )
      end)(),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/table/with_regular_and_metamethods/with_missed_regular_methods",
    args = {
      value = (function()
        return setmetatable(
          {
            three = function() end,
            four = function() end,
          },
          {
            __eq = function() end,
            __call = function() end,
          }
        )
      end)(),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/table/with_regular_and_metamethods/with_missed_metamethods",
    args = {
      value = (function()
        return setmetatable(
          {
            one = function() end,
            two = function() end,
          },
          {
            __add = function() end,
            __sub = function() end,
          }
        )
      end)(),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/table/with_regular_and_metamethods/with_missed_all_methods",
    args = {
      value = (function()
        return setmetatable(
          {
            three = function() end,
            four = function() end,
          },
          {
            __add = function() end,
            __sub = function() end,
          }
        )
      end)(),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.has_methods_anywhere_or_is_nil(
      data.args.value,
      data.args.method_names
    )

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.make_methods_anywhere_or_nil_checker()
for _, data in ipairs({
  {
    name = "test_make_methods_anywhere_or_nil_checker/nil",
    args = {
      value = nil,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_anywhere_or_nil_checker/boolean",
    args = {
      value = true,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_anywhere_or_nil_checker/number/integer",
    args = {
      value = 23,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_anywhere_or_nil_checker/number/float",
    args = {
      value = 2.3,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_anywhere_or_nil_checker/string",
    args = {
      value = "test",
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_anywhere_or_nil_checker/function",
    args = {
      value = function() end,
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_anywhere_or_nil_checker/table/empty",
    args = {
      value = {},
      method_names = {},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_anywhere_or_nil_checker/table/with_regular_methods",
    args = {
      value = {
        one = function() end,
        two = function() end,
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_anywhere_or_nil_checker/table/with_regular_methods/with_underscores",
    args = {
      value = {
        __one = function() end,
        __two = function() end,
      },
      method_names = {"__one", "__two"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_methods_anywhere_or_nil_checker/table/with_regular_methods/missed",
    args = {
      value = {
        three = function() end,
        four = function() end,
      },
      method_names = {"one", "two"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_methods_anywhere_or_nil_checker/table/with_metamethods",
    args = {
      value = (function()
        return setmetatable({}, {
          __eq = function() end,
          __call = function() end,
        })
      end)(),
      method_names = {"__eq", "__call"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_anywhere_or_nil_checker/table/with_metamethods/without_underscores",
    args = {
      value = (function()
        return setmetatable({}, {
          eq = function() end,
          call = function() end,
        })
      end)(),
      method_names = {"eq", "call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_methods_anywhere_or_nil_checker/table/with_metamethods/missed",
    args = {
      value = (function()
        return setmetatable({}, {
          __add = function() end,
          __sub = function() end,
        })
      end)(),
      method_names = {"__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_methods_anywhere_or_nil_checker/table/with_regular_and_metamethods",
    args = {
      value = (function()
        return setmetatable(
          {
            one = function() end,
            two = function() end,
          },
          {
            __eq = function() end,
            __call = function() end,
          }
        )
      end)(),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_methods_anywhere_or_nil_checker/table/with_regular_and_metamethods/with_missed_regular_methods",
    args = {
      value = (function()
        return setmetatable(
          {
            three = function() end,
            four = function() end,
          },
          {
            __eq = function() end,
            __call = function() end,
          }
        )
      end)(),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_methods_anywhere_or_nil_checker/table/with_regular_and_metamethods/with_missed_metamethods",
    args = {
      value = (function()
        return setmetatable(
          {
            one = function() end,
            two = function() end,
          },
          {
            __add = function() end,
            __sub = function() end,
          }
        )
      end)(),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_methods_anywhere_or_nil_checker/table/with_regular_and_metamethods/with_missed_all_methods",
    args = {
      value = (function()
        return setmetatable(
          {
            three = function() end,
            four = function() end,
          },
          {
            __add = function() end,
            __sub = function() end,
          }
        )
      end)(),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local checker = checks.make_methods_anywhere_or_nil_checker(
      data.args.method_names
    )

    luaunit.assert_is_function(checker)

    local result = checker(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.is_instance()
for _, data in ipairs({
  {
    name = "test_is_instance/nil",
    args = {
      value = nil,
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_instance/boolean",
    args = {
      value = true,
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_instance/number/integer",
    args = {
      value = 23,
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_instance/number/float",
    args = {
      value = 2.3,
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_instance/string",
    args = {
      value = "test",
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_instance/function",
    args = {
      value = function() end,
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_instance/table",
    args = {
      value = {},
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_instance/table/middleclass_object/directly",
    args = {
      value = MiddleclassObject:new(),
      class = MiddleclassObject,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_instance/table/middleclass_object/through_inheritance",
    args = {
      value = MiddleclassObject:new(),
      class = MiddleclassBaseObject,
    },
    want = luaunit.assert_true,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_instance(
      data.args.value,
      data.args.class
    )

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.make_instance_checker()
for _, data in ipairs({
  {
    name = "test_make_instance_checker/nil",
    args = {
      value = nil,
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_instance_checker/boolean",
    args = {
      value = true,
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_instance_checker/number/integer",
    args = {
      value = 23,
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_instance_checker/number/float",
    args = {
      value = 2.3,
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_instance_checker/string",
    args = {
      value = "test",
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_instance_checker/function",
    args = {
      value = function() end,
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_instance_checker/table",
    args = {
      value = {},
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_instance_checker/table/middleclass_object/directly",
    args = {
      value = MiddleclassObject:new(),
      class = MiddleclassObject,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_instance_checker"
      .. "/table"
      .. "/middleclass_object/through_inheritance",
    args = {
      value = MiddleclassObject:new(),
      class = MiddleclassBaseObject,
    },
    want = luaunit.assert_true,
  },
}) do
  TestChecks[data.name] = function()
    local checker = checks.make_instance_checker(data.args.class)

    luaunit.assert_is_function(checker)

    local result = checker(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.is_instance_or_nil()
for _, data in ipairs({
  {
    name = "test_is_instance_or_nil/nil",
    args = {
      value = nil,
      class = MiddleclassObject,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_instance_or_nil/boolean",
    args = {
      value = true,
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_instance_or_nil/number/integer",
    args = {
      value = 23,
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_instance_or_nil/number/float",
    args = {
      value = 2.3,
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_instance_or_nil/string",
    args = {
      value = "test",
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_instance_or_nil/function",
    args = {
      value = function() end,
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_instance_or_nil/table",
    args = {
      value = {},
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_instance_or_nil/table/middleclass_object/directly",
    args = {
      value = MiddleclassObject:new(),
      class = MiddleclassObject,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_instance_or_nil"
      .. "/table"
      .. "/middleclass_object/through_inheritance",
    args = {
      value = MiddleclassObject:new(),
      class = MiddleclassBaseObject,
    },
    want = luaunit.assert_true,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_instance_or_nil(
      data.args.value,
      data.args.class
    )

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.make_instance_or_nil_checker()
for _, data in ipairs({
  {
    name = "test_make_instance_or_nil_checker/nil",
    args = {
      value = nil,
      class = MiddleclassObject,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_instance_or_nil_checker/boolean",
    args = {
      value = true,
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_instance_or_nil_checker/number/integer",
    args = {
      value = 23,
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_instance_or_nil_checker/number/float",
    args = {
      value = 2.3,
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_instance_or_nil_checker/string",
    args = {
      value = "test",
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_instance_or_nil_checker/function",
    args = {
      value = function() end,
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_instance_or_nil_checker/table",
    args = {
      value = {},
      class = MiddleclassObject,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_instance_or_nil_checker"
      .. "/table"
      .. "/middleclass_object/directly",
    args = {
      value = MiddleclassObject:new(),
      class = MiddleclassObject,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_instance_or_nil_checker"
      .. "/table"
      .. "/middleclass_object/through_inheritance",
    args = {
      value = MiddleclassObject:new(),
      class = MiddleclassBaseObject,
    },
    want = luaunit.assert_true,
  },
}) do
  TestChecks[data.name] = function()
    local checker = checks.make_instance_or_nil_checker(data.args.class)

    luaunit.assert_is_function(checker)

    local result = checker(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end
