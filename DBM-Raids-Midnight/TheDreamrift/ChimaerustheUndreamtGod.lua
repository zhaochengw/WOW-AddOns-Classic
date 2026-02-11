local mod	= DBM:NewMod(2795, "DBM-Raids-Midnight", 2, 1314)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("20260208045326")
mod:SetCreatureID(256116)
mod:SetEncounterID(3306)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2939)

mod:RegisterCombat("combat")

--mod:RegisterEventsInCombat(

--)

--TODO. This boss has many encounter events with a 0 for encounter ID
