local M = {}

local function pathExists(path)
    local stat = vim.uv.fs_stat(path)
    return stat and stat.type or false
end

local function isFile(path)
    local stat = vim.uv.fs_stat(path)
    return stat and stat.type == "file"
end

local function isDir(path)
    local stat = vim.uv.fs_stat(path)
    return stat and stat.type == "directory"
end

local function toNvimPath(path)
    return vim.fn.stdpath("config") .. "/lua/" .. path
end

local function modToPath(mod)
    local base = toNvimPath(mod:gsub("%.", "/"))
    return base .. (pathExists(base) and "" or ".lua")
end

local function ls(path)
    local filenames = {}
    local entries = vim.fn.readdir(path)

    for _, entry in ipairs(entries) do
        table.insert(filenames, entry)
    end

    return filenames
end

function M.dirReq(mod)
    local path = modToPath(mod)
    if not pathExists(path) then
        return nil
    end

    local res = {}

    if isFile(path) then
        res = require(mod)
    elseif isDir(path) then
        for _, filename in ipairs(ls(path)) do
            local submodule_name = filename:gsub("%.lua", "")
            if submodule_name == "init" then goto continue end
            local submodule_path = mod .. "." .. submodule_name
            res[submodule_name] = M.dirReq(submodule_path)
            ::continue::
        end
    end


    return res
end

function M.recursiveCall(tables, fnname)
    for _, sub in pairs(tables) do
        if type(sub) == "table" then
            M.recursiveCall(sub, fnname)
            if sub[fnname] then sub[fnname]() end
        end
    end
end

function M.add_attach(on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            on_attach(client, buffer)
        end,
    })
end

function M.spawn_terminal(cmd)
    require("toggleterm.terminal").Terminal:new({
        cmd = cmd,
        dir = "git_dir",
        direction = "horizontal",
        close_on_exit = false,
    }):toggle()
end

return M
