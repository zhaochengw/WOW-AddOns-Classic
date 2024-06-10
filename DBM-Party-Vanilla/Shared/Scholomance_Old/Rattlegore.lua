local mod	= DBM:NewMod("Rattlegore", "DBM-Party-Vanilla", DBM:IsPostCata() and 16 or 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240316010232")
mod:SetCreatureID(11622)
mod:SetEncounterID(mod:IsClassic() and 2811 or 453)
mod:SetZone(289)

mod:RegisterCombat("combat")
