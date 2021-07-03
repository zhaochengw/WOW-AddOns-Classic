-- InspectTalent.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/20/2020, 1:37:49 PM
---@type ns
local ns = select(2, ...)

local Inspect = ns.Inspect

local CreateFrame = CreateFrame

local PanelTemplates_SetTab = PanelTemplates_SetTab
local PanelTemplates_SetNumTabs = PanelTemplates_SetNumTabs
local PanelTemplates_UpdateTabs = PanelTemplates_UpdateTabs
local PanelTemplates_TabResize = PanelTemplates_TabResize

---@type tdInspectInspectTalentFrame
local InspectTalent = ns.Addon:NewClass('UI.InspectTalent', 'Frame')

function InspectTalent:Constructor()
    self.Tabs = {}
    self.selectedTab = 1

    self:AddTab('Tab1')
    self:AddTab('Tab2')
    self:AddTab('Tab3')

    local TalentFrame = ns.UI.TalentFrame:Bind(CreateFrame('ScrollFrame', nil, self, 'UIPanelScrollFrameTemplate'))
    TalentFrame.initialOffsetX = INITIAL_TALENT_OFFSET_X
    TalentFrame.initialOffsetY = INITIAL_TALENT_OFFSET_Y
    TalentFrame.buttonSpacingX = 63
    TalentFrame.buttonSpacingY = 63
    TalentFrame:SetSize(296, 332)
    TalentFrame:SetPoint('TOPRIGHT', -65, -77)

    self.TalentFrame = TalentFrame

    local y = 152

    local t = self:CreateTexture(nil, 'BACKGROUND', nil, 1)
    t:SetPoint('TOPLEFT', 2, -257 - y)
    t:SetSize(256, 256 - y)
    t:SetTexture([[Interface\FriendsFrame\UI-FriendsFrame-Pending-BotLeft]])
    t:SetTexCoord(0, 1, y / 256, 1)

    local t = self:CreateTexture(nil, 'BACKGROUND', nil, 1)
    t:SetPoint('TOPLEFT', 258, -257 - y)
    t:SetSize(128, 256 - y)
    t:SetTexture([[Interface\FriendsFrame\UI-FriendsFrame-Pending-BotRight]])
    t:SetTexCoord(0, 1, y / 256, 1)

    local BottomFrame = CreateFrame('Frame', nil, self)
    BottomFrame:SetPoint('BOTTOMLEFT', 20, 77)
    BottomFrame:SetPoint('BOTTOMRIGHT', -40, 77)
    BottomFrame:SetHeight(24)

    local l = BottomFrame:CreateTexture(nil, 'BACKGROUND')
    l:SetWidth(12)
    l:SetPoint('TOPLEFT', 1, -1)
    l:SetPoint('BOTTOMLEFT', 0, 2)
    l:SetTexture([[Interface\MoneyFrame\UI-MoneyFrame-Border]])
    l:SetTexCoord(0, 0.09375, 0, 0.625)

    local r = BottomFrame:CreateTexture(nil, 'BACKGROUND')
    r:SetWidth(12)
    r:SetPoint('TOPRIGHT', 0, -1)
    r:SetPoint('BOTTOMRIGHT', 0, 2)
    r:SetTexture([[Interface\MoneyFrame\UI-MoneyFrame-Border]])
    r:SetTexCoord(0.90625, 1, 0, 0.625)

    local m = BottomFrame:CreateTexture(nil, 'BACKGROUND')
    m:SetPoint('TOPLEFT', l, 'TOPRIGHT')
    m:SetPoint('BOTTOMRIGHT', r, 'BOTTOMLEFT')
    m:SetTexture([[Interface\MoneyFrame\UI-MoneyFrame-Border]])
    m:SetTexCoord(0.09375, 0.90625, 0, 0.625)

    self.Summary = BottomFrame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall')
    self.Summary:SetPoint('CENTER')

    self:SetScript('OnShow', self.OnShow)
end

function InspectTalent:OnShow()
    self:RegisterMessage('INSPECT_TALENT_READY', 'UpdateInfo')
    self:UpdateInfo()
end

local function TabOnClick(self)
    self:GetParent():SetTab(self:GetID())
end

function InspectTalent:AddTab(text)
    local id = #self.Tabs + 1
    local tab = CreateFrame('Button', nil, self, 'TabButtonTemplate', id)
    tab:SetText(text)
    tab:SetScript('OnClick', TabOnClick)

    if id == 1 then
        tab:SetPoint('TOPLEFT', 70, -41)
    else
        tab:SetPoint('LEFT', self.Tabs[id - 1], 'RIGHT')
    end

    self.Tabs[id] = tab

    PanelTemplates_SetNumTabs(self, id)
    PanelTemplates_UpdateTabs(self)
end

function InspectTalent:SetTab(id)
    PanelTemplates_SetTab(self, id)
    self.TalentFrame:SetTalentTab(id)
end

function InspectTalent:UpdateInfo()
    ---@type tdInspectTalent
    local talent = ns.Talent:New(Inspect:GetUnitClassFileName(), Inspect:GetUnitTalent())
    local summaries = {}

    for i = 1, GetNumTalentTabs() do
        local name, _, pointsSpent = talent:GetTabInfo(i)
        if name then
            local tab = self.Tabs[i]
            tab:SetText(name)
            PanelTemplates_TabResize(tab, -10)

            tinsert(summaries, format('%s: |cffffffff%d|r', name, pointsSpent))
        end
    end

    self.Summary:SetText(table.concat(summaries, '  '))
    self.TalentFrame:SetTalent(talent)
end
