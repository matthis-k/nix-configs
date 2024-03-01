return {
    {
        "chrisgrieser/nvim-spider",
        keys = {
            { "w",  function() require('spider').motion('w') end,    mode = { "n", "o", "x" }, desc = "Next word", },
            { "cw", "vh<cmd>lua require('spider').motion('e')<cr>c", mode = { "n" },           desc = "Next word" },
            { "dw", "vh<cmd>lua require('spider').motion('e')<cr>d", mode = { "n" },           desc = "Next word" },
            { "yw", "vh<cmd>lua require('spider').motion('e')<cr>y", mode = { "n" },           desc = "Next word" },
            { "e",  function() require('spider').motion('e') end,    mode = { "n", "o", "x" }, desc = "Next word end", },
            { "b",  function() require('spider').motion('b') end,    mode = { "n", "o", "x" }, desc = "Prev word", },
        },
    },
}
