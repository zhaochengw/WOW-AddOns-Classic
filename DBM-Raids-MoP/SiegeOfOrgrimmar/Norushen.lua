local mod	= DBM:NewMod(866, "DBM-Raids-MoP", 1, 369)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,mythic,lfr"

mod:SetRevision("20240714050536")
mod:SetCreatureID(72276)
--mod:SetEncounterID(1624)
mod:SetZone(1136)

mod:RegisterCombat("combat")
mod.syncThreshold = 1

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 145216 144482 144654 144628 144649 144657 146707 144479",
	"SPELL_AURA_APPLIED 144514 145226 144849 144850 144851 146703",
	"SPELL_AURA_APPLIED_DOSE 146124",
	"SPELL_AURA_REMOVED 145226 144849 144850 144851",
	"SPELL_DAMAGE 145073",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5",--This boss can change boss ID any time you jump into one of tests, because he gets unregistered as boss1 then registered as boss2 when you leave, etc
	"CHAT_MSG_ADDON"
)

mod:RegisterEvents(
	"ENCOUNTER_START",
	"CHAT_MSG_MONSTER_YELL",
	"GOSSIP_SHOW"
)

local boss = DBM:EJ_GetSectionInfo(8216)

--Amalgam of Corruption
local warnSelfDoubt						= mod:NewStackAnnounce(146124, 2, nil, "Tank")
local warnResidualCorruption			= mod:NewSpellAnnounce(145073, 2, nil, false, 2)
local warnLookWithinEnd					= mod:NewEndTargetAnnounce(-8220, 2, nil, false)
local warnManifestationSoon				= mod:NewSoonAnnounce(-8232, 2)
--Test of Reliance (Healer)
local warnDishearteningLaugh			= mod:NewSpellAnnounce(146707, 3)

--Amalgam of Corruption
local specWarnUnleashedAnger			= mod:NewSpecialWarningDefensive(145216, nil, nil, nil, 1, 2)
local specWarnSelfDoubtOther			= mod:NewSpecialWarningTaunt(146124, nil, nil, nil, 1, 2)--Stack warning, to taunt off other tank
local specWarnBlindHatred				= mod:NewSpecialWarningSpell(145226, nil, nil, nil, 2, 2)
local specWarnManifestation				= mod:NewSpecialWarningSwitchCount(-8232, "-Healer", nil, nil, 1, 2)--Unleashed Manifestation of Corruption
--Test of Serenity (DPS)
local specWarnTearReality				= mod:NewSpecialWarningDodge(144482, nil, nil, nil, 2, 2)
--Test of Reliance (Healer)
local specWarnLingeringCorruption		= mod:NewSpecialWarningDispel(144514, nil, nil, nil, 1, 2)
local specWarnBottomlessPitMove			= mod:NewSpecialWarningGTFO(146703, nil, nil, nil, 1, 8)
--Test of Confidence (tank)
local specWarnTitanicSmash				= mod:NewSpecialWarningDodge(144628, nil, nil, nil, 2, 2)
local specWarnBurstOfCorruption			= mod:NewSpecialWarningSpell(144654, nil, nil, nil, 2, 2)
local specWarnHurlCorruption			= mod:NewSpecialWarningInterrupt(144649, nil, nil, nil, 3, 2)
local specWarnPiercingCorruption		= mod:NewSpecialWarningDefensive(144657, nil, nil, nil, 1, 2)

--Amalgam of Corruption
local timerCombatStarts					= mod:NewCombatTimer(25)
local timerUnleashedAngerCD				= mod:NewCDTimer(10, 145216, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerBlindHatred					= mod:NewBuffActiveTimer(30, 145226, nil, nil, nil, 6, nil, DBM_COMMON_L.DEADLY_ICON)
local timerBlindHatredCD				= mod:NewNextTimer(30, 145226, nil, nil, nil, 6, nil, DBM_COMMON_L.DEADLY_ICON)
--All Tests
local timerLookWithin					= mod:NewBuffFadesTimer(60, -8220, nil, nil, nil, 6, nil, nil, nil, 1, 4)
--Test of Serenity (DPS)
local timerTearRealityCD				= mod:NewCDNPTimer(8.5, 144482)--8.5-10sec variation. Nameplate only timer since a lot of these can be up at once
--Test of Reliance (Healer)
local timerDishearteningLaughCD			= mod:NewNextTimer(12, 146707)
local timerLingeringCorruptionCD		= mod:NewNextTimer(15.5, 144514, nil, nil, nil, 5, nil, nil, nil, 2, 4)
--Test of Confidence (tank)
local timerTitanicSmashCD				= mod:NewCDTimer(14.5, 144628, nil, nil, nil, 3)--14-17sec variation
local timerPiercingCorruptionCD			= mod:NewCDTimer(14, 144657, nil, nil, nil, 5)--14-17sec variation
local timerHurlCorruptionCD				= mod:NewNextTimer(20, 144649, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON, nil, 2, 3)
--All of them?
local timerExpelCorruptionCD			= mod:NewCDNPTimer(10.9, 144479)

local berserkTimer						= mod:NewBerserkTimer(418)

mod:AddGossipOption(true, "Encounter")

--Upvales, don't need variables
local Ambiguate = Ambiguate
--Tables, can't recover
local residue = {}
--Not important, don't need to recover
local playerInside = false
local warnedAdd = {}
--Important, needs recover
mod.vb.unleashedAngerCast = 0
mod.vb.manifestationCount = 0

--May be spammy with multiple adds spawning at exact same time
local function addsDelay()
	mod.vb.manifestationCount = mod.vb.manifestationCount + 1
	specWarnManifestation:Show(mod.vb.manifestationCount)
	specWarnManifestation:Play("bigmob")
end

local function addSync(guid)
	if not warnedAdd[guid] then
		warnedAdd[guid] = true
		warnManifestationSoon:Show()
		if mod:IsDifficulty("lfr25") then
			mod:Schedule(15, addsDelay)
		else
			mod:Schedule(5, addsDelay)
		end
	end
end

function mod:OnCombatStart(delay)
	playerInside = false
	table.wipe(warnedAdd)
	self.vb.unleashedAngerCast = 0
	self.vb.manifestationCount = 0
	table.wipe(residue)
	timerBlindHatredCD:Start(25-delay)
	if self:IsDifficulty("lfr25") then
		berserkTimer:Start(600-delay)
	else
		berserkTimer:Start(-delay)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 145216 then
		self.vb.unleashedAngerCast = self.vb.unleashedAngerCast + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnUnleashedAnger:Show()
			specWarnUnleashedAnger:Play("defensive")
		end
		if self.vb.unleashedAngerCast < 3 then
			timerUnleashedAngerCD:Start(nil, self.vb.unleashedAngerCast+1)
		end
	elseif spellId == 144482 then
		specWarnTearReality:Show()
		specWarnTearReality:Play("shockwave")
		timerTearRealityCD:Start(nil, args.sourceGUID)
	elseif spellId == 144654 then
		specWarnBurstOfCorruption:Show()
		specWarnBurstOfCorruption:Play("aesoon")
	elseif spellId == 144628 then
		specWarnTitanicSmash:Show()
		specWarnTitanicSmash:Play("shockwave")
		timerTitanicSmashCD:Start()
	elseif spellId == 144649 then
		specWarnHurlCorruption:Show(args.sourceName)
		specWarnHurlCorruption:Play("kickcast")
		timerHurlCorruptionCD:Start()
	elseif spellId == 144657 then
		specWarnPiercingCorruption:Show()
		specWarnPiercingCorruption:Play("defensive")
		timerPiercingCorruptionCD:Start()
	elseif spellId == 146707 then
		warnDishearteningLaugh:Show()
		timerDishearteningLaughCD:Start()
	elseif spellId == 144479 then
		timerExpelCorruptionCD:Start(nil, args.sourceGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 144514 then
		if self:CheckDispelFilter("magic") then
			specWarnLingeringCorruption:Show(args.destName)
			specWarnLingeringCorruption:Play("helpdispel")
		end
		timerLingeringCorruptionCD:Start()
	elseif spellId == 145226 then
		self:SendSync("BlindHatredStarted")
	elseif args:IsSpellID(144849, 144850, 144851) and args:IsPlayer() then--Look Within
		playerInside = true
		timerLookWithin:Start()
	elseif spellId == 146703 and args:IsPlayer() and self:AntiSpam(3, 2) then
		specWarnBottomlessPitMove:Show(args.spellName)
		specWarnBottomlessPitMove:Play("watchfeet")
	elseif spellId == 146124 then
		local amount = args.amount or 1
		warnSelfDoubt:Show(args.destName, amount)
		if not args:IsPlayer() and amount >= 3 then
			specWarnSelfDoubtOther:Show(args.destName)
			specWarnSelfDoubtOther:Play("tauntboss")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if args:IsSpellID(144849, 144850, 144851) then--Look Within
		warnLookWithinEnd:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			playerInside = false
			timerLingeringCorruptionCD:Cancel()
			timerDishearteningLaughCD:Cancel()
			timerTitanicSmashCD:Cancel()
			timerHurlCorruptionCD:Cancel()
			timerPiercingCorruptionCD:Cancel()
			timerLookWithin:Cancel()
		end
	elseif spellId == 145226 then
		self:SendSync("BlindHatredEnded")
	end
end

function mod:SPELL_DAMAGE(sourceGUID, _, _, _, _, _, _, _, spellId)
	if spellId == 145073 and not residue[sourceGUID] then
		residue[sourceGUID] = true
		warnResidualCorruption:Show()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 71977 then--Manifestation of Corruption (Dps Test)
		timerTearRealityCD:Cancel(args.destGUID)
		self:SendSync("ManifestationDied", args.destGUID)
	elseif cid == 72001 then--Greater Corruption (Healer Test)
		timerLingeringCorruptionCD:Cancel()
		timerDishearteningLaughCD:Cancel()
	elseif cid == 72051 then--Titanic Corruption (Tank Test)
		timerTitanicSmashCD:Cancel()
		timerHurlCorruptionCD:Cancel()
		timerPiercingCorruptionCD:Cancel()
	elseif cid == 71976 then--Essence of Corruption
		timerExpelCorruptionCD:Stop(args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 145769 and self:AntiSpam(1, 5) then--Unleash Corruption
		warnManifestationSoon:Show()
		self:Schedule(5, addsDelay)
	end
end

function mod:ENCOUNTER_START(id)
	if id == 1624 then
		---@diagnostic disable-next-line: undefined-field
		if self.lastWipeTime and GetTime() - self.lastWipeTime < 20 then return end--False ENCOUNTER_START firing on a wipe (blizz bug), ignore it so we don't start pre pull timer
		self:SendSync("prepull")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.wasteOfTime then
		self:SendSync("prepull")
	end
end

function mod:OnSync(msg, guid)
	if msg == "prepull" then
		---@diagnostic disable-next-line: undefined-field
		if self.lastWipeTime and GetTime() - self.lastWipeTime < 20 then return end
		timerCombatStarts:Start()
	elseif msg == "ManifestationDied" and guid then
		addSync(guid)
	elseif msg == "BlindHatredEnded" and self:AntiSpam(5, 4) then
		timerBlindHatredCD:Start()
		self.vb.unleashedAngerCast = 0
	elseif msg == "BlindHatredStarted" and self:AntiSpam(5, 3) then
		if not playerInside then
			specWarnBlindHatred:Show()
			specWarnBlindHatred:Play("farfromline")
		end
		timerBlindHatred:Start()
	end
end

function mod:CHAT_MSG_ADDON(prefix, message, channel, sender)
	--Because core already registers BigWigs prefix with server, shouldn't need it here
	if prefix == "BigWigs" and message then
		sender = Ambiguate(sender, "none")
		local _, bwMsg = message:match("^(%u-):(.+)")
		local _, rest = message:match("(%S+)%s*(.*)$")--May not work with 7.1 BW core, I am not really going out of way to fix norushen
		if bwMsg == "InsideBigAddDeath" and not playerInside and rest then
			addSync(rest)
		end
	end
end

function mod:GOSSIP_SHOW()
	local gossipOptionID = self:GetGossipID()
	if gossipOptionID then
		if self.Options.AutoGossipEncounter and gossipOptionID == 42038 then
			self:SelectGossip(gossipOptionID, true)
		end
	end
end
