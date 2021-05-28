local _, L = ...;

local CHARACTER_DEFAULTS = {
    AutoRepair = false,
    UseGuildRepair = false,
    ReputationRepairLimit = 5,
    VendorGreys = true,
}

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

local function selfMessage(v) 
    DEFAULT_CHAT_FRAME:AddMessage(v, 1.0, 1.0, 1.0);
end

--------------------------------------------------------------------------------
-- Settings
--------------------------------------------------------------------------------

local function LoadSettings()
    
    if orbSellAndRepair_settings == nil then
        orbSellAndRepair_settings = {}
    end

    local function CopyDefaults(src, dst)
        if type(src) ~= "table" then
            return {}
        end
        if type(dst) ~= "table" then
            dst = {}
        end

        for k, v in pairs(src) do
            if type(v) == "table" then
                dst[k] = CopyDefaults(v, dst[k])
            elseif type(v) ~= type(dst[k]) then
                dst[k] = v
            end
        end

        return dst
    end

    CopyDefaults(CHARACTER_DEFAULTS, orbSellAndRepair_settings)
end

--------------------------------------------------------------------------------
-- Autorepair && junk seller
--------------------------------------------------------------------------------

local function RegisterAutoRepairEvents()

    local function RepairItemsAndSellTrash(self, event)
        if (event == "MERCHANT_SHOW") then

            if orbSellAndRepair_settings.VendorGreys then
                local bag, slot
                local total = 0
                for bag = 0, 4 do
                    for slot = 0, GetContainerNumSlots(bag) do
                        local link = GetContainerItemLink(bag, slot)
                        if link and (select(3, GetItemInfo(link)) == 0) then
                            total = total + select(11, GetItemInfo(link))
                            UseContainerItem(bag, slot)
                        end
                    end
                end

                if total > 0 then
                    selfMessage(L.SELL_GREY .. GetCoinTextureString(total, " "));
                end
            end

            if orbSellAndRepair_settings.AutoRepair and CanMerchantRepair() then
                local repairAllCost, canRepair = GetRepairAllCost()
                if canRepair then
                    if orbSellAndRepair_settings.ReputationRepairLimit > UnitReaction("npc", "player") then
                        selfMessage(L.REPAIR_REPUT)
                    elseif repairAllCost > GetMoney() then
                        selfMessage(L.REPAIR_MONEY)
                    else
                        local repairFromGuild = orbSellAndRepair_settings.UseGuildRepair 
                            and IsInGuild() 
                            and CanGuildBankRepair ~= nil 
                            and CanGuildBankRepair()
                        RepairAllItems(repairFromGuild)
                        selfMessage(L.REPAIR_OK .. GetCoinTextureString(repairAllCost, " "));
                    end
                end
            end

        end
    end

    local f = CreateFrame("Frame")
    f:RegisterEvent("MERCHANT_SHOW")
    f:RegisterEvent("VARIABLES_LOADED")
    f:SetScript("OnEvent", RepairItemsAndSellTrash)
end

-----------------------------------------------------------------------------
-- Options panel                                                          --
-----------------------------------------------------------------------------
local configurationPanelCreated = false

function CreateConfigurationPanel()
    if configurationPanelCreated then
        return nil
    end
    configurationPanelCreated = true

    local pre = _ .. "Config_"

    local ConfigurationPanel = CreateFrame("Frame", pre .. "MainFrame");
	ConfigurationPanel.name = _
    InterfaceOptions_AddCategory(ConfigurationPanel)

    -- Title
    local IntroMessageHeader = ConfigurationPanel:CreateFontString(nil, "ARTWORK","GameFontNormalLarge")
	IntroMessageHeader:SetPoint("TOPLEFT", 10, -10)
    IntroMessageHeader:SetText(_ .. " " .. GetAddOnMetadata(_, "Version"))
    
    -- AutoRepair
    local AutoRepairBtn = CreateFrame("CheckButton", pre .. "AutoRepairBtn", ConfigurationPanel, "ChatConfigCheckButtonTemplate")
    AutoRepairBtn:SetPoint("TOPLEFT", 10, -40)
    getglobal(AutoRepairBtn:GetName().."Text"):SetText(L.AutoRepairBtn.text)

    -- ReputationRepairLimit
    local ReputSliderLbl = ConfigurationPanel:CreateFontString("ReputSliderLbl","ARTWORK","GameFontNormal")
	ReputSliderLbl:SetPoint("TOPLEFT", 200, -80)
    
    local ReputSlider = CreateFrame("Slider", pre .. "ReputSlider", ConfigurationPanel, "OptionsSliderTemplate")
	ReputSlider:SetMinMaxValues(4,8)
	ReputSlider:SetValueStep(1)
    ReputSlider:SetPoint("TOPLEFT", 40, -80)
    ReputSlider.tooltip = "L.ReputSlider.tooltip"
	getglobal(ReputSlider:GetName().."Text"):SetText(L.ReputSlider.text)
	getglobal(ReputSlider:GetName().."High"):SetText(L.REPUTATIONS[8])
	getglobal(ReputSlider:GetName().."Low"):SetText(L.REPUTATIONS[4])
	ReputSlider:SetScript("OnValueChanged", function(self)
        local iReput = math.floor(self:GetValue())
        ReputSliderLbl:SetText(L.REPUTATIONS[iReput])
    end)

    -- UseGuildRepair
    local UseGuildRepairBtn
    if CanGuildBankRepair ~= nil then
        UseGuildRepairBtn = CreateFrame("CheckButton", pre .. "UseGuildRepairBtn", ConfigurationPanel, "ChatConfigCheckButtonTemplate")
        UseGuildRepairBtn:SetPoint("TOPLEFT", 30, -110)
        getglobal(UseGuildRepairBtn:GetName().."Text"):SetText(L.UseGuildRepairBtn.text)
    end

    -- VendorGreys
    local VendorGreysBtn = CreateFrame("CheckButton", pre .. "VendorGreysBtn", ConfigurationPanel, "ChatConfigCheckButtonTemplate")
    VendorGreysBtn:SetPoint("TOPLEFT", 10, -140)
    getglobal(VendorGreysBtn:GetName().."Text"):SetText(L.VendorGreysBtn.text)
    
    -- save
    ConfigurationPanel.okay = function(self)
        orbSellAndRepair_settings.AutoRepair = AutoRepairBtn:GetChecked()
        if CanGuildBankRepair ~= nil then
            orbSellAndRepair_settings.UseGuildRepair = UseGuildRepairBtn:GetChecked()
        end
        orbSellAndRepair_settings.ReputationRepairLimit = math.floor(ReputSlider:GetValue())
        orbSellAndRepair_settings.VendorGreys = VendorGreysBtn:GetChecked()
    end

    -- cancel
    ConfigurationPanel.cancel = function(self)
        AutoRepairBtn:SetChecked(orbSellAndRepair_settings.AutoRepair)
        if CanGuildBankRepair ~= nil then
            UseGuildRepairBtn:SetChecked(orbSellAndRepair_settings.UseGuildRepair)
        end
        ReputSlider:SetValue(orbSellAndRepair_settings.ReputationRepairLimit)
        VendorGreysBtn:SetChecked(orbSellAndRepair_settings.VendorGreys)
    end

    -- init
    ConfigurationPanel.cancel()
end

-----------------------------------------------------------------------------
-- Load the addon                                                          --
-----------------------------------------------------------------------------

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event)
    if event == "ADDON_LOADED" then
        LoadSettings()
        CreateConfigurationPanel()
    elseif event == "PLAYER_LOGIN" then
        RegisterAutoRepairEvents()
    end
end)
