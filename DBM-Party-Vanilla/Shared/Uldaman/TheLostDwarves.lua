if UnitFactionGroup("player") == "Alliance" then return end
local mod	= DBM:NewMod(468, "DBM-Party-Vanilla", DBM:IsRetail() and 13 or 18, 239)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20231012014002")
mod:SetCreatureID(6906, 6907, 6908)
mod:SetEncounterID(548)
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")
