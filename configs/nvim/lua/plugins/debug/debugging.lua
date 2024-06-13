local icons = require("core.visuals").icons

return {
    {
        "mfussenegger/nvim-dap",
        keys = {
            { "<leader>dh", "<cmd>DapStepOut<cr>",   desc = "Step out" },
            { "<leader>dd", "<cmd>DapContinue<cr>",  desc = "Continue" },
            { "<leader>dj", "<cmd>DapStepOver<cr>",  desc = "Step over" },
            { "<leader>dl", "<cmd>DapStepInto<cr>",  desc = "Step over" },
            { "<leader>ds", "<cmd>DapTerminate<cr>", desc = "Stop" },
            { "<f4>",       "<cmd>DapStepOut<cr>",   desc = "Step out" },
            { "<f5>",       "<cmd>DapContinue<cr>",  desc = "Continue" },
            { "<f6>",       "<cmd>DapStepOver<cr>",  desc = "Step over" },
            { "<f7>",       "<cmd>DapStepInto<cr>",  desc = "Step over" },
        },
        config = function()
            vim.api.nvim_set_hl(0, "DapBreakpoint", { link = "error" })
            vim.api.nvim_set_hl(0, "DapLogPoint", { link = "attribute" })
            vim.api.nvim_set_hl(0, "DapStopped", { link = "enum" })
            vim.fn.sign_define("DapBreakpoint",
                { text = icons.debugging.breakpoint, texthl = "DapBreakpoint", numhl = "DapBreakpoint" })
            vim.fn.sign_define(
                "DapBreakpointCondition",
                { text = icons.debugging.breakpoint_conditional, texthl = "DapBreakpoint", numhl = "DapBreakpoint" }
            )
            vim.fn.sign_define(
                "DapBreakpointRejected",
                { text = icons.debugging.breakpoint_rejected, texthl = "DapBreakpoint", numhl = "DapBreakpoint" }
            )
            vim.fn.sign_define("DapLogPoint", { text = icons.debugging.logpoint, texthl = "DapLogPoint" })
            vim.fn.sign_define("DapStopped", { text = icons.debugging.current_position, texthl = "DapStopped" })
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        keys = {
            { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle UI" },
        },
        opts = {
            controls = {
                element = "repl",
                enabled = true,
                icons = icons.debugging,
            },
            element_mappings = {},
            expand_lines = true,
            floating = {
                border = require("core.visuals").border,
                mappings = {
                    close = { "q", "<Esc>" },
                },
            },
            force_buffers = true,
            icons = {
                collapsed = "",
                current_frame = "",
                expanded = "",
            },
            layouts = {
                {
                    elements = {
                        {
                            id = "watches",
                            size = 0.30,
                        },
                        {
                            id = "scopes",
                            size = 0.30,
                        },
                        {
                            id = "stacks",
                            size = 0.2,
                        },
                        {
                            id = "breakpoints",
                            size = 0.2,
                        },
                    },
                    position = "left",
                    size = 40,
                },
                {
                    elements = {
                        {
                            id = "repl",
                            size = 0.5,
                        },
                        {
                            id = "console",
                            size = 0.5,
                        },
                    },
                    position = "bottom",
                    size = 10,
                },
            },
            mappings = {
                edit = "e",
                expand = { "<cr>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                repl = "r",
                toggle = "t",
            },
            render = {
                indent = 1,
                max_value_lines = 100,
            },
        },
        dependencies = { "mfussenegger/nvim-dap" },
    },
    {
        ft = require("core.lsp.langlookup").merge_field("filetype"),
        "theHamsta/nvim-dap-virtual-text",
        config = true,
        dependencies = { "mfussenegger/nvim-dap" },
    },
    dependencies = { "mfussenegger/nvim-dap" },
    {
        "mfussenegger/nvim-dap-python",
        event = "BufEnter *.py",
        dependencies = { "mfussenegger/nvim-dap" },
    },
    {
        "Weissle/persistent-breakpoints.nvim",
        keys = {
            { "<leader>db", "<cmd>PBToggleBreakpoint<cr>",         desc = "Toggle breakpoint" },
            { "<leader>dB", "<cmd>PBSetConditionalBreakpoint<cr>", desc = "Conditonal breakpoint" },
        },
        dependencies = { "mfussenegger/nvim-dap" },
        opts = { load_breakpoints_event = { "BufReadPost" } },
    },
}
