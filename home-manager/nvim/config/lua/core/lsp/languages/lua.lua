return {
    filetype = { "lua" },
    lspconfig = {
        name = "lua_ls",
        opts = {
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT'
                    },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            unpack(vim.api.nvim_get_runtime_file("", true)),
                            "${3rd}/luv/library",
                        }
                    },
                    hint = {
                        enable = false,
                        arrayIndex = "Auto",
                        await = true,
                        paramName = "All",
                        paramType = true,
                        semicolon = "SameLine",
                        setType = false,
                    },
                },
            },
        },
    },
    treesitter = { "lua" },
    custom_keys = {
        { mode = "n", lhs = "<leader>vs", rhs = "<cmd>so %<cr>", opts = { desc = "source file" } },
        {
            mode = "n",
            lhs = "<leader>ar",
            rhs = function()
                local current_buffer = vim.api.nvim_get_current_buf()
                local buffer_name = vim.api.nvim_buf_get_name(current_buffer)
                require("utils").spawn_terminal("lua " .. buffer_name)
            end,
            opts = { desc = "run file" }
        },
        {
            mode = "n",
            lhs = "<leader>as",
            rhs = "<cmd>source %<cr>",
            opts = { desc = "run file" }
        },
    },
}
