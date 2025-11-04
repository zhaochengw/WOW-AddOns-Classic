local mod	= DBM:NewMod(682, "DBM-Raids-MoP", 5, 317)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240603220759")
mod:SetCreatureID(60143)
mod:SetEncounterID(1434)
mod:SetUsedIcons(1, 2, 3, 4)
mod:SetZone(1008)

mod:RegisterCombat("combat_yell", L.Pull)--Yell is secondary pull trigger. (leave it for lfr combat detection bug)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 116174 116272",
	"SPELL_AURA_APPLIED 122151 116161 116260 116278 117543 117549 117723 117752",
	"SPELL_AURA_REFRESH 122151 116161 116260 116278 117543 117549 117723 117752",
	"SPELL_AURA_REMOVED 116161 116260 116278 122151 117543 115749 117723 117549",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--NOTES
--Syncing is used for all warnings because the realms don't share combat events. You won't get warnings for other realm any other way.
--Voodoo dolls do not have a CD, they are linked to banishment (or player deaths), when he banishes current tank, he reapplies voodoo dolls to new tank and new players. If tank dies, he just recasts voodoo on a new current threat target.
--Latency checks are used for good reason (to prevent lagging users from sending late events and making our warnings go off again incorrectly). if you play with high latency and want to bypass latency check, do so with in game GUI option.
local warnTotem						= mod:NewCountAnnounce(116174, 2)
local warnVoodooDolls				= mod:NewTargetNoFilterAnnounce(122151, 3)
local warnCrossedOver				= mod:NewTargetNoFilterAnnounce(116161, 3)
local warnBanishment				= mod:NewTargetNoFilterAnnounce(116272, 3, nil, "Tank|Healer")
local warnSuicide					= mod:NewPreWarnAnnounce(116325, 5, 4)--Pre warn 5 seconds before you die so you take whatever action you need to, to prevent. (this is effect that happens after 30 seconds of Soul Sever
local warnFrenzy					= mod:NewSpellAnnounce(117752, 4)

local specWarnBanishment			= mod:NewSpecialWarningYou(116272, nil, nil, nil, 1, 5)
local specWarnBanishmentOther		= mod:NewSpecialWarningTaunt(116272, nil, nil, nil, 1, 2)
local specWarnVoodooDollsYou		= mod:NewSpecialWarningYou(122151, nil, nil, nil, 1, 2)

local timerRP						= mod:NewRPTimer(24.7)
local timerTotemCD					= mod:NewNextCountTimer(20, 116174, nil, nil, nil, 5)
local timerBanishmentCD				= mod:NewCDCountTimer(65, 116272, nil, nil, nil, 3, nil, DBM_COMMON_L.TANK_ICON)
local timerSoulSever				= mod:NewBuffFadesTimer(30, 116278, nil, nil, nil, 5, nil, nil, nil, 1, 4)--Tank version of spirit realm
local timerCrossedOver				= mod:NewBuffFadesTimer(30, 116161, nil, nil, nil, 5, nil, nil, nil, 1, 4)--Dps version of spirit realm
local timerSpiritualInnervation		= mod:NewBuffFadesTimer(30, 117549, nil, nil, nil, 5)
local timerShadowyAttackCD			= mod:NewCDTimer(8, -6698, nil, "Tank", nil, 5, 117222, DBM_COMMON_L.TANK_ICON)
local timerFrailSoul				= mod:NewBuffFadesTimer(30, 117723, nil, nil, nil, 5)

local berserkTimer					= mod:NewBerserkTimer(360)

mod:AddSetIconOption("SetIconOnVoodoo", 122151, true, 0, {1, 2, 3, 4})

mod.vb.totemCount = 0
mod.vb.banishCount = 0
local voodooDollTargets = {}
local crossedOverTargets = {}
local voodooDollTargetIcons = {}

local function warnVoodooDollTargets()
	warnVoodooDolls:Show(table.concat(voodooDollTargets, "<, >"))
	table.wipe(voodooDollTargets)
end

local function warnCrossedOverTargets()
	warnCrossedOver:Show(table.concat(crossedOverTargets, "<, >"))
	table.wipe(crossedOverTargets)
end

local function removeIcon(target)
	for i,j in ipairs(voodooDollTargetIcons) do
		if j == target then
			table.remove(voodooDollTargetIcons, i)
			mod:SetIcon(target, 0)
			break
		end
	end
end

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
	end
	function mod:SetVoodooIcons()
		table.sort(voodooDollTargetIcons, sort_by_group)
		local voodooIcon = 1
		for i, v in ipairs(voodooDollTargetIcons) do
			-- DBM:SetIcon() is used because of follow reasons
			--1. It checks to make sure you're on latest dbm version, if you are not, it disables icon setting so you don't screw up icons (ie example, a newer version of mod does icons differently)
			--2. It checks global dbm option "DontSetIcons"
			self:SetIcon(v, voodooIcon)
			voodooIcon = voodooIcon + 1
		end
	end
end

function mod:OnCombatStart(delay)
	self.vb.totemCount = 0
	self.vb.banishCount = 0
	table.wipe(voodooDollTargets)
	table.wipe(crossedOverTargets)
	table.wipe(voodooDollTargetIcons)
	timerShadowyAttackCD:Start(7-delay)
	if self:IsDifficulty("normal25", "heroic25") then
		timerTotemCD:Start(20-delay, 1)
	elseif self:IsDifficulty("lfr25") then
		timerTotemCD:Start(30-delay, 1)
	else
		timerTotemCD:Start(35.2-delay, 1)
	end
	timerBanishmentCD:Start(-delay, 1)
	if not self:IsDifficulty("lfr25") then -- lfr seems not berserks.
		berserkTimer:Start(-delay)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 116174 and self:LatencyCheck() then
		self:SendSync("SummonTotem")
	elseif spellId == 116272 then
		if args:IsPlayer() then--no latency check for personal notice you aren't syncing.
			specWarnBanishment:Show()--Can't miss, so using success is safe (and slightly faster)
			specWarnBanishment:Play("teleyou")
		end
		if self:LatencyCheck() then
			self:SendSync("BanishmentTarget", args.destGUID)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 122151 then
		if args:IsPlayer() then
			specWarnVoodooDollsYou:Show()
			specWarnVoodooDollsYou:Play("targetyou")
		end
		if self:LatencyCheck() then
			self:SendSync("VoodooTargets", args.destGUID)
		end
	elseif args:IsSpellID(116161, 116260) then -- 116161 is normal and heroic, 116260 is lfr.
		if args:IsPlayer() and self:AntiSpam(2, 3) then
			if not self:IsDifficulty("lfr25") then -- lfr do not suicide even you not press the extra button.
				warnSuicide:Schedule(25)
			end
			timerCrossedOver:Start(29)
		end
		if not self:IsDifficulty("lfr25") then -- lfr totems not breakable, instead totems can click. so lfr warns can be spam, not needed to warn. also CLEU fires all players, no need to use sync.
			crossedOverTargets[#crossedOverTargets + 1] = args.destName
			self:Unschedule(warnCrossedOverTargets)
			self:Schedule(0.3, warnCrossedOverTargets)
		end
	elseif spellId == 116278 then--this is tank spell, no delays?
		if args:IsPlayer() then--no latency check for personal notice you aren't syncing.
			timerSoulSever:Start()
			warnSuicide:Schedule(25)
		end
	elseif spellId == 117543 and args:IsPlayer() then -- 117543 is healer spell, 117549 is dps spell
		timerSpiritualInnervation:Start()
	elseif spellId == 117549 and args:IsPlayer() then -- 117543 is healer spell, 117549 is dps spell
		if self:IsDifficulty("lfr25") then
			timerSpiritualInnervation:Start(40)
		else
			timerSpiritualInnervation:Start()
		end
	elseif spellId == 117723 and args:IsPlayer() then
		timerFrailSoul:Start()
	elseif spellId == 117752 then
		warnFrenzy:Show()
		if not self:IsDifficulty("lfr25") then--lfr continuing summon totem below 20%
			timerTotemCD:Cancel()
		end
	end
end
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if args:IsSpellID(116161, 116260) and args:IsPlayer() then
		if not self:IsDifficulty("lfr25") then
			warnSuicide:Cancel()
		end
		timerCrossedOver:Cancel()
	elseif spellId == 116278 and args:IsPlayer() then
		warnSuicide:Cancel()
		timerSoulSever:Cancel()
	elseif spellId == 122151 then
		self:SendSync("VoodooGoneTargets", args.destGUID)
	elseif args:IsSpellID(117543, 117549) and args:IsPlayer() then
		timerSpiritualInnervation:Cancel()
	elseif spellId == 117723 and args:IsPlayer() then
		timerFrailSoul:Cancel()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if (spellId == 117215 or spellId == 117218 or spellId == 117219 or spellId == 117222) then--Shadowy Attacks
		timerShadowyAttackCD:Start()
	elseif spellId == 116964 then--Summon Totem
		if self:LatencyCheck() then
			self:SendSync("SummonTotem")
		end
	end
end

--"<0.25 13:15:57> [CHAT_MSG_MONSTER_YELL] Now you done made me angry!#Gara'jal the Spiritbinder#####0#0##0#2923#nil#0#false#false#false#false",
--"<25.01 13:16:22> [DBM_Debug] ENCOUNTER_START event fired: 1434 Gara'jal the Spiritbinder 5 10#nil",

--"<7.38 14:54:42> [CHAT_MSG_MONSTER_YELL] Now you done made me angry!#Gara'jal the Spiritbinder###Zandalari Terror
--"<32.87 14:55:08> [DBM_Debug] ENCOUNTER_START event fired: 1434 Gara'jal the Spiritbinder 7 25#nil",

--"<13.90 06:55:25> [CHAT_MSG_MONSTER_YELL] Now you done made me angry!#Gara'jal the Spiritbinder###Zandalari Terror Rider#
--"<38.76 06:55:50> [DBM_Debug] ENCOUNTER_START event fired: 1434 Gara'jal the Spiritbinder 7 25#nil",
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.RolePlay or msg:find(L.RolePlay) then
		self:SendSync("RolePlay")
	end
end

function mod:OnSync(msg, guid)
	local targetname
	if guid then
		targetname = DBM:GetFullPlayerNameByGUID(guid)
	end
	if msg == "RolePlay" then
		timerRP:Start()
	elseif msg == "SummonTotem" then
		self.vb.totemCount = self.vb.totemCount + 1
		warnTotem:Show(self.vb.totemCount)
		if self:IsDifficulty("normal25", "heroic25") then
			timerTotemCD:Start(20, self.vb.totemCount+1)
		elseif self:IsDifficulty("lfr25") then
			timerTotemCD:Start(30, self.vb.totemCount+1)
		else
			timerTotemCD:Start(36, self.vb.totemCount+1)
		end
	elseif msg == "VoodooTargets" and targetname then
		voodooDollTargets[#voodooDollTargets + 1] = targetname
		self:Unschedule(warnVoodooDollTargets)
		self:Schedule(0.3, warnVoodooDollTargets)
		if self.Options.SetIconOnVoodoo then
			local targetUnitID = DBM:GetRaidUnitId(targetname)
			--Added to fix a bug with duplicate entries of same person in icon table more than once
			local foundDuplicate = false
			for i = #voodooDollTargetIcons, 1, -1 do
				if voodooDollTargetIcons[i].targetUnitID then--make sure they aren't in table before inserting into table again. (not sure why this happens in LFR but it does, probably someone really high ping that cranked latency check way up)
					foundDuplicate = true
				end
			end
			if not foundDuplicate then
				table.insert(voodooDollTargetIcons, targetUnitID)
			end
			self:UnscheduleMethod("SetVoodooIcons")
			if self:LatencyCheck() then--lag can fail the icons so we check it before allowing.
				if #voodooDollTargetIcons >= 4 and self:IsDifficulty("normal25", "heroic25", "lfr25") or #voodooDollTargetIcons >= 3 and self:IsDifficulty("normal10", "heroic10") then
					self:SetVoodooIcons()
				else
					self:ScheduleMethod(1, "SetVoodooIcons")
				end
			end
		end
	elseif msg == "VoodooGoneTargets" and targetname and self.Options.SetIconOnVoodoo then
		removeIcon(DBM:GetRaidUnitId(targetname))
	elseif msg == "BanishmentTarget" and targetname then
		self.vb.banishCount = self.vb.banishCount + 1
		timerBanishmentCD:Start(nil, self.vb.banishCount+1)
		if guid ~= UnitGUID("player") then--make sure YOU aren't target before warning "other"
			if self:IsTank() then
				specWarnBanishmentOther:Show(targetname)
				specWarnBanishmentOther:Play("tauntboss")
			else
				warnBanishment:Show(targetname)
			end
		end
	end
end
