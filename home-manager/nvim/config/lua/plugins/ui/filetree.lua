local visuals = require("core.visuals")

return {
    "nvim-neo-tree/neo-tree.nvim",
    event = { "BufEnter" },
    cmd = { "Neotree" },
    keys = {
        { "<leader>e", "<cmd>Neotree filesystem toggle right<cr>", desc = "File Explorer" },
    },
    opts = {
        source_selector = {
            winbar = true,
            tabs_layout = "equal",
            content_layout = "center",
            sources = {
                { source = "filesystem", display_name = visuals.icons.filesystem.folder .. " Files" },
                { source = "git_status", display_name = visuals.icons.git.branch .. " Git" },
                { source = "buffers",    display_name = visuals.icons.filesystem.file .. " Buffers" },
            },
        },
        close_if_last_window = true,
        use_default_mappings = false,
        popup_border_style = require("core.visuals").border,
        enable_git_status = true,
        enable_diagnostics = true,
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
        sort_case_insensitive = true,
        default_component_configs = {
            icon = {
                folder_closed = visuals.icons.filesystem.folder,
                folder_open = visuals.icons.filesystem.open_folder,
                folder_empty = visuals.icons.filesystem.empty_folder,
                highlight = "NeoTreeFileIcon"
            },
            container = {
                enable_character_fade = true,
            },
            indent = {
                indent_size = 2,
                padding = 1,
                with_markers = true,
                visuals.icons.tree.indent_marker,
                visuals.icons.tree.last_indent_marker,
                highlight = "NeoTreeIndentMarker",
                with_expanders = nil,
                visuals.icons.tree.expander_collapsed,
                visuals.icons.tree.expander_expanded,
                expander_highlight = "NeoTreeExpander",
            },
            modified = {
                symbol = visuals.icons.git.modified,
                highlight = "NeoTreeModified",
            },
            name = {
                trailing_slash = true,
                use_git_status_colors = true,
                highlight = "NeoTreeFileName",
            },
            visuals.icons.git
        },
        window = {
            position = "right",
            width = 37,
            auto_expand_width = true,
            mapping_options = {
                noremap = true,
                nowait = true,
            },
            mappings = {
                ["space"] = false,
                ["<2-LeftMouse>"] = "open",
                ["<cr>"] = "open",
                ["<esc>"] = "revert_preview",
                ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
                ["l"] = "focus_preview",
                ["-"] = "open_split",
                ["|"] = "open_vsplit",
                ["S"] = "open_split",
                ["s"] = "open_vsplit",
                ["C"] = "close_all_subnodes",
                ["z"] = "close_all_nodes",
                ["Z"] = "expand_all_nodes",
                ["a"] = { "add", config = { show_path = "relative", }, },
                ["A"] = { "add_directory", config = { show_path = "relative", }, },
                ["d"] = "delete",
                ["r"] = "rename",
                ["y"] = "copy_to_clipboard",
                ["x"] = "cut_to_clipboard",
                ["p"] = "paste_from_clipboard",
                ["c"] = "copy",
                ["m"] = { "move", config = { show_path = "relative" } },
                ["q"] = "close_window",
                ["R"] = "refresh",
                ["?"] = "show_help",
                ["<"] = "prev_source",
                [">"] = "next_source",
            },
        },
        filesystem = {
            group_empty_dirs = false,
            follow_current_file = { enabled = true, },
            use_libuv_file_watcher = true,
            hijack_netrw_behavior = "open_current",
            window = {
                mappings = {
                    ["<bs>"] = "navigate_up",
                    ["h"] = "toggle_hidden",
                    ["."] = "set_root",
                }
            }
        },
        git_status = {
            window = {
                mappings = {
                    ["A"]  = "git_add_all",
                    ["gu"] = "git_unstage_file",
                    ["ga"] = "git_add_file",
                    ["gr"] = "git_revert_file",
                    ["gc"] = "git_commit",
                    ["gp"] = "git_push",
                    ["gg"] = "git_commit_and_push",
                },
            },
        },
        buffers = {
            window = {
                mappings = {
                    ["bd"] = "buffer_delete",
                },
            },
        },
    },
    config = function(_, opts)
        vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
        vim.fn.sign_define("DiagnosticSignError",
            { text = visuals.icons.diagnostics.Error, texthl = "DiagnosticSignError" })
        vim.fn.sign_define("DiagnosticSignWarn",
            { text = visuals.icons.diagnostics.Warn, texthl = "DiagnosticSignWarn" })
        vim.fn.sign_define("DiagnosticSignInfo",
            { text = visuals.icons.diagnostics.Info, texthl = "DiagnosticSignInfo" })
        vim.fn.sign_define("DiagnosticSignHint",
            { text = visuals.icons.diagnostics.Hint, texthl = "DiagnosticSignHint" })
        require("neo-tree").setup(opts)
    end,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        {
            "3rd/image.nvim",
            event = "BufReadPre " ..
                table.concat({ "*.gif", "*.ico", "*.jpeg", "*.jpg", "*.png", "*.svg", "*.tiff", "*.webp", "*.bmp" },
                    ","),
            opts = {
                hijack_file_patterns = { "*.gif", "*.ico", "*.jpeg", "*.jpg", "*.png", "*.svg", "*.tiff", "*.webp", "*.bmp" },
            },
        }
    },
}
