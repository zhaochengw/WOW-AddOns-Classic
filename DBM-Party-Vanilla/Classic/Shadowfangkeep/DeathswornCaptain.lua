local mod	= DBM:NewMod("DeathswornCaptain", "DBM-Party-Vanilla", 14)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103114940")
mod:SetCreatureID(3872)
mod:SetZone(33)

mod:RegisterCombat("combat")
