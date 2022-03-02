-- TitleContainer.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 2/3/2020, 8:10:05 PM
---- LUA
local pairs, ipairs = pairs, ipairs
local max = math.max
local tinsert = table.insert

---- WOW
local CreateFrame = CreateFrame
local ScrollFrame_OnScrollRangeChanged = ScrollFrame_OnScrollRangeChanged

---@type ns
local ns = select(2, ...)

local L = ns.L

local Container = ns.UI.Container

---@class UI.TitleContainer: UI.Container
---@field alwaysShowTitle boolean
local TitleContainer = ns.Addon:NewClass('UI.TitleContainer', ns.UI.Container)
TitleContainer.TEMPLATE = 'tdBag2ContainerTitleTemplate'
TitleContainer.SCROLL_TEMPLATE = 'tdBag2ScrollFrameTemplate'

function TitleContainer:Constructor()
    self.titleLabels = {}

    local parent = self:GetParent()

    self.ScrollFrame = CreateFrame('ScrollFrame', nil, parent, self.SCROLL_TEMPLATE)
    self.ScrollFrame:SetPoint(self:GetPoint(1))
    self.ScrollFrame:SetScrollChild(self)
    self.ScrollFrame:SetSize(1, 1)
    self.ScrollFrame.scrollBarHideable = true

    self.ScrollFrame.GetVerticalScrollRange = function()
        return self.ScrollFrame:GetHeight() - self:GetHeight()
    end

    self.ScrollFrame:SetScript('OnScrollRangeChanged', function(f)
        local yrange = self:GetHeight() - self.ScrollFrame:GetHeight()
        if yrange < 0 then
            yrange = 0
        end
        return ScrollFrame_OnScrollRangeChanged(f, 0, yrange)
    end)

    self:SetParent(self.ScrollFrame)
    self:ClearAllPoints()
    self:SetPoint('TOPLEFT')
end

function TitleContainer:OnSizeChanged()
    local width = self:GetWidth()
    local height = self:GetHeight()
    local maxHeight = UIParent:GetHeight() * 0.7 - 100

    if height > maxHeight then
        self.ScrollFrame:SetSize(width + 20, maxHeight)
    else
        self.ScrollFrame:SetSize(width, height)
    end
    Container.OnSizeChanged(self)
end

---@return tdBag2ContainerTitleTemplate
function TitleContainer:GetTitleLabel(bag)
    if not self.titleLabels[bag] then
        local frame = CreateFrame('Frame', nil, self.ContentParent or self, self.TEMPLATE)
        frame:SetHeight(20)
        self.titleLabels[bag] = frame
    end
    return self.titleLabels[bag]
end

function TitleContainer:OnLayout()
    local profile = self.meta.profile
    local column = profile.column
    local scale = profile.scale
    local reverseSlot = profile.reverseSlot

    local x, y = 0, 0
    local size = ns.ITEM_SIZE + ns.ITEM_SPACING

    for _, label in pairs(self.titleLabels) do
        label:Hide()
    end

    local bags = self:GetBags()
    local multi = #bags > 1
    local addHeight = multi and -5 or 0

    for _, bag in ipairs(bags) do
        local bagInfo = ns.Cache:GetBagInfo(self.meta.owner, bag)
        if multi or self.alwaysShowTitle then
            local label = self:GetTitleLabel(bag)
            label:SetPoint('TOPLEFT', self, 'TOPLEFT', 0, -y * size - addHeight)
            label:SetWidth(column * size - ns.ITEM_SPACING)
            label:SetScale(scale)
            label.Text:SetText(bagInfo.title or '')
            label:Show()
            addHeight = addHeight + 20
        end

        local numSlots = bagInfo.count or 0
        local slotBegin, slotEnd, slotStep
        if not reverseSlot then
            slotBegin, slotEnd, slotStep = 1, numSlots, 1
        else
            slotBegin, slotEnd, slotStep = numSlots, 1, -1
        end

        for slot = slotBegin, slotEnd, slotStep do
            local itemButton = self:GetItemButton(bag, slot)
            if x == column then
                y = y + 1
                x = 0
            end

            itemButton:ClearAllPoints()
            itemButton:SetPoint('TOPLEFT', self, 'TOPLEFT', x * size, -y * size - addHeight)
            itemButton:SetScale(scale)
            itemButton:Show()

            if self.Threshold and self:Threshold() then
                return
            end

            x = x + 1
        end

        if x > 0 then
            y = y + 1
            x = 0
        end
    end

    if x > 0 then
        y = y + 1
    end

    local width = max(1, column * size * scale)
    local height = max(1, (y * size + addHeight) * scale)
    self:SetSize(width, height)
end

function TitleContainer:GetBags()
    local bags = {}
    for _, bag in self:IterateBags() do
        local numSlots = Container.NumSlots(self, bag)
        if numSlots > 0 then
            tinsert(bags, bag)
        end
    end
    return bags
end

function TitleContainer:GetRealWidth()
    return self.ScrollFrame:GetWidth()
end

function TitleContainer:GetRealHeight()
    return self.ScrollFrame:GetHeight()
end
