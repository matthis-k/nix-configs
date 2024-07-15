return {
    "catppuccin/nvim",
    priority = 1000,
    opts = {
        dim_inactive = {
            enabled = false,
            shade = "dark",
            percenttage = 0.15,
        },
        integrations = {
            cmp = true,
            gitsigns = true,
            illuminate = true,
            lsp_trouble = true,
            markdown = true,
            mason = true,
            mini = true,
            neotest = false,
            neotree = true,
            noice = true,
            notify = true,
            telescope = true,
            treesitter = true,
            treesitter_context = false,
            which_key = true,
            dap = {
                enabled = true,
                enable_ui = true,
            },
            indent_blankline = {
                enabled = true,
                colored_indent_levels = false,
            },
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                },
                underlines = {
                    errors = { "undercurl" },
                    hints = { "undercurl" },
                    warnings = { "undercurl" },
                    information = { "undercurl" },
                },
            },
        },
    },
    config = function(_, opts)
        local p = require("catppuccin.palettes.mocha")
        opts.custom_highlights = {
            GitSignsUntracked = {
                fg = p.blue,
            },
            GitSignsChange = {
                fg = p.yellow,
            },
            GitSignsChangedelete = {
                fg = p.peach,
            },
            TelescopePromptNormal = {
                bg = p.base,
            },
            TelescopePromptBorder = {
                fg = p.blue,
                bg = p.base,
            },
            TelescopePromptTitle = {
                fg = p.blue,
                bg = p.base,
            },
            TelescopeResultsTitle = {
                fg = p.blue,
                bg = p.crust,
            },
            TeleScopeResultsNormal = {
                bg = p.crust,
            },
            TelescopeResultsBorder = {
                fg = p.blue,
                bg = p.crust,
            },
            TelescopePreviewTitle = {
                fg = p.blue,
                bg = p.crust,
            },
            TeleScopePreviewNormal = {
                bg = p.crust,
            },
            TelescopePreviewBorder = {
                fg = p.blue,
                bg = p.crust,
            },
            NoiceMini = {
                bg = p.base,
            },
            --cmp
            PmenuSel = { bg = p.surface0, fg = "NONE" },
            Pmenu = { fg = p.text, bg = p.base },

            CmpItemAbbrDeprecated = { fg = p.subtext1, bg = "NONE", strikethrough = true },
            CmpItemAbbrMatch = { fg = p.blue, bg = "NONE", bold = true },
            CmpItemAbbrMatchFuzzy = { fg = p.blue, bg = "NONE", bold = true },
            CmpItemMenu = { fg = p.mauve, bg = "NONE", italic = true },

            CmpItemKindField = { fg = p.base, bg = p.red },
            CmpItemKindProperty = { fg = p.base, bg = p.red },
            CmpItemKindEvent = { fg = p.base, bg = p.red },

            CmpItemKindText = { fg = p.base, bg = p.green },
            CmpItemKindEnum = { fg = p.base, bg = p.green },
            CmpItemKindKeyword = { fg = p.base, bg = p.green },

            CmpItemKindConstant = { fg = p.base, bg = p.yellow },
            CmpItemKindConstructor = { fg = p.base, bg = p.yellow },
            CmpItemKindReference = { fg = p.base, bg = p.yellow },

            CmpItemKindFunction = { fg = p.base, bg = p.mauve },
            CmpItemKindStruct = { fg = p.base, bg = p.mauve },
            CmpItemKindClass = { fg = p.base, bg = p.mauve },
            CmpItemKindModule = { fg = p.base, bg = p.mauve },
            CmpItemKindOperator = { fg = p.base, bg = p.mauve },

            CmpItemKindVariable = { fg = p.base, bg = p.sapphire },
            CmpItemKindFile = { fg = p.base, bg = p.sapphire },

            CmpItemKindUnit = { fg = p.base, bg = p.peach },
            CmpItemKindSnippet = { fg = p.base, bg = p.peach },
            CmpItemKindFolder = { fg = p.base, bg = p.peach },

            CmpItemKindMethod = { fg = p.base, bg = p.blue },
            CmpItemKindValue = { fg = p.base, bg = p.blue },
            CmpItemKindEnumMember = { fg = p.base, bg = p.blue },

            CmpItemKindInterface = { fg = p.base, bg = p.green },
            CmpItemKindColor = { fg = p.base, bg = p.green },
            CmpItemKindTypeParameter = { fg = p.base, bg = p.green },

            Red = { fg = p.red },
            Blue = { fg = p.blue },
            Green = { fg = p.green },

            AlphaNeovimLogoBlue = { fg = p.blue },
            AlphaNeovimLogoGreenFBlueB = { fg = p.green, bg = p.blue },
            AlphaNeovimLogoGreen = { fg = p.green },
            AlphaFooter = { fg = p.blue },

            WhichKeyBorder = { fg = p.blue, bg = p.mantle },
            WhichKeyTitle = { fg = p.maroon, bg = p.mantle },
        }
        require("catppuccin").setup(opts)

        vim.cmd([[colorscheme catppuccin]])
    end,
}
