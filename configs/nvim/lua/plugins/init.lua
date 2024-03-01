local opts = {
    root = vim.fn.stdpath("data") .. "/lazy",
    defaults = {
        lazy = false,
        version = nil,
        cond = nil,
        -- version = "*",
    },
    spec = nil,
    lockfile = vim.fn.stdpath("config") .. "/.lazy-lock.json",
    concurrency = nil,
    git = {
        -- log = { "-10" },
        log = { "--since=3 days ago" },
        timeout = 120,
        url_format = "https://github.com/%s.git",
        filter = true,
    },
    dev = {
        path = "~/projects",
        ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
        patterns = {},
        fallback = false,
    },
    install = {
        missing = true,
        colorscheme = { "catppuccin" },
    },
    ui = {
        size = { width = 0.8, height = 0.8 },
        wrap = true,
        border = require("core.visuals").border,
        icons = {
            cmd = " ",
            config = "",
            event = "",
            ft = " ",
            init = " ",
            import = " ",
            keys = " ",
            lazy = "󰒲 ",
            loaded = "●",
            not_loaded = "○",
            plugin = " ",
            runtime = " ",
            source = " ",
            start = "",
            task = "✔ ",
            list = {
                "●",
                "➜",
                "★",
                "‒",
            },
        },
        browser = "firefox", ---@type string?
        throttle = 20,
        custom_keys = {},
    },
    diff = {
        cmd = "git",
    },
    checker = {
        enabled = false,
        concurrency = nil, ---@type number? set to 1 to check for updates very slowly
        notify = true,
        frequency = 3600,
    },
    change_detection = {
        enabled = true,
        notify = false,
    },
    performance = {
        cache = {
            enabled = true,
        },
        reset_packpath = true,
        rtp = {
            reset = true,
            ---@type string[]
            paths = {},
            ---@type string[] list any plugins you want to disable here
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    readme = {
        enabled = true,
        root = vim.fn.stdpath("state") .. "/lazy/readme",
        files = { "README.md", "lua/**/README.md" },
        skip_if_doc_exists = true,
    },
    state = vim.fn.stdpath("state") .. "/lazy/state.json",
}

return {
    setup = function()
        local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
        if not vim.uv.fs_stat(lazypath) then
            vim.fn.system({
                "git",
                "clone",
                "--filter=blob:none",
                "https://github.com/folke/lazy.nvim.git",
                "--branch=stable", -- latest stable release
                lazypath,
            })
        end
        vim.opt.rtp:prepend(lazypath)

        require("lazy").setup({
            {
                "folke/lazy.nvim",
                keys = {
                    { "<leader>vl", "<cmd>:Lazy<cr>", desc = "Lazy" },
                },
            },
            { import = "plugins.lsp" },
            { import = "plugins.completion" },
            { import = "plugins.debug" },
            { import = "plugins.editor" },
            { import = "plugins.lsp" },
            { import = "plugins.other" },
            { import = "plugins.ui" },
        }, opts)
    end
}
