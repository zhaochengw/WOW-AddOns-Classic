--[[
    Author: Domekologe
    File: Locales/esMX.lua
    Notes: esMX locale for TinyInspect-Classic (Reforge additions)
]]
local addonName, ns = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "esMX")
if not L then return end

L["REQ_LEATHERWORKING_LWR"] = "requiere peletería"
L["REQ_LEATHERWORKING_ING"] = "requiere ingeniería"
L["ENCHANT_PREFIX_EN_MATCH"] = "^(encantado:%s+.+)$"
L["ENCHANT_PREFIX_DE_MATCH"] = nil
L["LW_ENCHANT_DETECTED"] = "Encantamiento exclusivo de peletería detectado"

ns.L = L
