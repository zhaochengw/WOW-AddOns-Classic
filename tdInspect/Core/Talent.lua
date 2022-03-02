-- Talent.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/21/2020, 11:22:55 AM
--
---@type ns
local ns = select(2, ...)

local tonumber = tonumber

local GetNumTalentTabs = GetNumTalentTabs

---@class Talent: Object
local Talent = ns.Addon:NewClass('Talent')

function Talent:Constructor(class, data)
    self.talents = {}
    self.class = class
    self.data = ns.Talents[class]
    self:ParseTalent(data)
end

function Talent:ParseTalent(data)
    data = data:gsub('[^%d]+', '')

    local index = 1
    for i = 1, GetNumTalentTabs() do
        self.talents[i] = {}

        local pointsSpent = 0
        for j = 1, self.data[i].numTalents do
            local point = tonumber(data:sub(index, index)) or 0
            self.talents[i][j] = point
            pointsSpent = pointsSpent + point
            index = index + 1
        end

        self.talents[i].pointsSpent = pointsSpent
    end
end

function Talent:_GetTalent(tab, index)
    local tabData = self.data[tab]
    return tabData and tabData.talents[index]
end

function Talent:GetTabInfo(tab)
    local tabData = self.data[tab]
    if tabData then
        return tabData.name, tabData.background, self.talents[tab].pointsSpent
    end
end

function Talent:GetNumTalents(tab)
    local tabData = self.data[tab]
    return tabData and tabData.numTalents
end

function Talent:GetTalentInfo(tab, index)
    local talent = self:_GetTalent(tab, index)
    if talent then
        return talent.name, --
        talent.icon, --
        talent.row, --
        talent.column, --
        self.talents[tab][index], --
        talent.maxRank, talent.prereqs, self.talents[tab][index]
    end
end

function Talent:GetTalentLink(tab, index)
    local talent = self:_GetTalent(tab, index)
    if talent and talent.id then
        return format('|cff4e96f7|Htalent:%d:%d|h[%s]|h|r', talent.id, self.talents[tab][index] - 1, talent.name)
    end
end

function Talent:GetTalentPrereqs(tab, index)
    local talent = self:_GetTalent(tab, index)
    if talent then
        return talent.prereqs
    end
end

function Talent:GetTalentRankSpell(tab, index, rank)
    local talent = self:_GetTalent(tab, index)
    if talent then
        if rank == 0 then
            rank = 1
        end
        return talent.ranks[rank]
    end
end
