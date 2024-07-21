local mod	= DBM:NewMod("OldSerrakis", "DBM-Party-Vanilla", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20231130010732")
mod:SetCreatureID(4830)
mod:SetEncounterID(2765)

mod:RegisterCombat("combat")
