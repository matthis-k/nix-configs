return {
    {
        "akinsho/bufferline.nvim",
        event = { "BufReadPre", "BufNewFile" },
        commit = "73540cb95f8d95aa1af3ed57713c6720c78af915",
        keys = {
            { "<leader>bp", "<cmd>BufferLineTogglePin<cr>",            desc = "Toggle pin" },
            { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Delete non-pinned buffers" },
            { "H",          "<cmd>BufferLineCyclePrev<cr>",            desc = "Next buffer" },
            { "L",          "<cmd>BufferLineCycleNext<cr>",            desc = "Prev buffer" },
        },
        opts = {
            options = {
                diagnostics = "nvim_lsp",
                always_show_bufferline = true,
                diagnostics_indicator = function(_, _, diag)
                    local icons = require("core.visuals").icons.diagnostics
                    local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                        .. (diag.warning and icons.Warn .. diag.warning or "")
                    return vim.trim(ret)
                end,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
                mode = "buffers",
                color_icons = true,
                numbers = "none",
                close_command = "bdelete! %d",
                right_mouse_command = "bdelete! %d",
                left_mouse_command = "buffer %d",
                middle_mouse_command = "bdelete! %d",
                diagnostics_update_in_insert = true,
                separator_style = "thick",
                enforce_regular_tabs = true,
            },
        },
        dependencies = {
            "catppuccin/nvim",
            { "tiagovla/scope.nvim", config = true },
        },
        config = function(_, opts)
            opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
            ---@diagnostic disable-next-line: different-requires
            require("bufferline").setup(opts)
        end
    },
}
