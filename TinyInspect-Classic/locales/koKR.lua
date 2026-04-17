--[[
    Author: Domekologe
    File: Locales/koKR.lua
    Notes: koKR locale for TinyInspect-Classic (Reforge additions)
]]
local addonName, ns = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "koKR")
if not L then return end

L["REQ_LEATHERWORKING_LWR"] = "가죽세공 필요"
L["REQ_LEATHERWORKING_ING"] = "기계공학 필요"
L["ENCHANT_PREFIX_EN_MATCH"] = "^(마법부여:%s+.+)$"
L["ENCHANT_PREFIX_DE_MATCH"] = nil
L["LW_ENCHANT_DETECTED"] = "가죽세공 전용 마법부여가 감지됨"

ns.L = L
