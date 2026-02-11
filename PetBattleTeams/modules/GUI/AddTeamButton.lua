local PetBattleTeams = LibStub("AceAddon-3.0"):GetAddon("PetBattleTeams")
local TeamManager =  PetBattleTeams:GetModule("TeamManager")
local GUI = PetBattleTeams:GetModule("GUI")

local _, addon = ...
local L = addon.L

local function OnClick(self)
    TeamManager:CreateTeam()
end

local function OnEnter(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT");
    GameTooltip:ClearLines()
    GameTooltip:AddLine(L["Click to add a new team"])
    local numTeams = TeamManager:GetNumTeams()

    GameTooltip:Show()
end

local function OnLeave(self)
    GameTooltip:Hide()
end

function GUI:CreateAddTeamButton(name,parent)
    local widget = CreateFrame("Button",name,parent)
    widget:SetSize(38,38)
    widget.icon = widget:CreateTexture(parent:GetName()..name.."Icon","ARTWORK")
    widget.icon:SetTexture("Interface\\GuildBankFrame\\UI-GuildBankFrame-NewTab")
    widget.icon:SetAllPoints(widget)
    widget:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square","ADD")
    widget:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")
    widget:SetScript("OnEnter",OnEnter)
    widget:SetScript("OnLeave",OnLeave)
    widget:SetScript("OnClick",OnClick)
    return widget
end
