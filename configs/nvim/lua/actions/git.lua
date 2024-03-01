require("actions.types")
local git = {
    ---@type Action
    toggle_current_line_blame = require("actions.util").todo("Toggle current line blame"),
    ---@type Action
    reset_buffer = require("actions.util").todo("Reset buffer"),
    ---@type Action
    stage_buffer = require("actions.util").todo("Stage buffer"),
    ---@type Action
    toggle_deleted = require("actions.util").todo("Toggle deleted"),
    ---@type Action
    preview_hunk = require("actions.util").todo("Preview hunk"),
    ---@type Action
    reset_hunk = require("actions.util").todo("Reset hunk"),
    ---@type Action
    stage_hunk = require("actions.util").todo("Stage hunk"),
    ---@type Action
    undo_stage_hunk = require("actions.util").todo("Undo stage hunk"),
    ---@type Action
    toggle_word_diff = require("actions.util").todo("Toggle word diff"),
}
return git
