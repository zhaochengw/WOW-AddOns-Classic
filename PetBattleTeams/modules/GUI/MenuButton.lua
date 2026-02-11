local PetBattleTeams = LibStub("AceAddon-3.0"):GetAddon("PetBattleTeams")
local Config = PetBattleTeams:GetModule("Config","AceConsole-3.0")
local GUI = PetBattleTeams:GetModule("GUI")
local AUTO_HIDE_DELAY = 12

local _, addon = ...
local L = addon.L

local function OnEnter(self)
    GameTooltip:SetOwner(self, "ANCHOR_CENTER");
    GameTooltip:ClearLines()
    GameTooltip:AddLine(L["PetBattle Teams"], 1, 1, 1)
    GameTooltip:AddLine(L["Right-click to show options menu.|nClick to toggle teams frame."], 0,1,0)
    GameTooltip:Show()
end
local function OnLeave(self)
    GameTooltip:Hide()
end

function GUI:CreateMenuButton()
    local button = CreateFrame("BUTTON")
    local lib = LibStub("LibDropDownMenu");
    local menuFrame = lib.Create_DropDownMenu("PetBattleTeamsMenu", UIParent)


    local options = Config:GetEasyMenu()


    button:EnableMouse(true)
    button:SetSize(33,33)
    button:ClearAllPoints()

    button.icon = button:CreateTexture("PetBattleTeambuttonButtonIcon","ARTWORK")
    button.icon:SetTexture("Interface\\Icons\\INV_PET_BATTLEPETTRAINING")
    button.icon:SetSize(21,21)
    button.icon:ClearAllPoints()
    button.icon:SetPoint("TOPLEFT",button,"TOPLEFT",7,-6)

    button.overlay = button:CreateTexture("PetBattleTeambuttonButtonIcon","OVERLAY")
    button.overlay:SetTexture("Interface\\MiniMap\\MiniMap-TrackingBorder")
    button.overlay:SetSize(56,56)
    button.overlay:ClearAllPoints()
    button.overlay:SetPoint("TOPLEFT",button,"TOPLEFT")

    button:SetHighlightTexture("Interface\\MiniMap\\UI-MiniMap-ZoomButton-Highlight","ADD")
    button:RegisterForClicks("LeftButtonUp","RightButtonUp")
    button:SetScript("OnClick", function(self, mouseButton)
        GameTooltip:Hide()
        if mouseButton == "LeftButton" then
            GUI:ToggleMinimize(not GUI:GetIsMinimized())
        else
            lib.EasyMenu(options, menuFrame, button, 0 , 0, "MENU",AUTO_HIDE_DELAY);
        end
    end)
    button:SetScript("OnEnter",OnEnter)
    button:SetScript("OnLeave",OnLeave)
    return button
end
