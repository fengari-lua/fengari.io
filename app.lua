local lapis = require("lapis")

local app = lapis.Application()
app:enable("etlua")
app.layout = require "views.layout"

app:get("/", function(self)
    return { render = "index" }
end)

app:get("/repl", function(self)
    return { render = "repl" }
end)

return app
