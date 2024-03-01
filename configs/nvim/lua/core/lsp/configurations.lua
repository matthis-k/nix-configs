local M = {}

local function load_configurations()
    local configurations = require("core.lsp.langlookup").languages
    return configurations
end

function M.setup()
    local utils = require("utils")
    local lspconfig = require("lspconfig")

    local configurations = load_configurations()
    utils.recursiveCall(configurations, "setup")

    for _, config in pairs(configurations) do
        if config.enabled ~= false and config.lspconfig then
            lspconfig[config.lspconfig.name].setup(config.lspconfig.opts or {})
        end
    end
end

return M
