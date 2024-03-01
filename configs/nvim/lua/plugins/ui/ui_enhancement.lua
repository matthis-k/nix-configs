return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            cmdline = {
                view = "cmdline_popup",
            },
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
                progress = { enabled = true, view = "notify" },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = true,
            },
            views = {
                cmdline_popup = {
                    border = {
                        style = require("core.visuals").border,
                    },
                },
                notify = {
                    replace = true,
                }
            },
            messages = { view = "notify" },
            routes = {
                {
                    filter = { min_height = 5, cmdline = true },
                    view = "cmdline_output",
                },
                {
                    filter = { min_height = 2, max_height = 4, cmdline = true },
                    view = "notify",
                },
            }
        },
        keys = {
            { "<s-bs>", "<cmd>NoiceDismiss<cr>", desc = "Clear Notifications" },
            {
                "<s-cr>",
                function()
                    require("noice").redirect(vim.fn.getcmdline() or "",
                        { { filter = { cmdline = true }, view = "cmdline_output", }, })
                end,
                desc = "Redirect Cmdline",
                mode = "c"
            },
            {
                "<c-f>",
                function()
                    if not require("noice.lsp").scroll(4) then
                        return "<c-f>"
                    end
                end,
                silent = true,
                expr = true,
                desc = "Scroll forward",
                mode = { "i", "n", "s", },
            },
            {
                "<c-b>",
                function()
                    if not require("noice.lsp").scroll(-4) then
                        return "<c-b>"
                    end
                end,
                silent = true,
                expr = true,
                desc = "Scroll backward",
                mode = { "i", "n", "s", },
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
            { "smjonas/inc-rename.nvim", config = true },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        main = "ibl",
        opts = {
            indent = { char = "▏", },
            exclude = { filetypes = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" }, },
            whitespace = {
                remove_blankline_trail = true,
            },
        },
    },
    {
        "rcarriga/nvim-notify",
        opts = {
            renderer = "wrapped-compact",
            timeout = 3000,
            level = vim.log.levels.INFO,
            top_down = false,
            max_height = function()
                return math.floor(vim.o.lines * 0.5)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.3)
            end,
            on_open = function(win)
                local config = vim.api.nvim_win_get_config(win)
                config.border = require("core.visuals").border
                vim.api.nvim_win_set_config(win, config)
            end
        },
    },
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        config = function()
            require("dressing").setup({
                input = {
                    enabled = true,
                },
                select = {
                    enabled = true,
                    backend = { "telescope" },
                    trim_prompt = true,
                    telescope = {
                        border = true,
                        theme = "center",
                        layout_config = {
                            horizontal = { prompt_position = "top", preview_width = 0.5 },
                            width = 0.5,
                            height = 0.3
                        },
                        layout_strategy = "horizontal",
                        prompt_prefix = " ",
                        selection_caret = "",
                        sorting_strategy = "ascending",
                        borderchars = {
                            prompt = require("core.visuals").border_telescope,
                            results = require("core.visuals").border_telescope,
                            preview = require("core.visuals").border_telescope,
                        },
                    },
                    get_config = function(opts)
                        if opts.kind == 'codeaction' then
                            return {
                                telescope = {
                                    theme = "cursor",
                                    border = true,
                                    layout_strategy = "cursor",
                                    sorting_strategy = "ascending",
                                    layout_config = {
                                        width = 70,
                                        height = 8,
                                    },
                                },
                            }
                        end
                    end
                },
            })
        end,
    },
    {
        "RRethy/vim-illuminate",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            providers = {
                "lsp",
                "treesitter",
                "regex",
            },
            delay = 100,
            filetype_overrides = {},
            filetypes_denylist = {
                "neo-tree",
                "alpha",
                "lazy",
                "toggleterm",
            },
            filetypes_allowlist = {},
            modes_allowlist = {},
            providers_regex_syntax_denylist = {},
            providers_regex_syntax_allowlist = {},
            under_cursor = false,
            large_file_cutoff = nil,
            large_file_overrides = nil,
            min_count_to_highlight = 1,
        },
        config = function(_, opts)
            require("illuminate").configure(opts)
        end,
    },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "MunifTanjim/nui.nvim",        lazy = true },
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = true,
    },
    {
        "jiaoshijie/undotree",
        lazy = true,
        keys = {
            {
                "<leader>U",
                function()
                    require("undotree").toggle()
                end,
                desc = "undotree",
            },
        },
        opts = {
            window = {
                winblend = 0,
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "folke/zen-mode.nvim",
        keys = {
            {
                "<leader>uz",
                function()
                    require("zen-mode").toggle()
                end,
                desc = "Toggle Zen mode"
            }
        },
        opts = {
            window = {
                backdrop = 0.80,
                width = 120,
                height = 1,
                options = {
                },
            },
            plugins = {
                options = {
                    enabled = true,
                    ruler = false,
                    showcmd = false,
                    laststatus = 0,
                },
                twilight = { enabled = true },
                gitsigns = { enabled = true },
                tmux = { enabled = false },
                kitty = {
                    enabled = false,
                    font = "+4",
                },
                alacritty = {
                    enabled = false,
                    font = "14",
                },
                wezterm = {
                    enabled = false,
                    font = "+4",
                },
            },
        }
    },
    {
        "chrisgrieser/nvim-recorder",
        keys = {
            { "q", desc = " Start Recording" },
            { "Q", desc = " Play Recording" },
        },
        dependencies = "rcarriga/nvim-notify", -- optional
        opts = {
            slots = { "a", "b" },
            mapping = {
                startStopRecording = "q",
                playMacro = "Q",
                switchSlot = "<c-q>",
                editMacro = "cq",
                deleteAllMacros = "dq",
                yankMacro = "yq",
                addBreakPoint = "##",
            },
            clear = false,
            logLevel = vim.log.levels.INFO,
            lessNotifications = true,
            useNerdfontIcons = true,
            performanceOpts = {
                countThreshold = 100,
                lazyredraw = true,
                noSystemClipboard = true,
                autocmdEventsIgnore = {
                    "TextChangedI",
                    "TextChanged",
                    "InsertLeave",
                    "InsertEnter",
                    "InsertCharPre",
                },
            },
            dapSharedKeymaps = false,
        },
    },
    {
        'declancm/maximize.nvim',
        keys = {
            { "<leader>wm", function() require("maximize").toggle() end, desc = "Maximize" },
        },
        opts = { default_keymaps = false },
    },
}
