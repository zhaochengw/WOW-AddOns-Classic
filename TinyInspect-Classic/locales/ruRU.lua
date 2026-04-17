--[[
    Author: Domekologe
    File: Locales/ruRU.lua
    Notes: ruRU locale for TinyInspect-Classic (Reforge additions)
]]
local addonName, ns = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "ruRU")
if not L then return end

L["REQ_LEATHERWORKING_LWR"] = "требуется кожевничество"
L["REQ_LEATHERWORKING_ING"] = "требуется инженерное дело"
L["ENCHANT_PREFIX_EN_MATCH"] = "^(чары:%s+.+)$"
L["ENCHANT_PREFIX_DE_MATCH"] = nil
L["LW_ENCHANT_DETECTED"] = "Обнаружено эксклюзивное чары кожевничества"

ns.L = L
