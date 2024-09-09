-- CharacterGearFrame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/4/2024, 4:30:30 PM
--
---@type ns
local ns = select(2, ...)

---@class UI.CharacterGearFrame : UI.GearFrame
local CharacterGearFrame = ns.Addon:NewClass('UI.CharacterGearFrame', ns.UI.GearFrame)

function CharacterGearFrame:Constructor()
    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.OnHide)

    self:SetUnit('player')

    self:UpdateOptionButton(ns.Addon.db.profile.showOptionButtonInCharacter)

    self.Talent2:SetScript('OnClick', function(button)
        if not InCombatLockdown() then
            SetActiveTalentGroup(button.id)
        end
    end)
end

function CharacterGearFrame:OnShow()
    self:RegisterEvent('UNIT_INVENTORY_CHANGED')
    self:RegisterEvent('UNIT_LEVEL', 'UNIT_INVENTORY_CHANGED')
    self:RegisterEvent('UNIT_MODEL_CHANGED')
    self:RegisterEvent('PLAYER_AVG_ITEM_LEVEL_UPDATE', 'UpdateItemLevel')
    self:RegisterMessage('TDINSPECT_OPTION_CHANGED', 'UpdateOption')
    self:Update()

    if GearManagerDialog then
        GearManagerDialog:SetFrameLevel(self:GetFrameLevel() + 10)
    end
end

function CharacterGearFrame:OnHide()
    self:UnregisterAllEvents()
    self:UnregisterAllMessages()
    self:Hide()
end

function CharacterGearFrame:UNIT_INVENTORY_CHANGED(_, unit)
    if unit == 'player' then
        self:Update()
    end
end

function CharacterGearFrame:UNIT_MODEL_CHANGED(_, unit)
    if unit == 'player' then
        self:UpdateUnit()
    end
end

function CharacterGearFrame:UpdateGears()
    for id, gear in pairs(self.gears) do
        gear:SetItem(GetInventoryItemLink('player', id))
    end
end

function CharacterGearFrame:UpdateItemLevel()
    self:SetItemLevel(select(2, GetAverageItemLevel()))
end

function CharacterGearFrame:Update()
    self:UpdateUnit()
    self:UpdateGears()
    self:UpdateItemLevel()
    self:UpdateTalents()
end

function CharacterGearFrame:GetNumTalentGroups()
    return GetNumTalentGroups()
end

function CharacterGearFrame:GetActiveTalentGroup()
    return GetActiveTalentGroup()
end

function CharacterGearFrame:GetTalentInfo(group)
    local maxPoint = 0
    local maxName = nil
    local maxIcon
    local maxBg
    local counts = {}
    for i = 1, GetNumTalentTabs() do
        local name, icon, pointsSpent, bg = GetTalentTabInfo(i, nil, nil, group)
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

function CharacterGearFrame:TapTo(frame, ...)
    self:SetParent(frame)
    self:ClearAllPoints()
    self:SetPoint(...)
    self:UpdateOption()
end

function CharacterGearFrame:UpdateOption(_, key, value)
    if key == 'showTalentBackground' then
        if value then
            self:UpdateTalents()
        else
            self:SetBackground()
        end
    elseif key == 'showOptionButtonInCharacter' then
        self:UpdateOptionButton(value)
    elseif key == 'showGem' or key == 'showEnchant' or key == 'showLost' then
        self:Update()
    end
end
