local M = {}

---@param opts? {force?:boolean}
function M.format(opts)
    local buf = vim.api.nvim_get_current_buf()
    if vim.b.autoformat == false and not (opts and opts.force) then
        return
    end

    local formatters = M.get_formatters(buf)
    local client_ids = vim.tbl_map(function(client)
        return client.id
    end, formatters.active)

    if #client_ids == 0 then
        return
    end

    vim.lsp.buf.format({
        bufnr = buf,
        filter = function(client)
            return vim.tbl_contains(client_ids, client.id)
        end,
    })
end

function M.get_formatters(bufnr)
    local ft = vim.bo[bufnr].filetype
    local null_ls = package.loaded["null-ls"] and require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") or
        {}

    local ret = {
        active = {},
        available = {},
        null_ls = null_ls,
    }

    local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
    for _, client in ipairs(clients) do
        if M.supports_format(client) then
            if (#null_ls > 0 and client.name == "null-ls") or #null_ls == 0 then
                table.insert(ret.active, client)
            else
                table.insert(ret.available, client)
            end
        end
    end

    return ret
end

-- Gets all lsp clients that support formatting
-- and have not disabled it in their client config
function M.supports_format(client)
    if
        client.config
        and client.config.capabilities
        ---@diagnostic disable-next-line: undefined-field
        and client.config.capabilities.documentFormattingProvider == false
    then
        return false
    end
    return client.supports_method("textDocument/formatting") or client.supports_method("textDocument/rangeFormatting")
end

function M.setup()
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LazyVimFormat", {}),
        callback = function()
            M.format()
        end,
    })
end

return M
