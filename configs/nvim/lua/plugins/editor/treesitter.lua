return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        lazy = false,
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
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = false,
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
                        ["aA"] = { query = "@attribute.outer", desc = "Select attribute" },
                        ["iA"] = { query = "@attribute.outer", desc = "Select inner attribute" },
                        ["aB"] = { query = "@conditional.outer", desc = "Select conditional" },
                        ["iB"] = { query = "@conditional.inner", desc = "Select inner conditional" },
                        ["aC"] = { query = "@comment.outer", desc = "Select comment" },
                        ["iC"] = { query = "@comment.inner", desc = "Select inner comment" },
                        ["aL"] = { query = "@loop.outer", desc = "Select loop" },
                        ["iL"] = { query = "@loop.inner", desc = "Select inner loop" },
                        ["af"] = { query = "@function.outer", desc = "Select function" },
                        ["if"] = { query = "@function.inner", desc = "Select inner function" },
                        ["ar"] = { query = "@return.outer", desc = "Select return" },
                        ["ir"] = { query = "@return.inner", desc = "Select inner return" },
                        ["iS"] = { query = "@statement.outer", desc = "Select statement" },
                        ["ac"] = { query = "@class.outer", desc = "Selet class" },
                        ["ic"] = { query = "@class.inner", desc = "Select inner class" },
                        ["aP"] = { query = "@parameter.outer", desc = "Selet parameter" },
                        ["iP"] = { query = "@parameter.inner", desc = "Select inner parameter" },
                        ["ah"] = { query = "@assignment.lhs", desc = "Select Assignment lhs" },
                        ["al"] = { query = "@assignment.rhs", desc = "Select Assignment rhs" },
                        ["aa"] = { query = "@assignment.outer", desc = "Select Assignment outer" },
                        ["ai"] = { query = "@assignment.inner", desc = "Select Assignment inner" },
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
