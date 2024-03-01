local M = {}

local inlay_hints = false

function M.setup()
    require("core.lsp.autoformat").setup()
    local lsp_keymaps = require("core.lsp.keymaps")
    local keyutil = require("core.keymaps")

    keyutil.lsp_attach_keymaps(lsp_keymaps.on_attach)
    keyutil.set_global_keymaps(lsp_keymaps.global)

    M.on_attach("InlayHints", function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local supports_inlay_hint = client.supports_method("textDocument/inlayHint")
        if supports_inlay_hint then
            vim.lsp.inlay_hint.enable(0, inlay_hints)
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
            local buffers = vim.lsp.get_buffers_by_client_id(client.id or 0)
            for _, buf in ipairs(buffers) do
                vim.lsp.inlay_hint.enable(buf, inlay_hints)
            end
        end
    end
end

return M
