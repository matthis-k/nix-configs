require("actions.types")
local debug = {
    ---@type Action
    step_out = require("actions.util").todo("Step out"),
    ---@type Action
    continue = require("actions.util").todo("Continue"),
    ---@type Action
    step_over = require("actions.util").todo("Step over"),
    ---@type Action
    step_into = require("actions.util").todo("Step into"),
    ---@type Action
    stop = require("actions.util").todo("Stop"),
    ---@type Action
    toggle_breakpoint = require("actions.util").todo("Toggle breakpoint"),
    ---@type Action
    set_conditional_breakpoint = require("actions.util").todo("Set conditional breakpoint"),
    ---@type Action
    toggle_ui = require("actions.util").todo("Toggle diagnostics window"),
}
return debug
