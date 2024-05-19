return {
    {
        "folke/which-key.nvim",
        module = true,
        event = "VeryLazy",
        opts = {
            icons = {
                breadcrumb = "»",
                separator = "➜",
                group = "+",
            },
            popup_mappings = {
                scroll_down = "<c-d>",
                scroll_up = "<c-u>",
            },
            window = {
                border = require("core.visuals").border,
                position = "bottom",
                margin = { 0, 0, 0, 0 },
                padding = { 1, 2, 1, 2 },
                winblend = 0,
            },
            layout = {
                height = { min = 4, max = 25 },
                width = { min = 20, max = 50 },
                spacing = 3,
                align = "center",
            },
            ignore_missing = false,
            hidden = { "<silent>", "<cmd>", "<cmd>", "<cr>", "^:", "^ ", "^call ", "^lua " },
            show_help = false,
            show_keys = true,
            triggers = "auto",
            triggers_nowait = {
                -- marks
                "`",
                "'",
                "g`",
                "g'",
                -- registers
                '"',
                "<c-r>",
                -- spelling
                "z=",
            },
            triggers_blacklist = {
                i = { "j", "k" },
                v = { "j", "k" },
            },
            disable = {
                buftypes = {},
                filetypes = {},
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            local keymaps = {
                mode = { "n", "v" },
                ["g"] = { name = "goto" },
                ["gi"] = { name = "incremental selection" },
                ["A"] = { name = "assignment" },
                ["cA"] = { name = "assignment" },
                ["dA"] = { name = "assignment" },
                ["yA"] = { name = "assignment" },
                ["]"] = { name = "next" },
                ["["] = { name = "prev" },
                ["<leader><tab>"] = { name = "tabs" },
                ["<leader>a"] = { name = "actions" },
                ["<leader>b"] = { name = "buffers" },
                ["<leader>d"] = { name = "debug" },
                ["<leader>g"] = { name = "git" },
                ["<leader>l"] = { name = "lsp" },
                ["<leader>lw"] = { name = "workspace" },
                ["<leader>p"] = { name = "pickers" },
                ["<leader>s"] = { name = "search" },
                ["<leader>S"] = { name = "snippet" },
                ["<leader>t"] = { name = "terminal" },
                ["<leader>u"] = { name = "ui" },
                ["<leader>v"] = { name = "vim" },
                ["<leader>w"] = { name = "windows" },
            }
            wk.register(keymaps)
        end,
    },
}
