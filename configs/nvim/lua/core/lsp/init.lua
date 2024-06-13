local M = {}

local inlay_hints = false

function M.setup()
    require("core.lsp.autoformat").setup()
    local lsp_keymaps = require("core.lsp.keymaps")
    local keyutil = require("core.keymaps")

    keyutil.lsp_attach_keymaps(lsp_keymaps.on_attach)
    keyutil.set_global_keymaps(lsp_keymaps.global)

    vim.diagnostic.config({
        virtual_text = {
            prefix = function(_, i, _)
                return require("core.visuals").icons.diagnostics[i]
            end
        }
    })

    M.on_attach("InlayHints", function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end
        local supports_inlay_hint = client.supports_method("textDocument/inlayHint")
        if supports_inlay_hint then
            vim.lsp.inlay_hint.enable(inlay_hints)
        end
    end)

    require("core.lsp.configurations").setup()
end

function M.on_attach(group, callback)
    if not group or not callback then return end
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup(group, {}),
        callback = callback
    })
end

function M.toggle_inlay_hints()
    inlay_hints = not inlay_hints
    local clients = vim.lsp.get_clients()
    for _, client in ipairs(clients) do
        local supports_inlay_hint = client.supports_method("textDocument/inlayHint")
        if supports_inlay_hint then
            vim.lsp.inlay_hint.enable(inlay_hints)
        end
    end
end

return M
