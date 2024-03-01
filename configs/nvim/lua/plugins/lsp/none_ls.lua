return {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function(_, opts)
        local null_ls = require("null-ls")
        local builtins = require("core.lsp.langlookup").merge_field("null_ls")
        local sources = {}
        for method, names in pairs(builtins) do
            for _, name in ipairs(names) do
                table.insert(sources, null_ls.builtins[method][name])
            end
        end
        null_ls.setup({
            sources = sources
        })
    end
}
