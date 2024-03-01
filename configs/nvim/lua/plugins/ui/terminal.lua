local custom_terms = {}

function custom_terms.toggle(name)
    if custom_terms[name] then
        custom_terms[name]:toggle()
    end
end

return {
    {
        "akinsho/toggleterm.nvim",
        event = "VeryLazy",
        version = "*",
        keys = {
            {
                "<leader>gg",
                function()
                    custom_terms.toggle("lazygit")
                end,
                desc = "Toggle lazygit",
            },
            {
                "<leader>tg",
                function()
                    custom_terms.toggle("lazygit")
                end,
                desc = "Toggle lazygit",
            },
            {
                "<leader>th",
                function()
                    custom_terms.toggle("btm")
                end,
                desc = "Toggle btm",
            },
            {
                "<c-t>",
                function()
                    local term = custom_terms["bottom_term"]
                    local open = term:is_open()
                    local focused = term:is_focused()
                    if focused or not open then
                        term:toggle()
                    else
                        term:focus()
                        vim.cmd("startinsert")
                    end
                end,
                mode = { "n", "i", "t" },
                desc = "Toggle or focus terminal",
            }
        },
        opts = {
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            open_mapping = nil,
            hide_numbers = true,
            shade_filetypes = {},
            autochdir = true,
            shade_terminals = false,
            start_in_insert = true,
            insert_mappings = true,
            terminal_mappings = true,
            persist_size = true,
            persist_mode = true,
            direction = "horizontal",
            close_on_exit = true,
            shell = vim.o.shell,
            auto_scroll = true,
            float_opts = {
                border = require("core.visuals").border,
                winblend = 3,
            },
            winbar = {
                enabled = false,
                name_formatter = function(term)
                    return term.name
                end,
            },
        },
        config = function(_, opts)
            require("toggleterm").setup(opts)
            local Terminal = require("toggleterm.terminal").Terminal
            local cmds = { "lazygit", "btm" }
            for _, cmd in pairs(cmds) do
                custom_terms[cmd] = Terminal:new({
                    cmd = cmd,
                    dir = "git_dir",
                    direction = "tab",
                })
            end
            custom_terms["bottom_term"] = Terminal:new()
        end,
    },
}
