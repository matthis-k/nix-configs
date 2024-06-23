---@alias condkey.NormalizedMaps table<string, condkey.ast.AnyNode>
local NormalizedMaps = {}
NormalizedMaps.__index = NormalizedMaps

---@class condkey.ast.AnyNode
---@field NODE_TYPE "Event" | "Action" | "Label" | "Node" | "Variant"
---@field enable? condkey.ast.Event
---@field disable? condkey.ast.Event
---@field mode? string | string[]
local AnyNode = {}
AnyNode.__index = AnyNode

---@class condkey.ast.Event: condkey.ast.AnyNode
---@field event string
---@field pattern? string
---@field cond? function(evnetargs)
---@field ft? string
local Event = setmetatable({ NODE_TYPE = "Event" }, { __index = AnyNode, })
Event.__index = Event

---@class condkey.ast.Action: condkey.ast.AnyNode
---@field [1] function() | string
---@field [2] string
---@field buffer? number
---@field silent? boolean
---@field noremap? boolean
---@field nowait? boolean
---@field expr? boolean
local Action = setmetatable({ NODE_TYPE = "Action" }, { __index = AnyNode, })
Action.__index = Action

---@class condkey.ast.Label: condkey.ast.AnyNode
---@field name string
local Label = setmetatable({ NODE_TYPE = "Label" }, { __index = AnyNode, })
Label.__index = Label

---@class condkey.ast.Node: condkey.ast.AnyNode
local Node = setmetatable({ NODE_TYPE = "Node" }, { __index = AnyNode, })
Node.__index = Node

---@class condkey.ast.Variant: condkey.ast.AnyNode, table<integer, condkey.ast.Node | condkey.ast.Action | condkey.ast.Event | condkey.ast.Label>
local Variant = setmetatable({ NODE_TYPE = "Variant" }, { __index = AnyNode, })
Variant.__index = Variant

---@param action? any
---@return boolean
function AnyNode:is_action(action)
    if action == nil then action = self end
    return type(action) == "table"
        and (type(action[1]) == "string" or type(action[1]) == "function")
        and (type(action[2]) == "string")
        and ((not action.buffer) or type(action.buffer) == "number")
        and ((not action.silent) or type(action.silent) == "boolean")
        and ((not action.noremap) or type(action.noremap) == "boolean")
        and ((not action.nowaitt) or type(action.nowaitt) == "boolean")
        and ((not action.expr) or type(action.expr) == "boolean")
end

---@param action any
---@return condkey.ast.Action | nil
function Action:new(action)
    if self:is_action(action) then
        if action.enable then
            action.enable = Event:new(action.enable)
        end
        if action.disable then
            action.disable = Event:new(action.disable)
        end
        setmetatable(action, self)
        return action
    end
end

---@param event any
---@return boolean
function AnyNode:is_event(event)
    if event == nil then event = self end
    return type(event) == "table"
        and (not event.event or type(event.event) == "string")
        and (not event.cond or type(event.cond) == "function")
        and (not event.ft or type(event.ft) == "string")
        and (not event.pattern or type(event.pattern) == "string")
        and (not event[1] or type(event[1]) == "boolean")
        and vim.iter(event):all(function(key, _)
            return (key == "event") or (key == "cond") or (key == "ft") or (key == "pattern")
        end)
        or (type(event) == "boolean" and event == false)
end

---@param event any
---@return condkey.ast.Event | nil
function Event:new(event)
    if self:is_event(event) then
        if type(event) == "boolean" then
            event = { event }
        else
            event.event = event.event or "BufEnter"
        end
        setmetatable(event, self)
        return event
    end
end

---@param label any
---@return boolean
function AnyNode:is_label(label)
    if label == nil then label = self end
    -- vim.iter(event) does not use the key if it is an array ({ "label" })
    local function only_has_correct_keys(l)
        for key, _ in pairs(l) do
            if key ~= "name" and key ~= "enable" and key ~= "disable" then return false end
        end
        return true
    end
    return
        (label.NODE_TYPE and label.NODE_TYPE == "Label")
        or (type(label) == "string"
            or (type(label) == "table"
                and (label.name and type(label.name) == "string")
                and (not label.enable or self:is_event(label.enable))
                and (not label.disable or self:is_event(label.disable))
                and only_has_correct_keys(label)))
end

---@param label any
---@return condkey.ast.Label | nil
function Label:new(label)
    if self:is_label(label) then
        if type(label) == "string" then
            return setmetatable({ name = label }, self)
        elseif type(label) == "table" then
            if label.enable then
                label.enable = Event:new(label.enable)
            end
            if label.disable then
                label.disable = Event:new(label.disable)
            end
            setmetatable(label, self)
            return label
        end
    end
end

---@param maps any
---@return boolean
function AnyNode:is_node(maps)
    if maps == nil then maps = self end
    if type(maps) ~= "table" then
        return false
    end
    if AnyNode:is_label(self) then return false end
    return
        (maps.NODE_TYPE and maps.NODE_TYPE == "Node")
        or vim.iter(maps):all(function(key, value)
            return
                type(key) == "string"
                and ((key == "name" and AnyNode:is_label(value))
                    or (key == "enable" and AnyNode:is_event(value))
                    or (key == "disable" and AnyNode:is_event(value))
                    or AnyNode:is_action(value)
                    or AnyNode:is_node(value)
                    or AnyNode:is_variant(value))
        end)
end

---@param maps any
---@return condkey.ast.Node | nil
function Node:new(maps)
    if self:is_node(maps) then
        for key, child in pairs(maps) do
            maps[key] = self:auto(child)
        end
        setmetatable(maps, self)
        return maps
    end
end

---@param maps any
---@return boolean
function AnyNode:is_variant(maps)
    if maps == nil then maps = self end
    return
        (type(maps) == "table" and maps.NODE_TYPE and maps.NODE_TYPE == "Node")
        or vim.islist(maps) and vim.iter(maps):all(function(value)
            return type(value) == "table" and
                (self:is_node(value) or self:is_action(value) or self:is_event(value) or self:is_label(value))
        end)
end

---@param maps any
---@return condkey.ast.Variant | nil
function Variant:new(maps)
    if self:is_variant(maps) then
        for key, child in pairs(maps) do
            maps[key] = AnyNode:auto(child)
        end
        setmetatable(maps, self)
        return maps
    end
end

---@param maps any
---@return boolean
function AnyNode:is_anynode(maps)
    return self:is_node(maps) or self:is_action(maps) or self:is_event(maps) or
        self:is_label(maps) or self:is_variant(maps)
end

---@param maps any
---@return condkey.ast.AnyNode | nil
function AnyNode:auto(maps)
    if AnyNode:is_anynode(maps) then
        return Node:new(maps) or Action:new(maps) or Event:new(maps) or
            Label:new(maps) or Variant:new(maps)
    end
end

---@param self? condkey.ast.AnyNode
---@param key string
---@param value? any
---@return condkey.ast.AnyNode | nil
function AnyNode:propagate_field(key, value)
    if not self then return end
    if self:is_event() then
    elseif self:is_label() or self:is_action() then
        if self[key] == nil then self[key] = value end
    elseif self:is_variant() or self:is_node() then
        for _, child in pairs(self) do
            child:propagate_field(key, self[key] ~= nil and self[key] or value)
        end
    end
    return self
end

---@param self? condkey.ast.AnyNode
---@param result? condkey.ast.Node
---@param prefix? string
---@return condkey.ast.Node | nil
function AnyNode:flatten(result, prefix)
    if not self then return end
    result = result or {}
    prefix = prefix or ""
    if self:is_node() or self:is_variant() then
        for key, child in pairs(self) do
            local new_prefix
            if type(key) == "number" or key == "name" or key == "enable" or key == "disable" then
                new_prefix = prefix
            else
                new_prefix = prefix .. key
            end
            child:flatten(result, new_prefix)
        end
    elseif self:is_action() or self:is_label() then
        if not result[prefix] then
            result[prefix] = {}
        end
        table.insert(result[prefix], self:without_metatable())
    end
    return result
end

---@param self condkey.ast.AnyNode
---@return condkey.ast.AnyNode?
function AnyNode:without_metatable()
    ---@class condkey.ast.AnyNode
    local result = setmetatable(vim.deepcopy(self), nil)
    if self:is_action() or self:is_label() or self:is_event() then
        if result.enable then
            result.enable = result.enable:without_metatable()
        end
        if result.disable then
            result.disable = result.disable:without_metatable()
        end
    end
    return result
end

---@param condition? condkey.ast.Event
---@return condkey.NormalizedMaps
function NormalizedMaps:filter_enable(condition)
    local result = {}
    vim.iter(self):each(function(key, children)
        result[key] = vim.deepcopy(vim.iter(children):find(function(child)
            return vim.deep_equal(child.enable, condition)
        end))
        if result[key] then
            result[key].enable = nil
        end
        if result[key] then
            result[key].disable = nil
        end
    end)
    return result
end

---@param condition? condkey.ast.Event
---@return condkey.NormalizedMaps
function NormalizedMaps:filter_disable(condition)
    local result = {}
    vim.iter(self):each(function(key, children)
        result[key] = vim.deepcopy(vim.iter(children):find(function(child)
            return vim.deep_equal(child.disable, condition)
        end))
        if result[key] then
            result[key].enable = nil
        end
        if result[key] then
            result[key].disable = nil
        end
    end)
    vim.iter(result):each(function(k, value)
        if k == "name" then
            result[k] = false
        end
        if AnyNode:is_action(value) then
            value[1] = "<nop>"
        elseif AnyNode:is_label(value) then
            value.name = "which_key_ignore"
        end
    end)
    return result
end

---@return condkey.ast.Node
function NormalizedMaps:get_conditions()
    local result = {}
    vim.iter(self):each(function(key, children)
        result[key] = vim.iter(children):each(function(child)
            if not vim.iter(result):find(function(condition)
                    return vim.deep_equal(child.enable, condition)
                end) then
                table.insert(result, child.enable)
            end
            if not vim.iter(result):find(function(condition)
                    return vim.deep_equal(child.disable, condition)
                end) then
                table.insert(result, child.disable)
            end
        end)
    end)
    return result
end

---@return condkey.NormalizedMaps
function NormalizedMaps:new(maps)
    return setmetatable(AnyNode:auto(maps):propagate_field("enable"):propagate_field("disable"):flatten() or {},
        NormalizedMaps)
end

function NormalizedMaps:setup()
    local autocommand_group = vim.api.nvim_create_augroup("CondKey", { clear = true })
    local wk = require("which-key")
    wk.register(self:filter_enable())
    for _, cond in pairs(self:get_conditions()) do
        vim.api.nvim_create_autocmd(cond.event, {
            group = autocommand_group,
            pattern = cond.pattern,
            desc = "Manage keymaps from condeky",
            callback = function(ev)
                if cond.ft and cond.ft ~= vim.api.nvim_get_option_value("filetype", { buf = 0 }) then
                    return
                end
                if cond.cond and not cond.cond(ev) then
                    return
                end
                wk.register(self:filter_disable(cond))
                wk.register(self:filter_enable(cond))
            end
        })
    end
end

local counter = 1
local function even_counter()
    counter = counter + 1
    return counter % 2 == 0
end

local maps = NormalizedMaps:new({
    ["<leader>r"] = {
        name = "TEST",
        r = { function()
            vim.notify("TEST WORKS", vim.log.levels.INFO)
        end, "print stuff" },
        enable = { event = "BufWritePre", cond = even_counter },
        disable = { event = "BufWritePost", cond = function() return counter % 2 == 1 end }
    }
})
maps:setup()
