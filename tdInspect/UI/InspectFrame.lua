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

---@class UI.InspectFrame: Object, Frame, AceEvent-3.0
local InspectFrame = ns.Addon:NewClass('UI.InspectFrame', 'Frame')

function InspectFrame:Constructor()
    self:SuperCall('UnregisterAllEvents')
    self:SetScript('OnEvent', nil)

    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.OnHide)

    self.tabFrames = {}
    for i, v in ipairs(INSPECTFRAME_SUBFRAMES) do
        self.tabFrames[i] = _G[v]
    end

    function InspectSwitchTabs(id)
        return self:SetTab(id)
    end

    self.Portrait = InspectFramePortrait
    self.Name = InspectNameText
    self.PaperDoll = ns.UI.PaperDoll:Bind(InspectPaperDollFrame)
    self.TalentFrame = ns.UI.InspectTalent:Bind(self:CreateTabFrame{
        -- topLeft = [[Interface\FriendsFrame\UI-FRIENDSFRAME-TOPLEFT]],
        -- topRight = [[Interface\PaperDollInfoFrame\UI-Character-ClassSkillsTab-R1]],
        -- bottomLeft = [[Interface\FriendsFrame\UI-FriendsFrame-Pending-BotLeft]],
        -- bottomRight = [[Interface\FriendsFrame\UI-FriendsFrame-Pending-BotRight]],
    })
    --[=[@classic@
    self:AddTab(TALENT, self.TalentFrame)
    --@end-classic@]=]
    --@non-classic@
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
    --@end-non-classic@

    self.Portrait:SetSize(64, 64)
end

function InspectFrame:OnShow()
    self:RegisterEvent('UNIT_NAME_UPDATE')
    self:RegisterEvent('UNIT_PORTRAIT_UPDATE')
    self:RegisterEvent('PORTRAITS_UPDATED', 'UpdatePortrait')
    self:RegisterMessage('INSPECT_TARGET_CHANGED', 'Update')
    self:RegisterMessage('INSPECT_TALENT_READY', 'UpdateTabs')
    self:Update()
    self:UpdateTabs()
    PlaySound(839) -- SOUNDKIT.IG_CHARACTER_INFO_OPEN
end

function InspectFrame:OnHide()
    self.unitName = nil
    self:UnregisterAllEvents()
    Inspect:Clear()
    self:SetTab(1)
    self.TalentFrame:SetTab(1)
    PlaySound(840) -- SOUNDKIT.IG_CHARACTER_INFO_CLOSE
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

    return frame
end

function InspectFrame:CreateTabFrame(bgs)
    ---@type Frame
    local frame = CreateFrame('Frame', nil, self)
    frame:SetAllPoints(true)
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

function InspectFrame:SetTab(id)
    PanelTemplates_SetTab(self, id)

    for i, frame in ipairs(self.tabFrames) do
        frame:SetShown(i == id)
    end
end

function InspectFrame:UpdateTabs()
    if Inspect:GetUnitTalent() and Inspect:GetUnitClassFileName() then
        PanelTemplates_EnableTab(self, 3)
    else
        PanelTemplates_DisableTab(self, 3)
    end

    if Inspect.unit and CheckInteractDistance(Inspect.unit, 1) and CanInspect(Inspect.unit) then
        PanelTemplates_EnableTab(self, 2)
    else
        PanelTemplates_DisableTab(self, 2)
    end
end
