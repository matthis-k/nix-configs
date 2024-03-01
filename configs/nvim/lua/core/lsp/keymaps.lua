local M = {}

M.global = {
    { lhs = "gl",         rhs = vim.diagnostic.open_float, opts = { desc = "Open diagnostics" },                          mode = "n", },
    { lhs = "<leader>lk", rhs = vim.diagnostic.goto_prev,  opts = { silent = true, desc = "Go to previous diagnostic", }, mode = "n", },
    { lhs = "<leader>lj", rhs = vim.diagnostic.goto_next,  opts = { silent = true, desc = "Go to next diagnostic", },     mode = "n", },
}

M.on_attach = {
    { lhs = "gD",         rhs = vim.lsp.buf.declaration,                                                 opts = { silent = true, desc = "Go to declaration", },       mode = "n",          needs = "textDocument/declaration*", },
    { lhs = "gd",         rhs = vim.lsp.buf.definition,                                                  opts = { silent = true, desc = "Go to definition", },        mode = "n",          needs = "textDocument/definition", },
    { lhs = "K",          rhs = vim.lsp.buf.hover,                                                       opts = { silent = true, desc = "Show hover information", },  mode = "n",          needs = "textDocument/hover", },
    { lhs = "gI",         rhs = vim.lsp.buf.implementation,                                              opts = { silent = true, desc = "Go to implementation", },    mode = "n",          needs = "textDocument/implementation*", },
    { lhs = "<space>lwa", rhs = vim.lsp.buf.add_workspace_folder,                                        opts = { silent = true, desc = "Add workspace folder", },    mode = "n",          needs = "workspace.workspaceFolders.supported", },
    { lhs = "<space>lwr", rhs = vim.lsp.buf.remove_workspace_folder,                                     opts = { silent = true, desc = "Remove workspace folder", }, mode = "n",          needs = "workspace.workspaceFolders.supported", },
    { lhs = "<space>lwl", rhs = function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts = { silent = true, desc = "List workspace folders", },  mode = "n",          needs = "workspace.workspaceFolders.supported", },
    { lhs = "<space>lD",  rhs = vim.lsp.buf.type_definition,                                             opts = { silent = true, desc = "Go to type definition", },   mode = "n",          needs = "textDocument/typeDefinition*", },
    { lhs = "<space>lr",  rhs = vim.lsp.buf.rename,                                                      opts = { silent = true, desc = "Rename symbol", },           mode = "n",          needs = "textDocument/rename", },
    { lhs = "<space>la",  rhs = vim.lsp.buf.code_action,                                                 opts = { silent = true, desc = "Code action", },             mode = { "n", "v" }, needs = "textDocument/codeAction", },
    { lhs = "gr",         rhs = "<cmd>Telescope lsp_references<cr>",                                     opts = { silent = true, desc = "Find references", },         mode = "n",          needs = "textDocument/references", },
    { lhs = "<space>lf",  rhs = function() vim.lsp.buf.format { async = true } end,                      opts = { silent = true, desc = "Format document", },         mode = "n",          needs = "textDocument/formatting", },
    { lhs = "<space>li",  rhs = require("core.lsp").toggle_inlay_hints,                                  opts = { silent = true, desc = "Toggle inlay hints", },      mode = "n",          needs = "textDocument/inlayHint", },
}

return M
