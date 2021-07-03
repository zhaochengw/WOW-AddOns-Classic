-- GlobalSearchContainer.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 2/11/2020, 2:54:54 PM
--
---@type ns
local ns = select(2, ...)

local TitleContainer = ns.UI.TitleContainer

---@type tdBag2GlobalSearchContainer
local GlobalSearchContainer = ns.Addon:NewClass('UI.GlobalSearchContainer', TitleContainer)
GlobalSearchContainer.SEARCHING_TEMPLATE = 'tdBag2SearchingTemplate'

function GlobalSearchContainer:Constructor()
    self.alwaysShowTitle = true

    self.ContentParent = CreateFrame('Frame', nil, self)

    self.Searching = CreateFrame('Frame', nil, self, self.SEARCHING_TEMPLATE)
    self.Searching:SetAllPoints(self)
    self.Searching:SetFrameLevel(self:GetFrameLevel() + 100)
    self.Searching:EnableMouse(true)
    self.Searching:Hide()
end

function GlobalSearchContainer:OnShow()
    TitleContainer.OnShow(self)
    self:RegisterEvent('GLOBAL_SEARCH_START')
end

function GlobalSearchContainer:GetBags()
    return ns.GlobalSearch:GetBags()
end

function GlobalSearchContainer:Layout()
    if not self.thread then
        self.thread = ns.Thread:New()
        self.thread:Start(self.AsyncLayout, self)
    end

    if self.thread:IsFinished() or self.thread:IsDead() then
        self:EndSearching()
        self:OnSizeChanged()
        self:SetScript('OnUpdate', nil)
        self.thread = nil
    else
        self.thread:Resume()
    end
end

function GlobalSearchContainer:AsyncLayout()
    self:FreeAll()
    self:StartSearching()
    self:OnLayout()
end

function GlobalSearchContainer:CancelLayout()
    if self.thread then
        self.thread:Kill()
        self.thread = nil
    end
end

function GlobalSearchContainer:Threshold()
    return self.thread and self.thread:Threshold()
end

function GlobalSearchContainer:StartSearching()
    self.Searching:Show()
    self.ContentParent:SetAlpha(0)
    self:SetHeight(ns.ITEM_SIZE + ns.ITEM_SPACING)
    self:OnSizeChanged()
end

function GlobalSearchContainer:EndSearching()
    self.Searching:Hide()
    self.ContentParent:SetAlpha(1)
end

function GlobalSearchContainer:GLOBAL_SEARCH_START()
    self:CancelLayout()
    self:StartSearching()
end

function GlobalSearchContainer:GLOBAL_SEARCH_UPDATE()
    self:CancelLayout()
    self:RequestLayout()
end
