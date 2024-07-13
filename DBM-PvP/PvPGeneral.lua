local mod	= DBM:NewMod("PvPGeneral", "DBM-PvP")
local L		= mod:GetLocalizedStrings()

local DBM = DBM
local GetPlayerFactionGroup = GetPlayerFactionGroup or UnitFactionGroup -- Classic Compat fix

local isRetail = WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1)
local isClassic = WOW_PROJECT_ID == (WOW_PROJECT_CLASSIC or 2)
local isBCC = WOW_PROJECT_ID == (WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 5)
local isWrath = WOW_PROJECT_ID == (WOW_PROJECT_WRATH_CLASSIC or 11)
local isCata = WOW_PROJECT_ID == (WOW_PROJECT_CATACLYSM_CLASSIC or 14)
local playerFaction = GetPlayerFactionGroup("player")

local DBM5Protocol = "1" -- DBM protocol version
local DBM5Prefix = UnitName("player") .. "-" .. GetRealmName() .. "\t" .. DBM5Protocol .. "\t" -- Name-Realm\tProtocol version\t

mod:SetRevision("20240609085421")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)
mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA",
	"LOADING_SCREEN_DISABLED",
	"PLAYER_ENTERING_WORLD",
	"PLAYER_DEAD",
	"START_TIMER",
	"AREA_POIS_UPDATED",
	"CHAT_MSG_BG_SYSTEM_NEUTRAL"
)

mod:AddBoolOption("HideBossEmoteFrame", false)
mod:AddBoolOption("AutoSpirit", false)
mod:AddBoolOption("ShowRelativeGameTime", true)
mod:AddBoolOption("ShowBasesToWin", true)

do
	local IsInInstance, RepopMe, GetSelfResurrectOptions = IsInInstance, RepopMe, C_DeathInfo.GetSelfResurrectOptions

	function mod:PLAYER_DEAD()
		local _, instanceType = IsInInstance()
		if instanceType == "pvp" and #GetSelfResurrectOptions() == 0 and self.Options.AutoSpirit then
			RepopMe()
		end
	end
end

local GetGametime, UpdateGametime
do
	local time, GetTime, GetBattlefieldInstanceRunTime = time, GetTime, GetBattlefieldInstanceRunTime
	local gameTime = 0

	function UpdateGametime()
		gameTime = time()
	end

	function GetGametime()
		if mod.Options.ShowRelativeGameTime then
			local sysTime = GetBattlefieldInstanceRunTime()
			if sysTime and sysTime > 0 then
				return sysTime / 1000
			end
			return time() - gameTime
		end
		return GetTime()
	end
end

local subscribedMapID, numObjectives, objectivesStore

function mod:SubscribeAssault(mapID, objectsCount)
	self:RegisterShortTermEvents(
		"AREA_POIS_UPDATED",
		"UPDATE_UI_WIDGET"
	)
	subscribedMapID = mapID
	objectivesStore = {}
	numObjectives = objectsCount
	UpdateGametime()
end

function mod:SubscribeFlags()
	self:RegisterShortTermEvents(
		"CHAT_MSG_BG_SYSTEM_ALLIANCE",
		"CHAT_MSG_BG_SYSTEM_HORDE"
	)
end

do
	local IsInInstance, SendAddonMessage = IsInInstance, C_ChatInfo.SendAddonMessage
	local bgzone = false

	local function Init(self)
		local _, instanceType = IsInInstance()
		if instanceType == "pvp" or instanceType == "arena" then
			if not bgzone then
				SendAddonMessage(isWrath and "D5WC" or isClassic and "D5C" or "D5", DBM5Prefix .. "H", "INSTANCE_CHAT")
				self:Schedule(3, DBM.RequestTimers, DBM)
				if self.Options.HideBossEmoteFrame then
					DBM:HideBlizzardEvents(1, true)
				end
			end
			bgzone = true
		elseif bgzone then
			bgzone = false
			self:UnregisterShortTermEvents()
			self:Stop()
			DBM.InfoFrame:Hide()
			subscribedMapID = nil
			if mod.Options.HideBossEmoteFrame then
				DBM:HideBlizzardEvents(0, true)
			end
		end
	end

	function mod:LOADING_SCREEN_DISABLED()
		self:Schedule(1, Init, self)
		self:Schedule(3, Init, self)
	end
	mod.ZONE_CHANGED_NEW_AREA	= mod.LOADING_SCREEN_DISABLED
	mod.PLAYER_ENTERING_WORLD	= mod.LOADING_SCREEN_DISABLED
	mod.OnInitialize			= mod.LOADING_SCREEN_DISABLED
end

do
	local UnitGUID, UnitHealth, UnitHealthMax, SendAddonMessage, RegisterAddonMessagePrefix, NewTicker = UnitGUID, UnitHealth, UnitHealthMax, C_ChatInfo.SendAddonMessage, C_ChatInfo.RegisterAddonMessagePrefix, C_Timer.NewTicker

	local scanTargetsRaid = {"target"}
	local scanTargetsWithNameplates = {"target"}
	for i = 1, 40 do
		scanTargetsRaid[#scanTargetsRaid + 1] = "raid" .. i .. "target"
		scanTargetsWithNameplates[#scanTargetsWithNameplates + 1] = "raid" .. i .. "target"
		scanTargetsWithNameplates[#scanTargetsWithNameplates + 1] = "nameplate" .. i
	end

	---@class HealthTracker
	local healthTracker = {}

	---@alias TrackingState "NONE"|"OBSERVED"|"SYNCED"

	function healthTracker:scan()
		local seen = {}
		local seenCount = 0
		for _, target in ipairs(self.scanNameplates and scanTargetsWithNameplates or scanTargetsRaid) do
			if seenCount >= #self.trackedUnits then
				break
			end
			local guid = UnitGUID(target)
			if guid then
				local cid = mod:GetCIDFromGUID(guid)
				if self.trackedUnitsByCid[cid] and not seen[cid] then
					seen[cid] = true
					seenCount = seenCount + 1
					local hp = math.floor(UnitHealth(target) / UnitHealthMax(target) * 100 + 0.5)
					local trackedUnit = self.trackedUnitsByCid[cid]
					-- display state, always the latest no matter the source
					trackedUnit.hp = hp
					trackedUnit.updateTime = GetTime()
					trackedUnit.state = "OBSERVED"
					-- per-channel state (where "observed"" is handled just like a channel)
					trackedUnit.observed = {
						updateTime = GetTime(),
						hp = hp,
					}
				end
			end
		end
		C_Timer.After(self.syncDelay, function() self:sendSync() end)
	end

	-- Acceptable updates are decreasing health, > 10% jumps upwards and resets to 100 (wipe or kited too far)
	local function isGoodUpdate(newHp, oldHp)
		if not newHp or not oldHp or newHp < 0 or newHp > 100 then
			return false
		end
		return newHp - oldHp < 0 or newHp - oldHp > 10 or oldHp < 98 and newHp == 100
	end

	function healthTracker:sendSync()
		local syncsByChannel = {}
		for _, trackedUnit in ipairs(self.trackedUnits) do
			for _, channel in ipairs(self.syncChannels) do
				syncsByChannel[channel] = syncsByChannel[channel] or {}
				local syncs = syncsByChannel[channel]
				local channelState = trackedUnit[channel]
				-- note that this gets sycned no matter where we got it from
				if trackedUnit.hp and (not channelState or isGoodUpdate(trackedUnit.hp, channelState.hp)) and GetTime() - trackedUnit.updateTime <= #self.syncChannels + 1 then
					syncs[#syncs + 1] = trackedUnit.cid .. ":" .. trackedUnit.hp
				end
			end
		end
		for channel, msg in pairs(syncsByChannel) do
			if #msg > 0 then
				local encoded = table.concat(msg, ":")
				DBM:Debug("Sending sync " .. encoded .. " to " .. channel, 3)
				SendAddonMessage("DBM-PvP", encoded, channel)
			end
		end
	end

	function healthTracker:receiveSync(args, channel, from)
		if not tContains(self.syncChannels, channel) then
			return
		end
		for _, entry in ipairs(args) do
			local trackedUnit = self.trackedUnitsByCid[entry.cid]
			DBM:Debug("Received sync " .. entry.cid .. ":" .. entry.hp .. " on " .. channel .. " from " .. tostring(from), 3)
			if trackedUnit then
				if not trackedUnit.hp or isGoodUpdate(entry.hp, trackedUnit.hp) then
					trackedUnit.hp = entry.hp
					trackedUnit.updateTime = GetTime()
					trackedUnit.state = "SYNCED"
				end
				if not trackedUnit[channel] or isGoodUpdate(entry.hp, trackedUnit[channel].hp) then
					trackedUnit[channel] = trackedUnit[channel] or {}
					trackedUnit[channel].hp = entry.hp
					trackedUnit[channel].updateTime = GetTime()
				end
			end
		end
	end

	function healthTracker:updateInfoFrame()
		local lines, sortedLines = {}, {}
		for _, entry in ipairs(self.trackedUnits) do
			local hp = entry.hp or 100
			local lastUpdate = GetTime() - (entry.updateTime or 0)
			local name = entry.name
			local color = entry.color or NORMAL_FONT_COLOR
			name = color:GenerateHexColorMarkup() .. name .. "|r"
			if lastUpdate < 60 then
				lines[name] = ("%s%d%%|r"):format(
					color:GenerateHexColorMarkup(),
					hp
				)
			else
				local stale = ""
				if hp > 0 then
					stale = L.Stale
				end
				lines[name] = ("%s%s%d%%|r"):format(
					GRAY_FONT_COLOR:GenerateHexColorMarkup(), stale, hp
				)
			end
			sortedLines[#sortedLines + 1] = name
		end
		return lines, sortedLines
	end

	---@param color ColorMixin
	function healthTracker:TrackHealth(cid, name, color)
		if self.ticker:IsCancelled() then
			error("tried to call TrackHealth on cancelled tracker")
		end
		local entry = {
			cid = cid,
			name = L[name] or name,
			color = color
		}
		tinsert(self.trackedUnits, entry)
		self.trackedUnitsByCid[cid] = entry
		DBM.InfoFrame:SetHeader(L.InfoFrameHeader)
		-- 9 lines at most to avoid seemingly buggy 2 column mode
		DBM.InfoFrame:Show(9, "function", function() return self:updateInfoFrame() end, false, false)
		DBM.InfoFrame:SetColumns(1)
	end

	function healthTracker:ShowInfoFrame()
		if not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:Show(9, "function", function() return self:updateInfoFrame() end, false, false)
		end
	end

	local trackers = {} ---@type HealthTracker[]
	--- Only a single health tracker can be active at a time.
	function mod:NewHealthTracker(syncChannels, scanNameplates)
		syncChannels = syncChannels or {"INSTANCE_CHAT"}
		local hash = 0
		-- simple hash to give everyone a unique delay of up to 1 second, updates are only posted if we are the first to post a specific update
		-- this is effectively a poor man's leader election scheme to avoid spamming yell chat when multiple raids are present
		-- i originally hoped that the effectively random scanning interval together with the anti-stomping is sufficient, but most updates were duplicated multiple times
		local playerName = UnitName("player") or ""
		for i = 1, #playerName do
			hash = hash * 31 + playerName:byte(i, i)
			hash = hash % 4294967311
		end
		mod:RegisterShortTermEvents("CHAT_MSG_ADDON")
		RegisterAddonMessagePrefix("DBM-PvP")
		RegisterAddonMessagePrefix("Capping") -- Listen to capping for extra data
		---@class HealthTracker
		local tracker = setmetatable({
			syncChannels = syncChannels,
			scanNameplates = scanNameplates,
			trackedUnits = {},  -- tracks state for each sync channel separately
			trackedUnitsByCid = {},
			syncDelay = (hash % 1000) / 1000,
		}, {__index = healthTracker})
		-- This sends up to one sync message per channel per invocation, there seem to be heavy rate limits in place to ~10 messages/second (per channel?)
		-- TODO: figure out what works
		tracker.ticker = NewTicker(#syncChannels, function() tracker:scan() end)
		trackers[#trackers + 1] = tracker
		return tracker
	end

	--- Cancels health tracking, it cannot be re-started on this object.
	function healthTracker:Cancel()
		self.ticker:Cancel()
		for i, v in ipairs(trackers) do
			if v == self then
				tremove(trackers, i)
				break
			end
		end
		mod:UnregisterShortTermEvents()
		DBM.InfoFrame:Hide()
	end

	-- format is cid1:hp1:cid2:hp2... for backwards compatibility with old single-entry message
	local function parseMessage(...)
		local n = select("#", ...)
		if n % 2 ~= 0 then
			return
		end
		local result = {}
		for i = 1, n, 2 do
			local cid = tonumber((select(i, ...)))
			local hp = tonumber((select(i + 1, ...)))
			if not cid or not hp or hp > 100 or hp < 0 then
				return
			end
			result[#result + 1] = {
				cid = cid,
				hp = hp
			}
		end
		return result
	end

	function mod:CHAT_MSG_ADDON(prefix, msg, channel, from)
		if prefix ~= "DBM-PvP" and prefix ~= "Capping" then
			return
		end
		local args = parseMessage((":"):split(msg))
		if not args then
			return
		end
		for _, tracker in ipairs(trackers) do
			tracker:receiveSync(args, channel, from)
		end
	end
end

do
	local ipairs = ipairs
	local TimerTracker, IsInInstance = TimerTracker, IsInInstance
	local FACTION_ALLIANCE = FACTION_ALLIANCE

	local flagTimer			= mod:NewTimer(12, "TimerFlag", "132483") -- Interface\\icons\\inv_banner_02.blp
	local startTimer		= mod:NewTimer(120, "TimerStart", playerFaction == "Alliance" and "132486" or "132485") -- Interface\\Icons\\INV_BannerPVP_02.blp || Interface\\Icons\\INV_BannerPVP_01.blp
	local vulnerableTimer, timerShadow, timerDamp
	if isRetail then
		vulnerableTimer	= mod:NewNextTimer(60, 46392)
		timerShadow		= mod:NewNextTimer(90, 34709)
		timerDamp		= mod:NewCastTimer(300, 110310)
	end

	function mod:START_TIMER(timerType, timeSeconds)
		if timerType ~= 1 then -- Only capture type 1 events (PvP)
			return
		end
		if self.Options.TimerStart then
			if TimerTracker then
				for _, bar in ipairs(TimerTracker.timerList) do
					bar.bar:Hide()
				end
			end
			if not startTimer:IsStarted() then
				startTimer:Update(timeSeconds, 120)
			end
		end
		local _, instanceType = IsInInstance()
		if isRetail and instanceType == "arena" then
			self:Schedule(timeSeconds + 1, function()
				timerShadow:Start()
				timerDamp:Start()
			end, self)
		end
	end

	local function Updateflagcarrier(self, msg)
		if not self.Options.TimerFlag then
			return
		end
		if msg == L.FlagCaptured or msg:match(L.FlagCaptured) then
			flagTimer:Start()
			if msg:find(FACTION_ALLIANCE) then
				flagTimer:SetColor({r=0, g=0, b=1})
				flagTimer:UpdateIcon("132486") -- Interface\\Icons\\INV_BannerPVP_02.blp
			else
				flagTimer:SetColor({r=1, g=0, b=0})
				flagTimer:UpdateIcon("132485") -- Interface\\Icons\\INV_BannerPVP_01.blp
			end
			if isRetail then
				vulnerableTimer:Cancel()
			end
		end
	end

	function mod:CHAT_MSG_BG_SYSTEM_ALLIANCE(...)
		Updateflagcarrier(self, ...)
	end

	function mod:CHAT_MSG_BG_SYSTEM_HORDE(...)
		Updateflagcarrier(self, ...)
	end

	function mod:CHAT_MSG_BG_SYSTEM_NEUTRAL(msg)
		-- in Classic era the chat msg is about 1.5 seconds early
		if self.Options.TimerStart and (msg:find(L.BgStart120) or msg:find(L.BgStart120era)) then
			startTimer:Update(0, 120)
		elseif self.Options.TimerStart and (msg:find(L.BgStart60) or msg:find(L.BgStart60era) or msg == L.ArenaStart60 or msg:find(L.ArenaStart60)) then
			startTimer:Update(isClassic and 58.5 or 60, 120)
		elseif self.Options.TimerStart and (msg:find(L.BgStart30) or msg:find(L.BgStart30era) or msg == L.ArenaStart30 or msg:find(L.ArenaStart30)) then
			startTimer:Update(isClassic and 88.5 or 90, 120)
		elseif self.Options.TimerStart and (msg == L.ArenaStart15 or msg:find(L.ArenaStart15)) then
			startTimer:Update(isClassic and 103.5 or 105, 120)
		elseif not isClassic and (msg == L.Vulnerable1 or msg == L.Vulnerable2 or msg:find(L.Vulnerable1) or msg:find(L.Vulnerable2)) then
			vulnerableTimer:Start()
		end
	end
end

do
	local ipairs, pairs, tonumber, type, mfloor, mmin, smatch = ipairs, pairs, tonumber, type, math.floor, math.min, string.match
	local GetAreaPOIInfo, GetAreaPOITimeLeft, GetAreaPOIForMap, GetDoubleStatusBarWidgetVisualizationInfo, GetIconAndTextWidgetVisualizationInfo, GetDoubleStateIconRowVisualizationInfo = C_AreaPoiInfo.GetAreaPOIInfo, C_AreaPoiInfo.GetAreaPOITimeLeft, C_AreaPoiInfo.GetAreaPOIForMap, C_UIWidgetManager.GetDoubleStatusBarWidgetVisualizationInfo, C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo, C_UIWidgetManager.GetDoubleStateIconRowVisualizationInfo
	local FACTION_HORDE, FACTION_ALLIANCE = FACTION_HORDE, FACTION_ALLIANCE

	local winTimer = mod:NewTimer(30, "TimerWin", playerFaction == "Alliance" and "132486" or "132485") -- Interface\\Icons\\INV_BannerPVP_02.blp || Interface\\Icons\\INV_BannerPVP_01.blp
	local resourcesPerSec = {
		[3] = {1e-300, 0.5, 1.5, 2}, -- Gilneas
		[4] = {1e-300, 1, 1.5, 2, 6}, -- TempleOfKotmogu/EyeOfTheStorm
		[5] = {1e-300, 1, 1.5, 2, 3.5, 30} -- Arathi/Deepwind
	}

	if not isRetail then
		-- 2014 values seem ok https://github.com/DeadlyBossMods/DBM-PvP/blob/843a882eae2276c2be0646287c37b114c51fcffb/DBM-PvP/Battlegrounds/Arathi.lua#L32-L39
		resourcesPerSec[5] = {1e-300, 10/12, 10/9, 10/6, 10/3, 30}
	end

	--[[
	local basesToWin = {}
	local function UpdateInfoFrame()
		local lines, sortedLines = {}, {}
		for bases, seconds in pairs(basesToWin) do
			lines[bases] = seconds
			sortedLines[#sortedLines + 1] = bases
		end
		return lines, sortedLines
	end
	]]--

	local infoFrameState = {
		allianceScore = 0,
		hordeScore = 0,
		maxScore = 0,
		resPerSec = {},
	}
	local function updateInfoFrame()
		local isAlly = playerFaction == "Alliance"
		local ourScore = isAlly and infoFrameState.allianceScore or infoFrameState.hordeScore
		local enemyScore = isAlly and infoFrameState.hordeScore or infoFrameState.allianceScore
		for ourBases = 0, numObjectives do
			local enemyBases = numObjectives - ourBases
			local ourTime = mmin(infoFrameState.maxScore, (infoFrameState.maxScore - ourScore) / (infoFrameState.resPerSec[ourBases + 1] or 0))
			local enemyTime = mmin(infoFrameState.maxScore, (infoFrameState.maxScore - enemyScore) / (infoFrameState.resPerSec[enemyBases + 1] or 0))
			-- It would be very clever to also take current capping timers and time to cap into account here
			-- But that'd be hard to test and not really necessary: it's pretty clear what this number means
			-- even when it misses the very rare edge case that the time until you cap an extra base is relevant for the number
			-- (it will just update to a higher number while you cap which is fine)
			if enemyTime > ourTime then
				local text = L.BasesToWin:format(ourBases)
				return {[text] = ""}, {text}
			end
		end
		return {}, {} -- shouldn't happen because you should always be able to win by capturing everything
	end

	function mod:UpdateWinTimer(maxScore, allianceScore, hordeScore, allianceBases, hordeBases)
		local resPerSec = resourcesPerSec[numObjectives]
		local gameTime = GetGametime()
		local allyTime = mfloor(mmin(maxScore, (maxScore - allianceScore) / resPerSec[allianceBases + 1]))
		local hordeTime = mfloor(mmin(maxScore, (maxScore - hordeScore) / resPerSec[hordeBases + 1]))
		if allyTime == hordeTime or allyTime == 0 or hordeTime == 0 then
			winTimer:Stop()
		elseif allyTime > hordeTime then
			winTimer:Update(gameTime, gameTime + hordeTime)
			winTimer:DisableEnlarge()
			winTimer:UpdateName(L.WinBarText:format(FACTION_HORDE))
			winTimer:SetColor({r=1, g=0, b=0})
			winTimer:UpdateIcon("132485") -- Interface\\Icons\\INV_BannerPVP_01.blp
		elseif hordeTime > allyTime then
			winTimer:Update(gameTime, gameTime + allyTime)
			winTimer:DisableEnlarge()
			winTimer:UpdateName(L.WinBarText:format(FACTION_ALLIANCE))
			winTimer:SetColor({r=0, g=0, b=1})
			winTimer:UpdateIcon("132486") -- Interface\\Icons\\INV_BannerPVP_02.blp
		end
		infoFrameState.allianceScore = allianceScore
		infoFrameState.hordeScore = hordeScore
		infoFrameState.maxScore = maxScore
		infoFrameState.resPerSec = resPerSec
		if self.Options.ShowBasesToWin then
			if not DBM.InfoFrame:IsShown() then
				DBM.InfoFrame:SetHeader(L.BasesToWinHeader)
				DBM.InfoFrame:Show(2, "function", updateInfoFrame, false, false)
				DBM.InfoFrame:SetColumns(1)
			end
		end
	end

	local ignoredAtlas = {
		[112]   = true,
		[397]   = true
	}
	local overrideTimers = {
		-- retail av
		[91]    = 243,
		-- classic av
		[1459]  = isClassic and 304 or 243,
		-- korrak
		[1537]  = 243
	}
	local State = {
		["ALLY_CONTESTED"]      = 1,
		["ALLY_CONTROLLED"]     = 2,
		["HORDE_CONTESTED"]     = 3,
		["HORDE_CONTROLLED"]    = 4
	}
	local icons = {
		-- Graveyard
		[(isClassic or isBCC) and 3 or 4]   = State.ALLY_CONTESTED,
		[(isClassic or isBCC) and 14 or 15] = State.ALLY_CONTROLLED,
		[(isClassic or isBCC) and 13 or 14] = State.HORDE_CONTESTED,
		[(isClassic or isBCC) and 12 or 13] = State.HORDE_CONTROLLED,
		-- Tower/Lighthouse
		[(isClassic or isBCC) and 8 or 9]   = State.ALLY_CONTESTED,
		[(isClassic or isBCC) and 10 or 11] = State.ALLY_CONTROLLED,
		[(isClassic or isBCC) and 11 or 12] = State.HORDE_CONTESTED,
		[(isClassic or isBCC) and 9 or 10]  = State.HORDE_CONTROLLED,
		-- Mine/Quarry
		[17]                        = State.ALLY_CONTESTED,
		[18]                        = State.ALLY_CONTROLLED,
		[19]                        = State.HORDE_CONTESTED,
		[20]                        = State.HORDE_CONTROLLED,
		-- Lumber
		[22]                        = State.ALLY_CONTESTED,
		[23]                        = State.ALLY_CONTROLLED,
		[24]                        = State.HORDE_CONTESTED,
		[25]                        = State.HORDE_CONTROLLED,
		-- Blacksmith/Waterworks
		[27]                        = State.ALLY_CONTESTED,
		[28]                        = State.ALLY_CONTROLLED,
		[29]                        = State.HORDE_CONTESTED,
		[30]                        = State.HORDE_CONTROLLED,
		-- Farm
		[32]                        = State.ALLY_CONTESTED,
		[33]                        = State.ALLY_CONTROLLED,
		[34]                        = State.HORDE_CONTESTED,
		[35]                        = State.HORDE_CONTROLLED,
		-- Stables
		[37]                        = State.ALLY_CONTESTED,
		[38]                        = State.ALLY_CONTROLLED,
		[39]                        = State.HORDE_CONTESTED,
		[40]                        = State.HORDE_CONTROLLED,
		-- Workshop
		[137]                       = State.ALLY_CONTESTED,
		[138]                       = State.ALLY_CONTROLLED,
		[139]                       = State.HORDE_CONTESTED,
		[140]                       = State.HORDE_CONTROLLED,
		-- Hangar
		[142]                       = State.ALLY_CONTESTED,
		[143]                       = State.ALLY_CONTROLLED,
		[144]                       = State.HORDE_CONTESTED,
		[145]                       = State.HORDE_CONTROLLED,
		-- Docks
		[147]                       = State.ALLY_CONTESTED,
		[148]                       = State.ALLY_CONTROLLED,
		[149]                       = State.HORDE_CONTESTED,
		[150]                       = State.HORDE_CONTROLLED,
		-- Refinery
		[152]                       = State.ALLY_CONTESTED,
		[153]                       = State.ALLY_CONTROLLED,
		[154]                       = State.HORDE_CONTESTED,
		[155]                       = State.HORDE_CONTROLLED,
		-- Market
		[208]                       = State.ALLY_CONTESTED,
		[205]                       = State.ALLY_CONTROLLED,
		[209]                       = State.HORDE_CONTESTED,
		[206]                       = State.HORDE_CONTROLLED,
		-- Ruins
		[213]                       = State.ALLY_CONTESTED,
		[210]                       = State.ALLY_CONTROLLED,
		[214]                       = State.HORDE_CONTESTED,
		[211]                       = State.HORDE_CONTROLLED,
		-- Shrine
		[218]                       = State.ALLY_CONTESTED,
		[215]                       = State.ALLY_CONTROLLED,
		[219]                       = State.HORDE_CONTESTED,
		[216]                       = State.HORDE_CONTROLLED
	}
	local capTimer = mod:NewTimer(isRetail and 60 or 64, "TimerCap", "136002") -- Interface\\icons\\spell_misc_hellifrepvphonorholdfavor.blp

	function mod:AREA_POIS_UPDATED(widget)
		local allyBases, hordeBases = 0, 0
		local widgetID = widget and widget.widgetID
		if subscribedMapID then
			local isAtlas = false
			for _, areaPOIID in ipairs(GetAreaPOIForMap(subscribedMapID)) do
				local areaPOIInfo = GetAreaPOIInfo(subscribedMapID, areaPOIID)
				local infoName, atlasName, infoTexture = areaPOIInfo.name, areaPOIInfo.atlasName, areaPOIInfo.textureIndex
				if infoName then
					local isAllyCapping, isHordeCapping
					if atlasName then
						isAtlas = true
						isAllyCapping = atlasName:find('leftIcon')
						isHordeCapping = atlasName:find('rightIcon')
					elseif infoTexture then
						isAllyCapping = icons[infoTexture] == State.ALLY_CONTESTED
						isHordeCapping = icons[infoTexture] == State.HORDE_CONTESTED
					end
					if objectivesStore[infoName] ~= (atlasName and atlasName or infoTexture) then
						capTimer:Stop(infoName)
						objectivesStore[infoName] = (atlasName and atlasName or infoTexture)
						if not ignoredAtlas[subscribedMapID] and (isAllyCapping or isHordeCapping) then
							local capTime = GetAreaPOITimeLeft and GetAreaPOITimeLeft(areaPOIID) and GetAreaPOITimeLeft(areaPOIID) * 60 or overrideTimers[subscribedMapID] or isRetail and 60 or 64
							if capTime ~= 0 then
								capTimer:Start(capTime, infoName)
							end
							if isAllyCapping then
								capTimer:SetColor({r=0, g=0, b=1}, infoName)
								capTimer:UpdateIcon("132486", infoName) -- Interface\\Icons\\INV_BannerPVP_02.blp
							else
								capTimer:SetColor({r=1, g=0, b=0}, infoName)
								capTimer:UpdateIcon("132485", infoName) -- Interface\\Icons\\INV_BannerPVP_01.blp
							end
						end
					end
				end
			end
			if isAtlas then
				for _, v in pairs(objectivesStore) do
					if type(v) ~= "string" then
						-- Do nothing
					elseif v:find('leftIcon') then
						allyBases = allyBases + 1
					elseif v:find('rightIcon') then
						hordeBases = hordeBases + 1
					end
				end
			else
				for _, v in pairs(objectivesStore) do
					if icons[v] == State.ALLY_CONTROLLED then
						allyBases = allyBases + 1
					elseif icons[v] == State.HORDE_CONTROLLED then
						hordeBases = hordeBases + 1
					end
				end
			end
			if widgetID == 1671 or widgetID == 2074 then -- Standard battleground score predictor: 1671. Deepwind rework: 2074
				local info = GetDoubleStatusBarWidgetVisualizationInfo(widgetID)
				if info then
					self:UpdateWinTimer(info.leftBarMax, info.leftBarValue, info.rightBarValue, allyBases, hordeBases)
				end
			end
			if widgetID == 1893 or widgetID == 1894 then -- Classic Arathi Basin
				local totalScore = (isCata or isWrath) and 1600 or 2000
				self:UpdateWinTimer(totalScore, tonumber(smatch(GetIconAndTextWidgetVisualizationInfo(1893).text, '(%d+)/' .. tostring(totalScore))), tonumber(smatch(GetIconAndTextWidgetVisualizationInfo(1894).text, '(%d+)/' .. tostring(totalScore))), allyBases, hordeBases)
			end
		elseif widgetID == 1683 then -- Temple Of Kotmogu
			local widgetInfo = GetDoubleStateIconRowVisualizationInfo(1683)
			if widgetInfo then
				for _, v in pairs(widgetInfo.leftIcons) do
					if v.iconState == 1 then
						allyBases = allyBases + 1
					end
				end
				for _, v in pairs(widgetInfo.rightIcons) do
					if v.iconState == 1 then
						hordeBases = hordeBases + 1
					end
				end
			end
			local info = GetDoubleStatusBarWidgetVisualizationInfo(1689)
			if info then
				self:UpdateWinTimer(info.leftBarMax, info.leftBarValue, info.rightBarValue, allyBases, hordeBases)
			end
		end
	end
	mod.UPDATE_UI_WIDGET = mod.AREA_POIS_UPDATED
end

-- Note on game time and server time.
-- Contrary to popular opinion the event start time is not synced to GetGameTime(), it seems a bit random.
-- Also, GetGameTime() is only available with minute granularity and the updates of minutes on game time as visible by the API does not seem to be synchronized to actual time.
-- This GetGameTime() randomness seems to be just be a weird effect due to how the time between client and server are synchronized.
-- The exact time at which the minute for GetGameTime updates changes between relogs, so there doesn't seem to be any meaning to the exact point in time when this happens.
-- Earlier versions of this mod just used GetGameTime() and attempted to adjust for seconds from local but it was often off by a whole minute,
-- this implementation is only off by at most 30 seconds, but usually at most 15 seconds (if your clock is synchronized)

-- Get current time in server time zone
function mod:GetServerTime()
	-- C_DateAndTime.GetServerTimeLocal() returns a time zone that is neither the server's time nor my time?
	-- GetGameTime() returns server time but is updated once per minute and the update interval is synchronized to actual server time, i.e., it will be off by up to a minute and the update time differs between relogs
	-- Also there is GetLocalGameTime() which seems to be identical to GetGameTime()?
	-- GetServerTime() looks like it returns local time, but good thing everyone has synchronized clocks nowadays, so this is fine to use
	-- We just need to handle time zones, i.e., find the diff between what GetGameTime() says and what is local time
	local gameHours, gameMinutes = GetGameTime()
	-- The whole date logic could probably be avoided with some clever modular arithmetic, but whatever, we know the date
	local gameDate = C_DateAndTime.GetTodaysDate() -- Yes, this is server date
	local localSeconds = GetServerTime() -- Yes, that is local time
	local gameSeconds = time({
		year = gameDate.year,
		month = gameDate.month,
		day = gameDate.day,
		hour = gameHours,
		min = gameMinutes
	})
	local timeDiff = localSeconds - gameSeconds
	-- Time zones can be in 15 minute increments, so round to that
	return localSeconds - math.floor(timeDiff / (15 * 60) + 0.5) * 15 * 60
end

-- Time until world pvp events (Season of Discovery) that ocur every `interval` hours at an offset of `offet` hours
---@return number
function mod:GetTimeUntilWorldPvpEvent(offset, interval)
	offset = offset or 0
	interval = interval or 3
	local time = date("*t", self:GetServerTime())
	local hour = time.hour + time.min / 60 + time.sec / 60 / 60
	return (interval - ((hour - offset) % interval)) * 60 * 60 + 30
end

