require("actions.types")
local ai = {
    ---@type Action
    chat = require("actions.util").todo("Chat with AI"),
    ---@type Action
    edit_code = require("actions.util").todo("AI-assisted code editing"),
}
return ai
