--[[--
	alex/ALA	Please Keep WOW Addon open-source & Reduce barriers for others.
	复用代码请在显著位置标注来源【ALA@网易有爱】
	喜欢加密和乱码的亲，请ALT+F4
--]]--
local ADDON, NS = ...;

local _G = _G;
do
	if NS.__fenv == nil then
		NS.__fenv = setmetatable({  },
				{
					__index = _G,
					__newindex = function(t, key, value)
						rawset(t, key, value);
						print("ain assign global", key, value);
						return value;
					end,
				}
			);
	end
	setfenv(1, NS.__fenv);
end

local time = time;
local wipe, ipairs = wipe, ipairs;
local max, floor, abs = max, floor, abs;
local strupper, format, gsub, strlower, strfind, strsplit = strupper, format, gsub, strlower, strfind, strsplit;

local function _noop_()
	return true;
end

local func = {  };
local var = {
};
local cache = {  };
local cache2 = {  };
local global_honor_sv = nil;
local honor_sv = nil;

local L = {  };
do
	if GetLocale() == "zhCN" or GetLocale == "zhTW" then
		L["FORMAT_NAME_HONOR"] = "击杀[%s], 获得荣誉\124cff00ff00%d\124r";
		L["FORMAT_NAME_RANK_HONOR"] = "击杀[%s]:%s, 获得荣誉\124cff00ff00%d\124r";
		L["FORMAT_HONOR_GAIN"] = "\124cffffffff荣誉(%.0f%%):\124r \124cff00ff00%.1f\124r";
		L["YESTERDAY_HONOR"] = "昨日荣誉: ";
		L["RANK_IN_NUMBER"] = "显示数字PVP军衔等级";
	else
		L["FORMAT_NAME_HONOR"] = "Kill[%s], honor gain\124cff00ff00%d\124r";
		L["FORMAT_NAME_RANK_HONOR"] = "Kill[%s]:%s, honor gain\124cff00ff00%d\124r";
		L["FORMAT_HONOR_GAIN"] = "\124cffffffffHonor(%.0f%%):\124r \124cff00ff00%.1f\124r";
		L["YESTERDAY_HONOR"] = "Honor gained yesterday: ";
		L["RANK_IN_NUMBER"] = "Show rank number instead of icon";
	end
end

local _EventHandler = CreateFrame("FRAME");

local temp_timer = 0;
local function wipe_cache(_, elasped)
	temp_timer = temp_timer + elasped;
	if temp_timer > 10 then
		local T = time() - 10;
		local empty = true;
		for lineID, t in next, cache2 do
			if t < T then
				cache[lineID] = nil;
				cache2[lineID] = nil;
			end
			empty = false;
		end
		if empty then
			_EventHandler:SetScript("OnUpdate", nil);
			temp_timer = 0;
		end
	end
	-- wipe(cache);
	-- _EventHandler:SetScript("OnUpdate", nil);
end
local function wipe_on_next_tick()
	_EventHandler:SetScript("OnUpdate", wipe_cache);
end

local DECAY_RATE = 0.1;
local HOOK = false;
local GUID = UnitGUID('player');
local REALM = GetRealmName();
local FACTION = UnitFactionGroup('player') == 'Alliance' and 1 or 0;
local ENEMY = abs(FACTION - 1);
local RANK_TO_INDEX = {};
local INDEX_TO_RANK = {};
for index = 5, 18 do
	local rank = GetPVPRankInfo(index, ENEMY);
	RANK_TO_INDEX[rank] = index;
	INDEX_TO_RANK[index] = rank;
	local rank = GetPVPRankInfo(index, abs(ENEMY - 1));
	RANK_TO_INDEX[rank] = index;
end
local STR_HONOR = {
	"^" .. gsub(gsub(COMBATLOG_HONORAWARD, "%^%$[%.%+%-%*%?%[%]%(%)]", "%%%1"), "%%d", "(%%d+)"),
	"^" .. gsub(gsub(INSPECT_HONORABLE_KILLS, "[%^%$%.%+%-%*%?%[%]%(%)]", "%%%1"), "%%d", "(%%d+)"),
	nil,
};
local STR_NAME_HONOR = {
	--	%s死亡（荣誉击杀）。你获得了%d点荣誉。
	"^" .. gsub(gsub(gsub(gsub(COMBATLOG_HONORGAIN_NO_RANK, "[%^%$%.%+%-%*%?%[%]%(%)]", "%%%1"), "^%%s", "(.+)"), "%%d", "(%%d+)"), "%%s", ".+"),
	--	%s死亡（荣誉击杀）。你获得了%d点荣誉。 (额外加成%s%s）
	"^" .. gsub(gsub(gsub(gsub(COMBATLOG_HONORGAIN_NO_RANK_EXHAUSTION1, "[%^%$%.%+%-%*%?%[%]%(%)]", "%%%1"), "^%%s", "(.+)"), "%%d", "(%%d+)"), "%%s", ".+"),
	nil,
};
local STR_NAME_RANK_HONOR = {
	--	%s死亡，荣誉击杀军衔：%s（贡献点数预估：%d）
	"^" .. gsub(gsub(gsub(gsub(COMBATLOG_HONORGAIN, "[%^%$%.%+%-%*%?%[%]%(%)]", "%%%1"), "%%s", "(.+)"), "%%d", "(%%d+)"), "%%s", ".+"),
	--	%s死亡（荣誉击杀：%s）。你获得了%d点荣誉。 (额外加成%s%s）
	"^" .. gsub(gsub(gsub(gsub(COMBATLOG_HONORGAIN_EXHAUSTION1, "[%^%$%.%+%-%*%?%[%]%(%)]", "%%%1"), "%%s", "(.+)"), "%%d", "(%%d+)"), "%%s", ".+"),
	nil,
};

do
	-- for _, v in next, STR_HONOR do print("STR_HONOR", v); end
	-- for _, v in ipairs(STR_NAME_HONOR) do print("STR_NAME_HONOR", v); end
	-- for _, v in ipairs(STR_NAME_RANK_HONOR) do print("STR_NAME_RANK_HONOR", v); end
end

function func.record_honor(honor)
	honor_sv["##SUM"] = honor_sv["##SUM"] + honor;
end
function func.honor_decay(name, honor)
	local rate = 1.0;
	if honor_sv[name] then
		rate = max(1 - DECAY_RATE * honor_sv[name], 0.0);
		honor = honor * rate;
		honor_sv[name] = honor_sv[name] + 1;
	else
		honor_sv[name] = 1;
	end
	func.record_honor(honor);
	return honor, rate;
end
function func.bg_get_info(_name, _rank)
	for index = 1, GetNumBattlefieldScores() do
		local name, killingBlows, honorableKills, deaths, honorGained, faction, rank, race, class, classToken = GetBattlefieldScore(index);
		if faction == ENEMY and name then
			local n, r = strsplit("-", name);
			if rank == 0 then
				rank = 5;
			end
			if _name == n and _rank == rank then
				if r == REALM then
					return n, classToken;
				else
					return name, classToken;
				end
			end
		end
	end
	return _name, nil;
end
function func.process_honor(honor)
	func.record_honor(honor);
	return honor, 1.0;
end
function func.process_name_honor(name, honor)
	if UnitInBattleground('player') then
		local _name, _class = func.bg_get_info(name, 0);
		local _honor, _rate = func.honor_decay(_name, honor);
		return _name, _class and strupper(_class), _honor, _rate;
	else
		local _honor, _rate = func.honor_decay(name, honor);
		return name, nil, _honor, _rate;
	end
end
function func.process_name_rank_honor(name, rank, honor)
	if UnitInBattleground('player') then
		local _name, _class = func.bg_get_info(name, RANK_TO_INDEX[rank]);
		local _honor, _rate = func.honor_decay(_name, honor);
		return _name, _class and strupper(_class), _honor, _rate;
	else
		local _honor, _rate = func.honor_decay(name, honor);
		return name, nil, _honor, _rate;
	end
end

local function record_msg(msg, lineID)
	cache[lineID] = msg;
	cache2[lineID] = time();
	wipe_on_next_tick();
end
local function build_msg(lineID, msg, honor, rate, old, new, class, rankText)
	if global_honor_sv.honorKillColorName then
		if class then
			local t = RAID_CLASS_COLORS[class];
			if t then
				new = format("\124cff%.2x%.2x%.2x%s\124r", t.r * 255, t.g * 255, t.b * 255, new);
			end
		end
		msg = gsub(msg, old, new);
	end
	if rankText and RANK_TO_INDEX[rankText] then
		local newRankText = "\124cffffffffR" .. (RANK_TO_INDEX[rankText] - 4) .. "\124r " .. rankText;
		msg = gsub(msg, rankText, newRankText);
	end
	if global_honor_sv.honorKillDetail then
		-- msg = msg .. "\124cffffffff获得荣誉(" .. (rate * 100) .. "%):\124r \124cff00ff00" .. honor .. "\124r";
		msg = msg .. format(L["FORMAT_HONOR_GAIN"], rate * 100, honor);
	end
	record_msg(msg, lineID);
	return msg;
end
local function build_msg_format(lineID, _format, _name, _class, _rank, _honor)
	if _class then
		local t = RAID_CLASS_COLORS[_class];
		if t then
			_name = format("\124cff%.2x%.2x%.2x%s\124r", t.r * 255, t.g * 255, t.b * 255, _name);
		end
	end
	local msg = nil;
	if _rank then
		msg = format(_format, _name, _rank, _honor);
	else
		msg = format(_format, _name, _honor);
	end
	record_msg(msg, lineID);
	return msg;
end

function func.CHAT_MSG_COMBAT_HONOR_GAIN(msg, _, _, _, _, _, _, _, _, _, lineID)
	if cache[lineID] then
		return cache[lineID];
	end
	local honor, rate = nil, nil;
	for _, v in ipairs(STR_HONOR) do
		local _, _, honor = strfind(msg, v);
		if honor then
			-- print("STR_HONOR", honor);
			local _honor, _rate = func.process_honor(honor);
			-- return build_msg(lineID, msg, _honor, _rate, nil);
			record_msg(msg, lineID);
			return msg;
		end
	end
	for _, v in ipairs(STR_NAME_HONOR) do
		local _, _, name, honor = strfind(msg, v);
		if name and honor then
			-- print("STR_NAME_HONOR", name, honor);
			local _name, _class, _honor, _rate = func.process_name_honor(name, honor);
			return build_msg(lineID, msg, _honor, _rate, name, _name, _class);
			-- return build_msg_format(lineID, L["FORMAT_NAME_HONOR"], _name, _class, nil, _honor);
		end
	end
	for _, v in ipairs(STR_NAME_RANK_HONOR) do
		local _, _, name, rank, honor = strfind(msg, v);
		if name and rank and honor then
			-- print("STR_NAME_RANK_HONOR", name, rank, honor);
			local _name, _class, _honor, _rate = func.process_name_rank_honor(name, rank, honor);
			return build_msg(lineID, msg, _honor, _rate, name, _name, _class, rank);
			-- return build_msg_format(lineID, L["FORMAT_NAME_RANK_HONOR"], _name, _class, rank, _honor);
		end
	end
	record_msg(msg, lineID);
	return msg;
end

local function chat_filter(self, event, msg, ...)
	local msg = func.CHAT_MSG_COMBAT_HONOR_GAIN(msg, ...);
	return false, msg, ...;
end

function func.UPDATE_BATTLEFIELD_STATUS(...)
	-- print("UPDATE_BATTLEFIELD_STATUS", ...);
end
function func.UPDATE_BATTLEFIELD_SCORE(...)
	-- print("UPDATE_BATTLEFIELD_SCORE", ...);
end

function func.ADDON_LOADED(addon)
	if strlower(addon) == 'honorspy' then
		_EventHandler:UnregisterEvent("ADDON_LOADED");
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_COMBAT_HONOR_GAIN", chat_filter);
		HOOK = false;
	end
end
local function set_day(honor_sv, y, DAY)
	wipe(honor_sv);
	honor_sv["#YSUM"] = y;
	honor_sv["##SUM"] = 0;
	honor_sv["##DAY"] = DAY;
end

local function hook_HonorFrame()
	if HOOK then
		-- HonorFrameCurrentHKValue:SetText(GetPVPSessionStats() .. " \124cffffffff(今日荣誉 \124cff00ff00" .. honor_sv["##SUM"] .. "\124r\124cffffffff)\124r");
		HonorFrameCurrentSessionHonor:SetText(honor_sv["##SUM"]);
		local rankName, rankNumber = GetPVPRankInfo(UnitPVPRank("player"));
		HonorFrameCurrentPVPRank:SetText("(" .. RANK .. " " .. rankNumber .. ")" .. format(" \124cffffffff进度%0.2f%%\124r", GetPVPRankProgress() * 100));
	end
end
local function hook_Honor()
	if not alaMiscSV.honor_sv[GUID] then
		honor_sv = {
			["##SUM"] = 0,
			["##DAY"] = floor((time() + 3600) / 86400),
		};
		alaMiscSV.honor_sv[GUID] = honor_sv;
	else
		honor_sv = alaMiscSV.honor_sv[GUID];
		local DAY = floor((time() + 3600) / 86400);
		if honor_sv["##DAY"] < DAY then
			local y = honor_sv["##SUM"];
			set_day(honor_sv, (DAY - honor_sv["##DAY"] == 1) and y or 0, DAY);
		end
	end
	local time_remain = 86400 - ((time() + 3600) % 86400);
	if time_remain > 0 then
		C_Timer.After(time_remain + 1, function()
			local y = honor_sv["##SUM"];
			set_day(honor_sv, y, floor((time() + 3600) / 86400));
		end);
	end
	if not IsAddOnLoaded('HonorSpy') then
		ChatFrame_AddMessageEventFilter("CHAT_MSG_COMBAT_HONOR_GAIN", chat_filter);
		_EventHandler:RegisterEvent("ADDON_LOADED");
		HOOK = true;
	end
	HonorFrame:CreateFontString("HonorFrameCurrentSessionHonor", HonorFrame, "GameFontNormal");
	HonorFrameCurrentSessionHonor:SetPoint("BOTTOMRIGHT", HonorFrameCurrentHKValue, "TOPRIGHT", 0, - 1);
	HonorFrameCurrentSessionHonor:SetVertexColor(0.0, 1.0, 0.0, 1.0);
	hooksecurefunc("HonorFrame_Update", hook_HonorFrame);
	hooksecurefunc("HonorFrame_UpdateShown", hook_HonorFrame);
	if honor_sv["#YSUM"] then
		-- print(L["YESTERDAY_HONOR"], "\124cff00ff00" .. honor_sv["#YSUM"] .. "\124r");
	end
end
----------------

local GetNumBattlefieldScores = GetNumBattlefieldScores;
local GetBattlefieldScore = GetBattlefieldScore;
local RAID_CLASS_COLORS = RAID_CLASS_COLORS;

local MAX_SCORE_BUTTONS = 22;
local WorldStateScoreScrollFrameScrollBar = WorldStateScoreScrollFrameScrollBar;

local lines = {  };
local titleRegion = nil;
local indicator = nil;
local rankTextCheck = nil;

local function toggle_rankText(on)
	if on then
		for i = 1, MAX_SCORE_BUTTONS do
			local line = lines[i];
			line.rankButton:SetAlpha(0.0);
			line.rankText:SetAlpha(1.0);
		end
	else
		for i = 1, MAX_SCORE_BUTTONS do
			local line = lines[i];
			line.rankButton:SetAlpha(1.0);
			line.rankText:SetAlpha(0.0);
		end
	end
end
local function hook_WorldStateScoreFrame()
	for i = 1, MAX_SCORE_BUTTONS do
		local line = _G["WorldStateScoreButton" .. i];
		local rankText = line:CreateFontString(nil, "OVERLAY", "GameFontNormal");
		rankText:SetPoint("RIGHT", line.rankButton, - 1, 0);
		rankText:SetVertexColor(1.0, 1.0, 1.0, 1.0);
		line.rankText = rankText;
		lines[i] = line;
	end

	WorldStateScoreFrame:SetMovable(true);

	titleRegion = CreateFrame("FRAME", nil, WorldStateScoreFrame);
	titleRegion:SetPoint("TOP", 0, -14);
	titleRegion:SetPoint("LEFT", 0);
	titleRegion:SetPoint("RIGHT", WorldStateScoreFrameCloseButton, "LEFT");
	titleRegion:SetHeight(24);
	-- titleRegion:SetAlpha(1.0);
	titleRegion:SetMovable(true);
	titleRegion:EnableMouse(true);
	titleRegion:Show();
	titleRegion:RegisterForDrag("LeftButton")
	titleRegion:SetScript("OnDragStart", function()
		WorldStateScoreFrame:StartMoving();
	end);
	titleRegion:SetScript("OnDragStop", function()
		WorldStateScoreFrame:StopMovingOrSizing();
	end);

	indicator = WorldStateScoreFrame:CreateTexture(nil, "OVERLAY");
	indicator:SetSize(32, 16);
	indicator:SetTexture("interface\\vehicles\\arrow");
	indicator:SetBlendMode("ADD");
	indicator:Hide();

	rankTextCheck = CreateFrame("CHECKBUTTON", nil, titleRegion, "OptionsBaseCheckButtonTemplate");
	rankTextCheck:SetHitRectInsets(0, 0, 0, 0);
	rankTextCheck:GetNormalTexture():SetVertexColor(1.0, 0.5, 0.0, 1.0);
	rankTextCheck:GetPushedTexture():SetVertexColor(1.0, 0.5, 0.0, 1.0);
	rankTextCheck:GetCheckedTexture():SetVertexColor(1.0, 0.5, 0.0, 1.0);
	rankTextCheck:ClearAllPoints();
	rankTextCheck:SetPoint("TOPLEFT", titleRegion, 14, 0);
	rankTextCheck:SetScript("OnClick", function()
		global_honor_sv.rankText = rankTextCheck:GetChecked();
		toggle_rankText(global_honor_sv.rankText);
	end);
	rankTextCheck:SetChecked(global_honor_sv.rankText);
	local label = rankTextCheck:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
	label:SetText(L["RANK_IN_NUMBER"]);
	label:SetPoint("LEFT", rankTextCheck, "RIGHT", 2, 0);
	toggle_rankText(global_honor_sv.rankText);

	hooksecurefunc("WorldStateScoreFrame_Update", function()
		local ofs = WorldStateScoreScrollFrameScrollBar:GetValue() / WorldStateScoreScrollFrameScrollBar:GetValueStep();
		local num = GetNumBattlefieldScores();
		local player_shown = false;
		for index = 1, min(MAX_SCORE_BUTTONS, num - ofs) do
			local name, killingBlows, honorableKills, deaths, honorGained, faction, rank, race, locale_class, class
					= GetBattlefieldScore(index + ofs);
			local line = lines[index];
			local color = RAID_CLASS_COLORS[class];
			if color then
				line.name.text:SetVertexColor(color.r, color.g, color.b, 1.0);
			else
				line.name.text:SetVertexColor(1.0, 0.82, 0.0, 1.0);
			end
			if name == UnitName("player") then
				player_shown = true;
				indicator:SetPoint("RIGHT", line, "LEFT", - 4, 0);
			end
			if rank >= 4 and rank <= 18 then
				line.rankText:SetText(rank - 4);
			else
				line.rankText:SetText(0);
			end
		end
		if player_shown then
			indicator:Show();
		else
			indicator:Hide();
		end
	end);
end
------------------------------------------------------------------------

function func.PLAYER_ENTERING_WORLD()
	_EventHandler:UnregisterEvent("PLAYER_ENTERING_WORLD");
	alaMiscSV.honor_sv = alaMiscSV.honor_sv or { rankText = false, honorKillColorName = true, honorKillDetail = true, };
	global_honor_sv = alaMiscSV.honor_sv;
	hook_Honor();
	hook_WorldStateScoreFrame();
end

local function OnEvent(self, event, ...)
	func[event](...);
end


_EventHandler:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN");
_EventHandler:RegisterEvent("PLAYER_ENTERING_WORLD");
_EventHandler:RegisterEvent("UPDATE_BATTLEFIELD_STATUS");
_EventHandler:RegisterEvent("UPDATE_BATTLEFIELD_SCORE");
_EventHandler:SetScript("OnEvent", OnEvent);

