return {
    {
        "ziontee113/icon-picker.nvim",
        opts = { disable_legacy_commands = true },
        keys = {
            { "<Leader>pp", "<cmd>IconPickerYank<cr>",                  desc = "Any" },
            { "<Leader>pn", "<cmd>IconPickerYank nerd_font_v3<cr>",     desc = "NerdFont" },
            { "<Leader>pe", "<cmd>IconPickerYank emoji<cr>",            desc = "Emoji" },
            { "<Leader>ps", "<cmd>IconPickerYank alt_font symbols<cr>", desc = "Symbol" },
        }
    }
}
