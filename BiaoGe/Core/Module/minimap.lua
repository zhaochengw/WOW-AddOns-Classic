if BG.IsBlackListPlayer then return end
local AddonName, ns = ...
local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN

local ldb = LibStub:GetLibrary("LibDataBroker-1.1", true)
if not ldb then return end

local pt = print

local plugin = ldb:NewDataObject(AddonName, { text = AddonName, type = "data source", icon = "Interface\\AddOns\\BiaoGe\\Media\\icon\\icon" })

function plugin:OnClick(button) --function plugin.OnClick(self, button)
    if button == "LeftButton" then
        if IsControlKeyDown() then
            BG.SetFBCD(nil, nil, true)
        else
            BG.MainFrame:SetShown(not BG.MainFrame:IsVisible())
        end
    elseif button == "RightButton" then
        if SettingsPanel:IsVisible() then
            HideUIPanel(SettingsPanel)
        else
            ns.InterfaceOptionsFrame_OpenToCategory("|cff00BFFFBiaoGe|r")
            BG.MainFrame:Hide()
        end
    elseif button == "MiddleButton" then
        BG.SetFBCD(nil, nil, true)
    end
    BG.PlaySound(1)
end

function plugin:OnEnter(button)
    BG.SetFBCD(self, "minimap")
end

function plugin:OnLeave(button)
    if BG.FBCDFrame and not BG.FBCDFrame.click then
        BG.FBCDFrame:Hide()
    end
    GameTooltip:Hide()
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
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
