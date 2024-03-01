return {
    filetype = { "bash", "sh" },
    lspconfig = { name = "bashls" },
    treesitter = { "bash" },
    null_ls = { formatting = { "shfmt", "shellharden" } },
    custom_keys = {
        {
            mode = "n",
            lhs = "<leader>ar",
            rhs = function()
                local current_buffer = vim.api.nvim_get_current_buf()
                local buffer_name = vim.api.nvim_buf_get_name(current_buffer)
                require("utils").spawn_terminal("bash " .. buffer_name)
            end,
            opts = { desc = "run file" }
        },
        {
            mode = "n",
            lhs = "<leader>ax",
            rhs = function()
                local current_buffer = vim.api.nvim_get_current_buf()
                local buffer_name = vim.api.nvim_buf_get_name(current_buffer)
                os.execute("chmod +x " .. buffer_name)
            end,
            opts = { desc = "make executable" }
        },
    },
}
