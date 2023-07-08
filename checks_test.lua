local luaunit = require("luaunit")
local checks = require("luatypechecks.checks")

-- luacheck: globals TestChecks
TestChecks = {}

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
