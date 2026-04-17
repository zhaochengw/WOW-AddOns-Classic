--[[
    Author: Domekologe
    File: Locales/zhTW.lua
    Notes: zhTW locale for TinyInspect-Classic (Reforge additions)
]]
local addonName, ns = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "zhTW")
if not L then return end

L["REQ_LEATHERWORKING_LWR"] = "需要製皮"
L["REQ_LEATHERWORKING_ING"] = "需要工程學"
L["ENCHANT_PREFIX_EN_MATCH"] = "^(附魔：.+)$"
L["ENCHANT_PREFIX_DE_MATCH"] = nil
L["LW_ENCHANT_DETECTED"] = "檢測到製皮專屬附魔"

ns.L = L
