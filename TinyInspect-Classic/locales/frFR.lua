--[[
    Author: Domekologe
    File: Locales/frFR.lua
    Notes: frFR locale for TinyInspect-Classic (Reforge additions)
]]
local addonName, ns = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "frFR")
if not L then return end

L["REQ_LEATHERWORKING_LWR"] = "requiert travail du cuir"
L["REQ_LEATHERWORKING_ING"] = "requiert ingénierie"
L["ENCHANT_PREFIX_EN_MATCH"] = "^(enchanté:%s+.+)$"
L["ENCHANT_PREFIX_DE_MATCH"] = nil
L["LW_ENCHANT_DETECTED"] = "Enchantement exclusif au travail du cuir détecté"

ns.L = L
