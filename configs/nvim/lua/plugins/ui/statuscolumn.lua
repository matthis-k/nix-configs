return {
    {
        "luukvbaal/statuscol.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = function()
            local builtin = require("statuscol.builtin")
            return {
                setopt = true,
                thousands = false,
                relculright = true,
                ft_ignore = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "toggleterm" },


                bt_ignore = nil,
                segments = {
                    { text = { " " }, },
                    { text = { builtin.foldfunc },                                            click = "v:lua.ScFa" },  -- StatusColumn FoldAction
                    { sign = { name = { ".*" }, namespace = { "diagnostic" }, maxwidth = 1 }, click = "v:lua.ScSa", },
                    { text = { builtin.lnumfunc, " " },                                       click = "v:lua.ScLa", }, -- StatusColumn LineAction
                    { sign = { name = { ".*" }, namespace = { "gitsigns" }, colwidth = 1 },   click = "v:lua.ScSa", },
                },
                clickmod = "c",
                clickhandlers = {
                    Lnum                    = builtin.toggle_breakpoint,
                    FoldClose               = builtin.foldclose_click,
                    FoldOpen                = builtin.foldopen_click,
                    FoldOther               = builtin.foldother_click,
                    DapBreakpointRejected   = builtin.toggle_breakpoint,
                    DapBreakpoint           = builtin.toggle_breakpoint,
                    DapBreakpointCondition  = builtin.toggle_breakpoint,
                    DiagnosticSignError     = builtin.diagnostic_click,
                    DiagnosticSignHint      = builtin.diagnostic_click,
                    DiagnosticSignInfo      = builtin.diagnostic_click,
                    DiagnosticSignWarn      = builtin.diagnostic_click,
                    GitSignsTopdelete       = builtin.gitsigns_click,
                    GitSignsUntracked       = builtin.gitsigns_click,
                    GitSignsAdd             = builtin.gitsigns_click,
                    GitSignsChange          = builtin.gitsigns_click,
                    GitSignsChangedelete    = builtin.gitsigns_click,
                    GitSignsDelete          = builtin.gitsigns_click,
                    gitsigns_extmark_signs_ = builtin.gitsigns_click,
                },
            }
        end
    }
}
