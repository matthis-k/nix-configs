require("actions.types")
local lsp = {
    ---@type Action
    show_diagnostics = require("actions.util").todo("Show diagnostics"),
    ---@type Action
    show_references = require("actions.util").todo("Show references"),
    ---@type Action
    go_to_definition = require("actions.util").todo("Go to definition"),
    ---@type Action
    hover = require("actions.util").todo("Hover"),
    ---@type Action
    rename = require("actions.util").todo("Rename"),
    ---@type Action
    code_action = require("actions.util").todo("Code action"),
}
return lsp
