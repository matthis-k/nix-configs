return {
    {
        "hrsh7th/nvim-cmp",
        version = false, -- last release is way too old
        event = { "InsertEnter", "CmdLineEnter" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            {
                "saadparwaiz1/cmp_luasnip",
                dependencies = {
                    {
                        "L3MON4D3/LuaSnip",
                        config = function(_, _)
                            require("luasnip.loaders.from_vscode").lazy_load { paths = { vim.fn.stdpath("config") .. "/snippets" } }
                        end
                    },
                },
            },
            "hrsh7th/cmp-cmdline",
            "onsails/lspkind.nvim",
        },
        opts = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            return {
                window = {
                    completion = { border = require("core.visuals").border },
                    documentation = { border = require("core.visuals").border },
                },
                completion = {
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                    completeopt = "menu,menuone,noinsert,noselect",
                },
                preselect = "None",
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ["<c-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<c-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<c-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<c-f>"] = cmp.mapping.scroll_docs(4),
                    ['<C-j>'] = cmp.mapping(function(fallback)
                        if luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s", "n" }),
                    ['<C-k>'] = cmp.mapping(function(fallback)
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s", "n" }),
                    ["<c-space>"] = cmp.mapping.complete(),
                    ["<c-e>"] = cmp.mapping.abort(),
                    ["<cr>"] = cmp.mapping({
                        i = function(fallback)
                            if cmp.visible() and cmp.get_active_entry() then
                                if luasnip.expandable() then
                                    luasnip.expand()
                                else
                                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                                end
                            else
                                fallback()
                            end
                        end,
                        s = cmp.mapping.confirm({ select = true }),
                        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
                    }),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                }, {
                    { name = "buffer" },
                }),
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry,
                            vim_item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        kind.kind = " " .. (strings[1] or "") .. " "
                        kind.menu = "    (" .. (strings[2] or "") .. ")"
                        return kind
                    end,
                },
                experimental = {
                    ghost_text = {
                        hl_group = "LspCodeLens",
                    },
                },
            }
        end,
        config = function(_, opts)
            local cmp = require("cmp")
            cmp.setup(opts)
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end,
    },
}
