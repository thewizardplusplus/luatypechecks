local luaunit = require("luaunit")

for _, module in ipairs({
  "checks",
  "assertions",
}) do
  require("luatypechecks." .. module .. "_test")
end

os.exit(luaunit.run())
