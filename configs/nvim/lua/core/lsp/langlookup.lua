---@class LanguageInfo
---@field lspconfig { name: string, opts: table }|nil
---@field filetype string[]
---@field null_ls { formatting: string[]|nil, hover: string[]|nil, code_actions: string[]|nil, completion: string[]|nil, diagnostics: string[]|nil }|nil
---@field treesitter string[]|nil
---@field setup fun()|nil
---@field custom_keys table[]|nil

local M = {}
M.languages = require("utils").dirReq("core.lsp.languages")

function M.merge_field(field_name)
    local r = {}
    for _, lang in pairs(M.languages) do
        local t = type(lang[field_name])
        if t == "string" then
            vim.list_extend(r, { lang[field_name] })
        elseif vim.isarray(lang[field_name]) then
            vim.list_extend(r, lang[field_name])
        elseif t == "table" then
            for k, v in pairs(lang[field_name]) do
                if not r[k] then r[k] = {} end
                if not vim.isarray(v) then
                    vim.list_extend(r[k], { v })
                else
                    vim.list_extend(r[k], v)
                end
            end
        end
    end
    return r
end

return M
