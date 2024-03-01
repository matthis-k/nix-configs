return {
    filetype = { "rust" },
    lspconfig = { name = "rust_analyzer" },
    treesitter = { "rust" },
    custom_keys = {
        {
            mode = "n",
            lhs = "<leader>ar",
            rhs = function()
                require("utils").spawn_terminal("cargo run")
            end,
            opts = { desc = "cargo run" }
        },
        {
            mode = "n",
            lhs = "<leader>at",
            rhs = function()
                require("utils").spawn_terminal("cargo test")
            end,
            opts = { desc = "cargo test" }
        },
    },
}
