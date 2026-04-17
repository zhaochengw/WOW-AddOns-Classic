--[[
    Author: Domekologe
    File: Locales/deDE.lua
    Notes: German locale for TinyInspect-Classic (Reforge additions)
]]
local addonName, ns = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "deDE")
if not L then return end

-- Tooltip scan needles / patterns (all lowercase matches!)
L["REQ_LEATHERWORKING_LWR"] = "benötigt lederverarbeitung"
L["REQ_LEATHERWORKING_ING"] = "benötigt ingenieurskunst"
L["ENCHANT_PREFIX_DE_MATCH"] = "^(verzauber%a*:%s+.+)$" -- "Verzaubert:" / "Verzauberung:"
L["ENCHANT_PREFIX_EN_MATCH"] = "" -- unused in deDE

L["LW_ENCHANT_DETECTED"] = "Lederverarbeitungs-exklusive Verzauberung erkannt"
ns.L = L
