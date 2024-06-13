return {
    {
        "nvim-lualine/lualine.nvim",
        event = { "BufReadPre", "BufNewFile", "WinNew" },
        opts = function(_)
            local icons = require("core.visuals").icons
            return {
                options = {
                    theme = "auto",
                    globalstatus = true,
                    disabled_filetypes = { statusline = { "lazy", "alpha" } },
                    component_separators = "",
                    section_separators = { left = " ", right = " " },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch",
                        {
                            "diff",
                            symbols = {
                                added = icons.git.added,
                                modified = icons.git.modified,
                                removed = icons.git.removed,
                            },
                        },
                    },
                    lualine_c = {
                        {
                            "diagnostics",
                            symbols = {
                                error = icons.diagnostics.Error,
                                warn = icons.diagnostics.Warn,
                                info = icons.diagnostics.Info,
                                hint = icons.diagnostics.Hint,
                            },
                        },
                        {
                            "filetype",
                            icon_only = true,
                            separator = "",
                            padding = {
                                left = 1,
                                right = 0,
                            },
                        },
                        { "filename", path = 1 },
                        { function() return vim.t.maximized and ' ' or '' end },
                    },
                    lualine_x = {
                        {
                            require("noice").api.status.message.get,
                            cond = require("noice").api.status.message.has,
                        },
                    },
                    lualine_y = {
                        { "location", padding = { left = 1, right = 1 } },
                    },
                    lualine_z = {
                        {
                            function() return require("recorder").recordingStatus() .. require("recorder").displaySlots() end,
                            padding = { left = 1, right = 1 }
                        },
                    },
                },
                extensions = { "neo-tree", "toggleterm", "nvim-dap-ui" },
            }
        end,
        dependencies = {
            "folke/noice.nvim",
            "chrisgrieser/nvim-recorder"
        },
    },
}
