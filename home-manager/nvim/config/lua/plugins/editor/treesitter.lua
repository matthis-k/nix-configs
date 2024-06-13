return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            ensure_installed = require("core.lsp.langlookup").merge_field("treesitter"),
            highlight = {
                disable = function(_, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gi",
                    node_incremental = "gin",
                    scope_incremental = "gic",
                    node_decremental = "gim",
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["aa"] = { query = "@attribute.outer", desc = "Select attribute" },
                        ["ia"] = { query = "@attribute.outer", desc = "Select inner attribute" },
                        ["ab"] = { query = "@conditional.outer", desc = "Select conditional" },
                        ["ib"] = { query = "@conditional.outer", desc = "Select inner conditional" },
                        ["af"] = { query = "@function.outer", desc = "Select function" },
                        ["if"] = { query = "@function.inner", desc = "Select inner function" },
                        ["ac"] = { query = "@class.outer", desc = "Selet class" },
                        ["ic"] = { query = "@class.inner", desc = "Select inner class" },
                        ["Ah"] = { query = "@assignment.lhs", desc = "Select Assignment lhs" },
                        ["Al"] = { query = "@assignment.rhs", desc = "Select Assignment rhs" },
                        ["Aa"] = { query = "@assignment.outer", desc = "Select Assignment outer" },
                        ["Ai"] = { query = "@assignment.inner", desc = "Select Assignment inner" },
                        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                    },
                    selection_modes = {
                        ['@parameter.outer'] = 'v',
                        ['@function.outer'] = 'V',
                        ['@class.outer'] = '<c-v>',
                    },
                    include_surrounding_whitespace = true,
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["gs"] = { query = "@parameter.inner", desc = "Swap" },
                    },
                    swap_previous = {
                        ["gS"] = { query = "@parameter.inner", desc = "Swap prev" },
                    },
                },
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end
    }
}
