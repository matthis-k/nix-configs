return {
    "kevinhwang91/nvim-ufo",
    dependencies = { "nvim-treesitter/nvim-treesitter", "kevinhwang91/promise-async" },
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        { "zR", function() require("ufo").openAllFolds() end,    desc = "Open all folds" },
        { "zM", function() require("ufo").closeAllFolds() end,   desc = "Close all folds" },
        { "zr", function() require("ufo").openFoldsWith(4) end,  desc = "Open fold level 5" },
        { "zm", function() require("ufo").closeFoldsWith(4) end, desc = "Close fold level 5" },
    },
    otps = {
        provider_selector = function(_, _, _)
            return { 'treesitter', 'indent' }
        end,
        {
            open_fold_hl_timeout = 150,
            close_fold_kinds = { 'imports', 'comment' },
            preview = {
                win_config = {
                    border = require("core.visuals").border,
                    winhighlight = 'Normal:Folded',
                    winblend = 0
                },
                mappings = {
                    scrollU = '<c-u>',
                    scrollD = '<c-d>',
                    jumpTop = '[',
                    jumpBot = ']'
                }
            },
        }
    },

    config = function(opts)
        require("ufo").setup(opts)
    end
}
