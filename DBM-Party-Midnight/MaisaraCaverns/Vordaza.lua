local mod	= DBM:NewMod(2811, "DBM-Party-Midnight", 7, 1315)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("20251115001127")
mod:SetCreatureID(248595)
mod:SetEncounterID(3213)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2874)
mod.respawnTime = 29

mod:RegisterCombat("combat")

--mod:RegisterEventsInCombat(

--)

--TODO. Not a damn thing
