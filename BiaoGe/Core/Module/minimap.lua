local AddonName, ADDONSELF = ...
local LibBG = ADDONSELF.LibBG
local L = ADDONSELF.L

local RR = ADDONSELF.RR
local NN = ADDONSELF.NN
local RN = ADDONSELF.RN

local ldb = LibStub:GetLibrary("LibDataBroker-1.1", true)
if not ldb then return end

local pt = print

local plugin = ldb:NewDataObject(AddonName, { type = "data source", icon = "Interface\\AddOns\\BiaoGe\\Media\\icon\\icon" })

function plugin:OnClick(button) --function plugin.OnClick(self, button)
    if button == "LeftButton" then
        if BG.MainFrame and not BG.MainFrame:IsVisible() then
            BG.MainFrame:Show()
        else
            BG.MainFrame:Hide()
        end
    elseif button == "RightButton" then
        if SettingsPanel:IsVisible() then
            HideUIPanel(SettingsPanel)
        else
            InterfaceOptionsFrame_OpenToCategory("|cff00BFFFBiaoGe|r")
            BG.MainFrame:Hide()
        end
        PlaySound(BG.sound1, "Master")
    end
end

function plugin:OnEnter(button)
    BG.SetFBCD("minimap")
    BG.FBCDFrame:ClearAllPoints()
    BG.FBCDFrame:SetPoint("TOPRIGHT", self, "BOTTOMLEFT", 0, 0)
    BG.FBCDFrame:Show()
end

function plugin:OnLeave(button)
    if BG.FBCDFrame then
        BG.FBCDFrame:Hide()
    end
    GameTooltip:Hide()
end

local frame = CreateFrame("Frame")
frame:SetScript("OnEvent", function()
    local icon = LibStub("LibDBIcon-1.0", true)
    if not icon then return end
    icon:Register(AddonName, plugin, BiaoGe)

    if BiaoGe.miniMoney then
        BiaoGe.miniMoney = nil
    end

    C_Timer.After(0.2, function()
        if BiaoGe.options["miniMap"] == 0 then
            icon:Hide(AddonName)
        end
    end)
end)
frame:RegisterEvent("PLAYER_LOGIN")
