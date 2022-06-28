--[[--
	ALA@163UI
	All Rights Reseverd
--]]--
local ADDON, NS = ...;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
local __ns = {  };
NS.InstanceLockeddownTimer = __ns;
__ala_meta__.InstanceLockeddownTimer = __ns;

local _G = _G;
do
	if __ns.__fenv == nil then
		__ns.__fenv = setmetatable({  },
				{
					__index = _G,
					__newindex = function(t, key, value)
						rawset(t, key, value);
						print("ilt assign global", key, value);
						return value;
					end,
				}
			);
	end
	setfenv(1, __ns.__fenv);
end
local __instlib = __ala_meta__.__instlib;

-->			upvalue
	local setmetatable, tinsert, tremove, unpack, next = setmetatable, tinsert, tremove, unpack, next;
	local type, tostring = type, tostring;
	local strsplit, strsub, strfind, format = strsplit, strsub, strfind, format;
	local date = date;
	local _ = nil;
-->			global variables
	local DAY_LIMIT = 32;
	local BIG_NUMBER = 4294967295;
	local ONE_HOUR = 3600;
	local ONE_DAY = 86400;
--

local IsClassic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC;
local SET, VAR = nil, nil;

local L = {  };
do
	if GetLocale() == 'zhCN' or GetLocale() == 'zhTW' then
		L["VARIABLES_ERROR"] = "\124cff00ff00InstanceLockeddownTimer\124r 配置文件错误";
		L["INSTANCE_CHANCE"] = "副本次数";
		L["CURRENT"] = "当前";
		L["AVAILABLE"] = "可用";
		L["AVAILABLE_GLOBAL"] = "可重置";
		L["LOCK"] = "锁定";
		L["CLOSE"] = "关闭";
		L["RESETINSTANCE"] = "重置副本";
		L["TIP_GLOBAL_HEADER"] = "\124cffffffff24小时副本次数\124r";
		L["TIP_INSTANCE"] = "\124cffffffff副本";
		L["TIP_GLOBAL_FORMAT_AVAILABLE"] = "\124cff00ff00可用: %d\124r";
		L["TIP_GLOBAL_FORMAT_LOCKED"] = "\124cffff0000锁定: %d\124r";
		L["TIP_GLOBAL_ALT"] = "按Alt显示完整细节";
		L["TIP_GLOBAL_SHIFT"] = "按Shift显示详情";

		L["NOTICE_FOR_24HRS"] = "\124cffffffff40人团队副本不受30次和5次限制\124r\n\124cffffffff20人团队副本受5次和32次限制，但其进度不入32次内\124r\n\124cffffffff每个副本每天有个不稳定的额外10-20次限制\124r";
		L["RESET"] = "%s 已被重置，请重新进入副本";
	else
		L["VARIABLES_ERROR"] = "\124cff00ff00InstanceLockeddownTimer\124r VARIABLES_ERROR";
		L["INSTANCE_CHANCE"] = "Inst lock ";
		L["CURRENT"] = "CUR";
		L["AVAILABLE"] = "AVL";
		L["AVAILABLE_GLOBAL"] = "AVL";
		L["LOCK"] = "LOCK";
		L["CLOSE"] = "CLOSE";
		L["RESETINSTANCE"] = "Reset instance";
		L["TIP_GLOBAL_HEADER"] = "\124cffffffffLimit in 24hrs\124r";
		L["TIP_INSTANCE"] = "\124cffffffffInst ";
		L["TIP_GLOBAL_FORMAT_AVAILABLE"] = "\124cff00ff00AVL: %d\124r";
		L["TIP_GLOBAL_FORMAT_LOCKED"] = "\124cffff0000LOCKED: %d\124r";
		L["TIP_GLOBAL_ALT"] = "Holding Shift to show all details";
		L["TIP_GLOBAL_SHIFT"] = "Holding Shift to show info";

		L["NOTICE_FOR_24HRS"] = "\124cffffffff40ppl-raid ignore all limits\124r\n\124cffffffff20ppl-raid is limited by 1hr and 24hrs. \124r\n\124cffffffffEach of the other instances has a unique  10-20 times limitition of day(not sure).\124r";
		L["RESET"] = "%s is reseted. Reenter the instance.";
	end
end

local function _noop_()
	return true;
end
local function _log_(...)
	-- tinsert(logfile, { date('\124cff00ff00%H:%M:%S\124r'), ... });
end
local function Info_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOP");
	GameTooltip:SetText(self.info);
	GameTooltip:Show();
end
local function Info_OnLeave(self)
	if GameTooltip:IsOwned(self) then
		GameTooltip:Hide();
	end
end

local _EventHandler = CreateFrame('FRAME');
-->		--	EventHandler
	local function _EventHandler_OnEvent(self, event, ...)
		return __ns[event](...);
	end
	function _EventHandler:FireEvent(event, ...)
		local func = __ns[event];
		if func then
			return func(...);
		end
	end
	function _EventHandler:RegEvent(event)
		__ns[event] = __ns[event] or _noop_;
		self:RegisterEvent(event);
		self:SetScript('OnEvent', _EventHandler_OnEvent);
	end
	function _EventHandler:UnregEvent(event)
		self:UnregisterEvent(event);
	end
-->

local function safe_call(func, ...)
	local success, result = xpcall(func,
		function(msg)
			geterrorhandler()(msg);
		end,
		...
	);
	if success then
		return true, result;
	else
		return false;
	end
end

-->		Notes
	--[[	--	reduced logfile
		{ "09:47:55", "PLAYER_STARTED_MOVING", },
		{ "09:47:55", "CURSOR_UPDATE", },
		{ "09:47:55", "LOADING_SCREEN_ENABLED", },
		{ "09:47:55", "CONSOLE_MESSAGE", "World transfer pending...", 0, },
		{ "09:47:55", "PLAYER_STOPPED_MOVING", },
		{ "09:47:56", "CONSOLE_MESSAGE", "Got new connection 3", 0, },
		{ "09:47:57", "INSTANCE_LOCK_STOP", },
		{ "09:47:57", "PLAYER_LEAVING_WORLD", },
		{ "09:47:57", "ACTIONBAR_UPDATE_COOLDOWN", },
		{ "09:47:57", "SPELL_UPDATE_CHARGES", },
		{ "09:47:57", "SPELL_UPDATE_COOLDOWN", },
		{ "09:47:58", "INSTANCE_GROUP_SIZE_CHANGED", },
		{ "09:47:58", "CONSOLE_MESSAGE", "Weather changed to 0, intensity 0.000000\n", 0, },
		{ "09:47:58", "TABARD_CANSAVE_CHANGED", },
		{ "09:47:58", "PLAYER_GUILD_UPDATE", "player", },
		{ "09:47:58", "UPDATE_INVENTORY_DURABILITY", },
		{ "09:47:58", "PET_BAR_UPDATE", },
		{ "09:47:58", "UPDATE_FACTION", },
		{ "09:47:58", "UPDATE_FACTION", },
		{ "09:47:58", "SKILL_LINES_CHANGED", },
		{ "09:47:58", "INITIAL_CLUBS_LOADED", },
		{ "09:47:58", "UPDATE_ALL_UI_WIDGETS", },
		{ "09:47:58", "W", true, "party", },
		{ "09:47:58", "W", "暴风城监狱", "party", 1, "普通", 5, 0, false, 34, 5, },
		{ "09:47:58", "W", true, "party", },
		{ "09:47:58", "W", "暴风城监狱", "party", 1, "普通", 5, 0, false, 34, 5, },
		{ "09:47:58", "CORPSE_POSITION_UPDATE", },
		{ "09:47:58", "CORPSE_POSITION_UPDATE", },
		{ "09:47:58", "PLAYER_ALIVE", },
		{ "09:47:58", "PVP_TIMER_UPDATE", "player", },
		{ "09:47:58", "COMMENTATOR_ENTER_WORLD", },
		{ "09:47:59", "L", true, "party", },
		{ "09:47:59", "L", "暴风城监狱", "party", 1, "普通", 5, 0, false, 34, 5, },
		{ "09:47:59", "L", true, "party", },
		{ "09:47:59", "L", "暴风城监狱", "party", 1, "普通", 5, 0, false, 34, 5, },
		{ "09:47:59", "ACTIONBAR_UPDATE_COOLDOWN", },
		{ "09:47:59", "MINIMAP_UPDATE_ZOOM", },
		{ "09:47:59", "QUEST_LOG_UPDATE", },
		{ "09:47:59", "SPELL_UPDATE_CHARGES", },
		{ "09:47:59", "SPELL_UPDATE_COOLDOWN", },
		{ "09:47:59", "SPELLS_CHANGED", },
		{ "09:47:59", "UNIT_MODEL_CHANGED", "player", },
		{ "09:47:59", "UNIT_PORTRAIT_UPDATE", "player", },
		{ "09:48:00", "ZONE_CHANGED_NEW_AREA", },
		{ "09:48:00", "UPDATE_ALL_UI_WIDGETS", },
		{ "09:48:00", "UNIT_FACTION", "player", },
		{ "09:48:00", "UPDATE_PENDING_MAIL", },
		{ "09:48:00", "UPDATE_INSTANCE_INFO", },
		{ "09:48:00", "GUILD_ROSTER_UPDATE", false, },
		{ "09:48:00", "S", "4894", "25735", "迪菲亚狱友", "00018D0ECE", 1594691279.855, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00018D0ECE", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00018D0ECE", "迪菲亚狱友", 2632, 0, },
		{ "09:48:00", "S", "4894", "25735", "迪菲亚狱友", "00018D0ECE", 1594691279.855, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00018D0ECE", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00018D0ECE", "迪菲亚狱友", 2632, 0, },
		{ "09:48:00", "S", "4894", "25735", "迪菲亚狱友", "00018D0ECE", 1594691279.855, "SPELL_CAST_SUCCESS", false, "Creature-0-4894-34-25735-1708-00018D0ECE", "迪菲亚狱友", 2632, 0, "", nil, -2147483648, -2147483648, },
		{ "09:48:00", "S", "4894", "25735", "迪菲亚狱友", "00018D0ECE", 1594691279.855, "SPELL_CAST_SUCCESS", false, "Creature-0-4894-34-25735-1708-00018D0ECE", "迪菲亚狱友", 2632, 0, "", nil, -2147483648, -2147483648, },
		{ "09:48:00", "ACTIONBAR_UPDATE_COOLDOWN", },
		{ "09:48:00", "AREA_POIS_UPDATED", },
		{ "09:48:00", "QUEST_LOG_UPDATE", },
		{ "09:48:00", "SPELL_UPDATE_CHARGES", },
		{ "09:48:00", "SPELL_UPDATE_COOLDOWN", },
		{ "09:48:00", "SPELLS_CHANGED", },
		{ "09:48:00", "UNIT_AURA", "player", },
		{ "09:48:00", "UNIT_MODEL_CHANGED", "player", },
		{ "09:48:00", "UNIT_PORTRAIT_UPDATE", "player", },
		{ "09:48:00", "REQUEST_CEMETERY_LIST_RESPONSE", false, },
		{ "09:48:00", "BN_INFO_CHANGED", },
		{ "09:48:00", "BN_FRIEND_INFO_CHANGED", },
		{ "09:48:00", "BN_INFO_CHANGED", },
		{ "09:48:00", "BN_FRIEND_INFO_CHANGED", },
		{ "09:48:00", "UNIT_PORTRAIT_UPDATE", "player", },
		{ "09:48:00", "UNIT_MODEL_CHANGED", "player", },
		{ "09:48:00", "PORTRAITS_UPDATED", },
		{ "09:48:00", "GUILD_ROSTER_UPDATE", false, },
		{ "09:48:00", "GUILD_RANKS_UPDATE", },
		{ "09:48:04", "S", "4894", "25735", "迪菲亚狱友", "00010D0ED1", 1594691284.219, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00010D0ED1", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00010D0ED1", "迪菲亚狱友", 2632, 0, },
		{ "09:48:04", "S", "4894", "25735", "迪菲亚狱友", "00010D0ED1", 1594691284.219, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00010D0ED1", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00010D0ED1", "迪菲亚狱友", 2632, 0, },
		{ "09:48:04", "S", "4894", "25735", "迪菲亚狱友", "00010D0ED1", 1594691284.219, "SPELL_CAST_SUCCESS", false, "Creature-0-4894-34-25735-1708-00010D0ED1", "迪菲亚狱友", 2632, 0, "", nil, -2147483648, -2147483648, },
		{ "09:48:04", "S", "4894", "25735", "迪菲亚狱友", "00010D0ED1", 1594691284.219, "SPELL_CAST_SUCCESS", false, "Creature-0-4894-34-25735-1708-00010D0ED1", "迪菲亚狱友", 2632, 0, "", nil, -2147483648, -2147483648, },
		{ "09:48:05", "S", "4894", "25735", "迪菲亚狱友", "00008D0ED0", 1594691284.619, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00008D0ED0", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00008D0ED0", "迪菲亚狱友", 2632, 0, },
		{ "09:48:05", "S", "4894", "25735", "迪菲亚狱友", "00008D0ED0", 1594691284.619, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00008D0ED0", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00008D0ED0", "迪菲亚狱友", 2632, 0, },
		{ "09:48:05", "S", "4894", "25735", "迪菲亚狱友", "00008D0ED0", 1594691284.619, "SPELL_CAST_SUCCESS", false, "Creature-0-4894-34-25735-1708-00008D0ED0", "迪菲亚狱友", 2632, 0, "", nil, -2147483648, -2147483648, },
		{ "09:48:05", "S", "4894", "25735", "迪菲亚狱友", "00008D0ED0", 1594691284.619, "SPELL_CAST_SUCCESS", false, "Creature-0-4894-34-25735-1708-00008D0ED0", "迪菲亚狱友", 2632, 0, "", nil, -2147483648, -2147483648, },
		{ "09:48:05", "S", "4894", "25735", "迪菲亚狱友", "00008D0ECF", 1594691285.419, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00008D0ECF", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00008D0ECF", "迪菲亚狱友", 2632, 0, },
		{ "09:48:05", "S", "4894", "25735", "迪菲亚狱友", "00008D0ECF", 1594691285.419, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00008D0ECF", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00008D0ECF", "迪菲亚狱友", 2632, 0, },
		{ "09:48:05", "S", "4894", "25735", "迪菲亚狱友", "00008D0ECF", 1594691285.419, "SPELL_CAST_SUCCESS", false, "Creature-0-4894-34-25735-1708-00008D0ECF", "迪菲亚狱友", 2632, 0, "", nil, -2147483648, -2147483648, },
		{ "09:48:05", "S", "4894", "25735", "迪菲亚狱友", "00008D0ECF", 1594691285.419, "SPELL_CAST_SUCCESS", false, "Creature-0-4894-34-25735-1708-00008D0ECF", "迪菲亚狱友", 2632, 0, "", nil, -2147483648, -2147483648, },
		{ "09:48:06", "S", "4894", "25735", "迪菲亚狱友", "00008D0ED1", 1594691285.819, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00008D0ED1", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00008D0ED1", "迪菲亚狱友", 2632, 0, },
		{ "09:48:06", "S", "4894", "25735", "迪菲亚狱友", "00008D0ED1", 1594691285.819, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00008D0ED1", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00008D0ED1", "迪菲亚狱友", 2632, 0, },
		{ "09:48:06", "S", "4894", "25735", "迪菲亚狱友", "00008D0ED1", 1594691285.819, "SPELL_CAST_SUCCESS", false, "Creature-0-4894-34-25735-1708-00008D0ED1", "迪菲亚狱友", 2632, 0, "", nil, -2147483648, -2147483648, },
		{ "09:48:06", "S", "4894", "25735", "迪菲亚狱友", "00008D0ED1", 1594691285.819, "SPELL_CAST_SUCCESS", false, "Creature-0-4894-34-25735-1708-00008D0ED1", "迪菲亚狱友", 2632, 0, "", nil, -2147483648, -2147483648, },
		{ "09:48:06", "S", "4894", "25735", "迪菲亚狱友", "00040D0ECE", 1594691286.236, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00040D0ECE", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00040D0ECE", "迪菲亚狱友", 2632, 0, },
		{ "09:48:06", "S", "4894", "25735", "迪菲亚狱友", "00040D0ECE", 1594691286.236, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00040D0ECE", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00040D0ECE", "迪菲亚狱友", 2632, 0, },
		{ "09:48:06", "S", "4894", "25735", "迪菲亚狱友", "00040D0ECE", 1594691286.236, "SPELL_CAST_SUCCESS", false, "Creature-0-4894-34-25735-1708-00040D0ECE", "迪菲亚狱友", 2632, 0, "", nil, -2147483648, -2147483648, },
		{ "09:48:06", "S", "4894", "25735", "迪菲亚狱友", "00040D0ECE", 1594691286.236, "SPELL_CAST_SUCCESS", false, "Creature-0-4894-34-25735-1708-00040D0ECE", "迪菲亚狱友", 2632, 0, "", nil, -2147483648, -2147483648, },
		{ "09:48:07", "S", "4894", "25735", "迪菲亚狱友", "00030D0ED0", 1594691286.619, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00030D0ED0", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00030D0ED0", "迪菲亚狱友", 2632, 0, },
		{ "09:48:07", "S", "4894", "25735", "迪菲亚狱友", "00030D0ED0", 1594691286.619, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00030D0ED0", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00030D0ED0", "迪菲亚狱友", 2632, 0, },
		{ "09:48:07", "S", "4894", "25735", "迪菲亚狱友", "00030D0ED0", 1594691286.619, "SPELL_CAST_SUCCESS", false, "Creature-0-4894-34-25735-1708-00030D0ED0", "迪菲亚狱友", 2632, 0, "", nil, -2147483648, -2147483648, },
		{ "09:48:07", "S", "4894", "25735", "迪菲亚狱友", "00030D0ED0", 1594691286.619, "SPELL_CAST_SUCCESS", false, "Creature-0-4894-34-25735-1708-00030D0ED0", "迪菲亚狱友", 2632, 0, "", nil, -2147483648, -2147483648, },
		{ "09:48:11", "S", "4894", "25735", "迪菲亚狱友", "00020D0ED0", 1594691291.469, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00020D0ED0", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00020D0ED0", "迪菲亚狱友", 2632, 0, },
		{ "09:48:11", "S", "4894", "25735", "迪菲亚狱友", "00020D0ED0", 1594691291.469, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00020D0ED0", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00020D0ED0", "迪菲亚狱友", 2632, 0, },
		{ "09:48:11", "S", "4894", "25735", "迪菲亚狱友", "00020D0ED0", 1594691291.469, "SPELL_CAST_SUCCESS", false, "Creature-0-4894-34-25735-1708-00020D0ED0", "迪菲亚狱友", 2632, 0, "", nil, -2147483648, -2147483648, },
		{ "09:48:11", "S", "4894", "25735", "迪菲亚狱友", "00020D0ED0", 1594691291.469, "SPELL_CAST_SUCCESS", false, "Creature-0-4894-34-25735-1708-00020D0ED0", "迪菲亚狱友", 2632, 0, "", nil, -2147483648, -2147483648, },
		{ "09:48:13", "PLAYER_STARTED_MOVING", },
		{ "09:48:13", "CURSOR_UPDATE", },
		{ "09:48:13", "LOADING_SCREEN_ENABLED", },
		{ "09:48:13", "CONSOLE_MESSAGE", "World transfer pending...", 0, },
		{ "09:48:14", "PLAYER_STOPPED_MOVING", },
		{ "09:48:15", "CONSOLE_MESSAGE", "Got new connection 3", 0, },
		{ "09:48:15", "INSTANCE_LOCK_STOP", },
		{ "09:48:15", "PLAYER_LEAVING_WORLD", },
		{ "09:48:16", "ACTIONBAR_UPDATE_COOLDOWN", },
		{ "09:48:16", "SPELL_UPDATE_CHARGES", },
		{ "09:48:16", "SPELL_UPDATE_COOLDOWN", },
		{ "09:48:17", "CONSOLE_MESSAGE", "Weather changed to 0, intensity 0.000000\n", 0, },
		{ "09:48:17", "TABARD_CANSAVE_CHANGED", },
		{ "09:48:17", "PLAYER_GUILD_UPDATE", "player", },
		{ "09:48:17", "UPDATE_INVENTORY_DURABILITY", },
		{ "09:48:17", "PET_BAR_UPDATE", },
		{ "09:48:17", "UPDATE_FACTION", },
		{ "09:48:17", "UPDATE_FACTION", },
		{ "09:48:17", "SKILL_LINES_CHANGED", },
		{ "09:48:17", "INITIAL_CLUBS_LOADED", },
		{ "09:48:17", "UPDATE_ALL_UI_WIDGETS", },
		{ "09:48:17", "W", false, "none", },
		{ "09:48:17", "W", "东部王国", "none", 0, "", 0, 0, false, 0, 0, },
		{ "09:48:17", "W", false, "none", },
		{ "09:48:17", "W", "东部王国", "none", 0, "", 0, 0, false, 0, 0, },
		{ "09:48:17", "CORPSE_POSITION_UPDATE", },
		{ "09:48:17", "CORPSE_POSITION_UPDATE", },
		{ "09:48:17", "PLAYER_ALIVE", },
		{ "09:48:17", "PVP_TIMER_UPDATE", "player", },
		{ "09:48:17", "COMMENTATOR_ENTER_WORLD", },
		{ "09:48:18", "L", false, "none", },
		{ "09:48:18", "L", "东部王国", "none", 0, "", 0, 0, false, 0, 0, },
		{ "09:48:18", "L", false, "none", },
		{ "09:48:18", "L", "东部王国", "none", 0, "", 0, 0, false, 0, 0, },
		{ "09:48:18", "ACTIONBAR_UPDATE_COOLDOWN", },
		{ "09:48:18", "MINIMAP_UPDATE_ZOOM", },
		{ "09:48:18", "QUEST_LOG_UPDATE", },
		{ "09:48:18", "SPELL_UPDATE_CHARGES", },
		{ "09:48:18", "SPELL_UPDATE_COOLDOWN", },
		{ "09:48:18", "SPELLS_CHANGED", },
		{ "09:48:18", "UNIT_MODEL_CHANGED", "player", },
		{ "09:48:18", "UNIT_PORTRAIT_UPDATE", "player", },
		{ "09:48:18", "UNIT_MAXHEALTH", "player", },
		{ "09:48:18", "S", "4955", "133", "玛丁雷少校", "00000637EF", 1594691297.626, "SPELL_AURA_APPLIED", false, "Creature-0-4955-0-133-14394-00000637EF", "玛丁雷少校", 2600, 0, "Creature-0-4955-0-133-4995-00018D0273", "监狱守卫", 2584, 0, },
		{ "09:48:18", "S", "4955", "133", "玛丁雷少校", "00000637EF", 1594691297.626, "SPELL_AURA_APPLIED", false, "Creature-0-4955-0-133-14394-00000637EF", "玛丁雷少校", 2600, 0, "Creature-0-4955-0-133-4995-00018D0273", "监狱守卫", 2584, 0, },
		{ "09:48:18", "S", "4955", "133", "玛丁雷少校", "00000637EF", 1594691297.626, "SPELL_AURA_APPLIED", false, "Creature-0-4955-0-133-14394-00000637EF", "玛丁雷少校", 2600, 0, "Creature-0-4955-0-133-4995-00000D0273", "监狱守卫", 2584, 0, },
		{ "09:48:18", "S", "4955", "133", "玛丁雷少校", "00000637EF", 1594691297.626, "SPELL_AURA_APPLIED", false, "Creature-0-4955-0-133-14394-00000637EF", "玛丁雷少校", 2600, 0, "Creature-0-4955-0-133-4995-00000D0273", "监狱守卫", 2584, 0, },
		{ "09:48:18", "S", "4955", "133", "玛丁雷少校", "00000637EF", 1594691297.626, "SPELL_AURA_APPLIED", false, "Creature-0-4955-0-133-14394-00000637EF", "玛丁雷少校", 2600, 0, "Creature-0-4955-0-133-6237-00000D025E", "监狱弓箭手", 2584, 0, },
		{ "09:48:18", "S", "4955", "133", "玛丁雷少校", "00000637EF", 1594691297.626, "SPELL_AURA_APPLIED", false, "Creature-0-4955-0-133-14394-00000637EF", "玛丁雷少校", 2600, 0, "Creature-0-4955-0-133-6237-00000D025E", "监狱弓箭手", 2584, 0, },
		{ "09:48:18", "S", "4955", "133", "玛丁雷少校", "00000637EF", 1594691297.626, "SPELL_AURA_APPLIED", false, "Creature-0-4955-0-133-14394-00000637EF", "玛丁雷少校", 2600, 0, "Creature-0-4955-0-133-4995-00010D0273", "监狱守卫", 2584, 0, },
		{ "09:48:18", "S", "4955", "133", "玛丁雷少校", "00000637EF", 1594691297.626, "SPELL_AURA_APPLIED", false, "Creature-0-4955-0-133-14394-00000637EF", "玛丁雷少校", 2600, 0, "Creature-0-4955-0-133-4995-00010D0273", "监狱守卫", 2584, 0, },
		{ "09:48:18", "S", "4955", "133", "玛丁雷少校", "00000637EF", 1594691297.626, "SPELL_AURA_APPLIED", false, "Creature-0-4955-0-133-14394-00000637EF", "玛丁雷少校", 2600, 0, "Creature-0-4955-0-133-4995-00008D0273", "监狱守卫", 2584, 0, },
		{ "09:48:18", "S", "4955", "133", "玛丁雷少校", "00000637EF", 1594691297.626, "SPELL_AURA_APPLIED", false, "Creature-0-4955-0-133-14394-00000637EF", "玛丁雷少校", 2600, 0, "Creature-0-4955-0-133-4995-00008D0273", "监狱守卫", 2584, 0, },
		{ "09:48:18", "S", "4955", "133", "玛丁雷少校", "00000637EF", 1594691297.626, "SPELL_AURA_APPLIED", false, "Creature-0-4955-0-133-14394-00000637EF", "玛丁雷少校", 2600, 0, "Creature-0-4955-0-133-6237-00008D0278", "监狱弓箭手", 2584, 0, },
		{ "09:48:18", "S", "4955", "133", "玛丁雷少校", "00000637EF", 1594691297.626, "SPELL_AURA_APPLIED", false, "Creature-0-4955-0-133-14394-00000637EF", "玛丁雷少校", 2600, 0, "Creature-0-4955-0-133-6237-00008D0278", "监狱弓箭手", 2584, 0, },
		{ "09:48:18", "S", "4955", "133", "玛丁雷少校", "00000637EF", 1594691297.626, "SPELL_AURA_APPLIED", false, "Creature-0-4955-0-133-14394-00000637EF", "玛丁雷少校", 2600, 0, "Creature-0-4955-0-133-5042-00000637EF", "护士莉莲", 2584, 0, },
		{ "09:48:18", "S", "4955", "133", "玛丁雷少校", "00000637EF", 1594691297.626, "SPELL_AURA_APPLIED", false, "Creature-0-4955-0-133-14394-00000637EF", "玛丁雷少校", 2600, 0, "Creature-0-4955-0-133-5042-00000637EF", "护士莉莲", 2584, 0, },
		{ "09:48:18", "S", "4955", "133", "玛丁雷少校", "00000637EF", 1594691297.626, "SPELL_AURA_APPLIED", false, "Creature-0-4955-0-133-14394-00000637EF", "玛丁雷少校", 2600, 0, "Creature-0-4955-0-133-6237-00000D0278", "监狱弓箭手", 2584, 0, },
		{ "09:48:18", "S", "4955", "133", "玛丁雷少校", "00000637EF", 1594691297.626, "SPELL_AURA_APPLIED", false, "Creature-0-4955-0-133-14394-00000637EF", "玛丁雷少校", 2600, 0, "Creature-0-4955-0-133-6237-00000D0278", "监狱弓箭手", 2584, 0, },
		{ "09:48:18", "S", "4955", "133", "玛丁雷少校", "00000637EF", 1594691297.626, "SPELL_AURA_APPLIED", false, "Creature-0-4955-0-133-14394-00000637EF", "玛丁雷少校", 2600, 0, "Creature-0-4955-0-133-6237-00008D025E", "监狱弓箭手", 2584, 0, },
		{ "09:48:18", "S", "4955", "133", "玛丁雷少校", "00000637EF", 1594691297.626, "SPELL_AURA_APPLIED", false, "Creature-0-4955-0-133-14394-00000637EF", "玛丁雷少校", 2600, 0, "Creature-0-4955-0-133-6237-00008D025E", "监狱弓箭手", 2584, 0, },
		{ "09:48:18", "S", "4955", "133", "玛丁雷少校", "00000637EF", 1594691297.626, "SPELL_AURA_APPLIED", false, "Creature-0-4955-0-133-14394-00000637EF", "玛丁雷少校", 2600, 0, "Creature-0-4955-0-133-68-00018637F0", "暴风城卫兵", 2584, 0, },
		{ "09:48:18", "S", "4955", "133", "玛丁雷少校", "00000637EF", 1594691297.626, "SPELL_AURA_APPLIED", false, "Creature-0-4955-0-133-14394-00000637EF", "玛丁雷少校", 2600, 0, "Creature-0-4955-0-133-68-00018637F0", "暴风城卫兵", 2584, 0, },
		{ "09:48:18", "S", "4955", "133", "玛丁雷少校", "00000637EF", 1594691297.626, "SPELL_AURA_APPLIED", false, "Creature-0-4955-0-133-14394-00000637EF", "玛丁雷少校", 2600, 0, "Creature-0-4955-0-133-68-00010637EF", "暴风城卫兵", 2584, 0, },
		{ "09:48:18", "S", "4955", "133", "玛丁雷少校", "00000637EF", 1594691297.626, "SPELL_AURA_APPLIED", false, "Creature-0-4955-0-133-14394-00000637EF", "玛丁雷少校", 2600, 0, "Creature-0-4955-0-133-68-00010637EF", "暴风城卫兵", 2584, 0, },
		{ "09:48:18", "UNIT_FACTION", "player", },
		{ "09:48:18", "QUEST_LOG_UPDATE", },
		{ "09:48:18", "UNIT_AURA", "player", },
		{ "09:48:18", "UNIT_MODEL_CHANGED", "player", },
		{ "09:48:18", "UNIT_PORTRAIT_UPDATE", "player", },
		{ "09:48:18", "UNIT_PORTRAIT_UPDATE", "player", },
		{ "09:48:18", "UNIT_MODEL_CHANGED", "player", },
		{ "09:48:18", "PORTRAITS_UPDATED", },
		{ "09:48:18", "ZONE_CHANGED_NEW_AREA", },
		{ "09:48:18", "UPDATE_ALL_UI_WIDGETS", },
		{ "09:48:18", "AREA_POIS_UPDATED", },
		{ "09:48:18", "UPDATE_INSTANCE_INFO", },
		{ "09:48:18", "GUILD_ROSTER_UPDATE", false, },
		{ "09:48:18", "UPDATE_PENDING_MAIL", },
		{ "09:48:18", "GUILD_ROSTER_UPDATE", false, },
		{ "09:48:18", "GUILD_RANKS_UPDATE", },
		{ "09:48:19", "REQUEST_CEMETERY_LIST_RESPONSE", false, },
		{ "09:48:20", "BN_INFO_CHANGED", },
		{ "09:48:20", "BN_FRIEND_INFO_CHANGED", },
		{ "09:48:20", "BN_INFO_CHANGED", },
		{ "09:48:20", "BN_FRIEND_INFO_CHANGED", },
		{ "09:48:23", "CONSOLE_MESSAGE", "DBCache::CancelCallback ignored", 0, },
		{ "09:48:31", "PLAYER_STARTED_MOVING", },
		{ "09:48:32", "CURSOR_UPDATE", },
		{ "09:48:32", "LOADING_SCREEN_ENABLED", },
		{ "09:48:32", "CONSOLE_MESSAGE", "World transfer pending...", 0, },
		{ "09:48:33", "PLAYER_STOPPED_MOVING", },
		{ "09:48:33", "CONSOLE_MESSAGE", "Got new connection 3", 0, },
		{ "09:48:34", "INSTANCE_LOCK_STOP", },
		{ "09:48:34", "PLAYER_LEAVING_WORLD", },
		{ "09:48:34", "ACTIONBAR_UPDATE_COOLDOWN", },
		{ "09:48:34", "SPELL_UPDATE_CHARGES", },
		{ "09:48:34", "SPELL_UPDATE_COOLDOWN", },
		{ "09:48:35", "INSTANCE_GROUP_SIZE_CHANGED", },
		{ "09:48:35", "CONSOLE_MESSAGE", "Weather changed to 0, intensity 0.000000\n", 0, },
		{ "09:48:35", "TABARD_CANSAVE_CHANGED", },
		{ "09:48:35", "PLAYER_GUILD_UPDATE", "player", },
		{ "09:48:35", "UPDATE_INVENTORY_DURABILITY", },
		{ "09:48:35", "PET_BAR_UPDATE", },
		{ "09:48:35", "UPDATE_FACTION", },
		{ "09:48:35", "UPDATE_FACTION", },
		{ "09:48:35", "SKILL_LINES_CHANGED", },
		{ "09:48:35", "INITIAL_CLUBS_LOADED", },
		{ "09:48:35", "UPDATE_ALL_UI_WIDGETS", },
		{ "09:48:35", "W", true, "party", },
		{ "09:48:35", "W", "暴风城监狱", "party", 1, "普通", 5, 0, false, 34, 5, },
		{ "09:48:35", "W", true, "party", },
		{ "09:48:35", "W", "暴风城监狱", "party", 1, "普通", 5, 0, false, 34, 5, },
		{ "09:48:35", "CORPSE_POSITION_UPDATE", },
		{ "09:48:35", "CORPSE_POSITION_UPDATE", },
		{ "09:48:35", "PLAYER_ALIVE", },
		{ "09:48:35", "PVP_TIMER_UPDATE", "player", },
		{ "09:48:35", "COMMENTATOR_ENTER_WORLD", },
		{ "09:48:35", "L", true, "party", },
		{ "09:48:35", "L", "暴风城监狱", "party", 1, "普通", 5, 0, false, 34, 5, },
		{ "09:48:35", "L", true, "party", },
		{ "09:48:35", "L", "暴风城监狱", "party", 1, "普通", 5, 0, false, 34, 5, },
		{ "09:48:35", "ACTIONBAR_UPDATE_COOLDOWN", },
		{ "09:48:35", "MINIMAP_UPDATE_ZOOM", },
		{ "09:48:35", "QUEST_LOG_UPDATE", },
		{ "09:48:35", "SPELL_UPDATE_CHARGES", },
		{ "09:48:35", "SPELL_UPDATE_COOLDOWN", },
		{ "09:48:35", "SPELLS_CHANGED", },
		{ "09:48:35", "UNIT_MODEL_CHANGED", "player", },
		{ "09:48:35", "UNIT_PORTRAIT_UPDATE", "player", },
		{ "09:48:35", "UNIT_MAXHEALTH", "player", },
		{ "09:48:35", "S", "4894", "25735", "迪菲亚狱友", "00030D0ED0", 1594691315.507, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00030D0ED0", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00030D0ED0", "迪菲亚狱友", 2632, 0, },
		{ "09:48:35", "S", "4894", "25735", "迪菲亚狱友", "00030D0ED0", 1594691315.507, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00030D0ED0", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00030D0ED0", "迪菲亚狱友", 2632, 0, },
		{ "09:48:35", "S", "4894", "25735", "迪菲亚狱友", "00040D0ECE", 1594691315.507, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00040D0ECE", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00040D0ECE", "迪菲亚狱友", 2632, 0, },
		{ "09:48:35", "S", "4894", "25735", "迪菲亚狱友", "00040D0ECE", 1594691315.507, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00040D0ECE", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00040D0ECE", "迪菲亚狱友", 2632, 0, },
		{ "09:48:35", "S", "4894", "25735", "迪菲亚狱友", "00000D0ED0", 1594691315.507, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00000D0ED0", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00000D0ED0", "迪菲亚狱友", 2632, 0, },
		{ "09:48:35", "S", "4894", "25735", "迪菲亚狱友", "00000D0ED0", 1594691315.507, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00000D0ED0", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00000D0ED0", "迪菲亚狱友", 2632, 0, },
		{ "09:48:35", "S", "4894", "25735", "迪菲亚狱友", "00008D0ED0", 1594691315.507, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00008D0ED0", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00008D0ED0", "迪菲亚狱友", 2632, 0, },
		{ "09:48:35", "S", "4894", "25735", "迪菲亚狱友", "00008D0ED0", 1594691315.507, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00008D0ED0", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00008D0ED0", "迪菲亚狱友", 2632, 0, },
		{ "09:48:35", "S", "4894", "25735", "迪菲亚狱友", "00010D0ED1", 1594691315.507, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00010D0ED1", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00010D0ED1", "迪菲亚狱友", 2632, 0, },
		{ "09:48:35", "S", "4894", "25735", "迪菲亚狱友", "00010D0ED1", 1594691315.507, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00010D0ED1", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00010D0ED1", "迪菲亚狱友", 2632, 0, },
		{ "09:48:35", "S", "4894", "25735", "迪菲亚狱友", "00008D0ECF", 1594691315.507, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00008D0ECF", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00008D0ECF", "迪菲亚狱友", 2632, 0, },
		{ "09:48:35", "S", "4894", "25735", "迪菲亚狱友", "00008D0ECF", 1594691315.507, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00008D0ECF", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00008D0ECF", "迪菲亚狱友", 2632, 0, },
		{ "09:48:35", "S", "4894", "25735", "迪菲亚狱友", "00008D0ED1", 1594691315.507, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00008D0ED1", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00008D0ED1", "迪菲亚狱友", 2632, 0, },
		{ "09:48:35", "S", "4894", "25735", "迪菲亚狱友", "00008D0ED1", 1594691315.507, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00008D0ED1", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00008D0ED1", "迪菲亚狱友", 2632, 0, },
		{ "09:48:35", "S", "4894", "25735", "迪菲亚狱友", "00020D0ED0", 1594691315.507, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00020D0ED0", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00020D0ED0", "迪菲亚狱友", 2632, 0, },
		{ "09:48:35", "S", "4894", "25735", "迪菲亚狱友", "00020D0ED0", 1594691315.507, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00020D0ED0", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00020D0ED0", "迪菲亚狱友", 2632, 0, },
		{ "09:48:35", "S", "4894", "25735", "迪菲亚狱友", "00018D0ECE", 1594691315.507, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00018D0ECE", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00018D0ECE", "迪菲亚狱友", 2632, 0, },
		{ "09:48:35", "S", "4894", "25735", "迪菲亚狱友", "00018D0ECE", 1594691315.507, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00018D0ECE", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00018D0ECE", "迪菲亚狱友", 2632, 0, },
		{ "09:48:35", "UNIT_FACTION", "player", },
		{ "09:48:35", "UPDATE_INSTANCE_INFO", },
		{ "09:48:35", "GUILD_ROSTER_UPDATE", false, },
		{ "09:48:35", "UPDATE_PENDING_MAIL", },
		{ "09:48:35", "ACTIONBAR_UPDATE_COOLDOWN", },
		{ "09:48:35", "QUEST_LOG_UPDATE", },
		{ "09:48:35", "SPELL_UPDATE_CHARGES", },
		{ "09:48:35", "SPELL_UPDATE_COOLDOWN", },
		{ "09:48:35", "UNIT_AURA", "player", },
		{ "09:48:35", "UNIT_MODEL_CHANGED", "player", },
		{ "09:48:35", "UNIT_PORTRAIT_UPDATE", "player", },
		{ "09:48:36", "UNIT_PORTRAIT_UPDATE", "player", },
		{ "09:48:36", "UNIT_MODEL_CHANGED", "player", },
		{ "09:48:36", "PORTRAITS_UPDATED", },
		{ "09:48:36", "ZONE_CHANGED_NEW_AREA", },
		{ "09:48:36", "UPDATE_ALL_UI_WIDGETS", },
		{ "09:48:36", "AREA_POIS_UPDATED", },
		{ "09:48:36", "GUILD_ROSTER_UPDATE", false, },
		{ "09:48:36", "GUILD_RANKS_UPDATE", },
		{ "09:48:37", "REQUEST_CEMETERY_LIST_RESPONSE", false, },
		{ "09:48:40", "BN_INFO_CHANGED", },
		{ "09:48:40", "BN_FRIEND_INFO_CHANGED", },
		{ "09:48:40", "BN_INFO_CHANGED", },
		{ "09:48:40", "BN_FRIEND_INFO_CHANGED", },
		{ "09:48:41", "S", "4894", "25735", "迪菲亚狱友", "00028D0ECE", 1594691320.932, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00028D0ECE", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00028D0ECE", "迪菲亚狱友", 2632, 0, },
		{ "09:48:41", "S", "4894", "25735", "迪菲亚狱友", "00028D0ECE", 1594691320.932, "SPELL_AURA_APPLIED", false, "Creature-0-4894-34-25735-1708-00028D0ECE", "迪菲亚狱友", 2632, 0, "Creature-0-4894-34-25735-1708-00028D0ECE", "迪菲亚狱友", 2632, 0, },
		{ "09:48:48", "INSTANCE_LOCK_STOP", },
		{ "09:48:48", "PLAYER_LEAVING_WORLD", },
		{ "09:48:48", "CURSOR_UPDATE", },
		{ "09:48:48", "TRADE_SKILL_CLOSE", },
		{ "09:48:48", "ADDONS_UNLOADING", true, },
		{ "09:48:48", "PLAYER_LOGOUT", },
	--]]
	--
	--[[		--	GUID format
		For players: 									"Player-[server ID]-[player UID]"
		Example: 										"Player-970-0002FD64"
		For creatures, pets, objects, and vehicles: 	"[Unit type]-0-[server ID]-[instance ID]-[zone UID]-[ID]-[spawn UID]"
		Example: 										"Creature-0-970-0-11-31146-000136DF91"
		Unit Type Names: "Creature", "Pet", "GameObject", "Vehicle", and "Vignette"
		For items:										"Item-[server ID]-0-[spawn UID]"
		Example: 										"Item-970-0-400000076620BFF4"
		Please note that this tells you nothing useful about the item, like the ID
		Creature-0-4539-389-28244-11320-00028C1038
		Creature-0-4528-389-18991-11320-00040C106F
	--]]
	--[[		--	event
		--	UNIT_TARGET	unitId
		--	UPDATE_MOUSEOVER_UNIT
		--	NAME_PLATE_CREATED	namePlateFrame
		--	NAME_PLATE_UNIT_ADDED	unitId
		--	COMBAT_LOG_EVENT_UNFILTERED, COMBAT_LOG_EVENT
		--	local timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = CombatLogGetCurrentEventInfo()
	--]]
	--[[		--	VAR format
			@char{  }
				@hash{  }	[uid] = GetServerTime()
				@list{  }	{ GetServerTime() on LOADING_SCREEN_DISABLED, instanceType, maxPlayers, serverID, instanceID, zoneUID, sync, }
			--
				{ 1595845122, "party", 5, 4893, 34, 17890, false, },
				{ 1595911260, "raid", 20, 4536, 309, 14859, false, },
	--]]
-->		UTILS
	function __ns.time_to_stamp(f, t)
		return date(f, t + 57600 - 1);
	end
-->		GUI
	function __ns.initUI()
		-->	1hr limit
			--	mainUI
				local ui = CreateFrame("FRAME", nil, UIParent, "BackdropTemplate");
				ui:SetSize(140, 80);
				ui:SetBackdrop({
					bgFile = "Interface/ChatFrame/ChatFrameBackground",
					edgeFile = "Interface/ChatFrame/ChatFrameBackground",
					tile = true,
					edgeSize = 1,
					tileSize = 5,
				});
				ui:SetMovable(true);
				function __ns.EnableUI()
					ui:Show();
					SET.enabled = true;
				end
				function __ns.DisableUI()
					ui:Hide();
					SET.enabled = false;
				end
				function __ns.LockUI()
					ui:EnableMouse(false);
					ui:SetBackdropColor(0.0, 0.0, 0.0, 0.0);
					ui:SetBackdropBorderColor(0.0, 0.0, 0.0, 0.0);
					SET.locked = true;
				end
				function __ns.UnlockUI()
					ui:EnableMouse(true);
					ui:SetBackdropColor(0.0, 0.0, 0.0, 0.5);
					ui:SetBackdropBorderColor(0.0, 0.0, 0.0, 0.5);
					SET.locked = false;
				end

				local drop_menu_table = {
					handler = _noop_,
					elements = {
						{
							handler = __ns.LockUI,
							para = {  },
							text = L["LOCK"],
						},
						{
							handler = __ns.DisableUI,
							para = {  },
							text = L["CLOSE"],
						},
					},
				};
				ui:SetScript("OnMouseDown", function(self, button)
					if button == "LeftButton" then
						self:StartMoving();
					else
						ALADROP(ui, "BOTTOMLEFT", drop_menu_table);
					end
				end);
				ui:SetScript("OnMouseUp", function(self, button)
					self:StopMovingOrSizing();
					SET.pos = { self:GetPoint(), };
					for i, v in next, SET.pos do
						if type(v) == 'table' then
							SET.pos[i] = v:GetName();
						end
					end
				end);
			--	board line
				local lines = {  };
				ui.lines = lines;
				for i = 1, 5 do
					local strL = ui:CreateFontString(nil, "OVERLAY");
					strL:SetFont(GameFontNormal:GetFont(), 16);
					strL:SetPoint("TOPLEFT", ui, "TOPLEFT", 0, - 16 * (i - 1));
					strL:SetJustifyH("CENTER");
					strL:Show();
					strL:SetText("\124cffffff00" .. L["INSTANCE_CHANCE"] .. i .. "\124r:  ");
					local strR = ui:CreateFontString(nil, "OVERLAY");
					strR:SetFont(GameFontNormal:GetFont(), 16);
					strR:SetPoint("TOP", strL, "TOP", 0, 0);
					strR:SetPoint("RIGHT", ui, "RIGHT", 0, 0);
					strR:SetJustifyH("CENTER");
					strR:Show();
					strR:SetText("\124cff00ff00" .. L["AVAILABLE"] .. "\124r");
					strR.id = i;
					local line = { strL, strR, };
					function line:SetText(...)
						strR:SetText(...);
					end
					lines[i] = line;
				end
				function __ns.LineSetText(index, ...)
					lines[index]:SetText(...);
				end
				local cur = 1;
				function __ns.LineStart()
					cur = 1;
				end
				function __ns.LineAddText(...)
					if cur <= 5 then
						__ns.LineSetText(cur, ...)
						cur = cur + 1;
					end
				end
				function __ns.LineEnd()
					if cur < 5 then
						for index = cur + 1, 5 do
							__ns.LineSetText(index, "\124cff00ff00" .. L["AVAILABLE"] .. "\124r");
						end
					end
				end
			--	reset instance
				local resetInstances = CreateFrame("BUTTON", nil, ui);
				resetInstances:SetSize(16, 16);
				resetInstances:SetNormalTexture("interface\\common\\indicator-green");
				resetInstances:SetHighlightTexture("Interface\\common\\indicator-gray");
				resetInstances:SetPoint("BOTTOMRIGHT", ui, "TOPRIGHT", 0, 0);
				resetInstances:Show();
				resetInstances:EnableMouse(true);
				-- resetInstances:RegisterForClicks("LeftButton");
				resetInstances.info = L["RESETINSTANCE"];
				resetInstances:SetScript("OnEnter", Info_OnEnter);
				resetInstances:SetScript("OnLeave", Info_OnLeave);
				resetInstances:SetScript("OnClick", function()
					ResetInstances();
				end);
				ui.resetInstances = resetInstances;
			--
		-->	24hrs limit	--	new for hotfix 20200612
		if IsClassic then
			local dayLimit = CreateFrame("BUTTON", nil, ui);
			dayLimit:SetHeight(24);
			dayLimit:SetPoint("TOPLEFT", ui, "BOTTOMLEFT");
			dayLimit:SetPoint("TOPRIGHT", ui, "BOTTOMRIGHT");
			dayLimit:Show();
			ui.dayLimit = dayLimit;
			local dayLimitStr = dayLimit:CreateFontString(nil, "OVERLAY");
			dayLimitStr:SetFont(GameFontNormal:GetFont(), 16);
			dayLimitStr:SetPoint("CENTER");
			dayLimitStr:SetJustifyH("CENTER");
			dayLimitStr:Show();
			ui.dayLimitStr = dayLimitStr;
			local function dayLimitOnEnter(self)
				local list = VAR.list;
				local num = #list;
				local num24hrs = 0;
				for index = 1, num do
					local info = list[index];
					if info[2] == 'party' then
						num24hrs = num24hrs + 1;
					end
				end
				if self:GetTop() + self:GetBottom() < UIParent:GetHeight() then
					GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 96);
				else
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOM");
				end
				GameTooltip:SetText(L["TIP_GLOBAL_HEADER"]);
				GameTooltip:AddDoubleLine(format(L["TIP_GLOBAL_FORMAT_AVAILABLE"], DAY_LIMIT - num24hrs),
											format(L["TIP_GLOBAL_FORMAT_LOCKED"], num24hrs));
				if num24hrs > 0 then
					if IsAltKeyDown() then
						local now = GetServerTime();
						local index = 0;
						for i = 1, num do
							local info = list[i];
							if info[2] == 'party' then
								index = index + 1;
								GameTooltip:AddDoubleLine(
										L["TIP_INSTANCE"] .. index .. " \124cffff7f00" .. GetRealZoneText(info[5]) .. "\124r uid " .. info[6],
										__ns.time_to_stamp("\124cffff0000[%H:%M:%S]\124r", info[1] - now + ONE_DAY)
									);
							end
						end
					elseif IsShiftKeyDown() then
						local now = GetServerTime();
						local index = 0;
						for i = 1, num do
							local info = list[i];
							if info[2] == 'party' then
								index = index + 1;
								GameTooltip:AddDoubleLine(
										L["TIP_INSTANCE"] .. index,
										__ns.time_to_stamp("\124cffff0000[%H:%M:%S]\124r", info[1] - now + ONE_DAY)
									);
							end
						end
						if not SET.hide_key_tip then
							GameTooltip:AddLine(L["TIP_GLOBAL_ALT"]);
						end
					else
						if not SET.hide_key_tip then
							GameTooltip:AddLine(L["TIP_GLOBAL_ALT"]);
							GameTooltip:AddLine(L["TIP_GLOBAL_SHIFT"]);
						end
					end
				else
				end
				if not SET.hide_notice then
					GameTooltip:AddLine(L["NOTICE_FOR_24HRS"]);
				end
				GameTooltip:Show();
			end
			dayLimit:SetScript("OnEnter", dayLimitOnEnter);
			dayLimit:SetScript("OnLeave", Info_OnLeave);
			dayLimit:SetScript("OnEvent", function(self)
				if GameTooltip:IsOwned(self) then
					-- GameTooltip:Hide();
					dayLimitOnEnter(self);
				end
			end);
			dayLimit:RegisterEvent("MODIFIER_STATE_CHANGED");
			function __ns.DayLimitStr(text)
				dayLimitStr:SetText(text);
			end
		end
		-->
		-->	apply set
			if SET.enabled then
				__ns.EnableUI();
			else
				__ns.DisableUI();
			end
			if SET.locked then
				__ns.LockUI();
			else
				__ns.UnlockUI();
			end
			ui:SetPoint(unpack(SET.pos));
		-->
		C_Timer.NewTicker(1.0, __ns.updateGUI);
		return ui;
	end
	function __ns.updateGUI()
		local list = VAR.list;
		local hash = VAR.hash;
		__ns.Cleanup(list, hash);
		local now = GetServerTime();
		local num = #list;
		--		1hr limit
		local num1hr = 0;
		__ns.LineStart();
		for index = num, 1, -1 do
			local val = list[index];
			if val[1] + ONE_HOUR > now then
				if val[2] == 'party' or (val[2] == 'raid' and val[3] == 20) then
					__ns.LineAddText(__ns.time_to_stamp("\124cffff0000[%M:%S]\124r", val[1] - now + ONE_HOUR));
					num1hr = num1hr + 1;
					if num1hr >= 5 then
						break;
					end
				end
			else
				break;
			end
		end
		__ns.LineEnd();
		--[==[
		local num1hr = 0;
		local num1hrStart = num + 1;
		for index = num, 1, -1 do
			local info = list[index];
			if info[1] + ONE_HOUR > now then
				if info[2] == 'party' or (info[2] == 'raid' and info[3] == 20) then
					num1hr = num1hr + 1;
					num1hrStart = index;
					if num1hr >= 5 then
						break;
					end
				end
			else
				break;
			end
		end
		__ns.LineStart();
		for index = num1hrStart, num do
			local info = list[index];
			if info[2] == 'party' or (info[2] == 'raid' and info[3] == 20) then
				__ns.LineAddText(__ns.time_to_stamp("\124cffff0000[%M:%S]\124r", info[1] - now + ONE_HOUR));
			end
		end
		__ns.LineEnd();
		--
		for index = 1, min(num, 5) do
			local info = list[num - index + 1];
			if info[1] + ONE_HOUR > now then
				num1hr = index;
			else
				break;
			end
		end
		for index = 1, 5 do
			if index > num1hr then
				for index2 = index, 5 do
					__ns.LineSetText(index2, "\124cff00ff00" .. L["AVAILABLE"] .. "\124r");
					index2 = index2 + 1;
				end
				break;
			else
				local info = list[num - num1hr + index];
				__ns.LineSetText(index, __ns.time_to_stamp("\124cffff0000[%M:%S]\124r", info[1] - now + ONE_HOUR));
			end
		end
		--]==]
		--		24hrs limit
		if IsClassic then
			local num24hrs = 0;
			for index = 1, num do
				local info = list[index];
				if info[2] == 'party' then
					num24hrs = num24hrs + 1;
				end
			end
			__ns.DayLimitStr(
					"\124cff00ff00" .. L["AVAILABLE_GLOBAL"] .. (DAY_LIMIT - num24hrs) .. 
					"\124r - \124cffff0000" .. 
					L["LOCK"] .. num24hrs .. "\124r");
		end
	end
-->		Method
	function __ns.Cleanup(list, hash)
		if #list > 0 then
			local now = GetServerTime();
			local info = list[1];
			while info and info[1] + ONE_DAY < now do
				tremove(list, 1);
				hash[info[6]] = nil;
				info = list[1];
			end
		end
	end
	function __ns.CHAT_MSG_SYSTEM(msg)
		if msg == RESET_FAILED_NOTIFY then
		else
			local _, instance;
			if __ns.bak_INSTANCE_RESET_SUCCESS ~= INSTANCE_RESET_SUCCESS then
				__ns.bak_INSTANCE_RESET_SUCCESS = INSTANCE_RESET_SUCCESS;
				__ns.instance_reset_success_pattern = gsub(INSTANCE_RESET_SUCCESS, "%%s", "(.+)");
			end
			_, _, instance = strfind(msg, __ns.instance_reset_success_pattern);
			if instance then
				if IsInRaid() then
					SendChatMessage(msg, 'RAID');
				elseif IsInGroup() then
					SendChatMessage(msg, 'PARTY');
				end
			else
				if __ns.bak_INSTANCE_RESET_FAILED ~= INSTANCE_RESET_FAILED then
					__ns.bak_INSTANCE_RESET_FAILED = INSTANCE_RESET_FAILED;
					__ns.instance_reset_failed_pattern = gsub(INSTANCE_RESET_FAILED, "%%s", "(.+)");
				end
				_, _, instance = strfind(msg, __ns.instance_reset_failed_pattern);
				if instance then
					if IsInRaid() then
						SendChatMessage(format(L["RESET"], instance), 'RAID');
					elseif IsInGroup() then
						SendChatMessage(format(L["RESET"], instance), 'PARTY');
					end
				end
			end
		end
	end
	function __ns.extern_callback(sync, rtime, instanceType, maxPlayers, serverID, instanceID, zoneUID)
		-- print('add', instanceID, zoneUID)
		local list = VAR.list;
		-- print('current') for index = 1, #list do print(list[index][5], list[index][6]) end
		local hash = VAR.hash;
		if hash[zoneUID] == nil then
			hash[zoneUID] = rtime;
			tinsert(list, { rtime, instanceType, maxPlayers, serverID, instanceID, zoneUID, sync});
			__ns.updateGUI();
		elseif not sync then
			for index = #list, 1, -1 do
				local val = list[index];
				if val[6] == zoneUID then
					if val[7] then
						val[1] = rtime;
						val[2] = instanceType;
						val[3] = maxPlayers;
						val[4] = serverID;
						val[5] = instanceID;
						--	val[6] = zoneUID;
						val[7] = sync;
					end
					break;
				end
			end
		end
	end
	function __ns.extern_revoke(sync, rtime, instanceType, maxPlayers, serverID, instanceID, zoneUID)
		-- print('revoke', instanceID, zoneUID)
		local list = VAR.list;
		-- print('current') for index = 1, #list do print(list[index][5], list[index][6]) end
		local hash = VAR.hash;
		for index = #list, 1, -1 do
			local val = list[index];
			if val[6] == zoneUID then
				if val[7] then
					tremove(list, index);
					hash[zoneUID] = nil;
				end
				break;
			end
		end
	end
	function __ns.extern_mark_as_local(which)
		local list = VAR.list;
		if which == nil then
			for index = 1, #list do
				local val = list[index];
				if which == val[5] then
					vl[7] = false;
				end
			end
		else
			for index = 1, #list do
				list[index][7] = false;
			end
		end
	end
-->
-->		Initialize
	local _def = {
		enabled = true,
		locked = false,
		pos = { "CENTER", "UIParent", "CENTER", 320, -160, },
		hide_key_tip = false;
		hide_notice = false,
	};
	function __ns.GetDefPos()
		return unpack(_def.pos);
	end
	function __ns.init_variables()
		if InstLockSV == nil then
			InstLockSV = {
				use_global_set = true,
				set = { ['*'] = {  }, },
				var = {  },
				_version = 20200715.0,
			};
		else
			if InstLockSV._version == nil or InstLockSV._version < 20200714.0 then
				wipe(InstLockSV);
				InstLockSV._version = 20200714.0;
				InstLockSV.use_global_set = true;
				InstLockSV.set = { ['*'] = {  }, };
				InstLockSV.var = {  };
			end
			if InstLockSV._version < 20200715.0 then
				InstLockSV._version = 20200715.0;
				if InstLockSV.var == nil then
					InstLockSV.var = {  };
				else
					wipe(InstLockSV.var);
				end
			end
			if InstLockSV._version < 20200728.0 then
				InstLockSV._version = 20200728.1;
				for _, VAR in next, InstLockSV.var do
					if VAR.list then
						for index, val in next, VAR.list do
							--	{ 1, 4, _, 5, 3, 2, 6, }
							local temp = { val[1], val[4], nil, tonumber(val[5]), tonumber(val[3]), tonumber(val[2]), val[6], };
							VAR.list[index] = temp;
							if temp[2] == 'raid' then
								if temp[5] == 309 then
									temp[3] = 20;
								else
									temp[3] = 40;
								end
							elseif temp[2] == 'party' then
								if temp[5] == 229 then
									temp[3] = 15;
								else
									temp[3] = 5;
								end
							end
						end
					end
				end
			end
			if InstLockSV._version < 20200728.1 then
				InstLockSV._version = 20200728.1;
				for _, VAR in next, InstLockSV.var do
					if VAR.list then
						for index, val in next, VAR.list do
							if val[2] == 'raid' then
								if val[5] == 309 then
									val[3] = 20;
								else
									val[3] = 40;
								end
							elseif val[2] == 'party' then
								if val[5] == 229 then
									val[3] = 15;
								else
									val[3] = 5;
								end
							end
						end
					end
				end
			end
		end
		InstLockSV._version = 20200728.1;
		local GUID = UnitGUID('player');
		--
		local key = InstLockSV.use_global_set and '*' or GUID;
		if InstLockSV.set[key] == nil then
			InstLockSV.set[key] = {  };
		end
		SET = setmetatable(InstLockSV.set[key], { __index = _def, });
		--
		VAR = InstLockSV.var[GUID];
		if VAR == nil then
			VAR = {
				list = {  },
				hash = {  },
			};
			InstLockSV.var[GUID] = VAR;
		else
			local list = VAR.list;
			local hash = VAR.hash;
			__ns.Cleanup(list, hash);
			--.		some verify
				local temp = {  };
				for _, v in next, list do
					temp[v[6]] = true;
				end
				for zoneUID, _ in next, hash do
					if temp[zoneUID] == nil then
						error(L["VARIABLES_ERROR"], 'H', zoneUID);
					end
				end
				for zoneUID, _ in next, temp do
					if hash[zoneUID] == nil then
						error(L["VARIABLES_ERROR"], 'L', zoneUID);
					end
				end
			--.
		end
	end
	function __ns.ADDON_LOADED(addon)
		if addon ~= ADDON then
			return;
		end
		safe_call(__ns.init_variables);
		_, __ns.ui = safe_call(__ns.initUI);
		--
		_EventHandler:UnregEvent("ADDON_LOADED");
		__instlib.RegInstanceIDCallback(__ns.extern_callback, __ns.extern_revoke, __ns.extern_mark_as_local);
		--
		__ns.bak_INSTANCE_RESET_FAILED = INSTANCE_RESET_FAILED;
		__ns.instance_reset_failed_pattern = gsub(INSTANCE_RESET_FAILED, "%%s", "(.+)");
		__ns.bak_INSTANCE_RESET_SUCCESS = INSTANCE_RESET_SUCCESS;
		__ns.instance_reset_success_pattern = gsub(INSTANCE_RESET_SUCCESS, "%%s", "(.+)");
		_EventHandler:RegEvent("CHAT_MSG_SYSTEM");
	end
	_EventHandler:RegEvent("ADDON_LOADED");
-->		SLASH & CONFIG
	_G.SLASH_ALAINSTANCETIMER1 = "/alainstancetimer";
	_G.SLASH_ALAINSTANCETIMER2 = "/alainsttimer";
	_G.SLASH_ALAINSTANCETIMER3 = "/alainst";
	_G.SLASH_ALAINSTANCETIMER4 = "/ait";
	_G.SLASH_ALAINSTANCETIMER5 = "/instancelockedo";
	_G.SLASH_ALAINSTANCETIMER6 = "/ilt";
	SlashCmdList["ALAINSTANCETIMER"] = function(msg)
		if strfind(msg, "^toggle_enabled") then
			if SET.enabled then
				__ns.DisableUI();
			else
				__ns.EnableUI();
			end
		elseif strfind(msg, "^enable") or strfind(msg, "^on") then
			__ns.EnableUI();
		elseif strfind(msg, "^disable") or strfind(msg, "^off") then
			__ns.DisableUI();
		elseif strfind(msg, "^toggle_lock") then
			if SET.locked then
				__ns.UnlockUI();
			else
				__ns.LockUI();
			end
		elseif strfind(msg, "^lock") then
			__ns.LockUI();
		elseif strfind(msg, "^unlock") then
			__ns.UnlockUI();
		elseif strfind(msg, "^reset_pos") then
			SET.pos = nil;
			__ns.ui:ClearAllPoints();
			__ns.ui:SetPoint(__ns.GetDefPos());
		elseif strfind(msg, "^hide_key_tip") then
			SET.hide_key_tip = true;
		elseif strfind(msg, "^show_key_tip") then
			SET.hide_key_tip = false;
		elseif strfind(msg, "^hide_notice") then
			SET.hide_notice = true;
		elseif strfind(msg, "^show_notice") then
			SET.hide_notice = false;
		end
	end
	function __ns.GetConfig(key)
		return SET[key];
	end
-->

