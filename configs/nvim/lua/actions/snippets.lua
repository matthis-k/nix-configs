require("actions.types")
local snippets = {
    ---@type Action
    edit = require("actions.util").todo("Edit snippet"),
    ---@type Action
    add = require("actions.util").todo("Add snippet"),
}
return snippets
