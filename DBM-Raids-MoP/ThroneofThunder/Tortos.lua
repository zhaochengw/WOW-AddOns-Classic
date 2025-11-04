local mod	= DBM:NewMod(825, "DBM-Raids-MoP", 2, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103134004")
mod:SetCreatureID(67977)
mod:SetEncounterID(1565)
mod:SetUsedIcons(8, 7, 6, 5, 4, 3)
mod:SetZone(1098)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 133939 136294 135251 134920",
	"SPELL_AURA_APPLIED 133971 133974",
	"SPELL_AURA_REMOVED 137633",
	"SPELL_CAST_SUCCESS 134031",
	"UNIT_AURA boss1",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnBite						= mod:NewSpellAnnounce(135251, 3, nil, "Tank")
local warnKickShell					= mod:NewAnnounce("warnKickShell", 2, 134031)
local warnShellConcussion			= mod:NewTargetNoFilterAnnounce(136431, 1)

local specWarnCallofTortos			= mod:NewSpecialWarningSpell(136294)
local specWarnQuakeStomp			= mod:NewSpecialWarningCount(134920, nil, nil, nil, 2)
local specWarnStoneBreath			= mod:NewSpecialWarningInterrupt(133939, nil, nil, 2, 3)
local specWarnCrystalShell			= mod:NewSpecialWarning("specWarnCrystalShell", false)
local specWarnSummonBats			= mod:NewSpecialWarningSwitch(-7140, "Tank")--Dps can turn it on too, but not on by default for dps cause quite frankly dps should NOT switch right away, tank needs to get aggro first and where they spawn is semi random.

local timerBiteCD					= mod:NewCDTimer(6.9, 135251, nil, "Tank", nil, 5)
local timerCallTortosCD				= mod:NewNextTimer(60.5, 136294, nil, nil, nil, 1)
local timerStompCD					= mod:NewCDCountTimer(47, 134920, nil, nil, nil, 2, nil, nil, nil, 1, 4)
local timerBreathCD					= mod:NewCDTimer(46, 133939, nil, nil, nil, 4, nil, nil, nil, 2, 4)--TODO, adjust timer when Growing Anger is cast, so we can use a Next bar more accurately
local timerSummonBatsCD				= mod:NewCDTimer(45, -7140, nil, nil, nil, 1, 136685)--45-47. This doesn't always sync up to furious stone breath. Longer fight goes on more out of sync they get. So both bars needed I suppose
local timerStompActive				= mod:NewBuffActiveTimer(10.8, 134920)--Duration of the rapid caveins
local timerShellConcussion			= mod:NewBuffFadesTimer(20, 136431)

local berserkTimer					= mod:NewBerserkTimer(780)

mod:AddBoolOption("InfoFrame")
mod:AddSetIconOption("SetIconOnTurtles", -7129, true, 5, {6, 7, 6, 5, 4, 3, 2, 1})
mod:AddBoolOption("ClearIconOnTurtles", false)--Different option, because you may want auto marking but not auto clearing. or you may want auto clearning when they "die" but not auto marking when they spawn
mod:AddBoolOption("AnnounceCooldowns", "RaidCooldown")

local shelldName, shellConcussion = DBM:GetSpellName(137633), DBM:GetSpellName(136431)
local stompCount = 0
local shellsRemaining = 0
local lastConcussion = 0
local kickedShells = {}
local addsActivated = 0

local function checkCrystalShell()
	if not DBM:UnitDebuff("player", shelldName) and not UnitIsDeadOrGhost("player") then
		local percent = (UnitHealth("player") / UnitHealthMax("player")) * 100
		if percent > 90 then
			specWarnCrystalShell:Show(shelldName)
		end
		mod:Unschedule(checkCrystalShell)
		mod:Schedule(3, checkCrystalShell)
	end
end

function mod:OnCombatStart(delay)
	stompCount = 0
	shellsRemaining = 0
	lastConcussion = 0
	addsActivated = 0
	table.wipe(kickedShells)
	timerCallTortosCD:Start(20.4-delay)
	timerStompCD:Start(27-delay, 1)
	timerBreathCD:Start(-delay)
	if self:IsHeroic() then
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(L.WrongDebuff:format(shelldName))
			DBM.InfoFrame:Show(5, "playergooddebuff", shelldName)
		end
		checkCrystalShell()
		berserkTimer:Start(600-delay)
	else
		berserkTimer:Start(-delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 133939 then
		if not self:IsDifficulty("lfr25") then
			specWarnStoneBreath:Show(args.sourceName)
		end
		timerBreathCD:Start()
	elseif spellId == 136294 then
		if self:AntiSpam(5, 4) then
			specWarnCallofTortos:Show()
		end
		if self:AntiSpam(59, 3) then -- On below 10%, he casts Call of Tortos always. This cast ignores cooldown, so filter below 10% cast.
			timerCallTortosCD:Start()
		end
	elseif spellId == 135251 then
		warnBite:Show()
		timerBiteCD:Start()
	elseif spellId == 134920 then
		stompCount = stompCount + 1
		specWarnQuakeStomp:Show(stompCount)
		timerStompActive:Start()
		timerStompCD:Start(nil, stompCount+1)
		if self.Options.AnnounceCooldowns then
			DBM:PlayCountSound(stompCount)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 133971 then--Shell Block (turtles dying and becoming kickable)
		shellsRemaining = shellsRemaining + 1
		addsActivated = addsActivated - 1
		if DBM:GetRaidRank() > 0 and self.Options.ClearIconOnTurtles then
			for uId in DBM:GetGroupMembers() do
				local unitid = uId.."target"
				local guid = UnitGUID(unitid)
				if args.destGUID == guid then
					self:SetIcon(unitid, 0)
				end
			end
		end
	elseif spellId == 133974 then--Spinning Shell
		addsActivated = addsActivated + 1
		if self.Options.SetIconOnTurtles and addsActivated < 9 then
			self:ScanForMobs(args.destGUID, 2, 9-addsActivated, 1, nil, 10)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 137633 and args:IsPlayer() then
		checkCrystalShell()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 134031 and not kickedShells[args.destGUID] then--Kick Shell
		kickedShells[args.destGUID] = true
		shellsRemaining = shellsRemaining - 1
		warnKickShell:Show(args.spellName, args.sourceName, shellsRemaining)
	end
end

--Does not show in combat log, so UNIT_AURA must be used instead
function mod:UNIT_AURA(uId)
	local _, _, _, _, _, expires = DBM:UnitDebuff(uId, shellConcussion)
	if expires and lastConcussion ~= expires then
		lastConcussion = expires
		timerShellConcussion:Start()
		if self:AntiSpam(3, 2) then
			warnShellConcussion:Show(L.name)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 136685 then --Don't filter main tank, bat tank often taunts boss just before bats for vengeance, otherwise we lose threat to dps. Then main tank taunts back after bats spawn and we go get them, fully vengeanced (if you try to pick up bats without vengeance you will not hold aggro for shit)
		specWarnSummonBats:Show()
		timerSummonBatsCD:Start()
	end
end
