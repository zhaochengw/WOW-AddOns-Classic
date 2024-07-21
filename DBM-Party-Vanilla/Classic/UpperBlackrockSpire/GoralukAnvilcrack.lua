local mod	= DBM:NewMod("GoralukAnvilcrack", "DBM-Party-Vanilla", DBM:IsCata() and 18 or 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240315080105")
mod:SetCreatureID(10899)

mod:RegisterCombat("combat")
