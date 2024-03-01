require("actions.types")
local buffers = {
    ---@type Action
    next = require("actions.util").todo("Next buffer"),
    ---@type Action
    prev = require("actions.util").todo("Previous buffer"),
    ---@type Action
    del = require("actions.util").todo("Delete buffer"),
}
return buffers
