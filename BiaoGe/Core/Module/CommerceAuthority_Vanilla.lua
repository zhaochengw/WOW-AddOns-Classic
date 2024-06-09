if not BG.IsVanilla_Sod() then return end

local AddonName, ADDONSELF = ...

local LibBG = ADDONSELF.LibBG
local L = ADDONSELF.L

local RR = ADDONSELF.RR
local NN = ADDONSELF.NN
local RN = ADDONSELF.RN
local Size = ADDONSELF.Size
local RGB = ADDONSELF.RGB
local RGB_16 = ADDONSELF.RGB_16
local GetClassRGB = ADDONSELF.GetClassRGB
local SetClassCFF = ADDONSELF.SetClassCFF
local GetText_T = ADDONSELF.GetText_T
local FrameDongHua = ADDONSELF.FrameDongHua
local FrameHide = ADDONSELF.FrameHide
local AddTexture = ADDONSELF.AddTexture
local GetItemID = ADDONSELF.GetItemID

local Width = ADDONSELF.Width
local Height = ADDONSELF.Height
local Maxb = ADDONSELF.Maxb
local Maxi = ADDONSELF.Maxi
local HopeMaxn = ADDONSELF.HopeMaxn
local HopeMaxb = ADDONSELF.HopeMaxb
local HopeMaxi = ADDONSELF.HopeMaxi

local pt = print
local RealmId = GetRealmID()
local player = UnitName("player")

local function GetPrice(itemID)
    itemID = tostring(itemID)
    local realmName = GetRealmName()
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
                leftt:SetText(name)
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

local function SetTooltipText(itemID, itemName, tooltip)
    for _itemID, v in pairs(BG.CommerceAuthority) do
        _itemID = tonumber(_itemID)
        if _itemID == itemID then
            tooltip:AddLine(" ")
            if v.isfullitem then
                tooltip:AddDoubleLine(L["声望奖励"], v.fullgive, 1, 0.82, 0, 1, 1, 1)
            else
                if v.usetoitem then
                    tooltip:AddDoubleLine(L["可用于"], "Loading", 1, 0.82, 0, 1, 1, 1)
                    tooltip:AddDoubleLine(L["需要数量"], v.needcount, 1, 0.82, 0, 1, 1, 1)
                    local item = Item:CreateFromItemID(v.usetoitem)
                    item:ContinueOnItemLoad(function()
                        UpdateLink(itemName, v.usetoitem, tooltip)
                    end)
                end
                if v.needitem and IsAddOnLoaded("Auctionator") then
                    tooltip:AddDoubleLine("Loading", "Loading", 1, 0.82, 0, 1, 1, 1)
                    local item = Item:CreateFromItemID(v.needitem)
                    item:ContinueOnItemLoad(function()
                        UpdatePrice(itemName, v.needitem, tooltip)
                    end)
                end
                tooltip:AddDoubleLine(L["空载时声望奖励"], v.emptygive, 1, 0.82, 0, 1, 1, 1)
                tooltip:AddDoubleLine(L["补足时声望奖励"], v.fullgive, 1, 0.82, 0, 1, 1, 1)
            end
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
