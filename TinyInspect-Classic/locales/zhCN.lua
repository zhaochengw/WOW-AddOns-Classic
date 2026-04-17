--[[
    Author: Domekologe
    File: Locales/zhCN.lua
    Notes: zhCN locale for TinyInspect-Classic (Reforge additions)
]]
local addonName, ns = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "zhCN")
if not L then return end

L["REQ_LEATHERWORKING_LWR"] = "需要制皮"
L["REQ_LEATHERWORKING_ING"] = "需要工程学"
L["ENCHANT_PREFIX_EN_MATCH"] = "^(附魔：.+)$"
L["ENCHANT_PREFIX_DE_MATCH"] = nil
L["LW_ENCHANT_DETECTED"] = "检测到制皮专属附魔"

ns.L = L
