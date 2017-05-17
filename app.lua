local lapis = require("lapis")

local app = lapis.Application()
app:enable("etlua")
app.layout = require "views.layout"

app:get("/", function(self)
    local script = io.open("node_modules/fengari-web-cli/src/web-cli.lua")
    self.repl = script:read("*all")
    script:close()

    return { render = "index" }
end)

return app
