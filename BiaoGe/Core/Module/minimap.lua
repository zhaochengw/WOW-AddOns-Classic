local AddonName, ns = ...
local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN

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
            ns.InterfaceOptionsFrame_OpenToCategory("|cff00BFFFBiaoGe|r")
            BG.MainFrame:Hide()
        end
        BG.PlaySound(1)
    end
end

function plugin:OnEnter(button)
    BG.SetFBCD("minimap")
    BG.FBCDFrame:ClearAllPoints()
    if BG.ButtonIsInRight(self) then
        BG.FBCDFrame:SetPoint("TOPRIGHT", self, "BOTTOMLEFT", 0, 0)
    else
        BG.FBCDFrame:SetPoint("TOPLEFT", self, "BOTTOMRIGHT", 0, 0)
    end
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
