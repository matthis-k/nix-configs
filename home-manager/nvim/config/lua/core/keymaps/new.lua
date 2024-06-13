---@class EventKeybindCache
---@field [0] Event
---@field [1] Keybind[]

---@class Mappings
---@field mappings Keybind[]

---@class Event
---@field event? string
---@field cond?  fun(args)
---@field pattern? string

---@class Keybind
---@field trigger string|fun()
---@field action string|fun()
---@field description? string
---@field when? Event|Event[]


local Mappings = {}
Mappings.__index = Mappings

function Mappings:new(maps)
    local instance = setmetatable({}, self)
    instance.mappings = vim.deepcopy(maps)
    instance:propagate_when()
    instance:trim()
    instance:flatten()
    return instance
end

local function is_leaf_mapping(map)
    return type(map) == "table" and
        map[1] and vim.list_contains({ "string", "function" }, type(map[1])) and
        map[2] and vim.list_contains({ "string", "nil" }, type(map[2]))
end

local function propagate_when(tbl, parent_when)
    if type(tbl) ~= "table" then return tbl end

    if tbl.when == nil then
        tbl.when = parent_when
    end

    if not is_leaf_mapping(tbl) then
        for key, child in pairs(tbl) do
            if not vim.list_contains({ "name", "when" }, key) then
                propagate_when(child, tbl.when)
            end
        end
    end
    return tbl
end
function Mappings:propagate_when()
    propagate_when(self.mappings)
    return self
end

local function flatten_maps(mappings, result, prefix)
    prefix = prefix or ""
    result = result or {}
    for key, value in pairs(mappings) do
        if key == "name" then
            result[prefix] = value
        elseif is_leaf_mapping(value) then
            local trigger = prefix .. key
            if not result[trigger] then
                result[trigger] = { value }
            else
                table.insert(result[trigger], value)
            end
        elseif vim.isarray(value) then
            vim.iter(value):each(function(map_group) flatten_maps(map_group, result, prefix .. key) end)
        elseif type(value) == "table" then
            flatten_maps(value, result, prefix .. key)
        end
    end
    return result
end

function Mappings:flatten()
    self.mappings = flatten_maps(self.mappings)
    return self
end

local function trim_maps(tbl)
    if type(tbl) ~= "table" then return tbl end
    local children = {}
    if not is_leaf_mapping(tbl) then
        for key, child in pairs(tbl) do
            if not vim.list_contains({ "name", "when" }, key) and type(child) == "table" then
                trim_maps(child)
                table.insert(children, child)
            end
        end
    end
    local has_unconditional_child = vim.iter(children):any(function(child) return not child.when end)
    if has_unconditional_child or tbl.when == false then tbl.when = nil end
end

function Mappings:trim()
    trim_maps(self.mappings)
    return self
end

function Mappings:get_maps_for_condition(cond)
    return vim.iter(self.mappings)
        :map(function(trigger, entries)
            if type(entries) ~= "table" then return end
            local entry = vim.iter(entries)
                :find(function(entry)
                    return vim.deep_equal(entry.when, cond)
                end)
            if entry then
                return { trigger, unpack(entry) }
            end
        end)
        :totable()
end

function Mappings:get_known_conditions()
    local result = {}
    for _, child in pairs(self.mappings) do
        if vim.islist(child) then
            for _, value in pairs(child) do
                if value.when and not vim.list_contains(result, value.when) then
                    table.insert(result, value.when)
                end
            end
        end
    end
    return result
end

-- Example usage
local mappings = require("core.keymaps.new_maps")
local maps = Mappings:new(mappings)
print("maps: " .. vim.inspect(maps:get_maps_for_condition(nil)))
for _, cond in pairs(maps:get_known_conditions()) do
    print("condition: " .. vim.inspect(cond))
    print("maps: " .. vim.inspect(maps:get_maps_for_condition(cond)))
end
