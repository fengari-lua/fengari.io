local js = require "js"
local global = js.global
local document = global.document

local printToDOM = function(element, ...)
    local toprint = table.pack(...)

    local line = document:createElement("pre")
    line.style["white-space"] = "pre-wrap"
    element:appendChild(line)

    for i = 1, toprint.n do
        if i ~= 1 then
            line:appendChild(document:createTextNode("\t"))
        end
        line:appendChild(document:createTextNode(tostring(toprint[i])))
    end
end

local closest = global.Element.prototype.closest
if not closest then
    -- Element.closest shim
    -- https://developer.mozilla.org/en-US/docs/Web/API/Element/closest
    local matches = global.Element.prototype.matches
    if not matches then
        matches = global.Element.prototype.msMatchesSelector or global.Element.prototype.webkitMatchesSelector
    end
    closest = function(el, s)
        if not document.documentElement:contains(el) then
            return js.null
        end
        repeat
            if matches(el, s) then
                return el
            end
            el = el.parentElement or el.parentNode
        until el == js.null
        return js.null;
    end
end

-- IE/Edge<=16 doesn't support NodeList.forEach or NodeList[Symbol.iterator]
local list = document:querySelectorAll(".snippet__actions__action[data-action='run']")
for i=0, list.length-1 do
    list[i]:addEventListener("click", function (_, event)
        local target = event.currentTarget
        local source = target:querySelector(".snippet__source")
        local output = closest(target, ".snippet"):querySelector(".snippet__output")

        local oldPrint = _G.print

        _G.print = function(...)
            printToDOM(output, ...)
            if (not output.classList:contains("snippet__output--visible")) then
                output.className = output.className .. " snippet__output--visible"
            end
        end

        output.innerHTML = ""

        if source.dataset and source.dataset.lang == "lua" then
            local success, msg = pcall(load(source.textContent))

            if not success then
                global.console:warn(msg or "An error occured while running snippet: \n" .. source.textContent)
            end
        else
            global:eval(source.textContent)
        end

        _G.print = oldPrint -- restore regular print
    end)
end
