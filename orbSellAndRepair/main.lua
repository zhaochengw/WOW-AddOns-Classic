local _, L = ...;

local CHARACTER_DEFAULTS = {
    AutoRepair = true,
    UseGuildRepair = false,
    ReputationRepairLimit = 4,
    VendorGreys = true,
    VendorWhites = true,
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
local ignore_white = {
    [2901] = 1, -- 矿工锄
    [5956] = 1, -- 铁匠之锤
    [6219] = 1, -- 扳手
    [7005] = 1, -- 剥皮小刀
    [6256] = 1, -- 鱼竿
    [6365] = 1, -- 强化钓鱼竿
    [6366] = 1, -- 暗木鱼竿
    [6367] = 1, -- 粗铁鱼竿
    [12225] = 1,    --布拉普家族鱼竿
    --  tabard  战袍
    [20131] = 1, 
    [23192] = 1, 
    [20132] = 1, 
    [5976] = 1, 
    [23705] = 1, 
    [22999] = 1, 
    [15196] = 1, 
    [15198] = 1, 
    [19506] = 1, 
    [23709] = 1, 
    [19032] = 1, 
    [15197] = 1, 
    [19505] = 1, 
    [15199] = 1, 
    [19031] = 1, 
    [11364] = 1, 
    [19160] = 1, 
    [23710] = 1,
    --  shirt/body  衬衫
    [3427] = 1, 
    [14617] = 1, 
    [11840] = 1, 
    [4334] = 1, 
    [49] = 1, 
    [4335] = 1, 
    [18231] = 1, 
    [4336] = 1, 
    [10056] = 1, 
    [6795] = 1, 
    [5107] = 1, 
    [10034] = 1, 
    [4333] = 1, 
    [2587] = 1, 
    [6125] = 1, 
    [3342] = 1, 
    [6833] = 1, 
    [10052] = 1, 
    [16060] = 1, 
    [10055] = 1, 
    [6134] = 1, 
    [53] = 1, 
    [859] = 1, 
    [6796] = 1, 
    [2575] = 1, 
    [3428] = 1, 
    [10054] = 1, 
    [4330] = 1, 
    [154] = 1, 
    [4332] = 1, 
    [2579] = 1, 
    [16059] = 1, 
    [38] = 1, 
    [127] = 1, 
    [2577] = 1, 
    [6097] = 1, 
    [45] = 1, 
    [148] = 1, 
    [6384] = 1, 
    [6096] = 1, 
    [2576] = 1, 
    [4344] = 1, 
    [6136] = 1, 
    [17723] = 1, 
    [3426] = 1, 
    [6385] = 1, 
    [6120] = 1, 
    [6130] = 1, 
    [93] = 1, 
    [6117] = 1,
    --
    [3719] = 1, --  山地披风（南海镇任务）
};

local GetContainerItemInfo = function(bag, slot)
    if C_Container and C_Container.GetContainerItemInfo then
        local info = C_Container.GetContainerItemInfo(bag, slot)
        if info then
            return info.iconFileID, info.stackCount, info.isLocked, info.quality, info.isReadable, info.hasLoot, info.hyperlink, info.isFiltered, info.hasNoValue, info.itemID, info.isBound
        end
    else
        return _G.GetContainerItemInfo(bag, slot)
    end
end

local GetContainerNumSlots = GetContainerNumSlots or C_Container.GetContainerNumSlots
local GetContainerItemID = GetContainerItemID or C_Container.GetContainerItemID
local UseContainerItem = UseContainerItem or C_Container.UseContainerItem

local function RegisterAutoRepairEvents()

    local held = nil;
    local shown = false;
    
    local function RepairItemsAndSellTrash(self, event)
        if (event == "MERCHANT_SHOW") then

            -- local balance = 0;
            shown = true;
            held = held or GetMoney();

            if orbSellAndRepair_settings.VendorGreys or orbSellAndRepair_settings.VendorWhites then
                local bag, slot
                local total = 0
                for bag = 0, 4 do
                    for slot = 0, GetContainerNumSlots(bag) do
                        local id = GetContainerItemID(bag, slot);
                        if id then
                            local _, _, quality, _, _, _, _, _, loc, _, price, class = GetItemInfo(id);
                            if price and price > 0 then
                                if orbSellAndRepair_settings.VendorGreys and quality == 0 then
                                    total = total + price
                                    UseContainerItem(bag, slot)
                                elseif orbSellAndRepair_settings.VendorWhites and quality == 1 and (class == LE_ITEM_CLASS_WEAPON or class == LE_ITEM_CLASS_ARMOR ) then
                                    if loc ~= "INVTYPE_TABARD" and loc ~= "INVTYPE_BODY" and not ignore_white[id] then
                                        total = total + price
                                        UseContainerItem(bag, slot)
                                    end
                                end
                            end
                        end
                        -- if link and (select(3, GetItemInfo(link)) == 0) then
                        --     total = total + select(11, GetItemInfo(link))
                        --     UseContainerItem(bag, slot)
                        -- end
                    end
                end

                if total > 0 then
                    selfMessage(L.SELL_GREY .. GetCoinTextureString(total, " "));
                    -- balance = total;
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
                        -- balance = balance - repairAllCost;
                    end
                end
            end

            -- if balance > 0 then
            --     selfMessage(L.BALANCE_P .. GetCoinTextureString(balance, " "));
            -- elseif balance < 0 then
            --     selfMessage(L.BALANCE_N .. GetCoinTextureString(- balance, " "));
            -- end

        elseif event == "MERCHANT_CLOSED" then
            C_Timer.After(1.0, function()
                shown = false;
                if held then
                    local cur = GetMoney();
                    local balance = cur - held;
                    if balance > 0 then
                        selfMessage(L.BALANCE_P .. GetCoinTextureString(balance, " "));
                    elseif balance < 0 then
                        selfMessage(L.BALANCE_N .. GetCoinTextureString(- balance, " "));
                    end
                    if shown then
                        held = cur;
                    else
                        held = nil;
                    end
                end
            end);
        end
    end

    local f = CreateFrame("Frame")
    f:RegisterEvent("MERCHANT_SHOW")
    f:RegisterEvent("MERCHANT_CLOSED");
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
    
    -- VendorWhites
    local VendorWhitesBtn = CreateFrame("CheckButton", pre .. "VendorWhitesBtn", ConfigurationPanel, "ChatConfigCheckButtonTemplate")
    VendorWhitesBtn:SetPoint("TOPLEFT", 10, -170)
    getglobal(VendorWhitesBtn:GetName().."Text"):SetText(L.VendorWhitesBtn.text)

    -- save
    ConfigurationPanel.okay = function(self)
        orbSellAndRepair_settings.AutoRepair = AutoRepairBtn:GetChecked()
        if CanGuildBankRepair ~= nil then
            orbSellAndRepair_settings.UseGuildRepair = UseGuildRepairBtn:GetChecked()
        end
        orbSellAndRepair_settings.ReputationRepairLimit = math.floor(ReputSlider:GetValue())
        orbSellAndRepair_settings.VendorGreys = VendorGreysBtn:GetChecked()
        orbSellAndRepair_settings.VendorWhites = VendorWhitesBtn:GetChecked()
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
