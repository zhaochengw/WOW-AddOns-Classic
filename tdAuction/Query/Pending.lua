-- Pending.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/31/2021, 2:01:21 PM
--
---@type ns
local ns = select(2, ...)

local Pending = ns.Addon:NewClass('Pending')

function Pending:Constructor()
    self.pending = {}
    self.ok = {}
end

function Pending:Add(itemId, index)
    self.pending[itemId] = self.pending[itemId] or {}
    tinsert(self.pending[itemId], index)
end

function Pending:Ready(itemId)
    self.ok[itemId] = self.pending[itemId]
    self.pending[itemId] = nil
end

function Pending:Pick()
    return self:PickFrom(self.ok) -- or self:PickFrom(self.pending)
end

function Pending:PickFrom(tbl)
    local itemId = next(tbl)
    if itemId then
        local list = tbl[itemId]
        local index = tremove(list)

        if #list == 0 then
            tbl[itemId] = nil
        end
        return index
    end
end

function Pending:IsEmpty()
    return not next(self.ok) and not next(self.pending)
end
