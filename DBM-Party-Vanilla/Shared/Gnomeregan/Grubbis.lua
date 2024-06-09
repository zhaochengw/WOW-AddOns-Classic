local mod	= DBM:NewMod(419, "DBM-Party-Vanilla", DBM:IsRetail() and 4 or 7, 231)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240131022251")
mod:SetCreatureID(7361)
mod:SetEncounterID(mod:IsClassic() and 2768 or 379)

mod:RegisterCombat("combat")
