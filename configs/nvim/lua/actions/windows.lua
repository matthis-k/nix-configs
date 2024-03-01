require("actions.types")
local windows = {
    ---@type Action
    vsplit = require("actions.util").todo("Split window vertically"),
    ---@type Action
    hsplit = require("actions.util").todo("Split window horizontally"),
    ---@type Action
    close = require("actions.util").todo("Close window"),
    ---@type Action
    maximise = require("actions.util").todo("Close window"),
    ---@type Action
    up = require("actions.util").todo("Focus up"),
    ---@type Action
    down = require("actions.util").todo("Focus down"),
    ---@type Action
    left = require("actions.util").todo("Focus left"),
    ---@type Action
    right = require("actions.util").todo("Focus right"),
}
return windows
