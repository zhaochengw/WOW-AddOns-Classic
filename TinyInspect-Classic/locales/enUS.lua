--[[
    Author: Domekologe
    File: Locales/enUS.lua
    Notes: English locale for TinyInspect-Classic (Reforge additions)
]]
local addonName, ns = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "enUS", true) -- default
if not L then return end

-- Tooltip scan needles / patterns (all lowercase matches!)
L["REQ_LEATHERWORKING_LWR"] = "requires leatherworking"
L["REQ_LEATHERWORKING_ING"] = "benötigt engineering"
L["ENCHANT_PREFIX_EN_MATCH"] = "^(enchant%a*:%s+.+)$"
L["ENCHANT_PREFIX_DE_MATCH"] = "" -- unused in enUS

L["LW_ENCHANT_DETECTED"] = "Leatherworking-only enchant detected"
ns.L = L
