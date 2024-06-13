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
            modes = {
                t = false,
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
            local maps = {
                mode = { "n", "v" },
                { "<leader><tab>", group = "tabs" },
                { "<leader>S",     group = "snippet" },
                { "<leader>a",     group = "actions" },
                { "<leader>b",     group = "buffers" },
                { "<leader>c",     group = "ChatGPT" },
                { "<leader>d",     group = "debug" },
                { "<leader>g",     group = "git" },
                { "<leader>l",     group = "lsp" },
                { "<leader>lw",    group = "workspace" },
                { "<leader>p",     group = "pickers" },
                { "<leader>s",     group = "search" },
                { "<leader>t",     group = "terminal" },
                { "<leader>u",     group = "ui" },
                { "<leader>v",     group = "vim" },
                { "<leader>w",     group = "windows" },
                { "A",             group = "assignment" },
                { "[",             group = "prev" },
                { "]",             group = "next" },
                { "g",             group = "goto" },
            }
            wk.add(maps)
        end,
    },
}
