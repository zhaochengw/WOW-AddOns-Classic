if BG.IsBlackListPlayer then return end
if not BG.IsVanilla_Sod then return end

local AddonName, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local Size = ns.Size
local RGB = ns.RGB
local RGB_16 = ns.RGB_16
local GetClassRGB = ns.GetClassRGB
local SetClassCFF = ns.SetClassCFF
local GetText_T = ns.GetText_T
local AddTexture = ns.AddTexture
local GetItemID = ns.GetItemID

local Maxb = ns.Maxb
local HopeMaxn = ns.HopeMaxn
local HopeMaxb = ns.HopeMaxb
local HopeMaxi = ns.HopeMaxi

local pt = print
local RealmId = GetRealmID()
local player = BG.playerName
local IsAddOnLoaded = IsAddOnLoaded or C_AddOns.IsAddOnLoaded

local function GetPrice(itemID)
    itemID = tostring(itemID)
    local realmName = BG.realmName
    local faction = UnitFactionGroup("player")
    if AUCTIONATOR_PRICE_DATABASE and AUCTIONATOR_PRICE_DATABASE[realmName .. " " .. faction] and
        AUCTIONATOR_PRICE_DATABASE[realmName .. " " .. faction][itemID] then
        return AUCTIONATOR_PRICE_DATABASE[realmName .. " " .. faction][itemID].m
    end
end

local function UpdateLink(owneritemName, usetoitemID, tooltip)
    local _owneritemName = tooltip:GetItem()
    if owneritemName ~= _owneritemName then return end
    local _, link = GetItemInfo(usetoitemID)
    for i = 1, 30 do
        local rightt = _G[tooltip:GetName() .. "TextRight" .. i]
        local leftt = _G[tooltip:GetName() .. "TextLeft" .. i]
        if rightt then
            local righttext = rightt:GetText()
            local lefttext = leftt:GetText()
            if righttext == "Loading" and lefttext == L["可用于"] then
                rightt:SetText(link)
                return
            end
        end
    end
end
local function UpdatePrice(owneritemName, needitemID, tooltip)
    local _owneritemName = tooltip:GetItem()
    if owneritemName ~= _owneritemName then return end

    local name, link = GetItemInfo(needitemID)
    for i = 1, 30 do
        local rightt = _G[tooltip:GetName() .. "TextRight" .. i]
        local leftt = _G[tooltip:GetName() .. "TextLeft" .. i]
        if leftt and rightt then
            local righttext = rightt:GetText()
            local lefttext = leftt:GetText()
            if righttext == "Loading" and lefttext == "Loading" then
                leftt:SetText(link)
                local money = GetPrice(needitemID)
                if money then
                    rightt:SetText(GetMoneyString(money, true))
                else
                    rightt:SetText(L["没有价格"])
                end
                return
            end
        end
    end
end

local jiange
local function SetTooltipText(itemID, itemName, tooltip)
    if jiange then return end
    jiange = true
    BG.After(0, function() jiange = false end)
    for _itemID, v in pairs(BG.CommerceAuthority) do
        _itemID = tonumber(_itemID)
        if _itemID == itemID then
            tooltip:AddLine(" ")
            if v.needitem and IsAddOnLoaded("Auctionator") then
                tooltip:AddDoubleLine("Loading", "Loading", 1, 0.82, 0, 1, 1, 1)
                local item = Item:CreateFromItemID(v.needitem)
                item:ContinueOnItemLoad(function()
                    UpdatePrice(itemName, v.needitem, tooltip)
                end)
            end
            if v.usetoitem then
                tooltip:AddDoubleLine(L["可用于"], "Loading", 1, 0.82, 0, 1, 1, 1)
                tooltip:AddDoubleLine(L["需要数量"], v.needcount, 1, 0.82, 0, 1, 1, 1)
                local item = Item:CreateFromItemID(v.usetoitem)
                item:ContinueOnItemLoad(function()
                    UpdateLink(itemName, v.usetoitem, tooltip)
                end)
            end

            tooltip:AddDoubleLine(L["金钱奖励"], GetMoneyString(v.moneygive,true), 1, 0.82, 0, 1, 1, 1)
            tooltip:AddDoubleLine(L["声望奖励"], v.fullgive, 1, 0.82, 0, 1, 1, 1)

            local faction
            if BG.IsAlliance then faction = 2586 else faction = 2587 end
            local r, g, b = 1, 1, 1
            local StandingID = select(3, GetFactionInfoByID(faction))
            if StandingID >= v.topFactionValue then
                r, g, b = 0.5, 0.5, 0.5
            end
            tooltip:AddDoubleLine(L["声望最高可提升至"], _G["FACTION_STANDING_LABEL" .. v.topFactionValue], 1, 0.82, 0, r, g, b)
            tooltip:Show()
            return
        end
    end
end

local function AddInfo(self)
    if BiaoGe.options["commerceAuthorityTooltip"] ~= 1 then return end
    local name, link = self:GetItem()
    if not link then return end
    local itemID = GetItemInfoInstant(link)
    SetTooltipText(itemID, name, self)
end

GameTooltip:HookScript("OnTooltipSetItem", AddInfo)
ItemRefTooltip:HookScript("OnTooltipSetItem", AddInfo)


-- 在专业技能面板和专业技能学习面板的清单里，高亮与[遭劫货物]有关联的物品
BG.RegisterEvent("ADDON_LOADED", function(self, event, addonName)
    -- 专业制造
    if addonName == "Blizzard_TradeSkillUI" then
        hooksecurefunc("TradeSkillFrame_Update", function()
            if BiaoGe.options["commerceAuthorityTooltip"] ~= 1 then return end
            local numTradeSkills = GetNumTradeSkills()
            local skillOffset = FauxScrollFrame_GetOffset(TradeSkillListScrollFrame)
            for i = 1, TRADE_SKILLS_DISPLAYED, 1 do
                local skillIndex = i + skillOffset
                local skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(skillIndex)
                local skillButton = _G["TradeSkillSkill" .. i]
                if (skillIndex <= numTradeSkills) then
                    if (skillType ~= "header") then
                        local link = GetTradeSkillItemLink(skillIndex)
                        if link then
                            local itemID = GetItemInfoInstant(link)
                            for _itemID in pairs(BG.CommerceAuthority) do
                                if itemID == _itemID then
                                    skillButton:SetText(skillButton:GetText() .. " " .. L["(贸易局)"])
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end)
        hooksecurefunc("TradeSkillFrame_SetSelection", function()
            if BiaoGe.options["commerceAuthorityTooltip"] ~= 1 then return end
            if not TradeSkillFrame.selectedSkill then return end
            local link = GetTradeSkillItemLink(TradeSkillFrame.selectedSkill)
            if link then
                local itemID = GetItemInfoInstant(link)
                for _itemID in pairs(BG.CommerceAuthority) do
                    if itemID == _itemID then
                        local bt = TradeSkillSkillName
                        bt:SetText(bt:GetText() .. " " .. L["(贸易局)"])
                    end
                end
            end
        end)
    end

    -- 学习技能
    if addonName == "Blizzard_TrainerUI" then
        hooksecurefunc("ClassTrainerFrame_Update", function()
            local numTrainerServices = GetNumTrainerServices();
            local skillOffset = FauxScrollFrame_GetOffset(ClassTrainerListScrollFrame);
            for i = 1, CLASS_TRAINER_SKILLS_DISPLAYED, 1 do
                local skillIndex = i + skillOffset
                local serviceName, serviceSubText, serviceType, isExpanded = GetTrainerServiceInfo(skillIndex);
                local skillButton = _G["ClassTrainerSkill" .. i]
                if (skillIndex <= numTrainerServices) then
                    if (serviceType ~= "header") then
                        for _itemID in pairs(BG.CommerceAuthority) do
                            local _name = GetItemInfo(_itemID)
                            if serviceName == _name then
                                skillButton:SetText(skillButton:GetText() .. " " .. L["(贸易局)"])
                                break
                            end
                        end
                    end
                end
            end
        end)
        hooksecurefunc("ClassTrainer_SetSelection", function()
            if not ClassTrainerFrame.selectedService then return end
            local serviceName = GetTrainerServiceInfo(ClassTrainerFrame.selectedService)
            for _itemID in pairs(BG.CommerceAuthority) do
                local _name = GetItemInfo(_itemID)
                if serviceName == _name then
                    local bt = ClassTrainerSkillName
                    bt:SetText(bt:GetText() .. " " .. L["(贸易局)"])
                end
            end
        end)
    end
end)

----------拍卖行的搜索框总是删除"遭劫货物："----------
do
    local function SearchItem(text)
        if AuctionatorShoppingFrame and AuctionatorShoppingFrame:IsVisible() then
            local name = GetItemInfo(text)
            if strfind(name, L["遭劫货物"]) then
                name = "\"" .. name:gsub(L["遭劫货物"] .. "[:：]*", "") .. "\""
                AuctionatorShoppingFrame:DoSearch({ name }, {})
                AuctionatorShoppingFrame.SearchOptions:SetSearchTerm(name)
                Auctionator.Shopping.Recents.Save(name)
            end
        end
    end
    local function SetSearchName(text)
        if BrowseName and BrowseName:IsVisible() then
            local name = GetItemInfo(text);
            if strfind(name, L["遭劫货物"]) then
                name = "\"" .. name:gsub(L["遭劫货物"] .. "[:：]*", "") .. "\""
                BrowseName:SetText(name)
            end
        end
    end
    hooksecurefunc(_G, "ChatEdit_InsertLink", function(text)
        if BiaoGe.options["commerceAuthorityTooltip"] ~= 1 then return end
        if strfind(text, "item:", 1, true) then
            BG.After(0, function()
                SearchItem(text)
                SetSearchName(text)
            end)
        end
    end)
end

----------血月活动期间自动释放尸体和对话自动复活----------
BG.Init2(function()
    local tbl = {
        121411, -- 血月活动
    }
    BG.RegisterEvent("GOSSIP_SHOW", function(self, event)
        if BiaoGe.options["xueyueAuto"] ~= 1 then return end
        local info = C_GossipInfo.GetOptions()
        for i, v in pairs(info) do
            for _, id in pairs(tbl) do
                if v.gossipOptionID == id then
                    C_GossipInfo.SelectOption(v.gossipOptionID)
                end
            end
        end
    end)

    local bt = CreateFrame("CheckButton", nil, UIParent, "ChatConfigCheckButtonTemplate")
    bt:SetSize(30, 30)
    bt.Text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
    bt.Text:SetText(BG.BG .. L["荆棘谷血月活动期间自动释放尸体和对话自动复活"])
    bt.Text:SetPoint("TOPLEFT", bt, "TOPRIGHT", 0, -5)
    bt:SetHitRectInsets(0, 0, 0, 0)
    bt.name = "xueyueAuto"
    if BiaoGe.options["xueyueAuto"] == 1 then
        bt:SetChecked(true)
    else
        bt:SetChecked(false)
    end
    bt:Hide()
    bt:SetScript("OnShow", function(self)
        if BiaoGe.options[self.name] == 1 then
            self:SetChecked(true)
        else
            self:SetChecked(false)
        end
    end)
    bt:SetScript("OnClick", function(self)
        if self:GetChecked() then
            BiaoGe.options[self.name] = 1
        else
            BiaoGe.options[self.name] = 0
        end
        BG.PlaySound(1)
    end)

    local wh = "DEATH"
    hooksecurefunc("StaticPopup_Show", function(whick)
        if whick == wh then
            local yes
            local i = 1
            while UnitAura("player", i) do
                local spellID = select(10, UnitAura("player", i))
                if spellID == 436097 then
                    yes = true
                    break
                end
                i = i + 1
            end
            if not yes then return end
            local _, dialog = StaticPopup_Visible(wh)
            if dialog then
                bt:ClearAllPoints()
                bt:SetPoint("TOPLEFT", dialog, "BOTTOMLEFT", 0, 0)
                bt.Text:SetWidth(StaticPopup1:GetWidth() - 50)
                bt:Show()
                if BiaoGe.options["xueyueAuto"] == 1 then
                    if dialog.button1 then
                        dialog.button1:Click()
                    else
                        dialog.visibleButtons[1]:Click()
                    end
                end
            end
        end
    end)
    hooksecurefunc("StaticPopup_Hide", function(whick)
        if whick == wh then
            if bt then
                bt:Hide()
            end
        end
    end)
end)
