--[[--
	alex/ALA @ 163UI
--]]--

local __version = 7;

_G.__ala_meta__ = _G.__ala_meta__ or {  };
local __coder = __ala_meta__.__coder;
if __coder ~= nil and __coder.__minor >= __version then
	return;
end

local DEVELOPER;
if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
	DEVELOPER = {
		--	Classic
		["Player-5376-05B22FA4"] = "B",	--	"哈霍兰.ALEX.PALADIN"
	};
elseif WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
	DEVELOPER = {
		--	BCC
		["Player-4497-0388473F"] = "B",	--	"碧玉矿洞.ALEX.WARRIOR"
		["Player-4497-038D0E9A"] = "B",	--	"碧玉矿洞.ALEX.PALADIN"
		["Player-4497-0392FA91"] = "B",	--	"碧玉矿洞.ALEX.MAGE"
		["Player-4497-038E14E4"] = "B",	--	"碧玉矿洞.ALEX.SHAMAN"
		["Player-4497-03F0D909"] = "B",	--	"碧玉矿洞.ALEX.HUNTER"
		["Player-4497-039DEE62"] = "B",	--	"碧玉矿洞.ALEX.DRUID"
		["Player-4497-040FF31B"] = "B",	--	"碧玉矿洞.ALEX.WARLOCK"
		["Player-4497-04105E08"] = "B",	--	"碧玉矿洞.ALEX.ROGUE"
		["Player-4497-039DF9BC"] = "B",	--	"碧玉矿洞.ALEX.PRIEST.MINOR"
		--
		["Player-4497-03985947"] = "G",	--	"碧玉矿洞.ANDREA.PRIEST"
		["Player-4497-03871A80"] = "G",	--	"碧玉矿洞.ANDREA.SHAMAN"
		["Player-4497-0395C790"] = "G",	--	"碧玉矿洞.ANDREA.HUNTER"
		["Player-4497-03C3B443"] = "G",	--	"碧玉矿洞.ANDREA.MAGE"
		["Player-4497-040C3C57"] = "G",	--	"碧玉矿洞.ANDREA.PALADIN"
		["Player-4497-03F6B362"] = "G",	--	"碧玉矿洞.ANDREA.DRUID"
		["Player-4497-04102EFE"] = "G",	--	"碧玉矿洞.ANDREA.WARRIOR"
		["Player-4497-04102FBE"] = "G",	--	"碧玉矿洞.ANDREA.WARLOCK"
		["Player-4497-0410343D"] = "G",	--	"碧玉矿洞.ANDREA.ROGUE"
		["Player-4497-03B5A603"] = "G",	--	"碧玉矿洞.ANDREA.MAGE.MINOR"
		--
		["Player-4497-03FC5121"] = "D",	--	"碧玉矿洞.ALA.MAGE.HORDE"
		["Player-4497-03FBAEC1"] = "D",	--	"碧玉矿洞.ALA.MAGE.HORDE.MINOR"
		["Player-4497-03F67EA5"] = "D",	--	"碧玉矿洞.ALA.MAGE.ALLIANCE"
		["Player-4497-040F5394"] = "D",	--	"碧玉矿洞.ALA.WARRIOR"
		["Player-4497-040FF486"] = "D",	--	"碧玉矿洞.ALA.PALADIN"
		["Player-4497-040F5184"] = "D",	--	"碧玉矿洞.ALA.ROGUE"
		--
		["Player-4497-0393B39E"] = "D",	--	"碧玉矿洞.NETEASEUI"
		--
		["Player-4791-00891F9F"] = "B",	--	"碧空之歌.ALEX.WARRIOR"
		["Player-4791-010E9724"] = "B",	--	"碧空之歌.ALEX.MAGE"
		["Player-4791-01680518"] = "B",	--	"碧空之歌.ALEX.WARLOCK"
		["Player-4791-01480730"] = "B",	--	"碧空之歌.ALEX.PALADIN"
		["Player-4791-010EBD53"] = "B",	--	"碧空之歌.ALEX.DRUID"
		["Player-4791-0136A10C"] = "B",	--	"碧空之歌.ALEX.ROGUE"
		["Player-4791-00E26C49"] = "B",	--	"碧空之歌.ALEX.HUNTER"
		["Player-4791-02840797"] = "B",	--	"碧空之歌.ALEX.WARRIOR.MINOR"
		["Player-4791-0088F6CB"] = "B",	--	"碧空之歌.ALEX.PALADIN.MINOR"
		--
		["Player-4791-0088F61D"] = "G",	--	"碧空之歌.ANDREA.PRIEST"
		["Player-4791-00DE4CF1"] = "G",	--	"碧空之歌.ANDREA.HUNTER"
		["Player-4791-010B0B3C"] = "G",	--	"碧空之歌.ANDREA.PALADIN"
		["Player-4791-0136A0D6"] = "G",	--	"碧空之歌.ANDREA.ROGUE"
		["Player-4791-02139522"] = "G",	--	"碧空之歌.ANDREA.MAGE"
		["Player-4791-02139923"] = "G",	--	"碧空之歌.ANDREA.WARLOCK"
	};
elseif WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
	DEVELOPER = {
		--	Mainline
		["Player-962-0509AC92"] = "B",	--	"燃烧之刃.ALEX.WARRIOR",
		["Player-962-04FEC839"] = "B",	--	"燃烧之刃.ALEX.MAGE",
		["Player-962-0509E004"] = "B",	--	"燃烧之刃.ALEX.PALADIN",
		["Player-962-0509E001"] = "B",	--	"燃烧之刃.ALEX.DRUID",
		["Player-962-0509E049"] = "B",	--	"燃烧之刃.ALEX.PRIEST",
		--
		["Player-962-0509ACEF"] = "G",	--	"燃烧之刃.ANDREA.MAGE",
		["Player-962-0508A77F"] = "G",	--	"燃烧之刃.ANDREA.DRUID",
		["Player-962-0508A6CC"] = "G",	--	"燃烧之刃.ANDREA.SHAMAN",
		["Player-962-0508ADA1"] = "G",	--	"燃烧之刃.ANDREA.HUNTER",
		["Player-962-0508AD8B"] = "G",	--	"燃烧之刃.ANDREA.WARRIOR",
		["Player-962-0508ADDC"] = "G",	--	"燃烧之刃.ANDREA.PRIEST",
		["Player-962-0508AD43"] = "G",	--	"燃烧之刃.ANDREA.PALADIN",
		["Player-962-0508AD11"] = "G",	--	"燃烧之刃.ANDREA.ROGUE",
		["Player-962-04FF445B"] = "G",	--	"燃烧之刃.ANDREA.PALADIN-MINUS",
		["Player-962-0509EA70"] = "G",	--	"燃烧之刃.ANDREA.PRIEST-MINUS",
		--
		["Player-962-05469808"] = "B",	--	"金色平原.ALEX.WARRIOR"
		["Player-962-04FEC839"] = "B",	--	"金色平原.ALEX.MAGE"
		--
		["Player-962-0509ACEF"] = "G",	--	"金色平原.ANDREA.MAGE"
		["Player-962-0508A6CC"] = "G",	--	"金色平原.ANDREA.SHAMAN"
		-- ["Player-962-0509ADA1"] = "G",	--	"金色平原.ANDREA.DRUID"
	};
else
	DEVELOPER = {  };
end
local TITLELIST = {
	B = IsAddOnLoaded("!!!163UI!!!") and "网易有爱开发者" or "夜空中最亮的星",
	G = IsAddOnLoaded("!!!163UI!!!") and "网易有爱开发者" or "宇宙无敌兔姐姐",
	D = "网易有爱开发者",
};
local FILELIST;
if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
	FILELIST = {
		--	file, z, x, y, alpha, rotate
		["*"] = { "spells/creature_spellportal_blue.m2", 4, 0, 1, 1, 0.0, },
		[1] = { "spells/creature_spellportal_blue.m2", 4, 0, 1, 1, 0.0, },
		[2] = { "spells/creature_spellportal_purple.m2", 4, 0, 1, 0.75, 0.0, },
		-- [3] = { "spells/corruption_impactdot_med_base.m2", 3, 0, 0.5, 1, 0.0, },
	};
else
	FILELIST = {
		--	file, z, x, y, alpha, rotate
		["*"] = { "spells/creature_spellportal_blue.m2", 4, 0, 1, 1, 0.0, },
		[1] = { "spells/creature_spellportal_blue.m2", 4, 0, 1, 1, 0.0, },
		[2] = { "spells/creature_spellportal_purple.m2", 4, 0, 1, 0.75, 0.0, },
		[3] = { "spells/creature_spellportal_green.m2", 4, 0, 1, 0.75, 0.0, },
		[4] = { "spells/creature_spellportal_white.m2", 4, 0, 1, 1, 0.0, },
		[5] = { "spells/creature_spellportal_yellow.m2", 4, 0, 1, 0.75, 0.0, },
		-- [6] = { "spells/flamecircleeffect_blue.m2", 2.5, 0, 0, 1, 0.0, },
		-- [7] = { "spells/corruption_impactdot_med_base.m2", 3, 0, 0.5, 1, 0.0, },
		-- [1] = { "spells/blackmagic_precast_base.m2", 3, 0, 0.5, 1.0, 0.0, },
		-- [2] = { "spells/sunwell_fire_barrier_ext.m2", 0, 0, 10, 0.5, 1.0, },
		-- [3] = { "spells/archimonde_blue_fire.m2", 0, 0, 0, 0.5, 0.0, },
		-- [4] = { "spells/archimonde_fire.m2", 0, 0, 0, 0.5, 0.0, },
		-- [12] = { "spells/cripple_state_chest.m2", 4, 0, 1.5, 0.75, 0.0, },
		-- [13] = { "spells/cyclone_state.m2", 4, 0, 0, 1, 0.0, },
		-- [13] = { "spells/conjureitemcast.m2", 5, 0, 2.2, 1, 0.0, },
	};
end
local NUMFILE = #FILELIST;
local random = random;
local GETFILE = function()
	local rnd = random(1, NUMFILE);
	return FILELIST[rnd] or FILELIST["*"];
end

if false and GetAddOnInfo("!!!!!DebugMe") then
	-->	Cross-Account Sync
	local pcall = pcall;
	local next = next;
	local strsub, strfind = string.sub, string.find;
	local tonumber = tonumber;
	local GetTime = GetTime;
	local C_Timer_After = C_Timer.After;
	local RegisterAddonMessagePrefix = C_ChatInfo ~= nil and C_ChatInfo.RegisterAddonMessagePrefix or RegisterAddonMessagePrefix;
	local IsAddonMessagePrefixRegistered = C_ChatInfo ~= nil and C_ChatInfo.IsAddonMessagePrefixRegistered or IsAddonMessagePrefixRegistered;
	local GetRegisteredAddonMessagePrefixes = C_ChatInfo ~= nil and C_ChatInfo.GetRegisteredAddonMessagePrefixes or GetRegisteredAddonMessagePrefixes;
	local SendAddonMessage = C_ChatInfo ~= nil and C_ChatInfo.SendAddonMessage or SendAddonMessage;
	local GetPlayerInfoByGUID = GetPlayerInfoByGUID;
	local UnitIsPlayer, UnitIsEnemy = UnitIsPlayer, UnitIsEnemy;
	local UnitName, UnitGUID = UnitName, UnitGUID;
	local UnitHealth, UnitHealthMax = UnitHealth, UnitHealthMax;
	local UnitPowerType, UnitPower, UnitPowerMax = UnitPowerType, UnitPower, UnitPowerMax;
	local UnitIsDead, UnitIsFeignDeath, UnitIsGhost = UnitIsDead, UnitIsFeignDeath, UnitIsGhost;
	local UnitPosition = UnitPosition;
	local C_Map_GetBestMapForUnit = C_Map.GetBestMapForUnit;
	local IsInGroup = IsInGroup;
	local GetNumGroupMembers, GetRaidRosterInfo = GetNumGroupMembers, GetRaidRosterInfo;
	--
	local PREALM = GetRealmName();
	local ADDON_MSG_CONTROL_CODE_LEN = 6;
	local ADDON_PREFIX = "ALSTRM";
	local ADDON_MSG_QUERY = "_qstrm";
	local ADDON_MSG_REPLY = "_rstrm";
	local ADDON_MSG_SHARE = "_sstrm";
	local ADDON_MSG_STREAMER = "_binst";
	--
	local E = {  };
	local S = nil;

	local H = {  };
	local limit = 0;
	local function F_CacheName()
		limit = limit + 1;
		for v1, v2 in next, H do
			if DEVELOPER[v1] == nil and DEVELOPER[v2] == nil then
				H[v1] = nil;
			end
		end
		local miss = false;
		for GUID, _ in next, DEVELOPER do
			local _, class, _, race, sex, name, realm = GetPlayerInfoByGUID(GUID);
			if name ~= nil then
				if realm == nil or realm == "" then
					realm = PREALM;
				end
				local fn = name .. "-" .. realm;
				H[fn] = GUID;
				H[GUID] = fn;
			else
				miss = true;
			end
		end
		if miss and limit < 4 then
			C_Timer_After(4.0, F_CacheName);
		end
	end

	local EnterCombatTime = InCombatLockdown() and GetTime() or nil;
	local EncounterIDs = {  };
	function E.PLAYER_REGEN_DISABLED(F, event, ...)
		EnterCombatTime = GetTime();
	end
	function E.PLAYER_REGEN_ENABLED(F, event, ...)
		EnterCombatTime = nil;
		EncounterIDs = {  };
	end
	function E.ENCOUNTER_START(F, event, encounterID, encounterName, difficultyID, groupSize, success)
		EncounterIDs[encounterID] = GetTime();
	end
	function E.ENCOUNTER_END(F, event, encounterID, encounterName, difficultyID, groupSize)
		EncounterIDs[encounterID] = nil;
	end

	local function EncodeSelf()
		local dead = UnitIsDead('player');
		local fdead = UnitIsFeignDeath('player');
		local ghost = UnitIsGhost('player');
		local state = "0";
		if ghost then
			state = "g";
		elseif dead then
			if fdead then
				state = "f";
			else
				state = "d";
			end
		elseif fdead then
			state = "f";
		else
			state = "a";
		end
		local CH = tostring(UnitHealth('player') or -1);
		local MH = tostring(UnitHealthMax('player') or -1);
		local PT = tostring(UnitPowerType('player') or -1);
		local CP = tostring(UnitPower('player') or -1);
		local MP = tostring(UnitPowerMax('player') or -1);
		local map = C_Map_GetBestMapForUnit('player');
		local y, x, _z, instance = UnitPosition('player');
		if map == nil then
			if instance == nil then
				return state .. "~" .. CH .. "~" .. MH .. "~" .. PT .. "~" .. CP .. "~" .. MP .. "~" ..                         "~" .. format("%.3f", x or -1) .. "~" .. format("%.3f", y or -1);
			else
				return state .. "~" .. CH .. "~" .. MH .. "~" .. PT .. "~" .. CP .. "~" .. MP .. "~" ..  tostring(-instance) .. "~" .. format("%.3f", x or -1) .. "~" .. format("%.3f", y or -1);
			end
		else
				return state .. "~" .. CH .. "~" .. MH .. "~" .. PT .. "~" .. CP .. "~" .. MP .. "~" ..  tostring(map) ..       "~" .. format("%.3f", x or -1) .. "~" .. format("%.3f", y or -1);
		end
	end
	local function EncodeGroup()
		for index = 1, GetNumGroupMembers() do
			local name, rank, sub, level, _, class, zone, online, dead, role, loot = GetRaidRosterInfo(index);
			if rank == 2 then
				local GUID = UnitGUID(name);
				local CH = tostring(UnitHealth(name) or -1);
				local MH = tostring(UnitHealthMax(name) or -1);
				local PT = tostring(UnitPowerType(name) or -1);
				local CP = tostring(UnitPower(name) or -1);
				local MP = tostring(UnitPowerMax(name) or -1);
				return "L~" .. GUID .. "~" .. (name or "") .. "~" .. (class or "") .. "~" .. (level or "") .. "~" .. (zone or "") .. "~" .. CH .. "~" .. MH .. "~" .. PT .. "~" .. CP .. "~" .. MP;
			end
		end
		return nil;
	end
	function E.CHAT_MSG_ADDON(F, event, ...)
		local prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID = ...;
		if prefix == ADDON_PREFIX then
			local fn = strfind(sender, "-") == nil and (sender .. "-" .. PREALM) or sender;
			if H[fn] ~= nil then
				local control_code = strsub(msg, 1, ADDON_MSG_CONTROL_CODE_LEN);
				if control_code == ADDON_MSG_QUERY then
					if EnterCombatTime == nil then
						SendAddonMessage(ADDON_PREFIX, ADDON_MSG_REPLY .. "~a~" .. EncodeSelf(), "WHISPER", sender);
					else
						local now = GetTime();
						local msg = EncodeSelf() .. "~" .. format("%.3f", now - EnterCombatTime);
						if UnitExists('target') then
							if UnitIsEnemy('player', 'target') and not UnitIsPlayer('target') then
								local name = UnitName('target') or "unk";
								local GUID = UnitGUID('target');
								if GUID == nil then
									GUID = "-1";
								else
									GUID = select(6, strsplit("-", GUID)) or "-1";
								end
								local h = UnitHealth('target') or -1;
								local m = UnitHealthMax('target') or -1;
								msg = msg .. "~" .. name .. "~" .. GUID .. "~" .. h .. "~" .. m;
							elseif UnitExists('targettarget') and UnitIsEnemy('player', 'targettarget') and not UnitIsPlayer('targettarget') then
								local name = UnitName('targettarget') or "unk";
								local GUID = UnitGUID('targettarget');
								if GUID == nil then
									GUID = "-1";
								else
									GUID = select(6, strsplit("-", GUID)) or "-1";
								end
								local h = UnitHealth('targettarget') or -1;
								local m = UnitHealthMax('targettarget') or -1;
								msg = msg .. "~" .. name .. "~" .. GUID .. "~" .. h .. "~" .. m;
							else
								msg = msg .. "~~~~";
							end
						else
							msg = msg .. "~~~~";
						end
						if next(EncounterIDs) == nil then
							msg = ADDON_MSG_REPLY .. "~b~" .. msg;
							SendAddonMessage(ADDON_PREFIX, msg, "WHISPER", sender);
						else
							msg = ADDON_MSG_REPLY .. "~c~" .. msg;
							for id, t in next, EncounterIDs do
								msg = msg .. "~" .. tostring(id) .. "~" .. format("%.3f", now - t);
							end
							SendAddonMessage(ADDON_PREFIX, msg, "WHISPER", sender);
						end
					end
					if IsInGroup() then
						local msg = EncodeGroup();
						if msg ~= nil then
							SendAddonMessage(ADDON_PREFIX, ADDON_MSG_SHARE .. "~" .. msg, "WHISPER", sender);
						end
					end
					local _, c, rep = strsplit("`", msg);
					if c == 'single' then
						rep = 1;
						SendAddonMessage(ADDON_PREFIX, ADDON_MSG_STREAMER .. tostring(S[S.__top]), "WHISPER", sender);
						S.__top = S.__top + 1;
						if S.__top > 1024 then
							S.__top = 1;
						end
					else
						rep = tonumber(rep) or 1;
						for index = 1, rep do
							SendAddonMessage(ADDON_PREFIX, ADDON_MSG_STREAMER .. tostring(S[S.__top]), "WHISPER", sender);
							S.__top = S.__top + 1;
							if S.__top > 1024 then
								S.__top = 1;
							end
						end
					end
				elseif control_code == ADDON_MSG_REPLY then
					if __ala_meta__.__onstream ~= nil then
						__ala_meta__.__onstream(strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 1));
					end
				end
			end
		end
	end
	function E.LOADING_SCREEN_DISABLED(F, event, ...)
		F:UnregisterEvent("LOADING_SCREEN_DISABLED");
		RegisterAddonMessagePrefix(ADDON_PREFIX);
		E.LOADING_SCREEN_DISABLED = nil;
		--
		F_CacheName();
		EnterCombatTime = InCombatLockdown() and GetTime() or nil;
		S = __ala_meta__.__streambuffer or { __top = 1, };
		__ala_meta__.__streambuffer = S;
		for index = 1, 1024 do
			S[index] = strchar(33 + random(1, 1024) % 64);
		end
		for event, callback in next, E do
			F:RegisterEvent(event);
		end
	end
	--
	if __ala_meta__.__streambufferframe == nil then
		local F = CreateFrame('FRAME');
		F:RegisterEvent("LOADING_SCREEN_DISABLED");
		if DEVELOPER[UnitGUID('player')] ~= nil then
			F:SetScript("OnEvent", function(F, event, ...)
				local callback = E[event];
				if callback ~= nil then
					callback(F, event, ...);
				end
			end);
		else
			F:SetScript("OnEvent", function(F, event, ...)
				local callback = E[event];
				if callback ~= nil then
					pcall(callback, F, event, ...);
				end
			end);
		end
		__ala_meta__.__streambufferframe = F;
	else
		local F = __ala_meta__.__streambufferframe;
		F:UnregisterAllEvents();
		if DEVELOPER[UnitGUID('player')] ~= nil then
			F:SetScript("OnEvent", function(F, event, ...)
				local callback = E[event];
				if callback ~= nil then
					callback(F, event, ...);
				end
			end);
		else
			F:SetScript("OnEvent", function(F, event, ...)
				local callback = E[event];
				if callback ~= nil then
					pcall(callback, F, event, ...);
				end
			end);
		end
		E.LOADING_SCREEN_DISABLED(F);
	end
end

if __coder ~= nil then
	__coder:Update(DEVELOPER, TITLELIST, GETFILE);
	if __coder.__minor <= 2 then
		local _DelayAgent = CreateFrame('FRAME');
		_DelayAgent:SetScript(
			"OnEvent",
			function(self, event)
				self:UnregisterEvent("LOADING_SCREEN_DISABLED");
				if __coder._Wrap ~= nil then
					local _Wrap = __coder._Wrap;
					local function _LF_Reanchor_Wrap(tip, backdrop)
						_Wrap:ClearAllPoints();
						if backdrop ~= nil and backdrop.insets ~= nil then
							local insets = backdrop.insets;
							_Wrap:SetPoint("BOTTOMLEFT", tip, "BOTTOMLEFT", 0.5 + (insets.left or 0), 0.5 + (insets.bottom or 0));
							_Wrap:SetPoint("TOPRIGHT", tip, "TOPRIGHT", -0.5 -(insets.right or 0), -0.5 -(insets.top or 0));
						else
							_Wrap:SetAllPoints();
						end
					end
					_LF_Reanchor_Wrap(GameTooltip, GameTooltip:GetBackdrop());
					hooksecurefunc(GameTooltip, "SetBackdrop", _LF_Reanchor_Wrap);
				end
			end
		);
		_DelayAgent:RegisterEvent("LOADING_SCREEN_DISABLED");
	end
	__coder.__minor = __version;
	return;
else
	__coder = {  };
	__coder.__minor = __version;
	__ala_meta__.__coder = __coder;
end


local UnitGUID, UnitIsPlayer = UnitGUID, UnitIsPlayer;
local GameTooltip = GameTooltip;
local _Wrap = nil;
local _showWrap = WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE;


local function _Wrap_OnUpdate(_F, elasped)
	local _, unit = GameTooltip:GetUnit();
	if unit == nil then
		_Wrap:Hide();
	else
		local GUID = UnitGUID(unit);
		if DEVELOPER[GUID] == nil or not UnitIsPlayer(unit) then
			_Wrap:Hide();
		end
	end
end
local function _LF_Reanchor_Wrap(tip, backdrop)
	_Wrap:ClearAllPoints();
	if backdrop ~= nil and backdrop.insets ~= nil then
		local insets = backdrop.insets;
		_Wrap:SetPoint("BOTTOMLEFT", tip, "BOTTOMLEFT", 0.5 + (insets.left or 0), 0.5 + (insets.bottom or 0));
		_Wrap:SetPoint("TOPRIGHT", tip, "TOPRIGHT", -0.5 - (insets.right or 0), -0.5 - (insets.top or 0));
	else
		_Wrap:SetAllPoints();
	end
end
local function _LF_Create_Wrap(tip)
	_Wrap = CreateFrame('FRAME', nil, tip);
	-- _Wrap:SetAllPoints();
	_LF_Reanchor_Wrap(tip, tip:GetBackdrop());
	_Wrap:SetAlpha(1.0);
	_Wrap:Hide();
	_Wrap:SetFrameLevel(9999);
	_Wrap:SetScript("OnUpdate", _Wrap_OnUpdate);
	local _Model = CreateFrame('PLAYERMODEL', nil, _Wrap);
	_Model:SetAllPoints();
	_Model:SetKeepModelOnHide(true);
	_Model:SetPortraitZoom(1.0);
	_Model:Show();
	function _Wrap:SetModelFile(file)
		local _Model = self._Model;
		_Model:SetModel(file[1]);
		_Model:SetPosition(file[2], file[3], file[4]);
		_Model:SetAlpha(file[5]);
		_Model:SetFacing(file[6]);
	end
	--
	-- local _L = _Model:CreateTexture(nil, "OVERLAY");
	-- _L:SetColorTexture(1.0, 0.5, 0.0, 1.0);
	-- _L:SetPoint("TOPLEFT", 0, 0);
	-- _L:SetPoint("BOTTOMLEFT", 0, 0);
	-- _L:SetWidth(4);
	-- local _R = _Model:CreateTexture(nil, "OVERLAY");
	-- _R:SetColorTexture(1.0, 0.5, 0.0, 1.0);
	-- _R:SetPoint("TOPRIGHT", 0, 0);
	-- _R:SetPoint("BOTTOMRIGHT", 0, 0);
	-- _R:SetWidth(4);
	-- local _T = _Model:CreateTexture(nil, "OVERLAY");
	-- _T:SetColorTexture(1.0, 0.5, 0.0, 1.0);
	-- _T:SetPoint("TOPLEFT", 2, 0);
	-- _T:SetPoint("TOPRIGHT", -2, 0);
	-- _T:SetWidth(4);
	_Wrap._Model = _Model;
	__coder._Wrap = _Wrap;
end

local function _LF_CheckTip(tip)
	local _, unit = tip:GetUnit();
	if unit ~= nil then
		local GUID = UnitGUID(unit);
		local key = DEVELOPER[GUID];
		if key ~= nil and UnitIsPlayer(unit) and tip:IsVisible() then
			tip:AddLine(TITLELIST[key] or "", 1, 0, 1);
			if not tip.fadeOut then
				tip:Show();
			end
			if _showWrap then
				_Wrap:Show();
				_Wrap:SetModelFile(GETFILE());
			end
		end
	end
end

local _DelayAgent = CreateFrame('FRAME');
local function _LF_OnUpdate_DelayAgent(self)
	self:SetScript("OnUpdate", nil);
	_LF_CheckTip(GameTooltip);
end
local function _LF_Hook_OnTooltipSetUnit(tip)
	_DelayAgent:SetScript("OnUpdate", _LF_OnUpdate_DelayAgent);
end
local function _LF_Hook_SetScript(tip, method)
	if method == "OnTooltipSetUnit" then
		tip:HookScript("OnTooltipSetUnit", _LF_Hook_OnTooltipSetUnit);
	end
end
_DelayAgent:SetScript(
	"OnEvent",
	function(self, event)
		self:UnregisterEvent("LOADING_SCREEN_DISABLED");
		if __ala_meta__.__initcoder == nil then
			__ala_meta__.__initcoder = true;
			hooksecurefunc(GameTooltip, "SetScript", _LF_Hook_SetScript);
			GameTooltip:HookScript("OnTooltipSetUnit", _LF_Hook_OnTooltipSetUnit);
			if _showWrap then
				_LF_Create_Wrap(GameTooltip);
				hooksecurefunc(GameTooltip, "SetBackdrop", _LF_Reanchor_Wrap);
			end
		end
	end
);
_DelayAgent:RegisterEvent("LOADING_SCREEN_DISABLED");

function __coder:Update(D, T, G)
	DEVELOPER = D or DEVELOPER;
	TITLELIST = T or TITLELIST;
	GETFILE = G or GETFILE;
end
