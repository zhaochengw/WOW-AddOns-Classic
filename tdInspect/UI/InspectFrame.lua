-- InspectFrame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/18/2020, 1:10:21 PM
--
---@type ns
local ns = select(2, ...)

local Inspect = ns.Inspect

local unpack = unpack

local PlaySound = PlaySound
local Ambiguate = Ambiguate
local CanInspect = CanInspect
local GetUnitName = GetUnitName
local CreateFrame = CreateFrame
local SetPortraitTexture = SetPortraitTexture
local CheckInteractDistance = CheckInteractDistance

local PanelTemplates_EnableTab = PanelTemplates_EnableTab
local PanelTemplates_DisableTab = PanelTemplates_DisableTab
local PanelTemplates_SetNumTabs = PanelTemplates_SetNumTabs
local PanelTemplates_SetTab = PanelTemplates_SetTab

local GameTooltip = GameTooltip

local CLASS_ICON_TCOORDS = CLASS_ICON_TCOORDS

---@class UI.InspectFrame: EventHandler, Object, Frame
local InspectFrame = ns.Addon:NewClass('UI.InspectFrame', 'Frame')

function InspectFrame:Constructor()
    self:UnregisterAllEvents()
    self:SetScript('OnEvent', nil)
    self.RegisterEvent = nop

    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.OnHide)

    self.tabFrames = {}
    for i, v in ipairs(INSPECTFRAME_SUBFRAMES) do
        self.tabFrames[i] = _G[v]
    end

    function InspectSwitchTabs(id)
        return self:SetTab(id)
    end

    local talentTab, glyphTab

    self.Portrait = InspectFramePortrait
    self.Name = InspectNameText
    self.PaperDoll = ns.UI.PaperDoll:Bind(InspectPaperDollFrame)
    self.TalentFrame = ns.UI.InspectTalent:Bind(self:CreateTabFrame())
    if ns.BUILD == 1 then
        talentTab = self:AddTab(TALENT, self.TalentFrame)
    elseif ns.BUILD >= 2 then
        talentTab = tIndexOf(INSPECTFRAME_SUBFRAMES, 'InspectTalentFrame')
        InspectTalentFrame:Hide()
        InspectTalentFrame.Show = function()
            self.TalentFrame:Show()
        end
        InspectTalentFrame.Hide = function()
            self.TalentFrame:Hide()
        end
        InspectTalentFrame.SetShown = function(_, shown)
            self.TalentFrame:SetShown(shown)
        end
    end
    if ns.BUILD >= 3 then
        self.GlyphFrame = ns.UI.GlyphFrame:Bind(self:CreateTabFrame())
        glyphTab = self:AddTab(GLYPHS, self.GlyphFrame)
    end

    self.tabDepends = {
        [tIndexOf(INSPECTFRAME_SUBFRAMES, 'InspectPVPFrame') or tIndexOf(INSPECTFRAME_SUBFRAMES, 'InspectHonorFrame')] = function()
            return Inspect.unit and not InCombatLockdown() and CheckInteractDistance(Inspect.unit, 1) and
                       CanInspect(Inspect.unit)
        end,
        [talentTab] = function()
            return Inspect:GetUnitClass() and Inspect:GetNumTalentGroups() > 0 and Inspect:GetUnitTalent()
        end,
    }

    if ns.BUILD >= 3 then
        self.tabDepends[glyphTab] = function()
            return Inspect:GetNumTalentGroups() > 0 and Inspect:GetUnitGlyph()
        end
    end

    self.groupTabs = {}
    self:AddTalentGroupTab(1)
    self:AddTalentGroupTab(2)

    self.Portrait:SetSize(64, 64)
end

function InspectFrame:OnShow()
    self:Event('UNIT_NAME_UPDATE')
    self:Event('UNIT_PORTRAIT_UPDATE')
    self:Event('PORTRAITS_UPDATED', 'UpdatePortrait')
    self:Event('TDINSPECT_TARGET_CHANGED', 'Update')
    self:Event('TDINSPECT_TALENT_READY', 'UpdateTabs')
    self:Update()
    self:UpdateTabs()
    self:UpdateTalentGroups()
    PlaySound(839) -- SOUNDKIT.IG_CHARACTER_INFO_OPEN
end

function InspectFrame:OnHide()
    self.groupId = nil
    self.unitName = nil
    self:UnAllEvents()
    Inspect:Clear()
    self:SetTab(1)
    self.TalentFrame:SetTab(1)
    PlaySound(840) -- SOUNDKIT.IG_CHARACTER_INFO_CLOSE
end

local function SpecOnEnter(button)
    local talent = Inspect:GetUnitTalent(button.id)
    if not talent then
        return
    end

    GameTooltip:SetOwner(button, 'ANCHOR_RIGHT')
    GameTooltip:SetText(button.id == 1 and TALENT_SPEC_PRIMARY or TALENT_SPEC_SECONDARY)

    if button.id == Inspect:GetActiveTalentGroup() then
        GameTooltip:AddLine(TALENT_ACTIVE_SPEC_STATUS, GREEN_FONT_COLOR:GetRGB())
    end

    for i = 1, talent:GetNumTalentTabs() do
        local name, _, pointsSpent = talent:GetTabInfo(i)
        local green = pointsSpent == button.best
        GameTooltip:AddDoubleLine(name, pointsSpent, 1, 1, 1, green and 0 or 1, 1, green and 0 or 1)
    end
    GameTooltip:Show()
end

local function SpecOnClick(button)
    ---@type UI.InspectFrame
    local parent = button:GetParent()
    parent:SetTalentGroup(button.id)
end

function InspectFrame:SetTalentGroup(id)
    if self.groupId == id then
        return
    end

    self.groupId = id
    for _, tab in ipairs(self.groupTabs) do
        tab.ct:SetShown(tab.id == id)
    end

    self.TalentFrame:SetTalentGroup(id)
    if ns.BUILD >= 3 then
        self.GlyphFrame:SetTalentGroup(id)
    end
end

function InspectFrame:AddTalentGroupTab(id)
    local button = CreateFrame('Button', nil, self)
    button:SetSize(32, 32)

    local bg = button:CreateTexture(nil, 'BACKGROUND')
    bg:SetPoint('TOPLEFT', -3, 11)
    bg:SetSize(64, 64)
    bg:SetTexture([[Interface\SpellBook\SpellBook-SkillLineTab]])

    local nt = button:CreateTexture(nil, 'ARTWORK')
    nt:SetAllPoints(true)

    local ct = button:CreateTexture(nil, 'OVERLAY')
    ct:SetAllPoints(true)
    ct:SetTexture([[Interface\Buttons\CheckButtonHilight]])
    ct:SetBlendMode('ADD')
    ct:Hide()

    button.ct = ct
    button.nt = nt
    button.id = id

    button:SetHighlightTexture([[Interface\Buttons\ButtonHilight-Square]], 'ADD')

    button:SetScript('OnClick', SpecOnClick)
    button:SetScript('OnEnter', SpecOnEnter)
    button:SetScript('OnLeave', GameTooltip_Hide)

    if id == 1 then
        button:SetPoint('TOPLEFT', self, 'TOPRIGHT', -32, -65)
    else
        button:SetPoint('TOPLEFT', self.groupTabs[id - 1], 'BOTTOMLEFT', 0, -22)
    end

    self.groupTabs[id] = button
end

local function TabOnEnter(self)
    GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
    GameTooltip:SetText(self.text, 1.0, 1.0, 1.0)
end

function InspectFrame:AddTab(text, frame)
    local id = self.numTabs + 1
    local tab = CreateFrame('Button', 'InspectFrameTab' .. id, self, 'CharacterFrameTabButtonTemplate')
    tab:SetPoint('LEFT', _G['InspectFrameTab' .. self.numTabs], 'RIGHT', -16, 0)
    tab:SetID(id)
    tab:SetText(text)
    tab:SetScript('OnClick', InspectFrameTab_OnClick)
    tab:SetScript('OnLeave', GameTooltip_Hide)
    tab:SetScript('OnEnter', TabOnEnter)
    tab:SetFrameLevel(InspectFrameTab1:GetFrameLevel())
    tab.text = text
    PanelTemplates_SetNumTabs(self, id)

    self.tabFrames[id] = frame or self:CreateTabFrame()

    return id
end

function InspectFrame:CreateTabFrame(bgs)
    ---@type Frame
    local frame = CreateFrame('Frame', nil, self)
    frame:SetAllPoints(self)
    frame:Hide()

    local tl = frame:CreateTexture(nil, 'BACKGROUND')
    tl:SetSize(256, 256)
    tl:SetPoint('TOPLEFT', 2, -1)
    tl:SetTexture(bgs and bgs.topLeft or [[Interface\PaperDollInfoFrame\UI-Character-General-TopLeft]])

    local tr = frame:CreateTexture(nil, 'BACKGROUND')
    tr:SetSize(128, 256)
    tr:SetPoint('TOPLEFT', 258, -1)
    tr:SetTexture(bgs and bgs.topRight or [[Interface\PaperDollInfoFrame\UI-Character-General-TopRight]])

    local bl = frame:CreateTexture(nil, 'BACKGROUND')
    bl:SetSize(256, 256)
    bl:SetPoint('TOPLEFT', 2, -257)
    bl:SetTexture(bgs and bgs.bottomLeft or [[Interface\PaperDollInfoFrame\UI-Character-General-BottomLeft]])

    local br = frame:CreateTexture(nil, 'BACKGROUND')
    br:SetSize(128, 256)
    br:SetPoint('TOPLEFT', 258, -257)
    br:SetTexture(bgs and bgs.bottomRight or [[Interface\PaperDollInfoFrame\UI-Character-General-BottomRight]])

    return frame
end

function InspectFrame:UpdatePortrait()
    if self.unit then
        self.unitName = ns.UnitName(self.unit)
        self.Portrait:SetTexCoord(0, 1, 0, 1)
        SetPortraitTexture(self.Portrait, self.unit)
    elseif not self.unitName or self.unitName ~= Inspect.unitName then
        local class = Inspect:GetUnitClassFileName()
        if class then
            self.Portrait:SetTexture([[Interface\TargetingFrame\UI-Classes-Circles]])
            self.Portrait:SetTexCoord(unpack(CLASS_ICON_TCOORDS[class]))
        else
            self.Portrait:SetTexture([[Interface\FriendsFrame\FriendsFrameScrollIcon]])
            self.Portrait:SetTexCoord(0, 1, 0, 1)
        end
    end
end

function InspectFrame:UpdateName()
    if self.unit then
        self.Name:SetText(GetUnitName(self.unit))
    else
        self.Name:SetText(Ambiguate(Inspect.unitName, 'none'))
    end
end

function InspectFrame:Update()
    self:UpdatePortrait()
    self:UpdateName()
end

function InspectFrame:UNIT_NAME_UPDATE(_, unit)
    if unit == self.unit then
        self:UpdateName()
    end
end

function InspectFrame:UNIT_PORTRAIT_UPDATE(_, unit)
    if unit == self.unit then
        self:UpdatePortrait()
    end
end

function InspectFrame:INSPECT_TALENT_READY()
    self:UpdateTabs()
    self:UpdateTalentGroups()
end

function InspectFrame:SetTab(id)
    PanelTemplates_SetTab(self, id)

    for i, frame in ipairs(self.tabFrames) do
        frame:SetShown(i == id)
    end

    self:UpdateTalentGroups()
end

function InspectFrame:UpdateTabs()
    for id, depend in pairs(self.tabDepends) do
        if depend() then
            PanelTemplates_EnableTab(self, id)
        else
            PanelTemplates_DisableTab(self, id)
        end
    end
end

function InspectFrame:UpdateTalentGroups()
    local numGroups = Inspect:GetNumTalentGroups()
    local activeGroup = Inspect:GetActiveTalentGroup()
    local showGroupTabs = numGroups > 1 and (self.selectedTab == 3 or self.selectedTab == 4)

    for _, tab in ipairs(self.groupTabs) do
        tab:SetShown(showGroupTabs)

        if showGroupTabs then
            local talent = Inspect:GetUnitTalent(tab.id)
            local best
            local bestIcon
            for i = 1, talent:GetNumTalentTabs() do
                local _, _, pointsSpent, icon = talent:GetTabInfo(i)
                if not best or best < pointsSpent then
                    best = pointsSpent
                    bestIcon = icon
                end
            end

            if bestIcon then
                tab.best = best
                tab.nt:SetTexture(bestIcon)
            else
                tab.best = nil
            end
        end
    end

    if activeGroup then
        self:SetTalentGroup(activeGroup)
    end
end
