---
-- @module checks

local checks = {}

---
-- @tparam any value
-- @treturn bool
function checks.is_number(value)
  return type(value) == "number"
end

return checks
