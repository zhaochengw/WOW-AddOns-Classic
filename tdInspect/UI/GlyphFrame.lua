-- GlyphFrame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 2022/9/21 20:54:59
--
---@type ns
local ns = select(2, ...)

---@class UI.GlyphFrame: Object, Frame, AceEvent-3.0
local GlyphFrame = ns.Addon:NewClass('UI.GlyphFrame', 'Frame')

function GlyphFrame:Constructor()
    self.buttons = {}

    local left, right, top, bottom = 16, 4, 35, 8

    local Background = self:CreateTexture(nil, 'BACKGROUND', nil, 1)
    Background:SetSize(352 - left - right, 441 - top - bottom)
    Background:SetPoint('TOPLEFT', left, -top)
    Background:SetTexture([[Interface\Spellbook\UI-GlyphFrame]])
    Background:SetTexCoord(left / 512, 0.6875 - right / 512, top / 512, 0.861328125 - bottom / 512)

    for i = 1, 6 do
        self.buttons[i] = ns.UI.GlyphItem:New(self, i)
    end

    self.Background = Background

    self:SetScript('OnShow', self.OnShow)
end

function GlyphFrame:OnShow()
    self:UpdateInfo()
end

function GlyphFrame:UpdateInfo()
    if not self:IsShown() then
        return
    end

    local activeGroup = ns.Inspect:GetActiveTalentGroup()
    local glyph = ns.Inspect:GetUnitGlyph(self.groupId or activeGroup)

    for i = 1, 6 do
        self.buttons[i]:UpdateInfo(glyph)
    end

    self.Background:SetDesaturated(self.groupId ~= ns.Inspect:GetActiveTalentGroup())
end

function GlyphFrame:SetTalentGroup(id)
    self.groupId = id
    self:UpdateInfo()
end
