return {
    {
        'abecodes/tabout.nvim',
        keys = {
            { "<tab>",   "<cmd>Tabout<cr>",     "Tabout" },
            { "<s-tab>", "<cmd>TaboutBack<cr>", "Tabout" },
        },
        config = function()
            require('tabout').setup {
                tabkey = '<tab>',
                backwards_tabkey = '<s-tab>',
                act_as_tab = true,
                act_as_shift_tab = false,
                default_tab = '<c-t>',
                default_shift_tab = '<c-d>',
                enable_backwards = true,
                completion = true,
                tabouts = {
                    { open = "'", close = "'" },
                    { open = '"', close = '"' },
                    { open = '`', close = '`' },
                    { open = '(', close = ')' },
                    { open = '[', close = ']' },
                    { open = '{', close = '}' }
                },
                ignore_beginning = true,
                exclude = {}
            }
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "L3MON4D3/LuaSnip",
            "hrsh7th/nvim-cmp"
        },
    },
}
