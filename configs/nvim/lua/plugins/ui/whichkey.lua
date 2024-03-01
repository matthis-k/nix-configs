return {
    {
        "folke/which-key.nvim",
        module = true,
        event = "VeryLazy",
        opts = {
            preset = "modern",
            icons = {
                breadcrumb = "»",
                separator = "➜",
                group = "+",
            },
            win = {
                border = require("core.visuals").border,
                wo = {
                    winblend = 0,
                },
            },
            layout = {
                height = { min = 4, max = 25 },
                width = { min = 20, max = 50 },
                spacing = 3,
                align = "center",
            },
            show_help = false,
            show_keys = true,
            triggers = {
                { "<auto>", mode = "nixsoc" },
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
                { "<leader>s",     group = "snippet" },
                { "<leader>a",     group = "actions" },
                { "<leader>b",     group = "buffers" },
                { "<leader>c",     group = "chatgpt" },
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
                { "a",             group = "assignment" },
                { "[",             group = "prev" },
                { "]",             group = "next" },
                { "g",             group = "goto" },
            }
            wk.add(maps)
        end,
    },
}
