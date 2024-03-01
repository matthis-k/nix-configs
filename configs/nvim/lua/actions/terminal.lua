require("actions.types")
local terminals = {
    ---@type Action
    toggle_lazygit = require("actions.util").todo("Toggle lazygit"),
    ---@type Action
    toggle_btm = require("actions.util").todo("Toggle btm"),
    ---@type Action
    toggle_or_focus = require("actions.util").todo("Toggle or focus terminal"),
}
return terminals
