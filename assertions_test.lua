local luaunit = require("luaunit")
local checks = require("luatypechecks.checks")
local assertions = require("luatypechecks.assertions")
local middleclass = require("middleclass")

local function _assert_no_error(test_function, ...)
  test_function(...)
end

local function _assert_error(test_function, ...)
  luaunit.assert_error_msg_matches(
    "^.+/luatypechecks/assertions_test.lua:%d+: assertion failed!$",
    -- we should wrap the call in a function
    -- to properly capture an error stack trace
    function(...) test_function(...) end,
    ...
  )
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

local MiddleclassObject = middleclass(
  "MiddleclassObject",
  MiddleclassBaseObject
)

-- luacheck: globals TestAssertions
TestAssertions = {}

-- assertions.set_assertions_mode()
for _, data in ipairs({
  {
    name = "test_set_assertions_mode/with_assertions",
    args = { value = "with_assertions" },
    want = "with_assertions",
  },
  {
    name = "test_set_assertions_mode/without_assertions",
    args = { value = "without_assertions" },
    want = "without_assertions",
  },
}) do
  TestAssertions[data.name] = function()
    local previous_assertions_mode = assertions.get_assertions_mode()
    assertions.set_assertions_mode(data.args.value)

    local result = assertions.get_assertions_mode()
    luaunit.assert_is_string(result)
    luaunit.assert_equals(result, data.want)

    assertions.set_assertions_mode(previous_assertions_mode)
  end
end

-- assertions.is_deep_checks_mode()
for _, data in ipairs({
  {
    name = "test_is_deep_checks_mode/nil",
    args = { value = nil },
    want = _assert_error,
  },
  {
    name = "test_is_deep_checks_mode/boolean",
    args = { value = true },
    want = _assert_error,
  },
  {
    name = "test_is_deep_checks_mode/number/integer",
    args = { value = 23 },
    want = _assert_error,
  },
  {
    name = "test_is_deep_checks_mode/number/float",
    args = { value = 2.3 },
    want = _assert_error,
  },
  {
    name = "test_is_deep_checks_mode/string",
    args = { value = "test" },
    want = _assert_error,
  },
  {
    name = "test_is_deep_checks_mode"
      .. "/string"
      .. "/deep_checks_mode/without_deep_checks",
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
    want = _assert_error,
  },
  {
    name = "test_is_deep_checks_mode/table",
    args = { value = {} },
    want = _assert_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(assertions.is_deep_checks_mode, data.args.value)

      assertions.set_assertions_mode(previous_assertions_mode)
    end
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
    want = _assert_error,
  },
  {
    name = "test_is_deep_checks_mode_or_nil/number/integer",
    args = { value = 23 },
    want = _assert_error,
  },
  {
    name = "test_is_deep_checks_mode_or_nil/number/float",
    args = { value = 2.3 },
    want = _assert_error,
  },
  {
    name = "test_is_deep_checks_mode_or_nil/string",
    args = { value = "test" },
    want = _assert_error,
  },
  {
    name = "test_is_deep_checks_mode_or_nil"
      .. "/string"
      .. "/deep_checks_mode/without_deep_checks",
    args = { value = "without_deep_checks" },
    want = _assert_no_error,
  },
  {
    name = "test_is_deep_checks_mode_or_nil"
      .. "/string"
      .. "/deep_checks_mode/with_deep_checks",
    args = { value = "with_deep_checks" },
    want = _assert_no_error,
  },
  {
    name = "test_is_deep_checks_mode_or_nil/function",
    args = { value = function() end },
    want = _assert_error,
  },
  {
    name = "test_is_deep_checks_mode_or_nil/table",
    args = { value = {} },
    want = _assert_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(assertions.is_deep_checks_mode_or_nil, data.args.value)

      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end

-- assertions.is_assertions_mode()
for _, data in ipairs({
  {
    name = "test_is_assertions_mode/nil",
    args = { value = nil },
    want = _assert_error,
  },
  {
    name = "test_is_assertions_mode/boolean",
    args = { value = true },
    want = _assert_error,
  },
  {
    name = "test_is_assertions_mode/number/integer",
    args = { value = 23 },
    want = _assert_error,
  },
  {
    name = "test_is_assertions_mode/number/float",
    args = { value = 2.3 },
    want = _assert_error,
  },
  {
    name = "test_is_assertions_mode/string",
    args = { value = "test" },
    want = _assert_error,
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
    want = _assert_error,
  },
  {
    name = "test_is_assertions_mode/table",
    args = { value = {} },
    want = _assert_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(assertions.is_assertions_mode, data.args.value)

      assertions.set_assertions_mode(previous_assertions_mode)
    end
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
    want = _assert_error,
  },
  {
    name = "test_is_assertions_mode_or_nil/number/integer",
    args = { value = 23 },
    want = _assert_error,
  },
  {
    name = "test_is_assertions_mode_or_nil/number/float",
    args = { value = 2.3 },
    want = _assert_error,
  },
  {
    name = "test_is_assertions_mode_or_nil/string",
    args = { value = "test" },
    want = _assert_error,
  },
  {
    name = "test_is_assertions_mode_or_nil"
      .. "/string"
      .. "/assertions_mode/without_assertions",
    args = { value = "without_assertions" },
    want = _assert_no_error,
  },
  {
    name = "test_is_assertions_mode_or_nil"
      .. "/string"
      .. "/assertions_mode/with_assertions",
    args = { value = "with_assertions" },
    want = _assert_no_error,
  },
  {
    name = "test_is_assertions_mode_or_nil/function",
    args = { value = function() end },
    want = _assert_error,
  },
  {
    name = "test_is_assertions_mode_or_nil/table",
    args = { value = {} },
    want = _assert_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(assertions.is_assertions_mode_or_nil, data.args.value)

      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end

-- assertions.is_true()
for _, data in ipairs({
  {
    name = "test_is_true/false",
    args = { value = false },
    want = _assert_error,
  },
  {
    name = "test_is_true/true",
    args = { value = true },
    want = _assert_no_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(assertions.is_true, data.args.value)

      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end

-- assertions.is_false()
for _, data in ipairs({
  {
    name = "test_is_false/false",
    args = { value = false },
    want = _assert_no_error,
  },
  {
    name = "test_is_false/true",
    args = { value = true },
    want = _assert_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(assertions.is_false, data.args.value)

      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end

-- assertions.is_boolean()
for _, data in ipairs({
  {
    name = "test_is_boolean/nil",
    args = { value = nil },
    want = _assert_error,
  },
  {
    name = "test_is_boolean/boolean",
    args = { value = true },
    want = _assert_no_error,
  },
  {
    name = "test_is_boolean/number/integer",
    args = { value = 23 },
    want = _assert_error,
  },
  {
    name = "test_is_boolean/number/float",
    args = { value = 2.3 },
    want = _assert_error,
  },
  {
    name = "test_is_boolean/string",
    args = { value = "test" },
    want = _assert_error,
  },
  {
    name = "test_is_boolean/function",
    args = { value = function() end },
    want = _assert_error,
  },
  {
    name = "test_is_boolean/table",
    args = { value = {} },
    want = _assert_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(assertions.is_boolean, data.args.value)

      assertions.set_assertions_mode(previous_assertions_mode)
    end
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
    want = _assert_error,
  },
  {
    name = "test_is_boolean_or_nil/number/float",
    args = { value = 2.3 },
    want = _assert_error,
  },
  {
    name = "test_is_boolean_or_nil/string",
    args = { value = "test" },
    want = _assert_error,
  },
  {
    name = "test_is_boolean_or_nil/function",
    args = { value = function() end },
    want = _assert_error,
  },
  {
    name = "test_is_boolean_or_nil/table",
    args = { value = {} },
    want = _assert_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(assertions.is_boolean_or_nil, data.args.value)

      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end

-- assertions.is_number()
for _, data in ipairs({
  {
    name = "test_is_number/nil",
    args = { value = nil },
    want = _assert_error,
  },
  {
    name = "test_is_number/boolean",
    args = { value = true },
    want = _assert_error,
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
    want = _assert_error,
  },
  {
    name = "test_is_number/function",
    args = { value = function() end },
    want = _assert_error,
  },
  {
    name = "test_is_number/table",
    args = { value = {} },
    want = _assert_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(assertions.is_number, data.args.value)

      assertions.set_assertions_mode(previous_assertions_mode)
    end
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
    want = _assert_error,
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
    want = _assert_error,
  },
  {
    name = "test_is_number_or_nil/function",
    args = { value = function() end },
    want = _assert_error,
  },
  {
    name = "test_is_number_or_nil/table",
    args = { value = {} },
    want = _assert_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(assertions.is_number_or_nil, data.args.value)

      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end

-- assertions.is_integer()
for _, data in ipairs({
  {
    name = "test_is_integer/nil",
    args = { value = nil },
    want = _assert_error,
  },
  {
    name = "test_is_integer/boolean",
    args = { value = true },
    want = _assert_error,
  },
  {
    name = "test_is_integer/number/integer",
    args = { value = 23 },
    want = _assert_no_error,
  },
  {
    name = "test_is_integer/number/float",
    args = { value = 2.3 },
    want = _assert_error,
  },
  {
    name = "test_is_integer/string",
    args = { value = "test" },
    want = _assert_error,
  },
  {
    name = "test_is_integer/function",
    args = { value = function() end },
    want = _assert_error,
  },
  {
    name = "test_is_integer/table",
    args = { value = {} },
    want = _assert_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(assertions.is_integer, data.args.value)

      assertions.set_assertions_mode(previous_assertions_mode)
    end
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
    want = _assert_error,
  },
  {
    name = "test_is_integer_or_nil/number/integer",
    args = { value = 23 },
    want = _assert_no_error,
  },
  {
    name = "test_is_integer_or_nil/number/float",
    args = { value = 2.3 },
    want = _assert_error,
  },
  {
    name = "test_is_integer_or_nil/string",
    args = { value = "test" },
    want = _assert_error,
  },
  {
    name = "test_is_integer_or_nil/function",
    args = { value = function() end },
    want = _assert_error,
  },
  {
    name = "test_is_integer_or_nil/table",
    args = { value = {} },
    want = _assert_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(assertions.is_integer_or_nil, data.args.value)

      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end

-- assertions.is_string()
for _, data in ipairs({
  {
    name = "test_is_string/nil",
    args = { value = nil },
    want = _assert_error,
  },
  {
    name = "test_is_string/boolean",
    args = { value = true },
    want = _assert_error,
  },
  {
    name = "test_is_string/number/integer",
    args = { value = 23 },
    want = _assert_error,
  },
  {
    name = "test_is_string/number/float",
    args = { value = 2.3 },
    want = _assert_error,
  },
  {
    name = "test_is_string/string",
    args = { value = "test" },
    want = _assert_no_error,
  },
  {
    name = "test_is_string/function",
    args = { value = function() end },
    want = _assert_error,
  },
  {
    name = "test_is_string/table",
    args = { value = {} },
    want = _assert_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(assertions.is_string, data.args.value)

      assertions.set_assertions_mode(previous_assertions_mode)
    end
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
    want = _assert_error,
  },
  {
    name = "test_is_string_or_nil/number/integer",
    args = { value = 23 },
    want = _assert_error,
  },
  {
    name = "test_is_string_or_nil/number/float",
    args = { value = 2.3 },
    want = _assert_error,
  },
  {
    name = "test_is_string_or_nil/string",
    args = { value = "test" },
    want = _assert_no_error,
  },
  {
    name = "test_is_string_or_nil/function",
    args = { value = function() end },
    want = _assert_error,
  },
  {
    name = "test_is_string_or_nil/table",
    args = { value = {} },
    want = _assert_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(assertions.is_string_or_nil, data.args.value)

      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end

-- assertions.is_function()
for _, data in ipairs({
  {
    name = "test_is_function/nil",
    args = { value = nil },
    want = _assert_error,
  },
  {
    name = "test_is_function/boolean",
    args = { value = true },
    want = _assert_error,
  },
  {
    name = "test_is_function/number/integer",
    args = { value = 23 },
    want = _assert_error,
  },
  {
    name = "test_is_function/number/float",
    args = { value = 2.3 },
    want = _assert_error,
  },
  {
    name = "test_is_function/string",
    args = { value = "test" },
    want = _assert_error,
  },
  {
    name = "test_is_function/function",
    args = { value = function() end },
    want = _assert_no_error,
  },
  {
    name = "test_is_function/table",
    args = { value = {} },
    want = _assert_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(assertions.is_function, data.args.value)

      assertions.set_assertions_mode(previous_assertions_mode)
    end
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
    want = _assert_error,
  },
  {
    name = "test_is_function_or_nil/number/integer",
    args = { value = 23 },
    want = _assert_error,
  },
  {
    name = "test_is_function_or_nil/number/float",
    args = { value = 2.3 },
    want = _assert_error,
  },
  {
    name = "test_is_function_or_nil/string",
    args = { value = "test" },
    want = _assert_error,
  },
  {
    name = "test_is_function_or_nil/function",
    args = { value = function() end },
    want = _assert_no_error,
  },
  {
    name = "test_is_function_or_nil/table",
    args = { value = {} },
    want = _assert_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(assertions.is_function_or_nil, data.args.value)

      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end

-- assertions.is_callable()
for _, data in ipairs({
  {
    name = "test_is_callable/nil",
    args = { value = nil },
    want = _assert_error,
  },
  {
    name = "test_is_callable/boolean",
    args = { value = true },
    want = _assert_error,
  },
  {
    name = "test_is_callable/number/integer",
    args = { value = 23 },
    want = _assert_error,
  },
  {
    name = "test_is_callable/number/float",
    args = { value = 2.3 },
    want = _assert_error,
  },
  {
    name = "test_is_callable/string",
    args = { value = "test" },
    want = _assert_error,
  },
  {
    name = "test_is_callable/function",
    args = { value = function() end },
    want = _assert_no_error,
  },
  {
    name = "test_is_callable/table",
    args = { value = {} },
    want = _assert_error,
  },
  {
    name = "test_is_callable/table/__call_metamethod/function",
    args = { value = Object:new(23) },
    want = _assert_no_error,
  },
  {
    name = "test_is_callable/table/__call_metamethod/table",
    args = {
      value = setmetatable({}, { __call = Object:new(23) }),
    },
    want = _assert_no_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(assertions.is_callable, data.args.value)

      assertions.set_assertions_mode(previous_assertions_mode)
    end
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
    want = _assert_error,
  },
  {
    name = "test_is_callable_or_nil/number/integer",
    args = { value = 23 },
    want = _assert_error,
  },
  {
    name = "test_is_callable_or_nil/number/float",
    args = { value = 2.3 },
    want = _assert_error,
  },
  {
    name = "test_is_callable_or_nil/string",
    args = { value = "test" },
    want = _assert_error,
  },
  {
    name = "test_is_callable_or_nil/function",
    args = { value = function() end },
    want = _assert_no_error,
  },
  {
    name = "test_is_callable_or_nil/table",
    args = { value = {} },
    want = _assert_error,
  },
  {
    name = "test_is_callable_or_nil/table/__call_metamethod/function",
    args = { value = Object:new(23) },
    want = _assert_no_error,
  },
  {
    name = "test_is_callable_or_nil/table/__call_metamethod/table",
    args = {
      value = setmetatable({}, { __call = Object:new(23) }),
    },
    want = _assert_no_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(assertions.is_callable_or_nil, data.args.value)

      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end

-- assertions.is_table()
for _, data in ipairs({
  {
    name = "test_is_table/nil",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = nil },
    want = _assert_error,
  },
  {
    name = "test_is_table/boolean",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = true },
    want = _assert_error,
  },
  {
    name = "test_is_table/number/integer",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 23 },
    want = _assert_error,
  },
  {
    name = "test_is_table/number/float",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 2.3 },
    want = _assert_error,
  },
  {
    name = "test_is_table/string",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = "test" },
    want = _assert_error,
  },
  {
    name = "test_is_table/function",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = function() end },
    want = _assert_error,
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
    want = _assert_error,
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
    want = _assert_error,
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
    want = _assert_error,
  },
  {
    name = "test_is_table/table/key_and_value_checkers/value_checker_false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_boolean,
    },
    want = _assert_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local previous_global_deep_checks_mode =
        checks.get_global_deep_checks_mode()
      checks.set_global_deep_checks_mode(data.global_deep_checks_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(
        assertions.is_table,
        data.args.value,
        data.args.key_checker,
        data.args.value_checker,
        data.args.deep_checks_mode
      )

      checks.set_global_deep_checks_mode(previous_global_deep_checks_mode)
      assertions.set_assertions_mode(previous_assertions_mode)
    end
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
    want = _assert_error,
  },
  {
    name = "test_is_table_or_nil/number/integer",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 23 },
    want = _assert_error,
  },
  {
    name = "test_is_table_or_nil/number/float",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 2.3 },
    want = _assert_error,
  },
  {
    name = "test_is_table_or_nil/string",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = "test" },
    want = _assert_error,
  },
  {
    name = "test_is_table_or_nil/function",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = function() end },
    want = _assert_error,
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
    want = _assert_error,
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
    want = _assert_error,
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
    name = "test_is_table_or_nil"
      .. "/table"
      .. "/key_and_value_checkers/key_checker_false",
    global_deep_checks_mode = "with_deep_checks",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_boolean,
      value_checker = checks.is_number,
    },
    want = _assert_error,
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
    want = _assert_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local previous_global_deep_checks_mode =
        checks.get_global_deep_checks_mode()
      checks.set_global_deep_checks_mode(data.global_deep_checks_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(
        assertions.is_table_or_nil,
        data.args.value,
        data.args.key_checker,
        data.args.value_checker,
        data.args.deep_checks_mode
      )

      checks.set_global_deep_checks_mode(previous_global_deep_checks_mode)
      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end

-- assertions.is_sequence()
for _, data in ipairs({
  {
    name = "test_is_sequence/nil",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = nil },
    want = _assert_error,
  },
  {
    name = "test_is_sequence/boolean",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = true },
    want = _assert_error,
  },
  {
    name = "test_is_sequence/number/integer",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 23 },
    want = _assert_error,
  },
  {
    name = "test_is_sequence/number/float",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 2.3 },
    want = _assert_error,
  },
  {
    name = "test_is_sequence/string",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = "test" },
    want = _assert_error,
  },
  {
    name = "test_is_sequence/function",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = function() end },
    want = _assert_error,
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
    want = _assert_error,
  },
  {
    name = "test_is_sequence/table/not_sequence/not_integer_indices",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { one = 1, two = 2 } },
    want = _assert_error,
  },
  {
    name = "test_is_sequence/table/not_sequence/absent_indices",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { [1] = "one", [3] = "two" } },
    want = _assert_error,
  },
  {
    name = "test_is_sequence/table/not_sequence/indices_not_starting_with_one",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { [2] = "one", [3] = "two"} },
    want = _assert_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence"
      .. "/table/not_sequence"
      .. "/not_integer_indices"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { one = 1, two = 2 } },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence"
      .. "/table/not_sequence"
      .. "/absent_indices"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { [1] = "one", [3] = "two" } },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence"
      .. "/table/not_sequence"
      .. "/indices_not_starting_with_one"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { [2] = "one", [3] = "two"} },
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local previous_global_deep_checks_mode =
        checks.get_global_deep_checks_mode()
      checks.set_global_deep_checks_mode(data.global_deep_checks_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(
        assertions.is_sequence,
        data.args.value,
        data.args.value_checker,
        data.args.deep_checks_mode
      )

      checks.set_global_deep_checks_mode(previous_global_deep_checks_mode)
      assertions.set_assertions_mode(previous_assertions_mode)
    end
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
    want = _assert_error,
  },
  {
    name = "test_is_sequence_or_nil/number/integer",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 23 },
    want = _assert_error,
  },
  {
    name = "test_is_sequence_or_nil/number/float",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = 2.3 },
    want = _assert_error,
  },
  {
    name = "test_is_sequence_or_nil/string",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = "test" },
    want = _assert_error,
  },
  {
    name = "test_is_sequence_or_nil/function",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = function() end },
    want = _assert_error,
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
    want = _assert_error,
  },
  {
    name = "test_is_sequence_or_nil/table/not_sequence/not_integer_indices",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { one = 1, two = 2 } },
    want = _assert_error,
  },
  {
    name = "test_is_sequence_or_nil/table/not_sequence/absent_indices",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { [1] = "one", [3] = "two" } },
    want = _assert_error,
  },
  {
    name = "test_is_sequence_or_nil"
      .. "/table/not_sequence"
      .. "/indices_not_starting_with_one",
    global_deep_checks_mode = "with_deep_checks",
    args = { value = { [2] = "one", [3] = "two"} },
    want = _assert_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence_or_nil"
      .. "/table/not_sequence"
      .. "/not_integer_indices"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { one = 1, two = 2 } },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence_or_nil"
      .. "/table/not_sequence"
      .. "/absent_indices"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { [1] = "one", [3] = "two" } },
    want = _assert_no_error,
  },
  {
    name = "test_is_sequence_or_nil"
      .. "/table/not_sequence"
      .. "/indices_not_starting_with_one"
      .. "/without_deep_checks",
    global_deep_checks_mode = "without_deep_checks",
    args = { value = { [2] = "one", [3] = "two"} },
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local previous_global_deep_checks_mode =
        checks.get_global_deep_checks_mode()
      checks.set_global_deep_checks_mode(data.global_deep_checks_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(
        assertions.is_sequence_or_nil,
        data.args.value,
        data.args.value_checker,
        data.args.deep_checks_mode
      )

      checks.set_global_deep_checks_mode(previous_global_deep_checks_mode)
      assertions.set_assertions_mode(previous_assertions_mode)
    end
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
    want = _assert_error,
  },
  {
    name = "test_is_enumeration/boolean",
    args = {
      value = true,
      enumeration = {},
    },
    want = _assert_error,
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
    want = _assert_error,
  },
  {
    name = "test_is_enumeration/number/float",
    args = {
      value = 2.3,
      enumeration = {},
    },
    want = _assert_error,
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
    want = _assert_error,
  },
  {
    name = "test_is_enumeration/function",
    args = {
      value = function() end,
      enumeration = {},
    },
    want = _assert_error,
  },
  {
    name = "test_is_enumeration/table",
    args = {
      value = {},
      enumeration = {},
    },
    want = _assert_error,
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
    want = _assert_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(
        assertions.is_enumeration,
        data.args.value,
        data.args.enumeration
      )

      assertions.set_assertions_mode(previous_assertions_mode)
    end
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
    want = _assert_error,
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
    want = _assert_error,
  },
  {
    name = "test_is_enumeration_or_nil/number/float",
    args = {
      value = 2.3,
      enumeration = {},
    },
    want = _assert_error,
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
    want = _assert_error,
  },
  {
    name = "test_is_enumeration_or_nil/function",
    args = {
      value = function() end,
      enumeration = {},
    },
    want = _assert_error,
  },
  {
    name = "test_is_enumeration_or_nil/table",
    args = {
      value = {},
      enumeration = {},
    },
    want = _assert_error,
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
    want = _assert_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(
        assertions.is_enumeration_or_nil,
        data.args.value,
        data.args.enumeration
      )

      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end

-- assertions.has_metaproperties()
for _, data in ipairs({
  {
    name = "test_has_metaproperties/nil",
    args = {
      value = nil,
      metaproperty_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metaproperties/boolean",
    args = {
      value = true,
      metaproperty_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metaproperties/number/integer",
    args = {
      value = 23,
      metaproperty_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metaproperties/number/float",
    args = {
      value = 2.3,
      metaproperty_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metaproperties/string",
    args = {
      value = "test",
      metaproperty_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metaproperties/function",
    args = {
      value = function() end,
      metaproperty_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metaproperties/table/without_metatable",
    args = {
      value = {},
      metaproperty_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metaproperties/table/without_metaproperties",
    args = {
      value = setmetatable({}, {}),
      metaproperty_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metaproperties"
      .. "/table"
      .. "/with_metaproperties/with_non-callable_values",
    args = {
      value = setmetatable({}, {
        __one = 23,
        __two = 42,
      }),
      metaproperty_names = {"__one", "__two"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_metaproperties"
      .. "/table"
      .. "/with_metaproperties/with_callable_values/functions",
    args = {
      value = Object:new(23),
      metaproperty_names = {"__eq", "__call"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_metaproperties"
      .. "/table"
      .. "/with_metaproperties/with_callable_values/tables",
    args = {
      value = setmetatable({}, {
        __eq = Object:new(23),
        __call = Object:new(42),
      }),
      metaproperty_names = {"__eq", "__call"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_metaproperties/table/with_missed_metaproperties/all",
    args = {
      value = Object:new(23),
      metaproperty_names = {"__add", "__sub"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metaproperties/table/with_missed_metaproperties/some",
    args = {
      value = Object:new(23),
      metaproperty_names = {"__eq", "__add"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metaproperties"
      .. "/table"
      .. "/with_metaproperties"
      .. "/with_request_for_empty_set",
    args = {
      value = Object:new(23),
      metaproperty_names = {},
    },
    want = _assert_no_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(
        assertions.has_metaproperties,
        data.args.value,
        data.args.metaproperty_names
      )

      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end

-- assertions.has_metaproperties_or_is_nil()
for _, data in ipairs({
  {
    name = "test_has_metaproperties_or_is_nil/nil",
    args = {
      value = nil,
      metaproperty_names = {"one", "two"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_metaproperties_or_is_nil/boolean",
    args = {
      value = true,
      metaproperty_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metaproperties_or_is_nil/number/integer",
    args = {
      value = 23,
      metaproperty_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metaproperties_or_is_nil/number/float",
    args = {
      value = 2.3,
      metaproperty_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metaproperties_or_is_nil/string",
    args = {
      value = "test",
      metaproperty_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metaproperties_or_is_nil/function",
    args = {
      value = function() end,
      metaproperty_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metaproperties_or_is_nil/table/without_metatable",
    args = {
      value = {},
      metaproperty_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metaproperties_or_is_nil/table/without_metaproperties",
    args = {
      value = setmetatable({}, {}),
      metaproperty_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metaproperties_or_is_nil"
      .. "/table"
      .. "/with_metaproperties/with_non-callable_values",
    args = {
      value = setmetatable({}, {
        __one = 23,
        __two = 42,
      }),
      metaproperty_names = {"__one", "__two"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_metaproperties_or_is_nil"
      .. "/table"
      .. "/with_metaproperties/with_callable_values/functions",
    args = {
      value = Object:new(23),
      metaproperty_names = {"__eq", "__call"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_metaproperties_or_is_nil"
      .. "/table"
      .. "/with_metaproperties/with_callable_values/tables",
    args = {
      value = setmetatable({}, {
        __eq = Object:new(23),
        __call = Object:new(42),
      }),
      metaproperty_names = {"__eq", "__call"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_metaproperties_or_is_nil"
      .. "/table"
      .. "/with_missed_metaproperties/all",
    args = {
      value = Object:new(23),
      metaproperty_names = {"__add", "__sub"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metaproperties_or_is_nil"
      .. "/table"
      .. "/with_missed_metaproperties/some",
    args = {
      value = Object:new(23),
      metaproperty_names = {"__eq", "__add"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metaproperties_or_is_nil"
      .. "/table"
      .. "/with_metaproperties"
      .. "/with_request_for_empty_set",
    args = {
      value = Object:new(23),
      metaproperty_names = {},
    },
    want = _assert_no_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(
        assertions.has_metaproperties_or_is_nil,
        data.args.value,
        data.args.metaproperty_names
      )

      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end

-- assertions.has_properties()
for _, data in ipairs({
  {
    name = "test_has_properties/nil",
    args = {
      value = nil,
      property_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties/boolean",
    args = {
      value = true,
      property_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties/number/integer",
    args = {
      value = 23,
      property_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties/number/float",
    args = {
      value = 2.3,
      property_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties/string",
    args = {
      value = "test",
      property_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties/function",
    args = {
      value = function() end,
      property_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties/table/empty",
    args = {
      value = {},
      property_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties/table/with_non-callable_values",
    args = {
      value = { one = 23, two = 42 },
      property_names = {"one", "two"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_properties/table/with_callable_values/functions",
    args = {
      value = {
        one = function() end,
        two = function() end,
      },
      property_names = {"one", "two"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_properties/table/with_callable_values/tables",
    args = {
      value = {
        one = Object:new(23),
        two = Object:new(42),
      },
      property_names = {"one", "two"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_properties"
      .. "/table"
      .. "/with_metaproperties/with_non-callable_values",
    args = {
      value = setmetatable({}, {
        __one = 23,
        __two = 42,
      }),
      property_names = {"__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties"
      .. "/table"
      .. "/with_metaproperties/with_callable_values/functions",
    args = {
      value = Object:new(23),
      property_names = {"__eq", "__call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties"
      .. "/table"
      .. "/with_metaproperties/with_callable_values/tables",
    args = {
      value = setmetatable({}, {
        __eq = Object:new(23),
        __call = Object:new(42),
      }),
      property_names = {"__eq", "__call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties/table/with_missed_properties/all",
    args = {
      value = {
        three = function() end,
        four = function() end,
      },
      property_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties/table/with_missed_properties/some",
    args = {
      value = {
        one = function() end,
        three = function() end,
      },
      property_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties"
      .. "/table"
      .. "/with_properties"
      .. "/with_request_for_empty_set",
    args = {
      value = {
        one = function() end,
        two = function() end,
      },
      property_names = {},
    },
    want = _assert_no_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(
        assertions.has_properties,
        data.args.value,
        data.args.property_names
      )

      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end

-- assertions.has_properties_or_is_nil()
for _, data in ipairs({
  {
    name = "test_has_properties_or_is_nil/nil",
    args = {
      value = nil,
      property_names = {"one", "two"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_properties_or_is_nil/boolean",
    args = {
      value = true,
      property_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_or_is_nil/number/integer",
    args = {
      value = 23,
      property_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_or_is_nil/number/float",
    args = {
      value = 2.3,
      property_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_or_is_nil/string",
    args = {
      value = "test",
      property_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_or_is_nil/function",
    args = {
      value = function() end,
      property_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_or_is_nil/table/empty",
    args = {
      value = {},
      property_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_or_is_nil/table/with_non-callable_values",
    args = {
      value = { one = 23, two = 42 },
      property_names = {"one", "two"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_properties_or_is_nil/table/with_callable_values/functions",
    args = {
      value = {
        one = function() end,
        two = function() end,
      },
      property_names = {"one", "two"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_properties_or_is_nil/table/with_callable_values/tables",
    args = {
      value = {
        one = Object:new(23),
        two = Object:new(42),
      },
      property_names = {"one", "two"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_properties_or_is_nil"
      .. "/table"
      .. "/with_metaproperties/with_non-callable_values",
    args = {
      value = setmetatable({}, {
        __one = 23,
        __two = 42,
      }),
      property_names = {"__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_or_is_nil"
      .. "/table"
      .. "/with_metaproperties/with_callable_values/functions",
    args = {
      value = Object:new(23),
      property_names = {"__eq", "__call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_or_is_nil"
      .. "/table"
      .. "/with_metaproperties/with_callable_values/tables",
    args = {
      value = setmetatable({}, {
        __eq = Object:new(23),
        __call = Object:new(42),
      }),
      property_names = {"__eq", "__call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_or_is_nil/table/with_missed_properties/all",
    args = {
      value = {
        three = function() end,
        four = function() end,
      },
      property_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_or_is_nil/table/with_missed_properties/some",
    args = {
      value = {
        one = function() end,
        three = function() end,
      },
      property_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_or_is_nil"
      .. "/table"
      .. "/with_properties"
      .. "/with_request_for_empty_set",
    args = {
      value = {
        one = function() end,
        two = function() end,
      },
      property_names = {},
    },
    want = _assert_no_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(
        assertions.has_properties_or_is_nil,
        data.args.value,
        data.args.property_names
      )

      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end

-- assertions.has_properties_anywhere()
for _, data in ipairs({
  {
    name = "test_has_properties_anywhere/nil",
    args = {
      value = nil,
      property_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere/boolean",
    args = {
      value = true,
      property_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere/number/integer",
    args = {
      value = 23,
      property_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere/number/float",
    args = {
      value = 2.3,
      property_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere/string",
    args = {
      value = "test",
      property_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere/function",
    args = {
      value = function() end,
      property_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere/table/empty",
    args = {
      value = {},
      property_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere/table/with_regular_properties",
    args = {
      value = {
        one = function() end,
        two = function() end,
      },
      property_names = {"one", "two"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_properties_anywhere"
      .. "/table"
      .. "/with_regular_properties/with_underscores",
    args = {
      value = {
        __one = function() end,
        __two = function() end,
      },
      property_names = {"__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere/table/with_regular_properties/missed",
    args = {
      value = {
        three = function() end,
        four = function() end,
      },
      property_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere/table/with_metaproperties",
    args = {
      value = setmetatable({}, {
        __eq = function() end,
        __call = function() end,
      }),
      property_names = {"__eq", "__call"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_properties_anywhere"
      .. "/table"
      .. "/with_metaproperties/without_underscores",
    args = {
      value = setmetatable({}, {
        eq = function() end,
        call = function() end,
      }),
      property_names = {"eq", "call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere/table/with_metaproperties/missed",
    args = {
      value = setmetatable({}, {
        __add = function() end,
        __sub = function() end,
      }),
      property_names = {"__eq", "__call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere/table/with_regular_and_metaproperties",
    args = {
      value = setmetatable(
        {
          one = function() end,
          two = function() end,
        },
        {
          __eq = function() end,
          __call = function() end,
        }
      ),
      property_names = {"one", "two", "__eq", "__call"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_properties_anywhere"
      .. "/table"
      .. "/with_regular_and_metaproperties/with_missed_regular_properties",
    args = {
      value = setmetatable(
        {
          three = function() end,
          four = function() end,
        },
        {
          __eq = function() end,
          __call = function() end,
        }
      ),
      property_names = {"one", "two", "__eq", "__call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere"
      .. "/table"
      .. "/with_regular_and_metaproperties/with_missed_metaproperties",
    args = {
      value = setmetatable(
        {
          one = function() end,
          two = function() end,
        },
        {
          __add = function() end,
          __sub = function() end,
        }
      ),
      property_names = {"one", "two", "__eq", "__call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere"
      .. "/table"
      .. "/with_regular_and_metaproperties/with_missed_all_properties",
    args = {
      value = setmetatable(
        {
          three = function() end,
          four = function() end,
        },
        {
          __add = function() end,
          __sub = function() end,
        }
      ),
      property_names = {"one", "two", "__eq", "__call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere"
      .. "/table"
      .. "/with_regular_and_metaproperties"
      .. "/with_request_for_empty_set",
    args = {
      value = setmetatable(
        {
          one = function() end,
          two = function() end,
        },
        {
          __eq = function() end,
          __call = function() end,
        }
      ),
      property_names = {},
    },
    want = _assert_no_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(
        assertions.has_properties_anywhere,
        data.args.value,
        data.args.property_names
      )

      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end

-- assertions.has_properties_anywhere_or_is_nil()
for _, data in ipairs({
  {
    name = "test_has_properties_anywhere_or_is_nil/nil",
    args = {
      value = nil,
      property_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_properties_anywhere_or_is_nil/boolean",
    args = {
      value = true,
      property_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere_or_is_nil/number/integer",
    args = {
      value = 23,
      property_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere_or_is_nil/number/float",
    args = {
      value = 2.3,
      property_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere_or_is_nil/string",
    args = {
      value = "test",
      property_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere_or_is_nil/function",
    args = {
      value = function() end,
      property_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere_or_is_nil/table/empty",
    args = {
      value = {},
      property_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere_or_is_nil"
      .. "/table"
      .. "/with_regular_properties",
    args = {
      value = {
        one = function() end,
        two = function() end,
      },
      property_names = {"one", "two"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_properties_anywhere_or_is_nil"
      .. "/table"
      .. "/with_regular_properties/with_underscores",
    args = {
      value = {
        __one = function() end,
        __two = function() end,
      },
      property_names = {"__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere_or_is_nil"
      .. "/table"
      .. "/with_regular_properties/missed",
    args = {
      value = {
        three = function() end,
        four = function() end,
      },
      property_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere_or_is_nil/table/with_metaproperties",
    args = {
      value = setmetatable({}, {
        __eq = function() end,
        __call = function() end,
      }),
      property_names = {"__eq", "__call"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_properties_anywhere_or_is_nil"
      .. "/table"
      .. "/with_metaproperties/without_underscores",
    args = {
      value = setmetatable({}, {
        eq = function() end,
        call = function() end,
      }),
      property_names = {"eq", "call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere_or_is_nil"
      .. "/table"
      .. "/with_metaproperties/missed",
    args = {
      value = setmetatable({}, {
        __add = function() end,
        __sub = function() end,
      }),
      property_names = {"__eq", "__call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere_or_is_nil"
      .. "/table"
      .. "/with_regular_and_metaproperties",
    args = {
      value = setmetatable(
        {
          one = function() end,
          two = function() end,
        },
        {
          __eq = function() end,
          __call = function() end,
        }
      ),
      property_names = {"one", "two", "__eq", "__call"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_properties_anywhere_or_is_nil"
      .. "/table"
      .. "/with_regular_and_metaproperties/with_missed_regular_properties",
    args = {
      value = setmetatable(
        {
          three = function() end,
          four = function() end,
        },
        {
          __eq = function() end,
          __call = function() end,
        }
      ),
      property_names = {"one", "two", "__eq", "__call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere_or_is_nil"
      .. "/table"
      .. "/with_regular_and_metaproperties/with_missed_metaproperties",
    args = {
      value = setmetatable(
        {
          one = function() end,
          two = function() end,
        },
        {
          __add = function() end,
          __sub = function() end,
        }
      ),
      property_names = {"one", "two", "__eq", "__call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere_or_is_nil"
      .. "/table"
      .. "/with_regular_and_metaproperties/with_missed_all_properties",
    args = {
      value = setmetatable(
        {
          three = function() end,
          four = function() end,
        },
        {
          __add = function() end,
          __sub = function() end,
        }
      ),
      property_names = {"one", "two", "__eq", "__call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_properties_anywhere_or_is_nil"
      .. "/table"
      .. "/with_regular_and_metaproperties"
      .. "/with_request_for_empty_set",
    args = {
      value = setmetatable(
        {
          one = function() end,
          two = function() end,
        },
        {
          __eq = function() end,
          __call = function() end,
        }
      ),
      property_names = {},
    },
    want = _assert_no_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(
        assertions.has_properties_anywhere_or_is_nil,
        data.args.value,
        data.args.property_names
      )

      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end

-- assertions.has_metamethods()
for _, data in ipairs({
  {
    name = "test_has_metamethods/nil",
    args = {
      value = nil,
      metamethod_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metamethods/boolean",
    args = {
      value = true,
      metamethod_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metamethods/number/integer",
    args = {
      value = 23,
      metamethod_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metamethods/number/float",
    args = {
      value = 2.3,
      metamethod_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metamethods/string",
    args = {
      value = "test",
      metamethod_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metamethods/function",
    args = {
      value = function() end,
      metamethod_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metamethods/table/without_metatable",
    args = {
      value = {},
      metamethod_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metamethods/table/without_metamethods",
    args = {
      value = setmetatable({}, {}),
      metamethod_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metamethods"
      .. "/table"
      .. "/with_metamethods/with_non-callable_values",
    args = {
      value = setmetatable({}, {
        __one = 23,
        __two = 42,
      }),
      metamethod_names = {"__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metamethods"
      .. "/table"
      .. "/with_metamethods/with_callable_values/functions",
    args = {
      value = Object:new(23),
      metamethod_names = {"__eq", "__call"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_metamethods"
      .. "/table"
      .. "/with_metamethods/with_callable_values/tables",
    args = {
      value = setmetatable({}, {
        __eq = Object:new(23),
        __call = Object:new(42),
      }),
      metamethod_names = {"__eq", "__call"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_metamethods/table/with_missed_metamethods/all",
    args = {
      value = Object:new(23),
      metamethod_names = {"__add", "__sub"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metamethods/table/with_missed_metamethods/some",
    args = {
      value = Object:new(23),
      metamethod_names = {"__eq", "__add"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metamethods"
      .. "/table"
      .. "/with_metamethods"
      .. "/with_request_for_empty_set",
    args = {
      value = Object:new(23),
      metamethod_names = {},
    },
    want = _assert_no_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(
        assertions.has_metamethods,
        data.args.value,
        data.args.metamethod_names
      )

      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end

-- assertions.has_metamethods_or_is_nil()
for _, data in ipairs({
  {
    name = "test_has_metamethods_or_is_nil/nil",
    args = {
      value = nil,
      metamethod_names = {"one", "two"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_metamethods_or_is_nil/boolean",
    args = {
      value = true,
      metamethod_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metamethods_or_is_nil/number/integer",
    args = {
      value = 23,
      metamethod_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metamethods_or_is_nil/number/float",
    args = {
      value = 2.3,
      metamethod_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metamethods_or_is_nil/string",
    args = {
      value = "test",
      metamethod_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metamethods_or_is_nil/function",
    args = {
      value = function() end,
      metamethod_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metamethods_or_is_nil/table/without_metatable",
    args = {
      value = {},
      metamethod_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metamethods_or_is_nil/table/without_metamethods",
    args = {
      value = setmetatable({}, {}),
      metamethod_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metamethods_or_is_nil"
      .. "/table"
      .. "/with_metamethods/with_non-callable_values",
    args = {
      value = setmetatable({}, {
        __one = 23,
        __two = 42,
      }),
      metamethod_names = {"__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metamethods_or_is_nil"
      .. "/table"
      .. "/with_metamethods/with_callable_values/functions",
    args = {
      value = Object:new(23),
      metamethod_names = {"__eq", "__call"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_metamethods_or_is_nil"
      .. "/table"
      .. "/with_metamethods/with_callable_values/tables",
    args = {
      value = setmetatable({}, {
        __eq = Object:new(23),
        __call = Object:new(42),
      }),
      metamethod_names = {"__eq", "__call"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_metamethods_or_is_nil/table/with_missed_metamethods/all",
    args = {
      value = Object:new(23),
      metamethod_names = {"__add", "__sub"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metamethods_or_is_nil/table/with_missed_metamethods/some",
    args = {
      value = Object:new(23),
      metamethod_names = {"__eq", "__add"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_metamethods_or_is_nil"
      .. "/table"
      .. "/with_metamethods"
      .. "/with_request_for_empty_set",
    args = {
      value = Object:new(23),
      metamethod_names = {},
    },
    want = _assert_no_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(
        assertions.has_metamethods_or_is_nil,
        data.args.value,
        data.args.metamethod_names
      )

      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end

-- assertions.has_methods()
for _, data in ipairs({
  {
    name = "test_has_methods/nil",
    args = {
      value = nil,
      method_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods/boolean",
    args = {
      value = true,
      method_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods/number/integer",
    args = {
      value = 23,
      method_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods/number/float",
    args = {
      value = 2.3,
      method_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods/string",
    args = {
      value = "test",
      method_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods/function",
    args = {
      value = function() end,
      method_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods/table/empty",
    args = {
      value = {},
      method_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods/table/with_non-callable_values",
    args = {
      value = { one = 23, two = 42 },
      method_names = {"one", "two"},
    },
    want = _assert_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
  },
  {
    name = "test_has_methods/table/with_metamethods/with_non-callable_values",
    args = {
      value = setmetatable({}, {
        __one = 23,
        __two = 42,
      }),
      method_names = {"__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods"
      .. "/table"
      .. "/with_metamethods/with_callable_values/functions",
    args = {
      value = Object:new(23),
      method_names = {"__eq", "__call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods"
      .. "/table"
      .. "/with_metamethods/with_callable_values/tables",
    args = {
      value = setmetatable({}, {
        __eq = Object:new(23),
        __call = Object:new(42),
      }),
      method_names = {"__eq", "__call"},
    },
    want = _assert_error,
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
    want = _assert_error,
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
    want = _assert_error,
  },
  {
    name = "test_has_methods/table/with_methods/with_request_for_empty_set",
    args = {
      value = {
        one = function() end,
        two = function() end,
      },
      method_names = {},
    },
    want = _assert_no_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(
        assertions.has_methods,
        data.args.value,
        data.args.method_names
      )

      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end

-- assertions.has_methods_or_is_nil()
for _, data in ipairs({
  {
    name = "test_has_methods_or_is_nil/nil",
    args = {
      value = nil,
      method_names = {"one", "two"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_methods_or_is_nil/boolean",
    args = {
      value = true,
      method_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_or_is_nil/number/integer",
    args = {
      value = 23,
      method_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_or_is_nil/number/float",
    args = {
      value = 2.3,
      method_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_or_is_nil/string",
    args = {
      value = "test",
      method_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_or_is_nil/function",
    args = {
      value = function() end,
      method_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_or_is_nil/table/empty",
    args = {
      value = {},
      method_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_or_is_nil/table/with_non-callable_values",
    args = {
      value = { one = 23, two = 42 },
      method_names = {"one", "two"},
    },
    want = _assert_error,
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
    want = _assert_no_error,
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
    want = _assert_no_error,
  },
  {
    name = "test_has_methods_or_is_nil"
      .. "/table"
      .. "/with_metamethods/with_non-callable_values",
    args = {
      value = setmetatable({}, {
        __one = 23,
        __two = 42,
      }),
      method_names = {"__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_or_is_nil"
      .. "/table"
      .. "/with_metamethods/with_callable_values/functions",
    args = {
      value = Object:new(23),
      method_names = {"__eq", "__call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_or_is_nil"
      .. "/table"
      .. "/with_metamethods/with_callable_values/tables",
    args = {
      value = setmetatable({}, {
        __eq = Object:new(23),
        __call = Object:new(42),
      }),
      method_names = {"__eq", "__call"},
    },
    want = _assert_error,
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
    want = _assert_error,
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
    want = _assert_error,
  },
  {
    name = "test_has_methods_or_is_nil"
      .. "/table"
      .. "/with_methods"
      .. "/with_request_for_empty_set",
    args = {
      value = {
        one = function() end,
        two = function() end,
      },
      method_names = {},
    },
    want = _assert_no_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(
        assertions.has_methods_or_is_nil,
        data.args.value,
        data.args.method_names
      )

      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end

-- assertions.has_methods_anywhere()
for _, data in ipairs({
  {
    name = "test_has_methods_anywhere/nil",
    args = {
      value = nil,
      method_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere/boolean",
    args = {
      value = true,
      method_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere/number/integer",
    args = {
      value = 23,
      method_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere/number/float",
    args = {
      value = 2.3,
      method_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere/string",
    args = {
      value = "test",
      method_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere/function",
    args = {
      value = function() end,
      method_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere/table/empty",
    args = {
      value = {},
      method_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
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
    want = _assert_no_error,
  },
  {
    name = "test_has_methods_anywhere"
      .. "/table"
      .. "/with_regular_methods/with_underscores",
    args = {
      value = {
        __one = function() end,
        __two = function() end,
      },
      method_names = {"__one", "__two"},
    },
    want = _assert_error,
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
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere/table/with_metamethods",
    args = {
      value = setmetatable({}, {
        __eq = function() end,
        __call = function() end,
      }),
      method_names = {"__eq", "__call"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_methods_anywhere"
      .. "/table"
      .. "/with_metamethods/without_underscores",
    args = {
      value = setmetatable({}, {
        eq = function() end,
        call = function() end,
      }),
      method_names = {"eq", "call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere/table/with_metamethods/missed",
    args = {
      value = setmetatable({}, {
        __add = function() end,
        __sub = function() end,
      }),
      method_names = {"__eq", "__call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere/table/with_regular_and_metamethods",
    args = {
      value = setmetatable(
        {
          one = function() end,
          two = function() end,
        },
        {
          __eq = function() end,
          __call = function() end,
        }
      ),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_methods_anywhere"
      .. "/table"
      .. "/with_regular_and_metamethods/with_missed_regular_methods",
    args = {
      value = setmetatable(
        {
          three = function() end,
          four = function() end,
        },
        {
          __eq = function() end,
          __call = function() end,
        }
      ),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere"
      .. "/table"
      .. "/with_regular_and_metamethods/with_missed_metamethods",
    args = {
      value = setmetatable(
        {
          one = function() end,
          two = function() end,
        },
        {
          __add = function() end,
          __sub = function() end,
        }
      ),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere"
      .. "/table"
      .. "/with_regular_and_metamethods/with_missed_all_methods",
    args = {
      value = setmetatable(
        {
          three = function() end,
          four = function() end,
        },
        {
          __add = function() end,
          __sub = function() end,
        }
      ),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere"
      .. "/table"
      .. "/with_regular_and_metamethods"
      .. "/with_request_for_empty_set",
    args = {
      value = setmetatable(
        {
          one = function() end,
          two = function() end,
        },
        {
          __eq = function() end,
          __call = function() end,
        }
      ),
      method_names = {},
    },
    want = _assert_no_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(
        assertions.has_methods_anywhere,
        data.args.value,
        data.args.method_names
      )

      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end

-- assertions.has_methods_anywhere_or_is_nil()
for _, data in ipairs({
  {
    name = "test_has_methods_anywhere_or_is_nil/nil",
    args = {
      value = nil,
      method_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/boolean",
    args = {
      value = true,
      method_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/number/integer",
    args = {
      value = 23,
      method_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/number/float",
    args = {
      value = 2.3,
      method_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/string",
    args = {
      value = "test",
      method_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/function",
    args = {
      value = function() end,
      method_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/table/empty",
    args = {
      value = {},
      method_names = {"one", "two", "__one", "__two"},
    },
    want = _assert_error,
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
    want = _assert_no_error,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil"
      .. "/table"
      .. "/with_regular_methods/with_underscores",
    args = {
      value = {
        __one = function() end,
        __two = function() end,
      },
      method_names = {"__one", "__two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil"
      .. "/table"
      .. "/with_regular_methods/missed",
    args = {
      value = {
        three = function() end,
        four = function() end,
      },
      method_names = {"one", "two"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/table/with_metamethods",
    args = {
      value = setmetatable({}, {
        __eq = function() end,
        __call = function() end,
      }),
      method_names = {"__eq", "__call"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil"
      .. "/table"
      .. "/with_metamethods/without_underscores",
    args = {
      value = setmetatable({}, {
        eq = function() end,
        call = function() end,
      }),
      method_names = {"eq", "call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil/table/with_metamethods/missed",
    args = {
      value = setmetatable({}, {
        __add = function() end,
        __sub = function() end,
      }),
      method_names = {"__eq", "__call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil"
      .. "/table"
      .. "/with_regular_and_metamethods",
    args = {
      value = setmetatable(
        {
          one = function() end,
          two = function() end,
        },
        {
          __eq = function() end,
          __call = function() end,
        }
      ),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = _assert_no_error,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil"
      .. "/table"
      .. "/with_regular_and_metamethods/with_missed_regular_methods",
    args = {
      value = setmetatable(
        {
          three = function() end,
          four = function() end,
        },
        {
          __eq = function() end,
          __call = function() end,
        }
      ),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil"
      .. "/table"
      .. "/with_regular_and_metamethods/with_missed_metamethods",
    args = {
      value = setmetatable(
        {
          one = function() end,
          two = function() end,
        },
        {
          __add = function() end,
          __sub = function() end,
        }
      ),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil"
      .. "/table"
      .. "/with_regular_and_metamethods/with_missed_all_methods",
    args = {
      value = setmetatable(
        {
          three = function() end,
          four = function() end,
        },
        {
          __add = function() end,
          __sub = function() end,
        }
      ),
      method_names = {"one", "two", "__eq", "__call"},
    },
    want = _assert_error,
  },
  {
    name = "test_has_methods_anywhere_or_is_nil"
      .. "/table"
      .. "/with_regular_and_metamethods"
      .. "/with_request_for_empty_set",
    args = {
      value = setmetatable(
        {
          one = function() end,
          two = function() end,
        },
        {
          __eq = function() end,
          __call = function() end,
        }
      ),
      method_names = {},
    },
    want = _assert_no_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(
        assertions.has_methods_anywhere_or_is_nil,
        data.args.value,
        data.args.method_names
      )

      assertions.set_assertions_mode(previous_assertions_mode)
    end
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
    want = _assert_error,
  },
  {
    name = "test_is_instance/boolean",
    args = {
      value = true,
      class = MiddleclassObject,
    },
    want = _assert_error,
  },
  {
    name = "test_is_instance/number/integer",
    args = {
      value = 23,
      class = MiddleclassObject,
    },
    want = _assert_error,
  },
  {
    name = "test_is_instance/number/float",
    args = {
      value = 2.3,
      class = MiddleclassObject,
    },
    want = _assert_error,
  },
  {
    name = "test_is_instance/string",
    args = {
      value = "test",
      class = MiddleclassObject,
    },
    want = _assert_error,
  },
  {
    name = "test_is_instance/function",
    args = {
      value = function() end,
      class = MiddleclassObject,
    },
    want = _assert_error,
  },
  {
    name = "test_is_instance/table",
    args = {
      value = {},
      class = MiddleclassObject,
    },
    want = _assert_error,
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
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(
        assertions.is_instance,
        data.args.value,
        data.args.class
      )

      assertions.set_assertions_mode(previous_assertions_mode)
    end
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
    want = _assert_error,
  },
  {
    name = "test_is_instance_or_nil/number/integer",
    args = {
      value = 23,
      class = MiddleclassObject,
    },
    want = _assert_error,
  },
  {
    name = "test_is_instance_or_nil/number/float",
    args = {
      value = 2.3,
      class = MiddleclassObject,
    },
    want = _assert_error,
  },
  {
    name = "test_is_instance_or_nil/string",
    args = {
      value = "test",
      class = MiddleclassObject,
    },
    want = _assert_error,
  },
  {
    name = "test_is_instance_or_nil/function",
    args = {
      value = function() end,
      class = MiddleclassObject,
    },
    want = _assert_error,
  },
  {
    name = "test_is_instance_or_nil/table",
    args = {
      value = {},
      class = MiddleclassObject,
    },
    want = _assert_error,
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
    name = "test_is_instance_or_nil"
      .. "/table"
      .. "/middleclass_object/through_inheritance",
    args = {
      value = MiddleclassObject:new(),
      class = MiddleclassBaseObject,
    },
    want = _assert_no_error,
  },
}) do
  for _, assertions_mode in ipairs({"without_assertions", "with_assertions"}) do
    local name = string.format("%s/%s", data.name, assertions_mode)
    TestAssertions[name] = function()
      local previous_assertions_mode = assertions.get_assertions_mode()
      assertions.set_assertions_mode(assertions_mode)

      local want = data.want
      if assertions_mode == "without_assertions" then
        want = _assert_no_error
      end

      want(
        assertions.is_instance_or_nil,
        data.args.value,
        data.args.class
      )

      assertions.set_assertions_mode(previous_assertions_mode)
    end
  end
end
