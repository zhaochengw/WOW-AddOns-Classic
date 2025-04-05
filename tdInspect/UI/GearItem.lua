-- GearItem.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/23/2024, 11:14:48 AM
--
---@type ns
local ns = select(2, ...)

local L = ns.L

---@class UI.GearItem : UI.BaseItem
local GearItem = ns.Addon:NewClass('UI.GearItem', ns.UI.BaseItem)

local SPACING = 3

---@param parent UI.GearFrame
---@param id number
---@param slotName string
function GearItem:Constructor(parent, id, slotName, inspect)
    self.inspect = inspect
    self.parent = parent
    self:SetID(id)
    self:SetSize(1, 17)
    self:Hide()

    ---@type Frame|BackdropTemplate
    local Slot = CreateFrame('Frame', nil, self, 'BackdropTemplate')
    Slot:SetPoint('TOPLEFT')
    Slot:SetPoint('BOTTOMLEFT')
    Slot:SetPoint('RIGHT', parent.SlotColumn, 'RIGHT')
    Slot:SetBackdrop{
        bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],
        edgeFile = [[Interface\Buttons\WHITE8X8]],
        tile = true,
        tileSize = 8,
        edgeSize = 1,
        insets = {left = 1, right = 1, top = 1, bottom = 1},
    }
    Slot:SetBackdropBorderColor(0, 0.9, 0.9, 0.2)
    Slot:SetBackdropColor(0, 0.9, 0.9, 0.2)

    local SlotText = Slot:CreateFontString(nil, 'ARTWORK')
    SlotText:SetPoint('CENTER')
    SlotText:SetFont(GameFontNormal:GetFont(), 11, 'OUTLINE')
    SlotText:SetText(slotName)

    local ItemLevel = self:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
    ItemLevel:SetFont(TextStatusBarText:GetFont(), 13)
    ItemLevel:SetPoint('TOPLEFT', Slot, 'TOPRIGHT', 3, 0)
    ItemLevel:SetPoint('BOTTOMLEFT', Slot, 'BOTTOMRIGHT', 3, 0)
    ItemLevel:SetPoint('RIGHT', parent.LevelColumn, 'RIGHT')

    local Name = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
    Name:SetFont(ChatFontNormal:GetFont(), 13)
    Name:SetPoint('TOPLEFT', ItemLevel, 'TOPRIGHT', 3, 0)
    Name:SetPoint('BOTTOMLEFT', ItemLevel, 'BOTTOMRIGHT', 3, 0)
    Name:SetJustifyH('LEFT')

    self.Slot = Slot
    self.SlotText = SlotText
    self.ItemLevel = ItemLevel
    self.Name = Name

    self:SetScript('OnClick', self.OnClick)
    self:SetScript('OnEnter', self.OnEnter)
    self:SetScript('OnLeave', self.OnLeave)

    self.UpdateTooltip = self.OnEnter
end

function GearItem:OnHide()
    self:UnAllEvents()
    self:Hide()
end

function GearItem:SetItem(item)
    self.item = item
    self:Update()
end

function GearItem:OnClick()
    if self.item then
        local _, link = GetItemInfo(self.item)
        HandleModifiedItemClick(link)
    end
end

function GearItem:OnEnter()
    local r, g, b = self.Slot:GetBackdropColor()
    self.Slot:SetBackdropColor(r, g, b, 0.7)

    if not self.inspect then
        GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
        GameTooltip:SetInventoryItem('player', self:GetID())
        GameTooltip:Show()
    elseif self.item then
        GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
        if not ns.ShowBlizzardInventoryItem(ns.Inspect.unit, self:GetID()) then
            GameTooltip:SetHyperlink(self.item)
            ns.FixInspectItemTooltip(GameTooltip, self:GetID(), self.item)
        end
        GameTooltip:Show()
    end
end

function GearItem:OnLeave()
    local r, g, b = self.Slot:GetBackdropColor()
    self.Slot:SetBackdropColor(r, g, b, 0.2)
    GameTooltip:Hide()
end

function GearItem:Update()
    self:Hide()
    self.Name:SetText('')
    self.ItemLevel:SetText('')
    self.SlotText:SetTextColor(0.6, 0.6, 0.6)
    self.Slot:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.2)
    self.Slot:SetBackdropColor(0.6, 0.6, 0.6, 0.2)
    self:Show()

    if not self.item then
        return
    end

    local socketWidth

    local name, link, quality, itemLevel = GetItemInfo(self.item)
    if name then
        socketWidth = self:ApplyEnhancement()

        local r, g, b = GetItemQualityColor(quality)
        self.Name:SetText(link)
        self.SlotText:SetTextColor(r, g, b)
        self.Slot:SetBackdropBorderColor(r, g, b, 0.2)
        self.Slot:SetBackdropColor(r, g, b, 0.2)
        self.ItemLevel:SetText(itemLevel)
    else
        socketWidth = SPACING

        self:WaitItem(self.item)
    end

    local slotWidth = self.SlotText:GetStringWidth() + 10
    local levelWidth = self.ItemLevel:GetStringWidth()
    local nameWidth = self.Name:GetStringWidth()

    self.parent:ApplyColumnWidth('SlotColumn', slotWidth)
    self.parent:ApplyColumnWidth('LevelColumn', levelWidth)
    self.parent:ApplyColumnWidth('Name', nameWidth + socketWidth)

    self:SetPoint('RIGHT', self.parent.LevelColumn, 'RIGHT', nameWidth + 5, 0)
end

function GearItem:ApplyEnhancement()
    local x = 0
    if ns.db.profile.showGemsFront then
        x = self:UpdateSockets(x)
        x = self:UpdateEnchant(x)
    else
        x = self:UpdateEnchant(x)
        x = self:UpdateSockets(x)
    end
    return x
end

function GearItem:UpdateEnchant(x)
    local enchant = ns.GetItemEnchantInfo(self.item)
    if enchant then
        if ns.db.profile.showEnchant then
            x = x + SPACING

            local tex = ns.UI.EnchantItem:Alloc(self)
            if enchant.itemId then
                tex:SetItem(enchant.itemId)
            elseif enchant.spellId then
                tex:SetSpell(enchant.spellId)
            end
            tex:SetPoint('LEFT', self.Name, 'RIGHT', x, 0)

            x = x + tex:GetWidth()
        end
    elseif ns.db.profile.showLost and ns.IsCanEnchant(self.item, self.inspect) then
        x = x + SPACING

        local tex = ns.UI.EnchantItem:Alloc(self)
        tex:SetEmpty(L['No Enchant'])
        tex:SetPoint('LEFT', self.Name, 'RIGHT', x, 0)

        x = x + tex:GetWidth()
    end
    return x
end

function GearItem:UpdateSockets(x)
    if ns.db.profile.showGem then
        for i = 1, 3 do
            local gemId = ns.GetItemGem(self.item, i)
            local socketType = ns.GetItemSocket(self.item, i)

            if socketType or gemId then
                x = x + SPACING

                local tex = ns.UI.GemItem:Alloc(self)
                tex:SetSocketItem(socketType, gemId)
                tex:SetPoint('LEFT', self.Name, 'RIGHT', x, 0)

                x = x + tex:GetWidth()
            end
        end
    end

    if ns.db.profile.showLost and ns.IsCanSocket(self.item, self.inspect) then
        x = x + SPACING

        local tex = ns.UI.GemItem:Alloc(self)
        tex:SetEmptyText(L['Add socket'])
        tex:SetPoint('LEFT', self.Name, 'RIGHT', x, 0)

        x = x + tex:GetWidth()
    end
    return x
end
