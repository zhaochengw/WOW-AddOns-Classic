-- Cacher.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 1/6/2020, 4:12:47 PM
--
local select = select
local wipe = table.wipe or wipe
local setmetatable = setmetatable

---@type ns
local ns = select(2, ...)

---@class Cacher: Object
local Cacher = ns.Addon:NewClass('Cacher')

local null = {}
local symbol = {}

function Cacher:Constructor()
    self[symbol] = {}
end

local mt = {
    __call = function(t, obj, ...)
        local cache = t.__cacher:FindCache(...)
        if cache[symbol] == nil then
            local r = t.__function(obj, ...)

            if t.Cachable and not t.Cachable(r) then
                return r
            end

            cache[symbol] = r
        end
        return cache[symbol]
    end,
}

function Cacher:Generate(f, advance)
    if advance then
        return setmetatable({__cacher = self, __function = f}, mt)
    else
        return function(obj, ...)
            local cache = self:FindCache(...)
            if cache[symbol] == nil then
                cache[symbol] = f(obj, ...)
            end
            return cache[symbol]
        end
    end
end

function Cacher:Patch(cls, ...)
    local len = select('#', ...)
    local last = select(len, ...)
    local advance

    if type(last) ~= 'string' then
        len = len - 1
        advance = not not last
    end

    for i = 1, len do
        local method = select(i, ...)
        cls[method] = self:Generate(cls[method], advance)
    end
end

function Cacher:FindCache(...)
    local cache = self[symbol]
    for i = 1, select('#', ...) do
        local key = select(i, ...)
        if key == nil then
            key = null
        end
        cache[key] = cache[key] or {}
        cache = cache[key]
    end
    return cache
end

function Cacher:RemoveCache(...)
    wipe(self:FindCache(...))
end
