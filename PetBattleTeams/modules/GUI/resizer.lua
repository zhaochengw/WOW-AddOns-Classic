local PetBattleTeams = LibStub("AceAddon-3.0"):GetAddon("PetBattleTeams")
local GUI = PetBattleTeams:GetModule("GUI")

local function OnDragStart(self)
    self.parent:SetResizable(true)
    self.parent:StartSizing()
end

local function OnDragStop(self)
    self.parent:StopMovingOrSizing()
    self.parent:SetResizable(false)
end

function GUI:CreateResizer(parent)
    local resizeButton = CreateFrame("Button",nil,parent)
    resizeButton:EnableMouse(true)
    resizeButton:SetSize(20,20)
    resizeButton:SetPoint("BOTTOMRIGHT",parent,"BOTTOMRIGHT",-6,6)
    resizeButton.icon = resizeButton:CreateTexture(nil,"ARTWORK")
    resizeButton.icon:SetTexture("Interface\\CHATFRAME\\UI-ChatIM-SizeGrabber-Up")
    resizeButton.icon:SetAllPoints(resizeButton)
    resizeButton:SetHighlightTexture("Interface\\CHATFRAME\\UI-ChatIM-SizeGrabber-Highlight","ADD")
    resizeButton:SetPushedTexture("Interface\\CHATFRAME\\UI-ChatIM-SizeGrabber-Down")
    resizeButton:RegisterForDrag("LeftButton","RightButton")
    resizeButton.parent = parent

    resizeButton:SetScript("OnDragStart",OnDragStart)
    resizeButton:SetScript("OnDragStop",OnDragStop)

    return resizeButton
end
