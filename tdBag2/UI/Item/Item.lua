-- Item.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/17/2019, 12:05:58 AM
--
---- LUA
local _G = _G
local select = select
local floor = math.floor
local format = string.format

---- WOW
local CreateFrame = CreateFrame
local GetItemQualityColor = GetItemQualityColor
local IsBattlePayItem = IsBattlePayItem or C_Container.IsBattlePayItem
if not IsBattlePayItem then
    IsBattlePayItem = function(bag, slot)
        return false
    end
end

local IsNewItem = C_NewItems.IsNewItem
local RemoveNewItem = C_NewItems.RemoveNewItem

local ContainerFrame_UpdateCooldown = ContainerFrame_UpdateCooldown
local CooldownFrame_Set = CooldownFrame_Set

---- UI
local StackSplitFrame = StackSplitFrame
local UIParent = UIParent

---- G
local MAX_CONTAINER_ITEMS = MAX_CONTAINER_ITEMS
local MAX_BLIZZARD_ITEMS = NUM_CONTAINER_FRAMES * MAX_CONTAINER_ITEMS

local DEFAULT_SLOT_COLOR = {r = 1, g = 1, b = 1}

---@type ns
local ns = select(2, ...)
local ItemBase = ns.UI.ItemBase

---@class UI.Item: UI.ItemBase, ContainerFrameItemButtonTemplate
---@field hasStackSplit boolean
local Item = ns.Addon:NewClass('UI.Item', ItemBase)
Item.pool = {}
Item.GenerateName = ns.NameGenerator('tdBag2Item')

function Item:Constructor()
    local name = self:GetName()
    self.Cooldown = _G[name .. 'Cooldown']
    self.Timeout = _G[name .. 'Stock']

    self.NewItemTexture:SetTexture([[Interface\Buttons\UI-ActionButton-Border]])
    self.NewItemTexture:SetBlendMode('ADD')
    self.NewItemTexture:ClearAllPoints()
    self.NewItemTexture:SetPoint('CENTER')
    self.NewItemTexture:SetSize(67, 67)

    self.BattlepayItemTexture:Hide()

    self.UpdateTooltip = self.OnEnter
    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.OnHide)
    self:SetScript('OnEnter', self.OnEnter)
    self:SetScript('OnLeave', self.OnLeave)
    self:SetScript('OnEvent', nil)
end

local index = 0
function Item:Create()
    if index < MAX_BLIZZARD_ITEMS then
        index = index + 1

        local i = floor(index / MAX_CONTAINER_ITEMS) + 1
        local j = (index - 1) % MAX_CONTAINER_ITEMS + 1
        local item = _G[format('ContainerFrame%dItem%d', i, j)]
        if item then
            return Item:Bind(item)
        end
    end
    return Item:Bind(CreateFrame('Button', Item:GenerateName(), UIParent, 'ContainerFrameItemButtonTemplate'))
end

function Item:OnHide()
    if self.hasStackSplit == 1 then
        StackSplitFrame:Hide()
    end

    if self:IsNew() then
        RemoveNewItem(self.bag, self.slot)
    end
end

function Item:Update()
    self:UpdateInfo()
    self:UpdateItem()
    self:UpdateSearch()
    self:UpdateLocked()
    self:UpdateFocus()
    self:UpdateBorder()
    self:UpdateSlotColor()
    self:UpdateCooldown()
    self:UpdatePlugin()
end

function Item:UpdateBorder()
    local sets = self.meta.sets
    local new = sets.glowNew and self:IsNew()
    local r, g, b = self:GetBorderColor()

    if new then
        if not self.newitemglowAnim:IsPlaying() then
            self.newitemglowAnim:Play()
            self.flashAnim:Play()
        end

        local paid = self:IsPaid()

        self.BattlepayItemTexture:SetShown(paid)
        self.NewItemTexture:SetShown(not paid)
        self.NewItemTexture:SetVertexColor(r or 1, g or 1, b or 1)
    else
        if self.newitemglowAnim:IsPlaying() or self.flashAnim:IsPlaying() then
            self.flashAnim:Stop()
            self.newitemglowAnim:Stop()
        end

        self.BattlepayItemTexture:Hide()
        self.NewItemTexture:Hide()
    end

    self.IconBorder:SetVertexColor(r or 1, g or 1, b or 1, sets.glowAlpha)
    self.IconBorder:SetShown(r and not new)
    self.QuestBorder:SetShown(sets.iconQuestStarter and self:IsQuestStarter())
    self.JunkIcon:SetShown(sets.iconJunk and self:IsJunk())
end

function Item:UpdateSlotColor()
    local color = DEFAULT_SLOT_COLOR
    local alpha = self.hasItem and 1 or self.meta.sets.emptyAlpha

    if self.meta.sets.colorSlots and not self.hasItem then
        local family = self:GetBagFamily()
        local key = ns.BAG_FAMILY_KEYS[family]
        if key then
            color = self.meta.sets[key]
        else
            color = self.meta.sets.colorNormal
        end
    end

    self.nt:SetVertexColor(color.r, color.g, color.b, alpha)
    self.icon:SetVertexColor(color.r, color.g, color.b, alpha)
end

function Item:UpdateCooldown()
    if self.hasItem and not self:IsCached() then
        ContainerFrame_UpdateCooldown(self.bag, self)
    else
        self.Cooldown:Hide()
        CooldownFrame_Set(self.Cooldown, 0, 0, 0)
    end
end

function Item:UpdateSearch()
    local isNew = self.newitemglowAnim:IsPlaying()
    if isNew then
        self.newitemglowAnim:Stop()
        self.flashAnim:Stop()
    end

    ItemBase.UpdateSearch(self)

    if isNew then
        self.newitemglowAnim:Play()
    end
end

function Item:IsNew()
    return self.bag and ns.IsContainerBag(self.bag) and not self:IsCached() and IsNewItem(self.bag, self.slot)
end

function Item:IsPaid()
    return IsBattlePayItem(self.bag, self.slot)
end
