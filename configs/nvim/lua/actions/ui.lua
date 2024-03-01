require("actions.types")
local ui = {
    ---@type Action
    toggle_sidebar = require("actions.util").todo("Toggle sidebar"),
    ---@type Action
    toggle_statusline = require("actions.util").todo("Toggle statusline"),
    ---@type Action
    toggle_tabline = require("actions.util").todo("Toggle tabline"),
    ---@type Action
    toggle_zen_mode = require("actions.util").todo("Toggle Zen mode"),
    ---@type Action
    toggle_unto_tree = require("actions.util").todo("Toggle undo tree"),
    ---@type Action
    toggle_highlight_colors = require("actions.util").todo("Toggle color highlights"),
    ---@type Action
    toggle_file_exploree = require("actions.util").todo("Toggle filesystem"),
    ---@type Action
    toggle_diagnostics_window = require("actions.util").todo("Toggle diagnostics window"),
}
return ui
