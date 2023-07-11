local luaunit = require("luaunit")
local checks = require("luatypechecks.checks")

-- luacheck: globals TestChecks
TestChecks = {}

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

-- checks.is_table()
for _, data in ipairs({
  {
    name = "test_is_table/nil",
    args = { value = nil },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table/boolean",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table/number/integer",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table/string",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table/function",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table/table",
    args = { value = {} },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table/table/key_checker/true",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table/table/key_checker/false",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table/table/value_checker/true",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table/table/value_checker/false",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_string,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table/table/key_and_value_checkers/true",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table/table/key_and_value_checkers/key_checker_false",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_boolean,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table/table/key_and_value_checkers/value_checker_false",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_boolean,
    },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_table(
      data.args.value,
      data.args.key_checker,
      data.args.value_checker
    )

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.make_table_checker()
for _, data in ipairs({
  {
    name = "test_make_table_checker/nil",
    args = { value = nil },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_checker/boolean",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_checker/number/integer",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_checker/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_checker/string",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_checker/function",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_checker/table",
    args = { value = {} },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_checker/table/key_checker/true",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_checker/table/key_checker/false",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_checker/table/value_checker/true",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_checker/table/value_checker/false",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_string,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_checker/table/key_and_value_checkers/true",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_checker/table/key_and_value_checkers/key_checker_false",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_boolean,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_checker/table/key_and_value_checkers/value_checker_false",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_boolean,
    },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local checker = checks.make_table_checker(
      data.args.key_checker,
      data.args.value_checker
    )

    luaunit.assert_is_function(checker)

    local result = checker(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.is_table_or_nil()
for _, data in ipairs({
  {
    name = "test_is_table_or_nil/nil",
    args = { value = nil },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table_or_nil/boolean",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table_or_nil/number/integer",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table_or_nil/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table_or_nil/string",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table_or_nil/function",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table_or_nil/table",
    args = { value = {} },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table_or_nil/table/key_checker/true",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table_or_nil/table/key_checker/false",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table_or_nil/table/value_checker/true",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table_or_nil/table/value_checker/false",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_string,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table_or_nil/table/key_and_value_checkers/true",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_table_or_nil/table/key_and_value_checkers/key_checker_false",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_boolean,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_table_or_nil/table/key_and_value_checkers/value_checker_false",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_boolean,
    },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_table_or_nil(
      data.args.value,
      data.args.key_checker,
      data.args.value_checker
    )

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.make_table_or_nil_checker()
for _, data in ipairs({
  {
    name = "test_make_table_or_nil_checker/nil",
    args = { value = nil },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_or_nil_checker/boolean",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_or_nil_checker/number/integer",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_or_nil_checker/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_or_nil_checker/string",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_or_nil_checker/function",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_or_nil_checker/table",
    args = { value = {} },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_or_nil_checker/table/key_checker/true",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_or_nil_checker/table/key_checker/false",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_or_nil_checker/table/value_checker/true",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_or_nil_checker/table/value_checker/false",
    args = {
      value = { one = 1, two = 2 },
      value_checker = checks.is_string,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_or_nil_checker/table/key_and_value_checkers/true",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_table_or_nil_checker/table/key_and_value_checkers/key_checker_false",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_boolean,
      value_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_table_or_nil_checker/table/key_and_value_checkers/value_checker_false",
    args = {
      value = { one = 1, two = 2 },
      key_checker = checks.is_string,
      value_checker = checks.is_boolean,
    },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local checker = checks.make_table_or_nil_checker(
      data.args.key_checker,
      data.args.value_checker
    )

    luaunit.assert_is_function(checker)

    local result = checker(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.is_sequence()
for _, data in ipairs({
  {
    name = "test_is_sequence/nil",
    args = { value = nil },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence/boolean",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence/number/integer",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence/string",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence/function",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence/table/empty",
    args = { value = {} },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence/table/sequence",
    args = { value = {"one", "two"} },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence/table/sequence/value_checker/true",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence/table/sequence/value_checker/false",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence/table/not_sequence/not_integer_indices",
    args = { value = { one = 1, two = 2 } },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence/table/not_sequence/absent_indices",
    args = { value = { [1] = "one", [3] = "two" } },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence/table/not_sequence/indices_not_starting_with_one",
    args = { value = { [2] = "one", [3] = "two"} },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_sequence(
      data.args.value,
      data.args.value_checker
    )

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.make_sequence_checker()
for _, data in ipairs({
  {
    name = "test_make_sequence_checker/nil",
    args = { value = nil },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_checker/boolean",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_checker/number/integer",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_checker/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_checker/string",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_checker/function",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_checker/table/empty",
    args = { value = {} },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_checker/table/sequence",
    args = { value = {"one", "two"} },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_checker/table/sequence/value_checker/true",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_checker/table/sequence/value_checker/false",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_checker/table/not_sequence/not_integer_indices",
    args = { value = { one = 1, two = 2 } },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_checker/table/not_sequence/absent_indices",
    args = { value = { [1] = "one", [3] = "two" } },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_checker/table/not_sequence/indices_not_starting_with_one",
    args = { value = { [2] = "one", [3] = "two"} },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local checker = checks.make_sequence_checker(data.args.value_checker)

    luaunit.assert_is_function(checker)

    local result = checker(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.is_sequence_or_nil()
for _, data in ipairs({
  {
    name = "test_is_sequence_or_nil/nil",
    args = { value = nil },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence_or_nil/boolean",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence_or_nil/number/integer",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence_or_nil/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence_or_nil/string",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence_or_nil/function",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence_or_nil/table/empty",
    args = { value = {} },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence_or_nil/table/sequence",
    args = { value = {"one", "two"} },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence_or_nil/table/sequence/value_checker/true",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_is_sequence_or_nil/table/sequence/value_checker/false",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence_or_nil/table/not_sequence/not_integer_indices",
    args = { value = { one = 1, two = 2 } },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence_or_nil/table/not_sequence/absent_indices",
    args = { value = { [1] = "one", [3] = "two" } },
    want = luaunit.assert_false,
  },
  {
    name = "test_is_sequence_or_nil/table/not_sequence/indices_not_starting_with_one",
    args = { value = { [2] = "one", [3] = "two"} },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local result = checks.is_sequence_or_nil(
      data.args.value,
      data.args.value_checker
    )

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end

-- checks.make_sequence_or_nil_checker()
for _, data in ipairs({
  {
    name = "test_make_sequence_or_nil_checker/nil",
    args = { value = nil },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_or_nil_checker/boolean",
    args = { value = true },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_or_nil_checker/number/integer",
    args = { value = 23 },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_or_nil_checker/number/float",
    args = { value = 2.3 },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_or_nil_checker/string",
    args = { value = "test" },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_or_nil_checker/function",
    args = { value = function() end },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_or_nil_checker/table/empty",
    args = { value = {} },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_or_nil_checker/table/sequence",
    args = { value = {"one", "two"} },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_or_nil_checker/table/sequence/value_checker/true",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_string,
    },
    want = luaunit.assert_true,
  },
  {
    name = "test_make_sequence_or_nil_checker/table/sequence/value_checker/false",
    args = {
      value = {"one", "two"},
      value_checker = checks.is_number,
    },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_or_nil_checker/table/not_sequence/not_integer_indices",
    args = { value = { one = 1, two = 2 } },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_or_nil_checker/table/not_sequence/absent_indices",
    args = { value = { [1] = "one", [3] = "two" } },
    want = luaunit.assert_false,
  },
  {
    name = "test_make_sequence_or_nil_checker/table/not_sequence/indices_not_starting_with_one",
    args = { value = { [2] = "one", [3] = "two"} },
    want = luaunit.assert_false,
  },
}) do
  TestChecks[data.name] = function()
    local checker = checks.make_sequence_or_nil_checker(data.args.value_checker)

    luaunit.assert_is_function(checker)

    local result = checker(data.args.value)

    luaunit.assert_is_boolean(result)
    data.want(result)
  end
end
