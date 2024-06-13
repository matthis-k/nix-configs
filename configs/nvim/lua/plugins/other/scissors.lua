return {
    {
        "chrisgrieser/nvim-scissors",
        keys = {
            { "<leader>Se", function() require("scissors").editSnippet() end,   desc = "Edit" },
            { "<leader>Sa", function() require("scissors").addNewSnippet() end, desc = "Add", mode = "x" },
        },
        dependencies = "nvim-telescope/telescope.nvim",
        opts = {
            snippetDir = vim.fn.stdpath("config") .. "/snippets/",
        }
    },
}
