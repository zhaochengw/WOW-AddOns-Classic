--[[
    ManyItemTooltips 3.0
    By Doomchicken of Dark Iron[US]
    Add support for MIT to your addon! See bottom of code.
    :D
]]
local _
local _G = _G

local presetHooks = {
    TooltipItemIcon = { { "OnCreate", function(frame) TooltipItemIcon_HookFrame(frame) end } },
    IDCard = { { "OnCreate", function(frame) IDCard:RegisterTooltip(frame) end } },
    Valuation = { { "OnShow", function(frame) if (Valuation["styles"][ValuationCfg["style"]]) then Valuation["styles"][ValuationCfg["style"]].Draw(frame, GetSellValue(MIT:GetLinkString(frame)), 1) end end } },
    StatStain = { { "OnCreate", function(frame) LibStub("AceAddon-3.0"):GetAddon("StatStain"):AddTooltip(frame) end } },
    Mendeleev = { { "OnShow", function(frame) Mendeleev:OnTooltipSetItem(frame) end }, { "OnHide", function(frame) Mendeleev:OnTooltipCleared(frame) end } },
    CowTip = { { "OnShow", function(frame) local ct = CowTip:GetModule("Appearance") if ct then ct:SetScale(nil, frame) ct:SetFont(nil, frame) ct:SetTexture(nil, nil, nil, nil, frame) end end } },
    TipTac = { { "OnCreate", function(frame) TipTac:AddModifiedTip(frame) end } },
}

local tooltipTypes = {
    item = true,
    spell = true,
    achievement = true,
    quest = true,
    enchant = true,
    talent = true,
    instancelock = true,
}

local MIT = CreateFrame("Frame")
_G.MIT = MIT

local hooks = { }
local tooltips = { }
local links = { }

local function onEvent(self, event, addon)
    if event == "ADDON_LOADED" then
        if presetHooks[addon] and not hooks[addon] then
            for _,v in ipairs(presetHooks[addon]) do
                self:AddHook(addon, v[1], v[2])
            end
        end
    else
        hooksecurefunc(ItemRefTooltip, "Hide", function() links["ItemRefTooltip"] = nil end)
        for i,v in pairs(presetHooks) do
            if IsAddOnLoaded(i) and not hooks[i] then
                for _,h in ipairs(v) do
                    self:AddHook(i, h[1], h[2])
                end
            end
        end
        self:RegisterEvent("ADDON_LOADED")
    end
end
MIT:SetScript("OnEvent", onEvent)
MIT:RegisterEvent("VARIABLES_LOADED")

local function checkHook(event, frame)
    for i,v in pairs(hooks) do
        if v[event] then
            v[event](frame)
        end
    end
end

local OldSetItemRef = SetItemRef
-- Our replacement function
SetItemRef = function(...)
    local link, text, button, chatFrame = ...

    -- Don't mess with modified clicks
    if IsModifiedClick() then
        return OldSetItemRef(...)
    end

    -- Check if it's an item / profession link
    local linkType = strsplit(":", link)
    if not linkType or not tooltipTypes[linkType] then
        return OldSetItemRef(...)
    end

    -- Check shown tooltips (and close if it matches)
    local isShown = MIT:IsLinkShown(text)
    if isShown then
        return HideUIPanel(getglobal(isShown))
    end

    -- ItemRef not shown? Use it first
    if not ItemRefTooltip:IsVisible() then
        links["ItemRefTooltip"] = text
        return OldSetItemRef(...)
    end

    MIT:ShowFrame(MIT:GetAvailableFrame(), text)
end

function MIT:ShowFrame(frame, link)
    ShowUIPanel(frame)
    if not frame:IsShown() then
        frame:SetOwner(UIParent, "ANCHOR_PRESERVE")
    end
    links[frame:GetName()] = link
    frame:SetHyperlink(link)
end

function MIT:GetAvailableFrame()
    for i,v in ipairs(tooltips) do
        if not v:IsVisible() then
            return v
        end
    end
    return self:CreateTooltip()
end

-- Returns the link string (I don't think it's possible through blizzard code to get profession, etc strings)
function MIT:GetLinkString(frame)
    return links[(type(frame) == "string" and frame) or frame:GetName()]
end

function MIT:IsLinkShown(link)
    for i,v in pairs(links) do
        if v == link then
            return i
        end
    end
    return nil
end

function MIT:CreateTooltip(link)
    local n = #tooltips+1
    local name = "ItemRefTooltip"..n+1
    local frame = CreateFrame("GameTooltip", name, UIParent, "MIT_Tooltip_Template")
    tinsert(UISpecialFrames, name)
    hooksecurefunc(frame, "Hide", function() checkHook("OnHide", frame) links[name] = nil end)
    hooksecurefunc(frame, "SetHyperlink", function(...) checkHook("OnShow", frame) frame:Show() end)
    if link then
        self:ShowFrame(frame, link)
    end
    tooltips[n] = frame
    checkHook("OnCreate", frame)

    if MITAddItemlevelToTooltip then
        frame:HookScript("OnTooltipSetItem", MITAddItemlevelToTooltip)
    end
    if MITVendorPrice then
        frame:HookScript("OnTooltipSetItem", MITVendorPrice)
    end
    if MITgetItemIdFromTooltip then
        frame:HookScript("OnTooltipSetItem", MITgetItemIdFromTooltip)
    end

    return frame
end

-- To AddOn Authors: Thanks for your interest in adding support for MIT to your addon!
-- Usage: MIT:AddHook("MyAddOn", "OnShow", function(frame) MyAddon:DoSomething(frame) end)
-- Events: OnShow, OnHide, OnCreate
function MIT:AddHook(name, event, func)
    hooks[name] = hooks[name] or { }
    hooks[name][event] = func
end

-- Backwards compatibility (don't use please, may be removed in the future)
function MIT_AddHook(event, func)
    hooks[#hooks+1] = { }
    hooks[#hooks][event] = func
end