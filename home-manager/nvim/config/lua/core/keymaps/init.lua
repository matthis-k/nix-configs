local M = {}

function M.setup()
    local keys = require("core.keymaps")
    local mappings = require("core.keymaps.default_keymaps")
    keys.set_global_keymaps(mappings)
end

local function map(mapping)
    local keys = require("lazy.core.handler").handlers.keys
    ---@diagnostic disable-next-line: undefined-field
    if not keys.active[keys.parse({ mapping.lhs, mode = mapping.mode }).id] then
        local opts = mapping.opts or {}
        if not opts.silent then
            opts.silent = true
        end
        vim.keymap.set(mapping.mode or "n", mapping.lhs, mapping.rhs, opts)
    end
end

function M.set_global_keymaps(mappings)
    for _, mapping in ipairs(mappings) do
        map(mapping)
    end
end

local function overwrite(mappings, new)
    local res = vim.deepcopy(mappings)
    for _, new_mapping in pairs(new) do
        -- delete duplicates
        for k, mapping in pairs(res) do
            if mapping.lhs == new_mapping.lhs then
                res[k] = nil
            end
        end
        table.insert(res, new_mapping)
    end
    return res
end

function M.lsp_attach_keymaps(mappings)
    require("core.lsp").on_attach("LspKeyBindings", function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client then return end
        local ft = vim.filetype.match({ buf = 0 })

        for lang, conf in pairs(require("core.lsp.langlookup").languages) do
            local is_fitting_ft = vim.tbl_isarray(conf.filetype) and vim.tbl_contains(conf.filetype, ft) or
                conf.filetype == ft or lang == ft
            if is_fitting_ft then
                for _, mapping in ipairs(overwrite(mappings, conf.custom_keys or {})) do
                    if not mapping.needs or client.server_capabilities[mapping.needs] or client.supports_method and client.supports_method(mapping.needs) then
                        map(mapping)
                    end
                end
            end
        end
    end
    )
end

return M
