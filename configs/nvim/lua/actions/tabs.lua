require("actions.types")
local tabs = {
    ---@type Action
    next = require("actions.util").todo("Next tab"),
    ---@type Action
    prev = require("actions.util").todo("Previous tab"),
    ---@type Action
    close = require("actions.util").todo("Close tab"),
}
return tabs
