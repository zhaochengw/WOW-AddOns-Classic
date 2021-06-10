local mod	= DBM:NewMod("AuctTombsTrash", "DBM-Party-BC", 8, 250)

mod:SetRevision("20210603191916")

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 34925"
)

local warningCurseOfImpotence	= mod:NewTargetNoFilterAnnounce(53925, 2)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 34925 then
		warningCurseOfImpotence:Show(args.destName)
	end
end
