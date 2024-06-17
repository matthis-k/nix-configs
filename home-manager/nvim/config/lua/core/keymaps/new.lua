---@alias condkey.NormalizedMaps table<string, condkey.ast.AnyNode>
local NormalizedMaps = {}
NormalizedMaps.__index = NormalizedMaps

---@class condkey.ast.AnyNode
---@field NODE_TYPE "Event" | "Action" | "Label" | "Node" | "Variant"
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
---@field when? condkey.ast.Event
local Action = setmetatable({ NODE_TYPE = "Action" }, { __index = AnyNode, })
Action.__index = Action

---@class condkey.ast.Label: condkey.ast.AnyNode
---@field [1] string
---@field when? condkey.ast.Event
local Label = setmetatable({ NODE_TYPE = "Label" }, { __index = AnyNode, })
Label.__index = Label

---@class condkey.ast.Node: condkey.ast.AnyNode
---@field when? condkey.ast.Event
local Node = setmetatable({ NODE_TYPE = "Node" }, { __index = AnyNode, })
Node.__index = Node

---@class condkey.ast.Variant: condkey.ast.AnyNode, table<integer, condkey.ast.Node | condkey.ast.Action | condkey.ast.Event | condkey.ast.Label>
local Variant = setmetatable({ NODE_TYPE = "Variant" }, { __index = AnyNode, })
Variant.__index = Variant

function AnyNode:validate(object, validators, fallback)
    if type(validators) == "table" and type(object) == "table" then
        for key, validator in pairs(validators) do
            local value = object[key]
            if type(validator) == "function" and not validator(value) then
                return false
            elseif type(validator) == "string" and type(value) ~= validator then
                return false
            elseif type(validator) == "table" then
                if not vim.iter(validator):any(function(val) return AnyNode:validate(value, val[1], val.fallback) end) then
                    return false
                elseif not AnyNode:validate(value, validator) then
                    return false
                end
            end
        end
        if fallback then
            for key, value in pairs(object) do
                if not validators[key] and not fallback(value) then
                    return false
                end
            end
        end
    elseif type(validators) == "table" and vim.iter(validators):all(function(validator)
            return type(validator) == "string"
        end) and not vim.list_contains(validators, type(object)) then
        return false
    elseif type(validators) == "string" and type(object) ~= validators then
        return false
    elseif type(validators) == "function" and not validators(object) then
        return false
    end
    return true
end

---@param action? any
---@return boolean
function AnyNode:is_action(action)
    return type(action) == "table"
        and (type(action[1]) == "string" or type(action[1]) == "function")
        and (type(action[2]) == "string")
end

---@param action any
---@return condkey.ast.Action | nil
function Action:new(action)
    if self:is_action(action) then
        if action.when then
            action.when = Event:new(action.when)
        end
        setmetatable(action, self)
        return action
    end
end

---@param event any
---@return boolean
function AnyNode:is_event(event)
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
            if key ~= 1 and key ~= "when" then return false end
        end
        return true
    end
    return
        (label.NODE_TYPE and label.NODE_TYPE == "Label")
        or (type(label) == "string"
            or (type(label) == "table"
                and (label[1] and type(label[1]) == "string")
                and (not label.when or self:is_event(label.when))
                and only_has_correct_keys(label)))
end

---@param label any
---@return condkey.ast.Label | nil
function Label:new(label)
    if self:is_label(label) then
        if type(label) == "string" then
            return setmetatable({ label }, self)
        elseif type(label) == "table" then
            if label.when then
                label.when = Event:new(label.when)
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
    return
        (maps.NODE_TYPE and maps.NODE_TYPE == "Node")
        or vim.iter(maps):all(function(key, value)
            return
                type(key) == "string"
                and ((key == "name" and AnyNode:is_label(value))
                    or (key == "when" and AnyNode:is_event(value))
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
---@param when? condkey.ast.Event
---@return condkey.ast.AnyNode | nil
function AnyNode:propagate_when(when)
    if not self then return end
    if self:is_event(self) then
    elseif self:is_label() or self:is_action() then
        if self.when == nil then self.when = when end
    elseif self:is_variant(self) or self:is_node(self) then
        for _, child in pairs(self) do
            child:propagate_when(self.when ~= nil and self.when or when)
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
            if type(key) == "number" or key == "name" or key == "when" then
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
    local result = setmetatable(vim.deepcopy(self), nil)
    if self:is_action() or self:is_label() or self:is_event() then
        if result.when then
            ---@type condkey.ast.AnyNode?
            result.when = result.when:without_metatable()
        end
    end
    return result
end

---@param condition? condkey.ast.Event
---@return condkey.NormalizedMaps
function NormalizedMaps:filter_condition(condition)
    local result = {}
    vim.iter(self):each(function(key, children)
        result[key] = vim.deepcopy(vim.iter(children):find(function(child)
            return vim.deep_equal(child.when, condition)
        end))
        if result[key] then
            result[key].when = nil
        end
    end)
    return result
end

---@return condkey.ast.Node
function NormalizedMaps:get_all_conditions()
    local result = {}
    vim.iter(self):each(function(key, children)
        result[key] = vim.iter(children):each(function(child)
            if not vim.iter(result):find(function(condition)
                    return vim.deep_equal(child.when, condition)
                end) then
                table.insert(result, child.when)
            end
        end)
    end)
    return result
end

---@return condkey.NormalizedMaps
function NormalizedMaps:new(maps)
    return setmetatable(AnyNode:auto(maps):propagate_when():flatten() or {}, NormalizedMaps)
end

-- vim.print(AnyNode:is_event(false))
-- vim.print(AnyNode:validate({ ft = "lua", }, { ft = { "nil", "string" } }))

local maps = NormalizedMaps:new({ ["<leader>l"] = { name = { { "LSP" }, { "lua", when = { ft = "lua" } } }, a = { { "code action", "codeactioooon" }, { "aösldfj", "öalsdkf", when = { ft = "lua" } } } } })
vim.print("no condition -> " .. vim.inspect(maps:filter_condition()))
for _, condition in pairs(maps:get_all_conditions()) do
    vim.print(vim.inspect(condition) .. " -> " .. vim.inspect(maps:filter_condition(condition)))
end
