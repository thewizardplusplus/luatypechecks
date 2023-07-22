local luaunit = require("luaunit")
local checks = require("luatypechecks.checks")
local assertions = require("luatypechecks.assertions")
local middleclass = require("middleclass")

local function _assert_no_error(test_function, ...)
  test_function(...)
end

local Object = {}

function Object:new(id)
  assertions.is_integer(id)

  local object = setmetatable({}, self)
  object.id = id

  return object
end

function Object:__eq(another_object)
  assertions.is_table(another_object)

  return self.id == another_object.id
end

function Object.__call() end

local MiddleclassBaseObject = middleclass("MiddleclassBaseObject")

local MiddleclassObject = middleclass("MiddleclassObject", MiddleclassBaseObject)

-- luacheck: globals TestAssertions
TestAssertions = {}

-- assertions.is_deep_checks_mode()
for _, data in ipairs({
  {
    name = "test_is_deep_checks_mode/nil",
    args = { value = nil },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_deep_checks_mode/boolean",
    args = { value = true },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_deep_checks_mode/number/integer",
    args = { value = 23 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_deep_checks_mode/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_deep_checks_mode/string",
    args = { value = "test" },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_deep_checks_mode/string/deep_checks_mode/without_deep_checks",
    args = { value = "without_deep_checks" },
    want = _assert_no_error,
  },
  {
    name = "test_is_deep_checks_mode/string/deep_checks_mode/with_deep_checks",
    args = { value = "with_deep_checks" },
    want = _assert_no_error,
  },
  {
    name = "test_is_deep_checks_mode/function",
    args = { value = function() end },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_deep_checks_mode/table",
    args = { value = {} },
    want = luaunit.assert_error,
  },
}) do
  TestAssertions[data.name] = function()
    data.want(assertions.is_deep_checks_mode, data.args.value)
  end
end

-- assertions.is_deep_checks_mode_or_nil()
for _, data in ipairs({
  {
    name = "test_is_deep_checks_mode_or_nil/nil",
    args = { value = nil },
    want = _assert_no_error,
  },
  {
    name = "test_is_deep_checks_mode_or_nil/boolean",
    args = { value = true },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_deep_checks_mode_or_nil/number/integer",
    args = { value = 23 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_deep_checks_mode_or_nil/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_deep_checks_mode_or_nil/string",
    args = { value = "test" },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_deep_checks_mode_or_nil/string/deep_checks_mode/without_deep_checks",
    args = { value = "without_deep_checks" },
    want = _assert_no_error,
  },
  {
    name = "test_is_deep_checks_mode_or_nil/string/deep_checks_mode/with_deep_checks",
    args = { value = "with_deep_checks" },
    want = _assert_no_error,
  },
  {
    name = "test_is_deep_checks_mode_or_nil/function",
    args = { value = function() end },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_deep_checks_mode_or_nil/table",
    args = { value = {} },
    want = luaunit.assert_error,
  },
}) do
  TestAssertions[data.name] = function()
    data.want(assertions.is_deep_checks_mode_or_nil, data.args.value)
  end
end

-- assertions.is_assertions_mode()
for _, data in ipairs({
  {
    name = "test_is_assertions_mode/nil",
    args = { value = nil },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_assertions_mode/boolean",
    args = { value = true },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_assertions_mode/number/integer",
    args = { value = 23 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_assertions_mode/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_assertions_mode/string",
    args = { value = "test" },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_assertions_mode/string/assertions_mode/without_assertions",
    args = { value = "without_assertions" },
    want = _assert_no_error,
  },
  {
    name = "test_is_assertions_mode/string/assertions_mode/with_assertions",
    args = { value = "with_assertions" },
    want = _assert_no_error,
  },
  {
    name = "test_is_assertions_mode/function",
    args = { value = function() end },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_assertions_mode/table",
    args = { value = {} },
    want = luaunit.assert_error,
  },
}) do
  TestAssertions[data.name] = function()
    data.want(assertions.is_assertions_mode, data.args.value)
  end
end

-- assertions.is_assertions_mode_or_nil()
for _, data in ipairs({
  {
    name = "test_is_assertions_mode_or_nil/nil",
    args = { value = nil },
    want = _assert_no_error,
  },
  {
    name = "test_is_assertions_mode_or_nil/boolean",
    args = { value = true },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_assertions_mode_or_nil/number/integer",
    args = { value = 23 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_assertions_mode_or_nil/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_assertions_mode_or_nil/string",
    args = { value = "test" },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_assertions_mode_or_nil/string/assertions_mode/without_assertions",
    args = { value = "without_assertions" },
    want = _assert_no_error,
  },
  {
    name = "test_is_assertions_mode_or_nil/string/assertions_mode/with_assertions",
    args = { value = "with_assertions" },
    want = _assert_no_error,
  },
  {
    name = "test_is_assertions_mode_or_nil/function",
    args = { value = function() end },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_assertions_mode_or_nil/table",
    args = { value = {} },
    want = luaunit.assert_error,
  },
}) do
  TestAssertions[data.name] = function()
    data.want(assertions.is_assertions_mode_or_nil, data.args.value)
  end
end

-- assertions.is_boolean()
for _, data in ipairs({
  {
    name = "test_is_boolean/nil",
    args = { value = nil },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_boolean/boolean",
    args = { value = true },
    want = _assert_no_error,
  },
  {
    name = "test_is_boolean/number/integer",
    args = { value = 23 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_boolean/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_boolean/string",
    args = { value = "test" },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_boolean/function",
    args = { value = function() end },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_boolean/table",
    args = { value = {} },
    want = luaunit.assert_error,
  },
}) do
  TestAssertions[data.name] = function()
    data.want(assertions.is_boolean, data.args.value)
  end
end

-- assertions.is_boolean_or_nil()
for _, data in ipairs({
  {
    name = "test_is_boolean_or_nil/nil",
    args = { value = nil },
    want = _assert_no_error,
  },
  {
    name = "test_is_boolean_or_nil/boolean",
    args = { value = true },
    want = _assert_no_error,
  },
  {
    name = "test_is_boolean_or_nil/number/integer",
    args = { value = 23 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_boolean_or_nil/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_boolean_or_nil/string",
    args = { value = "test" },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_boolean_or_nil/function",
    args = { value = function() end },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_boolean_or_nil/table",
    args = { value = {} },
    want = luaunit.assert_error,
  },
}) do
  TestAssertions[data.name] = function()
    data.want(assertions.is_boolean_or_nil, data.args.value)
  end
end

-- assertions.is_number()
for _, data in ipairs({
  {
    name = "test_is_number/nil",
    args = { value = nil },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_number/boolean",
    args = { value = true },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_number/number/integer",
    args = { value = 23 },
    want = _assert_no_error,
  },
  {
    name = "test_is_number/number/float",
    args = { value = 2.3 },
    want = _assert_no_error,
  },
  {
    name = "test_is_number/string",
    args = { value = "test" },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_number/function",
    args = { value = function() end },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_number/table",
    args = { value = {} },
    want = luaunit.assert_error,
  },
}) do
  TestAssertions[data.name] = function()
    data.want(assertions.is_number, data.args.value)
  end
end

-- assertions.is_number_or_nil()
for _, data in ipairs({
  {
    name = "test_is_number_or_nil/nil",
    args = { value = nil },
    want = _assert_no_error,
  },
  {
    name = "test_is_number_or_nil/boolean",
    args = { value = true },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_number_or_nil/number/integer",
    args = { value = 23 },
    want = _assert_no_error,
  },
  {
    name = "test_is_number_or_nil/number/float",
    args = { value = 2.3 },
    want = _assert_no_error,
  },
  {
    name = "test_is_number_or_nil/string",
    args = { value = "test" },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_number_or_nil/function",
    args = { value = function() end },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_number_or_nil/table",
    args = { value = {} },
    want = luaunit.assert_error,
  },
}) do
  TestAssertions[data.name] = function()
    data.want(assertions.is_number_or_nil, data.args.value)
  end
end

-- assertions.is_integer()
for _, data in ipairs({
  {
    name = "test_is_integer/nil",
    args = { value = nil },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_integer/boolean",
    args = { value = true },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_integer/number/integer",
    args = { value = 23 },
    want = _assert_no_error,
  },
  {
    name = "test_is_integer/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_integer/string",
    args = { value = "test" },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_integer/function",
    args = { value = function() end },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_integer/table",
    args = { value = {} },
    want = luaunit.assert_error,
  },
}) do
  TestAssertions[data.name] = function()
    data.want(assertions.is_integer, data.args.value)
  end
end

-- assertions.is_integer_or_nil()
for _, data in ipairs({
  {
    name = "test_is_integer_or_nil/nil",
    args = { value = nil },
    want = _assert_no_error,
  },
  {
    name = "test_is_integer_or_nil/boolean",
    args = { value = true },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_integer_or_nil/number/integer",
    args = { value = 23 },
    want = _assert_no_error,
  },
  {
    name = "test_is_integer_or_nil/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_integer_or_nil/string",
    args = { value = "test" },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_integer_or_nil/function",
    args = { value = function() end },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_integer_or_nil/table",
    args = { value = {} },
    want = luaunit.assert_error,
  },
}) do
  TestAssertions[data.name] = function()
    data.want(assertions.is_integer_or_nil, data.args.value)
  end
end

-- assertions.is_string()
for _, data in ipairs({
  {
    name = "test_is_string/nil",
    args = { value = nil },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_string/boolean",
    args = { value = true },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_string/number/integer",
    args = { value = 23 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_string/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_string/string",
    args = { value = "test" },
    want = _assert_no_error,
  },
  {
    name = "test_is_string/function",
    args = { value = function() end },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_string/table",
    args = { value = {} },
    want = luaunit.assert_error,
  },
}) do
  TestAssertions[data.name] = function()
    data.want(assertions.is_string, data.args.value)
  end
end

-- assertions.is_string_or_nil()
for _, data in ipairs({
  {
    name = "test_is_string_or_nil/nil",
    args = { value = nil },
    want = _assert_no_error,
  },
  {
    name = "test_is_string_or_nil/boolean",
    args = { value = true },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_string_or_nil/number/integer",
    args = { value = 23 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_string_or_nil/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_string_or_nil/string",
    args = { value = "test" },
    want = _assert_no_error,
  },
  {
    name = "test_is_string_or_nil/function",
    args = { value = function() end },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_string_or_nil/table",
    args = { value = {} },
    want = luaunit.assert_error,
  },
}) do
  TestAssertions[data.name] = function()
    data.want(assertions.is_string_or_nil, data.args.value)
  end
end

-- assertions.is_function()
for _, data in ipairs({
  {
    name = "test_is_function/nil",
    args = { value = nil },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_function/boolean",
    args = { value = true },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_function/number/integer",
    args = { value = 23 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_function/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_function/string",
    args = { value = "test" },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_function/function",
    args = { value = function() end },
    want = _assert_no_error,
  },
  {
    name = "test_is_function/table",
    args = { value = {} },
    want = luaunit.assert_error,
  },
}) do
  TestAssertions[data.name] = function()
    data.want(assertions.is_function, data.args.value)
  end
end

-- assertions.is_function_or_nil()
for _, data in ipairs({
  {
    name = "test_is_function_or_nil/nil",
    args = { value = nil },
    want = _assert_no_error,
  },
  {
    name = "test_is_function_or_nil/boolean",
    args = { value = true },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_function_or_nil/number/integer",
    args = { value = 23 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_function_or_nil/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_function_or_nil/string",
    args = { value = "test" },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_function_or_nil/function",
    args = { value = function() end },
    want = _assert_no_error,
  },
  {
    name = "test_is_function_or_nil/table",
    args = { value = {} },
    want = luaunit.assert_error,
  },
}) do
  TestAssertions[data.name] = function()
    data.want(assertions.is_function_or_nil, data.args.value)
  end
end

-- assertions.is_callable()
for _, data in ipairs({
  {
    name = "test_is_callable/nil",
    args = { value = nil },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_callable/boolean",
    args = { value = true },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_callable/number/integer",
    args = { value = 23 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_callable/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_callable/string",
    args = { value = "test" },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_callable/function",
    args = { value = function() end },
    want = _assert_no_error,
  },
  {
    name = "test_is_callable/table",
    args = { value = {} },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_callable/table/__call_metamethod/function",
    args = { value = Object:new(23) },
    want = _assert_no_error,
  },
  {
    name = "test_is_callable/table/__call_metamethod/table",
    args = {
      value = (function()
        return setmetatable({}, { __call = Object:new(23) })
      end)(),
    },
    want = _assert_no_error,
  },
}) do
  TestAssertions[data.name] = function()
    data.want(assertions.is_callable, data.args.value)
  end
end

-- assertions.is_callable_or_nil()
for _, data in ipairs({
  {
    name = "test_is_callable_or_nil/nil",
    args = { value = nil },
    want = _assert_no_error,
  },
  {
    name = "test_is_callable_or_nil/boolean",
    args = { value = true },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_callable_or_nil/number/integer",
    args = { value = 23 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_callable_or_nil/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_callable_or_nil/string",
    args = { value = "test" },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_callable_or_nil/function",
    args = { value = function() end },
    want = _assert_no_error,
  },
  {
    name = "test_is_callable_or_nil/table",
    args = { value = {} },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_callable_or_nil/table/__call_metamethod/function",
    args = { value = Object:new(23) },
    want = _assert_no_error,
  },
  {
    name = "test_is_callable_or_nil/table/__call_metamethod/table",
    args = {
      value = (function()
        return setmetatable({}, { __call = Object:new(23) })
      end)(),
    },
    want = _assert_no_error,
  },
}) do
  TestAssertions[data.name] = function()
    data.want(assertions.is_callable_or_nil, data.args.value)
  end
end

-- assertions.is_table()
for _, data in ipairs({
  {
    name = "test_is_table/nil",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = nil },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_table/boolean",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = true },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_table/number/integer",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 23 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_table/number/float",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 2.3 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_table/string",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = "test" },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_table/function",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = function() end },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_table/table",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = {} },
    want = _assert_no_error,
  },
  {
    name = "test_is_table/table/key_checker/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table/table/key_checker/false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_number,
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_table/table/value_checker/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_number,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table/table/value_checker/false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_string,
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_table/table/key_and_value_checkers/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_number,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table/table/key_and_value_checkers/key_checker_false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_boolean,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_table/table/key_and_value_checkers/value_checker_false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_boolean,
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_table/table/key_checker/true/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table/table/key_checker/false/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_number,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table/table/value_checker/true/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_number,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table/table/value_checker/false/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_string,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table/table/key_and_value_checkers/true/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_number,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table/table/key_and_value_checkers/key_checker_false/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_boolean,
      value_checker = checks.is_number,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table/table/key_and_value_checkers/value_checker_false/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_boolean,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table/table/key_checker/true/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table/table/key_checker/false/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table/table/value_checker/true/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table/table/value_checker/false/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_string,
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table/table/key_and_value_checkers/true/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table/table/key_and_value_checkers/key_checker_false/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_boolean,
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table/table/key_and_value_checkers/value_checker_false/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_boolean,
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
}) do
  TestAssertions[data.name] = function()
    local previous_global_deep_checks_mode = checks.get_global_deep_checks_mode()
    checks.set_global_deep_checks_mode(data.global_deep_checks_mode)

    data.want(
      assertions.is_table,
      data.args.value,
      data.args.key_checker,
      data.args.value_checker,
      data.args.deep_checks_mode
    )

    checks.set_global_deep_checks_mode(previous_global_deep_checks_mode)
  end
end

-- assertions.is_table_or_nil()
for _, data in ipairs({
  {
    name = "test_is_table_or_nil/nil",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = nil },
    want = _assert_no_error,
  },
  {
    name = "test_is_table_or_nil/boolean",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = true },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_table_or_nil/number/integer",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 23 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_table_or_nil/number/float",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 2.3 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_table_or_nil/string",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = "test" },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_table_or_nil/function",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = function() end },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_table_or_nil/table",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = {} },
    want = _assert_no_error,
  },
  {
    name = "test_is_table_or_nil/table/key_checker/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table_or_nil/table/key_checker/false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_number,
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_table_or_nil/table/value_checker/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_number,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table_or_nil/table/value_checker/false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_string,
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_table_or_nil/table/key_and_value_checkers/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_number,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table_or_nil/table/key_and_value_checkers/key_checker_false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_boolean,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_table_or_nil/table/key_and_value_checkers/value_checker_false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_boolean,
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_table_or_nil/table/key_checker/true/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table_or_nil/table/key_checker/false/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_number,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table_or_nil/table/value_checker/true/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_number,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table_or_nil/table/value_checker/false/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_string,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table_or_nil/table/key_and_value_checkers/true/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_number,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table_or_nil/table/key_and_value_checkers/key_checker_false/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_boolean,
      value_checker = checks.is_number,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table_or_nil/table/key_and_value_checkers/value_checker_false/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_boolean,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table_or_nil/table/key_checker/true/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table_or_nil/table/key_checker/false/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table_or_nil/table/value_checker/true/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table_or_nil/table/value_checker/false/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_string,
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table_or_nil/table/key_and_value_checkers/true/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table_or_nil/table/key_and_value_checkers/key_checker_false/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_boolean,
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_table_or_nil/table/key_and_value_checkers/value_checker_false/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_boolean,
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
}) do
  TestAssertions[data.name] = function()
    local previous_global_deep_checks_mode = checks.get_global_deep_checks_mode()
    checks.set_global_deep_checks_mode(data.global_deep_checks_mode)

    data.want(
      assertions.is_table_or_nil,
      data.args.value,
      data.args.key_checker,
      data.args.value_checker,
      data.args.deep_checks_mode
    )

    checks.set_global_deep_checks_mode(previous_global_deep_checks_mode)
  end
end

-- assertions.is_sequence()
for _, data in ipairs({
  {
    name = "test_is_sequence/nil",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = nil },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_sequence/boolean",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = true },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_sequence/number/integer",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 23 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_sequence/number/float",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 2.3 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_sequence/string",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = "test" },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_sequence/function",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = function() end },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_sequence/table/empty",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = {} },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence/table/sequence",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = {"one", "two"} },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence/table/sequence/value_checker/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_string,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence/table/sequence/value_checker/false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_number,
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_sequence/table/not_sequence/not_integer_indices",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { one = 1, two = 2 } },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_sequence/table/not_sequence/absent_indices",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { [1] = "one", [3] = "two" } },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_sequence/table/not_sequence/indices_not_starting_with_one",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { [2] = "one", [3] = "two"} },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_sequence/table/sequence/value_checker/true/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_string,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence/table/sequence/value_checker/false/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_number,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence/table/not_sequence/not_integer_indices/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { one = 1, two = 2 } },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence/table/not_sequence/absent_indices/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { [1] = "one", [3] = "two" } },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence/table/not_sequence/indices_not_starting_with_one/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { [2] = "one", [3] = "two"} },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence/table/sequence/value_checker/true/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_string,
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence/table/sequence/value_checker/false/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence/table/not_sequence/not_integer_indices/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence/table/not_sequence/absent_indices/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { [1] = "one", [3] = "two" },
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence/table/not_sequence/indices_not_starting_with_one/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { [2] = "one", [3] = "two"},
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
}) do
  TestAssertions[data.name] = function()
    local previous_global_deep_checks_mode = checks.get_global_deep_checks_mode()
    checks.set_global_deep_checks_mode(data.global_deep_checks_mode)

    data.want(
      assertions.is_sequence,
      data.args.value,
      data.args.value_checker,
      data.args.deep_checks_mode
    )

    checks.set_global_deep_checks_mode(previous_global_deep_checks_mode)
  end
end

-- assertions.is_sequence_or_nil()
for _, data in ipairs({
  {
    name = "test_is_sequence_or_nil/nil",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = nil },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence_or_nil/boolean",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = true },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_sequence_or_nil/number/integer",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 23 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_sequence_or_nil/number/float",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 2.3 },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_sequence_or_nil/string",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = "test" },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_sequence_or_nil/function",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = function() end },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_sequence_or_nil/table/empty",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = {} },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence_or_nil/table/sequence",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = {"one", "two"} },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence_or_nil/table/sequence/value_checker/true",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_string,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence_or_nil/table/sequence/value_checker/false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_number,
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_sequence_or_nil/table/not_sequence/not_integer_indices",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { one = 1, two = 2 } },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_sequence_or_nil/table/not_sequence/absent_indices",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { [1] = "one", [3] = "two" } },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_sequence_or_nil/table/not_sequence/indices_not_starting_with_one",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { [2] = "one", [3] = "two"} },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_sequence_or_nil/table/sequence/value_checker/true/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_string,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence_or_nil/table/sequence/value_checker/false/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_number,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence_or_nil/table/not_sequence/not_integer_indices/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { one = 1, two = 2 } },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence_or_nil/table/not_sequence/absent_indices/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { [1] = "one", [3] = "two" } },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence_or_nil/table/not_sequence/indices_not_starting_with_one/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { [2] = "one", [3] = "two"} },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence_or_nil/table/sequence/value_checker/true/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_string,
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence_or_nil/table/sequence/value_checker/false/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_number,
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence_or_nil/table/not_sequence/not_integer_indices/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence_or_nil/table/not_sequence/absent_indices/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { [1] = "one", [3] = "two" },
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence_or_nil/table/not_sequence/indices_not_starting_with_one/without_deep_checks/via_parameter",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { [2] = "one", [3] = "two"},
      deep_checks_mode = "without_deep_checks",
    },
    want = _assert_no_error,
  },
}) do
  TestAssertions[data.name] = function()
    local previous_global_deep_checks_mode = checks.get_global_deep_checks_mode()
    checks.set_global_deep_checks_mode(data.global_deep_checks_mode)

    data.want(
      assertions.is_sequence_or_nil,
      data.args.value,
      data.args.value_checker,
      data.args.deep_checks_mode
    )

    checks.set_global_deep_checks_mode(previous_global_deep_checks_mode)
  end
end

-- assertions.is_enumeration()
for _, data in ipairs({
  {
    name = "test_is_enumeration/nil",
    args = {
      value = nil,
      enumeration = {},
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_enumeration/boolean",
    args = {
      value = true,
      enumeration = {},
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_enumeration/number/integer/true",
    args = {
      value = 12,
      enumeration = {5, 12},
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_enumeration/number/integer/false",
    args = {
      value = 23,
      enumeration = {5, 12},
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_enumeration/number/float",
    args = {
      value = 2.3,
      enumeration = {},
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_enumeration/string/true",
    args = {
      value = "two",
      enumeration = {"one", "two"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_enumeration/string/false",
    args = {
      value = "three",
      enumeration = {"one", "two"},
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_enumeration/function",
    args = {
      value = function() end,
      enumeration = {},
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_enumeration/table",
    args = {
      value = {},
      enumeration = {},
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_enumeration/table/__eq_metamethod/true",
    args = {
      value = Object:new(12),
      enumeration = {Object:new(5), Object:new(12)},
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_enumeration/table/__eq_metamethod/false",
    args = {
      value = Object:new(23),
      enumeration = {Object:new(5), Object:new(12)},
    },
    want = luaunit.assert_error,
  },
}) do
  TestAssertions[data.name] = function()
    data.want(
      assertions.is_enumeration,
      data.args.value,
      data.args.enumeration
    )
  end
end

-- assertions.is_enumeration_or_nil()
for _, data in ipairs({
  {
    name = "test_is_enumeration_or_nil/nil",
    args = {
      value = nil,
      enumeration = {},
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_enumeration_or_nil/boolean",
    args = {
      value = true,
      enumeration = {},
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_enumeration_or_nil/number/integer/true",
    args = {
      value = 12,
      enumeration = {5, 12},
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_enumeration_or_nil/number/integer/false",
    args = {
      value = 23,
      enumeration = {5, 12},
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_enumeration_or_nil/number/float",
    args = {
      value = 2.3,
      enumeration = {},
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_enumeration_or_nil/string/true",
    args = {
      value = "two",
      enumeration = {"one", "two"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_enumeration_or_nil/string/false",
    args = {
      value = "three",
      enumeration = {"one", "two"},
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_enumeration_or_nil/function",
    args = {
      value = function() end,
      enumeration = {},
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_enumeration_or_nil/table",
    args = {
      value = {},
      enumeration = {},
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_enumeration_or_nil/table/__eq_metamethod/true",
    args = {
      value = Object:new(12),
      enumeration = {Object:new(5), Object:new(12)},
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_enumeration_or_nil/table/__eq_metamethod/false",
    args = {
      value = Object:new(23),
      enumeration = {Object:new(5), Object:new(12)},
    },
    want = luaunit.assert_error,
  },
}) do
  TestAssertions[data.name] = function()
    data.want(
      assertions.is_enumeration_or_nil,
      data.args.value,
      data.args.enumeration
    )
  end
end

-- assertions.is_instance()
for _, data in ipairs({
  {
    name = "test_is_instance/nil",
    args = {
      value = nil,
      class = MiddleclassObject,
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_instance/boolean",
    args = {
      value = true,
      class = MiddleclassObject,
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_instance/number/integer",
    args = {
      value = 23,
      class = MiddleclassObject,
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_instance/number/float",
    args = {
      value = 2.3,
      class = MiddleclassObject,
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_instance/string",
    args = {
      value = "test",
      class = MiddleclassObject,
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_instance/function",
    args = {
      value = function() end,
      class = MiddleclassObject,
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_instance/table",
    args = {
      value = {},
      class = MiddleclassObject,
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_instance/table/middleclass_object/directly",
    args = {
      value = MiddleclassObject:new(),
      class = MiddleclassObject,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_instance/table/middleclass_object/through_inheritance",
    args = {
      value = MiddleclassObject:new(),
      class = MiddleclassBaseObject,
    },
    want = _assert_no_error,
  },
}) do
  TestAssertions[data.name] = function()
    data.want(
      assertions.is_instance,
      data.args.value,
      data.args.class
    )
  end
end

-- assertions.is_instance_or_nil()
for _, data in ipairs({
  {
    name = "test_is_instance_or_nil/nil",
    args = {
      value = nil,
      class = MiddleclassObject,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_instance_or_nil/boolean",
    args = {
      value = true,
      class = MiddleclassObject,
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_instance_or_nil/number/integer",
    args = {
      value = 23,
      class = MiddleclassObject,
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_instance_or_nil/number/float",
    args = {
      value = 2.3,
      class = MiddleclassObject,
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_instance_or_nil/string",
    args = {
      value = "test",
      class = MiddleclassObject,
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_instance_or_nil/function",
    args = {
      value = function() end,
      class = MiddleclassObject,
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_instance_or_nil/table",
    args = {
      value = {},
      class = MiddleclassObject,
    },
    want = luaunit.assert_error,
  },
  {
    name = "test_is_instance_or_nil/table/middleclass_object/directly",
    args = {
      value = MiddleclassObject:new(),
      class = MiddleclassObject,
    },
    want = _assert_no_error,
  },
  {
    name = "test_is_instance_or_nil/table/middleclass_object/through_inheritance",
    args = {
      value = MiddleclassObject:new(),
      class = MiddleclassBaseObject,
    },
    want = _assert_no_error,
  },
}) do
  TestAssertions[data.name] = function()
    data.want(
      assertions.is_instance_or_nil,
      data.args.value,
      data.args.class
    )
  end
end