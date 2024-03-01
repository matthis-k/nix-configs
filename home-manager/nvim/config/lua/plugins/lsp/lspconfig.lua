return {
    "neovim/nvim-lspconfig",
    dependencies = { "folke/neodev.nvim", opts = {}, },
    event = { "BufReadPre", "BufNewFile" },
}
