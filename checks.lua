---
-- @module checks

local checks = {}

local function _is_nil(value)
  return type(value) == "nil"
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

return checks
