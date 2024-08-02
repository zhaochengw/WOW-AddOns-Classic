local mod	= DBM:NewMod("LordValthalak", "DBM-Party-Vanilla", DBM:IsCata() and 18 or 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240728020407")
mod:SetCreatureID(16042)

mod:RegisterCombat("combat")

