local actions = require("actions")
local mappings = {
    -- Better up/down
    j = { "gj", "Better down", expr = true },
    k = { "gk", "Better up", expr = true },

    -- Resize window using <ctrl> arrow keys
    ["<a-up>"] = { "<cmd>resize +2<cr>", "Increase window height" },
    ["<a-down>"] = { "<cmd>resize -2<cr>", "Decrease window height" },
    ["<a-left>"] = { "<cmd>vertical resize -2<cr>", "Decrease window width" },
    ["<a-right>"] = { "<cmd>vertical resize +2<cr>", "Increase window width" },

    -- Move Lines
    ["<a-j>"] = { ":m '>+1<cr>gv=gv", "Move down", mode = "v" },
    ["<a-k>"] = { ":m '<-2<cr>gv=gv", "Move up", mode = "v" },
    ["<a-J>"] = { "<cmd>m .+1<cr>==gi", "Move down", mode = { "n", "i" } },
    ["<a-K>"] = { "<cmd>m .-2<cr>==gi", "Move up", mode = { "n", "i" } },

    -- Clear search with <esc>
    ["<esc>"] = { "<cmd>noh<cr><esc>", "Escape and clear hlsearch", mode = { "i", "n" } },

    -- Next/Prev search result
    n = { "'Nn'[v:searchforward]", "Next search result", expr = true },
    N = { "'nN'[v:searchforward]", "Prev search result", expr = true },

    -- Add undo break-points
    [","] = { ",<c-g>u", "Add undo break-point", mode = "i" },
    ["."] = { ".<c-g>u", "Add undo break-point", mode = "i" },
    [";"] = { ";<c-g>u", "Add undo break-point", mode = "i" },

    -- Make control + backspace work
    ["<c-bs>"] = { "<c-w>", "Control + backspace", mode = "i" },

    -- Better indenting
    ["<"] = { "<gv", "Better indenting", mode = "v" },
    [">"] = { ">gv", "Better indenting", mode = "v" },

    -- Floating terminal
    ["<esc><esc>"] = { "<c-\\><c-n>", "Enter Normal Mode", mode = "t" },

    -- Grouped mappings under <leader>
    ["<leader>"] = {
        ["<tab>"] = {
            name = "Tabs",
            ["<tab>"] = { "<cmd>tabnew %<cr>", "New Tab" },
            l = { "<cmd>tabnext<cr>", "Next Tab (gt)" },
            d = { "<cmd>tabclose<cr>", "Close Tab" },
            h = { "<cmd>tabprevious<cr>", "Previous Tab (gT)" },
        },
        G = {
            name = "Git",
            B = { actions.git.toggle_current_line_blame, "Toggle current line blame" },
            D = { actions.git.diffthis, "Show diff" },
            R = { actions.git.reset_buffer, "Reset buffer" },
            S = { actions.git.stage_buffer, "Stage buffer" },
            d = { actions.git.toggle_deleted, "Toggle deleted" },
            p = { actions.git.preview_hunk, "Preview hunk" },
            r = { actions.git.reset_hunk, "Reset hunk" },
            s = { actions.git.stage_hunk, "Stage hunk" },
            u = { actions.git.undo_stage_hunk, "Undo stage hunk" },
            w = { actions.git.toggle_word_diff, "Toggle word diff" },
        },
        S = {
            name = "Snippets",
            a = { actions.snippets.add, "Add snippet" },
            e = { actions.snippets.edit, "Edit snippet" },
        },
        U = {
            name = "UI",
            t = { actions.ui.toggle_tabline, "Toggle tabline" },
            f = { actions.ui.toggle_unto_tree, "Show floating window" },
            l = { actions.ui.toggle_statusline, "Toggle statusline" },
            z = { actions.ui.toggle_zen_mode, "Toggle Zen mode" }
        },
        a = {
            name = "AI",
            c = { actions.ai.chat, "Chat with AI" },
            e = { actions.ai.edit_code, "AI-assisted code editing" },
        },
        b = {
            name = "Buffer Management",
            b = { "<cmd>e #<cr>", "Switch to Other Buffer" },
            d = { actions.buffer.del, "Delete buffers" },
            q = { actions.buffer.del, "Delete buffers" },
            h = { actions.buffer.prev, "Cycle to previous buffer" },
            l = { actions.buffer.next, "Cycle to next buffer" },
        },
        d = {
            name = "Debug",
            B = { actions.debug.set_conditional_breakpoint, "Set conditional breakpoint" },
            b = { actions.debug.toggle_breakpoint, "Toggle breakpoint" },
            c = { actions.debug.continue, "Continue" },
            h = { actions.debug.step_out, "Step out" },
            j = { actions.debug.step_over, "Step over" },
            l = { actions.debug.step_into, "Step into" },
            s = { actions.debug.stop, "Stop" },
            u = { actions.debug.toggle_ui, "Toggle UI" },
        },
        f = {
            name = "Folds",
            ["+"] = { actions.folds.open_with_level, "Open folds with level 4" },
            ["-"] = { actions.folds.close_with_level, "Close folds with level 4" },
            c = { actions.folds.close_all, "Close all folds" },
            o = { actions.folds.open_all, "Open all folds" },
        },
        l = {
            name = "LSP",
            when = { event = "LspAttatch", enabled = function() return true end, ft = "lua" },
            c = { actions.lsp.code_action, "Code action" },
            d = { actions.lsp.show_diagnostics, "Show diagnostics" },
            g = { actions.lsp.go_to_definition, "Go to definition" },
            h = { actions.lsp.hover, "Hover" },
            n = { actions.lsp.rename, "Rename", when = false },
            r = { actions.lsp.show_references, "Show references" },
        },
        n = {
            name = "Notifications",
            b = { actions.notifications.history, "History" },
            c = { actions.notifications.clear, "Clear Notifications" },
        },
        q = { "<cmd>qa<cr>", "Quit" },
        v = {
            name = "Vim",
            c = { "<cmd>cd " .. vim.fn.stdpath("config") .. " | e $MYVIMRC <cr>", "Config" },
        },
        w = {
            name = "Windows",
            h = { actions.windows.left, "Focus window left (<c-w>h)" },
            j = { actions.windows.down, "Focus window down (<c-w>j)" },
            k = { actions.windows.up, "Focus window up (<c-w>k)" },
            l = { actions.windows.right, "Focus window right (<c-w>l)" },
            m = { actions.windows.maximise, "Delete window" },
            q = { "<c-w>q", "Delete window" },
            w = { "<c-w>p", "Other window" },
            ["-"] = { actions.windows.hsplit, "Split window below" },
            ["|"] = { actions.windows.wsplit, "Split window right" },
        },
    },
    -- Save file
    ["<c-s>"] = { "<cmd>w<cr>", "Save file", mode = { "i", "v", "n", "s" } },
}
mappings = {
    ["<leader>"] = {
        O = {
            name = "tests",
            when = { ft = "lua" },
            T = { function() vim.notify("hello") end, "say hello" },
        },
        M = {
            { "A", "desc A", when = { event = "EnterInsert" }, },
            { "B", "desc B", when = { ft = "lua" }, },
        }

    },
}
return mappings
