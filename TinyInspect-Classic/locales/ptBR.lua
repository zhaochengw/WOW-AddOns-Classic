--[[
    Author: Domekologe
    File: Locales/ptBR.lua
    Notes: ptBR locale for TinyInspect-Classic (Reforge additions)
]]
local addonName, ns = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "ptBR")
if not L then return end

L["REQ_LEATHERWORKING_LWR"] = "requer couro"
L["REQ_LEATHERWORKING_ING"] = "requer engenharia"
L["ENCHANT_PREFIX_EN_MATCH"] = "^(encantado:%s+.+)$"
L["ENCHANT_PREFIX_DE_MATCH"] = nil
L["LW_ENCHANT_DETECTED"] = "Encantamento exclusivo de couro detectado"

ns.L = L
