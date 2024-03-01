require("actions.types")
local notifications = {
    ---@type Action
    clear = require("actions.util").todo("Clear Notifications"),
    ---@type Action
    history = require("actions.util").todo("Clear Notifications"),
}
return notifications
