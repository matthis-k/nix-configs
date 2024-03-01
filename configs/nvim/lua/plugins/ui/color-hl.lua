return {
    {
        "brenoprata10/nvim-highlight-colors",
        keys = {
            { "<leader>uc", function() require("nvim-highlight-colors").toggle() end, desc = "Toggle color highlights" }
        },
        opts = {},
    },
    {
        enabled = false,
        "max397574/colortils.nvim",
        cmd = "Colortils",
        keys = {
            { "<leader>cp", "<cmd>Colortils picker #888888<cr>", desc = "Color picker" },
        },
        opts = {
            register = "+",
            color_preview = "█ %s",
            default_format = "hex",
            border = require("core.visuals").border,
            mappings = {
                increment = "l",
                decrement = "h",
                increment_big = "L",
                decrement_big = "H",
                min_value = "0",
                max_value = "$",
                set_register_default_format = "<cr>",
                set_register_cjoose_format = "g<cr>",
                replace_default_format = "<c-cr>",
                replace_choose_format = "g<c-cr>",
                export = "E",
                set_value = "c",
                transparency = "T",
                choose_background = "B",
            }
        }
    }
}
