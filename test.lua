local luaunit = require("luaunit")

for _, module in ipairs({
}) do
  require("luatypechecks." .. module .. "_test")
end

os.exit(luaunit.run())
