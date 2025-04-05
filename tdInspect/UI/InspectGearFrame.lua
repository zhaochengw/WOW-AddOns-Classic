-- InspectGearFrame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/23/2024, 12:33:12 PM
--
---@type ns
local ns = select(2, ...)

local L = ns.L
local Inspect = ns.Inspect

---@class UI.InspectGearFrame : UI.GearFrame
local InspectGearFrame = ns.Addon:NewClass('UI.InspectGearFrame', ns.UI.GearFrame)

function InspectGearFrame:Constructor()
    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.OnHide)

    local DataSource = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall')
    DataSource:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 10, 0)
    DataSource:SetFont(DataSource:GetFont(), 12, 'OUTLINE')
    self.DataSource = DataSource

    self.isInspect = true
end

function InspectGearFrame:OnShow()
    self:Event('UNIT_LEVEL')
    self:Event('UNIT_INVENTORY_CHANGED')
    self:Event('GET_ITEM_INFO_RECEIVED', 'UpdateItemLevel')
    self:Event('TDINSPECT_READY', 'Update')
    self:Event('TDINSPECT_OPTION_CHANGED', 'UpdateOption')

    self:UpdateOptionButton(ns.db.profile.showOptionButtonInInspect)

    self:Update()
end

function InspectGearFrame:OnHide()
    self:Clear()
    self:UnAllEvents()
    self:Hide()
end

function InspectGearFrame:UNIT_INVENTORY_CHANGED(_, unit)
    if self.unit == unit then
        self:UpdateGears()
        self:UpdateItemLevel()
    end
end

function InspectGearFrame:UNIT_LEVEL(_, unit)
    if self.unit == unit then
        self:UpdateLevel()
    end
end

function InspectGearFrame:UpdateItemLevel()
    self:SetItemLevel(Inspect:GetItemLevel())
end

function InspectGearFrame:UpdateLevel()
    self:SetLevel(Inspect:GetUnitLevel())
end

function InspectGearFrame:UpdateGears()
    self:ResetColumnWidths()

    for id, gear in pairs(self.gears) do
        gear:SetItem(Inspect:GetItemLink(id))
    end
end

function InspectGearFrame:UpdateDataSource()
    local dataSource = Inspect:GetDataSource()
    local lastUpdate = Inspect:GetLastUpdate()

    self.DataSource:SetFormattedText('%s|cffffffff%s|r  %s|cffffffff%s|r', L['Data source:'], dataSource,
                                     L['Last update:'], FriendsFrame_GetLastOnline(lastUpdate))
end

function InspectGearFrame:Update()
    self:SetUnit(Inspect:GetUnit())
    self:SetClass(Inspect:GetUnitClassFileName())

    self:UpdateName()
    self:UpdatePortrait()
    self:UpdateClass()
    self:UpdateLevel()
    self:UpdateGears()
    self:UpdateItemLevel()
    self:UpdateTalents()
    self:UpdateDataSource()
end

function InspectGearFrame:GetNumTalentGroups()
    return Inspect:GetNumTalentGroups()
end

function InspectGearFrame:GetActiveTalentGroup()
    return Inspect:GetActiveTalentGroup()
end

function InspectGearFrame:GetTalentInfo(group)
    local maxPoint = 0
    local maxName = nil
    local maxIcon
    local maxBg
    local counts = {}
    local talent = Inspect:GetUnitTalent(group)
    if not talent then
        return
    end
    for i = 1, talent:GetNumTalentTabs() do
        local name, bg, pointsSpent, icon = talent:GetTabInfo(i)
        if pointsSpent > maxPoint then
            maxPoint = pointsSpent
            maxName = name
            maxIcon = icon
            maxBg = bg
        end

        tinsert(counts, pointsSpent)
    end
    return maxName, maxIcon, maxBg, table.concat(counts, '/')
end

function InspectGearFrame:UpdateOption(_, key, value)
    if key == 'showTalentBackground' then
        if value then
            self:UpdateTalents()
        else
            self:SetBackground()
        end
    elseif key == 'showOptionButtonInInspect' then
        self:UpdateOptionButton(value)
    elseif key == 'showGem' or key == 'showEnchant' or key == 'showLost' or key == 'showGemsFront' then
        self:UpdateGears()
    end
end
