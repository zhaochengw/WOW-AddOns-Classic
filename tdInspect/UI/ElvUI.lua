-- ElvUI.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 7/13/2021, 9:40:58 AM
--
if not ElvUI then
    return
end

---@type ns
local ns = select(2, ...)

local E = unpack(ElvUI)
local S = E:GetModule('Skins')

local function hook(t, m, f)
    local o = t[m]
    t[m] = function(...)
        return f(o, ...)
    end
end

hooksecurefunc(ns.Addon, 'SetupUI', function(self)
    self.InspectFrame.TalentFrame:StripTextures()
    self.InspectFrame.TalentFrame.TalentFrame:StripTextures()
    self.InspectFrame.TalentFrame.TalentFrame:CreateBackdrop('Default')

    self.InspectFrame.PaperDoll.EquipFrame:CreateBackdrop('Default')
    self.InspectFrame.PaperDoll.ModelFrame:CreateBackdrop('Default')

    for i, tab in ipairs(self.InspectFrame.TalentFrame.Tabs) do
        S:HandleTab(tab, true)
    end

    S:HandleScrollBar(self.InspectFrame.TalentFrame.TalentFrame.ScrollBar)
    S:HandleCheckBox(self.InspectFrame.PaperDoll.ToggleButton)

    self.InspectFrame.TalentFrame.Summary:GetParent():StripTextures()

    InspectMainHandSlot:StripTextures()
    InspectSecondaryHandSlot:StripTextures()
    InspectRangedSlot:StripTextures()
end)

hooksecurefunc(ns.UI.SlotItem, 'UpdateBorder', function(self, r, g, b)
    if r then
        self.backdrop:SetBackdropBorderColor(r, g, b)
    else
        self.backdrop:SetBackdropBorderColor(unpack(E.media.bordercolor))
    end
    self.IconBorder:Hide()
end)

hook(ns.UI.TalentFrame, 'GetTalentButton', function(orig, self, i)
    local button = orig(self, i)

    if not button.__elvui then
        button.__elvui = true

        button:StripTextures()
        button:SetTemplate('Default')
        button:StyleButton()

        local icon = button.icon
        icon:SetInside()
        icon:SetTexCoord(unpack(E.TexCoords))
        icon:SetDrawLayer('ARTWORK')

        button.Rank:SetFont(E.LSM:Fetch('font', E.db['general'].font), 12, 'OUTLINE')
    end
    return button
end)
