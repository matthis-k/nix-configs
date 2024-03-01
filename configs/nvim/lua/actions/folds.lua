require("actions.types")
local folds = {
    ---@type Action
    open_all = require("actions.util").todo("Open all folds"),
    ---@type Action
    close_all = require("actions.util").todo("Close all folds"),
    ---@type Action
    open_with_level = require("actions.util").todo("Open folds with level"),
    ---@type Action
    close_with_level = require("actions.util").todo("Close folds with level"),
}
return folds
