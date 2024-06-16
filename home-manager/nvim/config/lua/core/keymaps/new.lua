---@alias condkey.ast.AnyNode condkey.ast.Node | condkey.ast.Action | condkey.ast.Event| condkey.ast.Label | condkey.ast.Variant


---@alias condkey.ast.Node table<string, condkey.ast.AnyNode>
---@alias condkey.ast.Variant table<integer, condkey.ast.Node | condkey.ast.Action | condkey.ast.Event | condkey.ast.Label>

---@class condkey.ast.Action
---@field [1] function() | string
---@field [2] string
---@class condkey.ast.Event
---@field event string
---@field pattern? string
---@field cond? function(evnetargs)
---@field ft? string

---@alias condkey.ast.LabelFromString string
---@class condkey.ast.Label
---@field [1] string
---@field when? condkey.ast.Event

local condkey = {}

---@param action any
---@return boolean
function condkey.is_action(action)
    return type(action) == "table"
        and (type(action[1]) == "string" or type(action[1]) == "function")
        and (type(action[2]) == "string")
end

---@param action any
---@return condkey.ast.Action | nil
function condkey.to_action(action)
    if condkey.is_action(action) then
        if action.when then
            action.when = condkey.to_event(action.when)
        end
        return action
    end
end

---@param event any
---@return boolean
function condkey.is_event(event)
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
function condkey.to_event(event)
    if condkey.is_event(event) then
        if type(event) == "boolean" then
            event = { event }
        else
            event.event = event.event or "BufEnter"
        end
        return event
    end
end

---@param label any
---@return boolean
function condkey.is_label(label)
    local function only_has_correct_keys(l)
        for key, value in pairs(l) do
            if key ~= 1 and key ~= "when" then return false end
        end
        return true
    end
    return type(label) == "string"
        or (type(label) == "table"
            and (label[1] and type(label[1]) == "string")
            and (not label.when or condkey.is_event(label.when))
            and only_has_correct_keys(label))
end

---@param label any
---@return condkey.ast.Label | nil
function condkey.to_label(label)
    if condkey.is_label(label) then
        if type(label) == "string" then
            return { label }
        elseif type(label) == "table" then
            if label.when then
                label.when = condkey.to_event(label.when)
            end
            return label
        end
    end
end

---@param maps any
---@return boolean
function condkey.is_mappings(maps)
    if type(maps) ~= "table" then
        return false
    end

    return vim.iter(maps):all(function(key, value)
        return
            type(key) == "string"
            and ((key == "name" and condkey.is_label(value))
                or (key == "when" and condkey.is_event(value))
                or condkey.is_action(value)
                or condkey.is_mappings(value)
                or condkey.is_variant(value))
    end)
end

---@param maps any
---@return condkey.ast.Node | nil
function condkey.to_mappings(maps)
    if condkey.is_mappings(maps) then
        for key, value in pairs(maps) do
            maps[key] = condkey.to_anynode(value)
        end
        return maps
    end
end

---@param maps any
---@return boolean
function condkey.is_variant(maps)
    return vim.islist(maps) and vim.iter(maps):all(function(value)
        return type(value) == "table" and
            (condkey.is_mappings(value) or condkey.is_action(value) or condkey.is_event(value) or condkey.is_label(value))
    end)
end

---@param maps any
---@return condkey.ast.Variant | nil
function condkey.to_variant(maps)
    if condkey.is_variant(maps) then
        for key, value in pairs(maps) do
            maps[key] = condkey.to_anynode(value)
        end
        return maps
    end
end

---@param maps any
---@return boolean
function condkey.is_anynode(maps)
    return condkey.is_mappings(maps) or condkey.is_action(maps) or condkey.is_event(maps) or
        condkey.is_label(maps) or condkey.is_variant(maps)
end

---@param maps any
---@return condkey.ast.AnyNode | nil
function condkey.to_anynode(maps)
    if condkey.is_anynode(maps) then
        return condkey.to_mappings(maps) or condkey.to_action(maps) or condkey.to_event(maps) or
            condkey.to_label(maps) or condkey.to_variant(maps)
    end
end

---@param node? condkey.ast.AnyNode
---@param when? condkey.ast.Event
---@return condkey.ast.AnyNode | nil
function condkey.add_when(node, when)
    if not node then return end
    if condkey.is_event(node) then
    elseif condkey.is_label(node) or condkey.is_action(node) then
        if node.when == nil then node.when = when end
    elseif condkey.is_variant(node) or condkey.is_mappings(node) then
        for _, child in pairs(node) do
            condkey.add_when(child, node.when ~= nil and node.when or when)
        end
    end
    return node
end

---@param node? condkey.ast.AnyNode
---@param result? condkey.ast.Node
---@param prefix? string
---@return condkey.ast.Node | nil
function condkey.flatten(node, result, prefix)
    if not node then return end
    result = result or {}
    prefix = prefix or ""
    if condkey.is_mappings(node) or condkey.is_variant(node) then
        for key, child in pairs(node) do
            local new_prefix
            if type(key) == "number" or key == "name" or key == "when" then
                new_prefix = prefix
            else
                new_prefix = prefix .. key
            end
            condkey.flatten(child, result, new_prefix)
        end
    elseif condkey.is_action(node) or condkey.is_label(node) then
        if not result[prefix] then
            result[prefix] = {}
        end
        table.insert(result[prefix], node)
    end
    return result
end

---@param maps? condkey.ast.AnyNode
---@param condition? condkey.ast.Event
---@return condkey.ast.Node | nil
function condkey.filter_condition(maps, condition)
    local result = {}
    vim.iter(maps):each(function(key, children)
        result[key] = vim.iter(children):find(function(child)
            return vim.deep_equal(child.when, condition)
        end)
    end)
    return result
end

---@param maps? condkey.ast.AnyNode
---@return condkey.ast.Node | nil
function condkey.get_all_conditions(maps)
    local result = {}
    vim.iter(maps):each(function(key, children)
        result[key] = vim.iter(children):each(function(child)
            if not vim.list_contains(result, child.when) then
                table.insert(result, child.when)
            end
        end)
    end)
    return result
end

print(vim.inspect(condkey.filter_condition(condkey.flatten(condkey.add_when(condkey.to_anynode(
        { ["<leader>l"] = { name = "LSP", a = { { "code action", "codeactioooon" }, { "aösldfj", "öalsdkf", when = { ft = "lua" } } } } }))),
    condkey.to_event({ ft = "lua" }))))
print(vim.inspect(condkey.filter_condition(condkey.flatten(condkey.add_when(condkey.to_anynode(
        { ["<leader>l"] = { name = "LSP", a = { { "code action", "codeactioooon" }, { "aösldfj", "öalsdkf", when = { ft = "lua" } } } } }))),
    nil)))
print(vim.inspect(condkey.get_all_conditions(condkey.flatten(condkey.add_when(condkey.to_anynode(
    { ["<leader>l"] = { name = "LSP", a = { { "code action", "codeactioooon", when = { ft = "lsasdua" } }, { "aösldfj", "öalsdkf", when = { ft = "lua" } } } } }))))))
