return {
    -- Better up/down
    { mode = "n",                    lhs = "j",                  rhs = "v:count == 0 ? 'gj' : 'j'",   opts = { expr = true } },
    { mode = "n",                    lhs = "k",                  rhs = "v:count == 0 ? 'gk' : 'k'",   opts = { expr = true } },
    -- Resize window using <ctrl> arrow keys
    { mode = "n",                    lhs = "<c-up>",             rhs = "<cmd>resize +2<cr>",          opts = { desc = "Increase window height" } },
    { mode = "n",                    lhs = "<c-down>",           rhs = "<cmd>resize -2<cr>",          opts = { desc = "Decrease window height" } },
    { mode = "n",                    lhs = "<c-left>",           rhs = "<cmd>vertical resize -2<cr>", opts = { desc = "Decrease window width" } },
    { mode = "n",                    lhs = "<c-right>",          rhs = "<cmd>vertical resize +2<cr>", opts = { desc = "Increase window width" } },
    -- Move Lines
    { mode = "v",                    lhs = "<a-j>",              rhs = ":m '>+1<cr>gv=gv",            opts = { desc = "Move down" } },
    { mode = "v",                    lhs = "<a-k>",              rhs = ":m '<-2<cr>gv=gv",            opts = { desc = "Move up" } },
    { mode = "n",                    lhs = "<a-J>",              rhs = "<cmd>m .+1<cr>==",            opts = { desc = "Move down" } },
    { mode = "n",                    lhs = "<a-K>",              rhs = "<cmd>m .-2<cr>==",            opts = { desc = "Move up" } },
    { mode = "i",                    lhs = "<a-J>",              rhs = "<esc><cmd>m .+1<cr>==gi",     opts = { desc = "Move down" } },
    { mode = "i",                    lhs = "<a-K>",              rhs = "<esc><cmd>m .-2<cr>==gi",     opts = { desc = "Move up" } },
    -- Switch to Other Buffer
    { mode = "n",                    lhs = "<leader>bb",         rhs = "<cmd>e #<cr>",                opts = { desc = "Switch to Other Buffer" } },
    { mode = "n",                    lhs = "<leader>bq",         rhs = "<cmd>bdelete %<cr>",          opts = { desc = "Delete Buffer" } },
    -- Quit
    { mode = "n",                    lhs = "<leader>q",          rhs = "<cmd>qa<cr>",                 opts = { desc = "Quit" } },
    -- Save
    { mode = { "i", "v", "n", "s" }, lhs = "<c-s>",              rhs = "<cmd>w<cr>",                  opts = { desc = "Save file" } },
    -- Clear search with <esc>
    { mode = { "i", "n" },           lhs = "<esc>",              rhs = "<cmd>noh<cr><esc>",           opts = { desc = "Escape and clear hlsearch" } },
    -- Next/Prev search result
    { mode = "n",                    lhs = "n",                  rhs = "'Nn'[v:searchforward]",       opts = { expr = true, desc = "Next search result" } },
    { mode = "x",                    lhs = "n",                  rhs = "'Nn'[v:searchforward]",       opts = { expr = true, desc = "Next search result" } },
    { mode = "o",                    lhs = "n",                  rhs = "'Nn'[v:searchforward]",       opts = { expr = true, desc = "Next search result" } },
    { mode = "n",                    lhs = "N",                  rhs = "'nN'[v:searchforward]",       opts = { expr = true, desc = "Prev search result" } },
    { mode = "x",                    lhs = "N",                  rhs = "'nN'[v:searchforward]",       opts = { expr = true, desc = "Prev search result" } },
    { mode = "o",                    lhs = "N",                  rhs = "'nN'[v:searchforward]",       opts = { expr = true, desc = "Prev search result" } },
    -- Add undo break-points
    { mode = "i",                    lhs = ",",                  rhs = ",<c-g>u" },
    { mode = "i",                    lhs = ".",                  rhs = ".<c-g>u" },
    { mode = "i",                    lhs = ";",                  rhs = ";<c-g>u" },
    -- Make control + backspace work
    { mode = { "i" },                lhs = "<c-bs>",             rhs = "<c-w>", },
    -- Better indenting
    { mode = "v",                    lhs = "<",                  rhs = "<gv" },
    { mode = "v",                    lhs = ">",                  rhs = ">gv" },
    -- Plugins


    -- Floating terminal
    { mode = "t",                    lhs = "<esc><esc>",         rhs = "<c-\\><c-n>",                 opts = { desc = "Enter Normal Mode" } },
    -- Windows
    { mode = "n",                    lhs = "<leader>ww",         rhs = "<c-W>p",                      opts = { desc = "Other window" } },
    { mode = "n",                    lhs = "<leader>wd",         rhs = "<c-W>c",                      opts = { desc = "Delete window" } },
    { mode = "n",                    lhs = "<leader>w-",         rhs = "<c-W>s",                      opts = { desc = "Split window below" } },
    { mode = "n",                    lhs = "<leader>w|",         rhs = "<c-W>v",                      opts = { desc = "Split window right" } },
    -- Tabs
    { mode = "n",                    lhs = "<leader><tab><tab>", rhs = "<cmd>tabnew %<cr>",           opts = { desc = "New Tab" } },
    { mode = "n",                    lhs = "<leader><tab>l",     rhs = "<cmd>tabnext<cr>",            opts = { desc = "Next Tab (gt)" } },
    { mode = "n",                    lhs = "<leader><tab>d",     rhs = "<cmd>tabclose<cr>",           opts = { desc = "Close Tab" } },
    { mode = "n",                    lhs = "<leader><tab>h",     rhs = "<cmd>tabprevious<cr>",        opts = { desc = "Previous Tab (gT)" } },

    -- vim realated stuff
    {
        mode = "n",
        lhs = "<leader>vc",
        rhs = "<cmd>cd " .. vim.fn.stdpath("config") .. " | e $MYVIMRC <cr>",
        opts = { desc = "Config" }
    },
}
