require("actions.types")
local M = {}
---@param func string
---@return Action
M.todo = function(func)
    return function()
        vim.notify(func .. " not implemented in the current config")
    end
end
return M
