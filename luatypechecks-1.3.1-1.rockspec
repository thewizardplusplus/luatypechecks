rockspec_format = "3.0"
package = "luatypechecks"
version = "1.3.1-1"
description = {
  summary = "The library that implements various type checks in order to simulate static typing in the Lua language.",
  license = "MIT",
  maintainer = "thewizardplusplus <thewizardplusplus@yandex.ru>",
  homepage = "https://github.com/thewizardplusplus/luatypechecks",
}
source = {
  url = "git+https://github.com/thewizardplusplus/luatypechecks.git",
  tag = "v1.3.1",
}
dependencies = {
  "lua >= 5.1",
  "middleclass >= 4.1.1, < 5.0",
}
test_dependencies = {
  "luaunit >= 3.4, < 4.0",
}
build = {
  type = "builtin",
  modules = {
    ["luatypechecks.checks"] = "checks.lua",
    ["luatypechecks.assertions"] = "assertions.lua",
  },
  copy_directories = {
    "doc",
  },
}
