--[[--
	by ALA @ 163UI
	RECIPES DATA CREDITS ATLASLOOT & MTSL, MIXING DATA FROM DB.NFUWOW.COM
	配方数据来源于AtlasLoot和MissingTradeSkillList，部分修改来源于nfu数据库
	Please Keep WOW Addon open-source & Reduce barriers for others.
	复用代码请在显著位置标注来源【ALA@网易有爱】
	不欢迎加密和乱码发布的整合包、插件作者、插件修改者
	##	2020-02-18
		Blacksmithing
			20039	Dark Iron Boots	黑铁长靴
			recipe_info		pid = 2, xid = 20039, {  nil, 20039, #MOD#3, 24399, ... }
			recipe_phase	pid = 2, xid = 20039, #MOD#3
--]]--
----------------------------------------------------------------------------------------------------
do return end
local ADDON, NS = ...;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
local control_independent = true;

do
	local _G = _G;
	if NS.__fenv == nil then
		NS.__fenv = setmetatable({  },
				{
					__index = _G,
					__newindex = function(t, key, value)
						rawset(t, key, value);
						print("atf assign global", key, value);
						return value;
					end,
				}
			);
	end
	setfenv(1, NS.__fenv);
end

-- local L = NS.L;
-- if not L then return;end
local curPhase = 3;
----------------------------------------------------------------------------------------------------upvalue
	----------------------------------------------------------------------------------------------------LUA
	local math, table, string, bit = math, table, string, bit;
	local type = type;
	local assert, collectgarbage, date, difftime, error, getfenv, getmetatable, loadstring, next, newproxy, pcall, select, setfenv, setmetatable, time, type, unpack, xpcall, rawequal, rawget, rawset =
			assert, collectgarbage, date, difftime, error, getfenv, getmetatable, loadstring, next, newproxy, pcall, select, setfenv, setmetatable, time, type, unpack, xpcall, rawequal, rawget, rawset;
	local abs, acos, asin, atan, atan2, ceil, cos, deg, exp, floor, fmod, frexp,ldexp, log, log10, max, min, mod, rad, random, sin, sqrt, tan, fastrandom =
			abs, acos, asin, atan, atan2, ceil, cos, deg, exp, floor, fmod or math.fmod, frexp,ldexp, log, log10, max, min, mod, rad, random, sin, sqrt, tan, fastrandom;
	local format, gmatch, gsub, strbyte, strchar, strfind, strlen, strlower, strmatch, strrep, strrev, strsub, strupper, tonumber, tostring =
			format, gmatch, gsub, strbyte, strchar, strfind, strlen, strlower, strmatch, strrep, strrev, strsub, strupper, tonumber, tostring;
	local strcmputf8i, strlenutf8, strtrim, strsplit, strjoin, strconcat, tostringall = strcmputf8i, strlenutf8, strtrim, strsplit, strjoin, strconcat, tostringall;
	local ipairs, pairs, sort, tContains, tinsert, tremove, wipe = ipairs, pairs, sort, tContains, tinsert, tremove, wipe;
	-- local gcinfo, foreach, foreachi, getn = gcinfo, foreach, foreachi, getn;	-- Deprecated
	----------------------------------------------------------------------------------------------------GAME
	local _G = _G;
	local print = print;
	local CreateFrame = CreateFrame;
	local GetCursorPosition = GetCursorPosition;
	local IsAltKeyDown = IsAltKeyDown;
	local IsControlKeyDown = IsControlKeyDown;
	local IsShiftKeyDown = IsShiftKeyDown;
	--------------------------------------------------
	-- local RegisterAddonMessagePrefix = RegisterAddonMessagePrefix or C_ChatInfo.RegisterAddonMessagePrefix;
	-- local IsAddonMessagePrefixRegistered = IsAddonMessagePrefixRegistered or C_ChatInfo.IsAddonMessagePrefixRegistered;
	-- local GetRegisteredAddonMessagePrefixes = GetRegisteredAddonMessagePrefixes or C_ChatInfo.GetRegisteredAddonMessagePrefixes;
	-- local SendAddonMessage = SendAddonMessage or C_ChatInfo.SendAddonMessage;
	-- local SendAddonMessageLogged = SendAddonMessageLogged or C_ChatInfo.SendAddonMessageLogged;
	--------------------------------------------------
	local function _log_(...)
		-- print(date('\124cff00ff00%H:%M:%S\124r'), ...);
	end
	local function _error_(...)
		print(date('\124cffff0000%H:%M:%S\124r'), ...);
	end
	local function _noop_()
	end
	--------------------------------------------------
	--[[
		TAG:
			-- NEED VALIDATE
	]]
----------------------------------------------------------------------------------------------------
local LOCALE = GetLocale();
local L = {  };
do
	if LOCALE == "zhCN" or LOCALE == "zhTW" then
		L["OK"] = "确定";
		L["Search"] = "搜索";
		L["Open"] = "打开搜索";
		L["Close"] = "关闭搜索";
		L["add_fav"] = "添加收藏";
		L["sub_fav"] = "取消收藏";
		L["showKnown"] = "已学";
		L["showUnkown"] = "未学";
		L["showHighRank"] = "高等级";
		L["showItemInsteadOfSpell"] = "物品";
		L["showRank"] = "等级";
		L["coverMode"] = "coverMode";
		--
		L["rank_level"] = "技能等级";
		L["get_from"] = "来源";
		L["quest"] = "任务";
		L["item"] = "物品";
		L["trainer"] = "训练师";
		L["quest_reward"] = "任务奖励";
		L["quest_accepted_from"] = "开始于";
		L["sold_by"] = "出售";
		L["dropped_by"] = "掉落自";
		L["world_drop"] = "世界掉落";
		L["dropped_by_mod_level"] = "怪物等级";
		L["tradable"] = "可交易";
		L["non_tradable"] = "不可交易";
		L["elite"] = "精英";
		L["phase"] = "阶段";
		L["not_available_for_player's_faction"] = "不适用于当前角色阵营";
		L["available_in_phase_"] = "开放于阶段: ";

		L["Needs: "] = "材料: ";
		L["Unk"] = "未知";
		L["UNK_ITEM_ID"] = "\124cffff0000未知物品ID\124r";
		L["AH_PRICE"] = "\124cff00ff00价格\124r";
		L["VENDOR_RPICE"] = "\124cffffaf00商人\124r";
		L["COST_PRICE"] = "\124cffff7f00成本\124r";
		L["COST_PRICE_KNOWN"] = "\124cffff0000已缓存成本\124r";
		L["UNKOWN_PRICE"] = "未知价格";
		L["PRICE_DIFF+"] = "\124cff00ff00差价\124r";
		L["PRICE_DIFF-"] = "\124cffff0000差价\124r";
		L["PRICE_DIFF0"] = "持平";
		L["PRICE_DIFF_INFO+"] = "\124cff00ff00利润\124r";
		L["PRICE_DIFF_INFO-"] = "\124cffff0000亏损\124r";
		L["CRAFT_INFO"] = "\124cffff7f00商业技能制造信息: \124r";
		L["UNKONWN_PROFESSION"] = "未知技能";
		L["PROFIT_FRAME_CALL_INFO1"] = "\124cffffffff我想赚点零花钱! \124r";
		L["ITEMS_UNK"] = "项未知";
		L["NEED_UPDATE"] = "\124cffff0000!!需要刷新!!\124r";
	else
		L["OK"] = "OK";
		L["Search"] = "Search";
		L["Open"] = "Open";
		L["Close"] = "Close";
		L["add_fav"] = "Favorite";
		L["sub_fav"] = "Unfavorite";
		L["showKnown"] = "Known";
		L["showUnkown"] = "Unknown";
		L["showHighRank"] = "High Rank";
		L["showItemInsteadOfSpell"] = "Items";
		L["show_rank"] = "Rank";
		L["coverMode"] = "coverMode";
		--
		L["rank_level"] = "Rank";
		L["get_from"] = "Get from";
		L["quest"] = "Quest";
		L["item"] = "Item";
		L["trainer"] = "Trainer";
		L["quest_reward"] = "Quest reward";
		L["quest_accepted_from"] = "Quest given by";
		L["sold_by"] = "Sold by";
		L["dropped_by"] = "Dropped by";
		L["world_drop"] = "World drop";
		L["dropped_by_mod_level"] = "Mob Lv";
		L["tradable"] = "Tradable";
		L["non_tradable"] = "Non-tradable";
		L["elite"] = "Elite";
		L["phase"] = "Phase";
		L["not_available_for_player's_faction"] = "Not available for player's faction";
		L["available_in_phase_"] = "Available in phase ";

		L["Needs: "] = "Needs: ";
		L["Unk"] = "Unknown";
		L["UNK_ITEM_ID"] = "\124cffff0000Unkown item id\124r";
		L["AH_PRICE"] = "\124cff00ff00AH\124r";
		L["VENDOR_RPICE"] = "\124cffffaf00Vendor\124r";
		L["COST_PRICE"] = "\124cffff7f00Cost\124r";
		L["COST_PRICE_KNOWN"] = "\124cffff0000Known Material\124r";
		L["UNKOWN_PRICE"] = "Unkown";
		L["PRICE_DIFF+"] = "\124cff00ff00Price diff\124r";
		L["PRICE_DIFF-"] = "\124cffff0000Price diff\124r";
		L["PRICE_DIFF0"] = "The same";
		L["PRICE_DIFF_INFO+"] = "\124cff00ff00Profit\124r";
		L["PRICE_DIFF_INFO-"] = "\124cffff0000Loss\124r";
		L["CRAFT_INFO"] = "\124cffff7f00Craft info: \124r";
		L["UNKONWN_PROFESSION"] = "Unknown profession";
		L["PROFIT_FRAME_CALL_INFO1"] = "\124cffffffffI want to make some money! \124r";
		L["ITEMS_UNK"] = "items unk";
		L["NEED_UPDATE"] = "\124cffff0000!!Need refresh!!\124r";
	end
end

local mtsl_locale_list = {
	def = "English",
	["frFR"] = "French",
	["deDE"] = "German",
	["ruRU"] = "Russian",
	["koKR"] = "Korean",
	["zhCN"] = "Chinese",
	["zhTW"] = "Chinese",
	["esES"] = "Spanish",
	["ptBR"] = "Portuguese",
};

local LOCALIZED_LOC = {
	zhCN = {
		INVTYPE_CLOAK = "披风",
		INVTYPE_CHEST = "胸甲",
		INVTYPE_WRIST = "护腕",
		INVTYPE_HAND = "手套",
		INVTYPE_FEET = "靴子",
		INVTYPE_WEAPON = "武器",
		INVTYPE_SHIELD = "盾牌",
		NONE = "没有匹配的附魔",
	},
	zhTW = {
		INVTYPE_CLOAK = "披風",
		INVTYPE_CHEST = "胸甲",
		INVTYPE_WRIST = "護腕",
		INVTYPE_HAND = "手套",
		INVTYPE_FEET = "長靴",
		INVTYPE_WEAPON = "武器",
		INVTYPE_SHIELD = "盾牌",
		NONE = "沒有匹配的附魔",
	},
	enUS = {
		INVTYPE_CLOAK = "Cloak",
		INVTYPE_CHEST = "Chest",
		INVTYPE_WRIST = "Bracer",
		INVTYPE_HAND = "Glove",
		INVTYPE_FEET = "Boot",
		INVTYPE_WEAPON = "Weapon",
		INVTYPE_SHIELD = "Shield",
		NONE = "No matched enchating recipe",
	},
	deDE = {
		INVTYPE_CLOAK = "Umhang",
		INVTYPE_CHEST = "Brust",
		INVTYPE_WRIST = "Armschiene",
		INVTYPE_HAND = "Handschuhe",
		INVTYPE_FEET = "Stiefel",
		INVTYPE_WEAPON = "Waffe",
		INVTYPE_SHIELD = "Schild",
		NONE = "No matched enchating recipe",
	},
	esES = {	-- esMX
		INVTYPE_CLOAK = "capa",
		INVTYPE_CHEST = "pechera",
		INVTYPE_WRIST = "brazal",
		INVTYPE_HAND = "guantes",
		INVTYPE_FEET = "botas",
		INVTYPE_WEAPON = "arma",
		INVTYPE_SHIELD = "escudo",
		NONE = "No matched enchating recipe",
	},
	frFR = {
		INVTYPE_CLOAK = "cape",
		INVTYPE_CHEST = "plastron",
		INVTYPE_WRIST = "bracelets",
		INVTYPE_HAND = "gants",
		INVTYPE_FEET = "bottes",
		INVTYPE_WEAPON = "d'arme",
		INVTYPE_SHIELD = "bouclier",
		NONE = "No matched enchating recipe",
	},
	ptBR = {
		INVTYPE_CLOAK = "Manto",
		INVTYPE_CHEST = "Torso",
		INVTYPE_WRIST = "Braçadeiras",
		INVTYPE_HAND = "Luvas",
		INVTYPE_FEET = "Botas",
		INVTYPE_WEAPON = "Arma",
		INVTYPE_SHIELD = "Escudo",
		NONE = "No matched enchating recipe",
	},
	ruRU = {
		INVTYPE_CLOAK = "плаща",
		INVTYPE_CHEST = "нагрудника",
		INVTYPE_WRIST = "браслетов",
		INVTYPE_HAND = "перчаток",
		INVTYPE_FEET = "обуви",
		INVTYPE_WEAPON = "оружия",
		INVTYPE_SHIELD = "щита",
		NONE = "No matched enchating recipe",
	},
	koKR = {
		INVTYPE_CLOAK = "망토",
		INVTYPE_CHEST = "가슴보호구",
		INVTYPE_WRIST = "손목보호구",
		INVTYPE_HAND = "장갑",
		INVTYPE_FEET = "장화",
		INVTYPE_WEAPON = "무기",
		INVTYPE_SHIELD = "방패",
		NONE = "No matched enchating recipe",
	},
};
for _, v in pairs(LOCALIZED_LOC) do
	v.INVTYPE_ROBE = v.INVTYPE_CHEST;
	v.INVTYPE_2HWEAPON = v.INVTYPE_WEAPON;
	v.INVTYPE_WEAPONMAINHAND = v.INVTYPE_WEAPON;
	v.INVTYPE_WEAPONOFFHAND = v.INVTYPE_WEAPON;
end
LOCALIZED_LOC.esMX = esES;

local ui_style = {
	frame_width = 360,
	frame_width_narrow = 240;
	button_height = 16,

	frameBackdrop = {
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",	-- "Interface\\Buttons\\WHITE8X8",	-- "Interface\\Tooltips\\UI-Tooltip-Background", -- "Interface\\ChatFrame\\ChatFrameBackground"
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileSize = 2,
		edgeSize = 2,
		insets = { left = 0, right = 0, top = 0, bottom = 0, }
	},
	frameBackdropColor = { 0.05, 0.05, 0.05, 1.0, },
	frameBackdropBorderColor = { 0.0, 0.0, 0.0, 1.0, },
	buttonBackdrop = {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileSize = 2,
		edgeSize = 2,
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	};
	buttonBackdropColor = { 0.25, 0.25, 0.25, 0.75 };
	buttonBackdropBorderColor = { 0.0, 0.0, 0.0, 1.0 };

	frameFont = SystemFont_Shadow_Med1:GetFont(),--=="Fonts\ARKai_T.ttf"
	frameFontSize = 15,
	frameFontOutline = "NORMAL",
};
local rank_color = {
	['optimal'] = { 1.0, 0.5, 0.35, 1.0, },
	['medium'] = { 1.0, 1.0, 0.25, 1.0, },
	['easy'] = { 0.25, 1.0, 0.25, 1.0, },
	['trivial'] = { 0.5, 0.5, 0.5, 1.0, },
};
local rank_index = {
	['optimal'] = 1,
	['medium'] = 2,
	['easy'] = 3,
	['trivial'] = 4,
};

local BIG_NUMBER = 4294967295;
----------------------------------------------------------------------------------------------------
local prof = {  };
_G.__ala_meta__.prof = prof;
local _EventHandler = CreateFrame("Frame");
local config = nil;
local merc = nil;
local default = {
	showKnown = true,
	showUnkown = false,
	showHighRank = false,
	showRank = true,
	showItemInsteadOfSpell = false,
	coverMode = true,
	shown = true,
	phase = curPhase,
	showConfig = false,
	--
};

do	-- InsertLink
	if not _G.ALA_HOOK_ChatEdit_InsertLink then
		local handlers_name = {  };
		local handlers_link = {  };
		function _G.ALA_INSERT_LINK(link, ...)
			if not link then return; end
			if #handlers_link > 0 then
				for _, func in pairs(handlers_link) do
					if func(link, ...) then
						return true;
					end
				end
			end
		end
		function _G.ALA_INSERT_NAME(name, ...)
			if not name then return; end
			if #handlers_name > 0 then
				for _, func in pairs(handlers_name) do
					if func(name, ...) then
						return true;
					end
				end
			end
		end
		function _G.ALA_HOOK_ChatEdit_InsertName(func)
			for _, v in pairs(handlers_name) do
				if func == v then
					return;
				end
			end
			tinsert(handlers_name, func);
		end
		function _G.ALA_UNHOOK_ChatEdit_InsertName(func)
			for i, v in pairs(handlers_name) do
				if func == v then
					tremove(handlers_name, i);
					return;
				end
			end
		end
		function _G.ALA_HOOK_ChatEdit_InsertLink(func)
			for _, v in pairs(handlers_link) do
				if func == v then
					return;
				end
			end
			tinsert(handlers_link, func);
		end
		function _G.ALA_UNHOOK_ChatEdit_InsertLink(func)
			for i, v in pairs(handlers_link) do
				if func == v then
					tremove(handlers_link, i);
					return;
				end
			end
		end
		local __ChatEdit_InsertLink = ChatEdit_InsertLink;
		function _G.ChatEdit_InsertLink(link, addon, ...)
			if not link then return; end
			if addon == false then
				return __ChatEdit_InsertLink(link, addon, ...);
			end
			local editBox = ChatEdit_ChooseBoxForSend();
			if not editBox:HasFocus() then
				if _G.ALA_INSERT_LINK(link, addon, ...) then
					return true;
				end
			end
			return __ChatEdit_InsertLink(link, addon, ...);
		end
	end
end

local function button_info_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	if self.info_lines then
		for _, v in pairs(self.info_lines) do
			GameTooltip:AddLine(v);
		end
	end
	GameTooltip:Show();
end
local function button_info_OnLeave(self)
	if GameTooltip:IsOwned(self) then
		GameTooltip:Hide();
	end
end

do	-- MAIN
	local player_prof = {  };
	local index_cid = 2;
	local index_phase = 3;
	local index_sid = 4;
	local index_rid = 5;
	local index_learn_rank = 6;
	local index_yellow_rank = 7;
	local index_green_rank = 8;
	local index_grey_rank = 9;
	local index_num_made_min = 10;
	local index_num_made_max = 11;
	local index_reagents_id = 12;
	local index_reagents_count = 13;
	local index_trainer = 14;
	local index_train_price = 15;
	local index_quest = 16;
	local index_object = 17;
	-- for enchanting xid = sid (because GetCraftItemLink returns sid), for others xid = cid
	--  [xid]    = {  1cid, 2p, 3sid, 4rid, 5learn_rank, 6yellow_rank, 7green_rank, 8grey_rank, 9num_made, 10reagents_id, 11reagents_count, 12trainer, 13trainer_price, 14quest, 15object, }
	--  [xid]    = {  1validated, 2cid, 3p, 4sid, 5rid, 6learn_rank, 7yellow_rank, 8green_rank, 9grey_rank, 10num_made_min, 11num_made_max, 
	--																				, 12reagents_id, 13reagents_count, 14trainer, 15trainer_price, 16quest, 17object, }
	do	-- DB CREDIT ATLASLOOT & MTSL
		local tradeskill_id = {
			[1] = 3273,		-- FirstAid
			[2] = 2018,		-- Blacksmithing
			[3] = 2108,		-- Leatherworking
			[4] = 2259,		-- Alchemy
			[5] = 2383,		-- Herbalism		UNUSED
			[6] = 2550,		-- Cooking
			[7] = 2575,		-- Mining
			[8] = 3908,		-- Tailoring
			[9] = 4036,		-- Engineering
			[10] = 7411,	-- Enchanting
			[13] = 2842,	-- RoguePoisons
		};
		local tradeskill_check_id = {
			[1] = 3273,		-- FirstAid
			[2] = 2018,		-- Blacksmithing
			[3] = 2108,		-- Leatherworking
			[4] = 2259,		-- Alchemy
			[5] = 2383,		-- Herbalism		UNUSED
			[6] = 2550,		-- Cooking
			[7] = 2656,		-- Mining
			[8] = 3908,		-- Tailoring
			[9] = 4036,		-- Engineering
			[10] = 7411,	-- Enchanting
			[11] = 7620,	-- Fishing
			[12] = 8613,	-- Skinning
			-- [13] = 2842,	-- RoguePoisons
		};
		local tradeskill_texture = {
			[1] = "Interface\\Icons\\spell_holy_sealofsacrifice",
			[2] = "Interface\\Icons\\trade_blacksmithing",
			[3] = "Interface\\Icons\\trade_leatherworking",
			[4] = "Interface\\Icons\\trade_alchemy",
			[5] = "Interface\\Icons\\trade_herbalism",
			[6] = "Interface\\Icons\\inv_misc_food_15",
			[7] = "Interface\\Icons\\trade_mining",
			[8] = "Interface\\Icons\\trade_tailoring",
			[9] = "Interface\\Icons\\trade_engineering",
			[10] = "Interface\\Icons\\trade_engraving",
			[13] = "Interface\\Icons\\trade_brewpoison",
			-- [] = "Interface\\Icons\\trade_fishing",	-- FISHING
		}
		local recipe_info = {
			[1] = {
				[1251]  = { true,  1251, 1,  3275,   nil,   1,  30,  45,  60,   1,   1, { 2589, }, { 1, }, { 2326, 2327, 2329, 2798, 3181, 3373, 4211, 4591, 5150, 5759, 5939, 5943, 6094, }, 0, },
				[2581]  = { true,  2581, 1,  3276,   nil,  40,  50,  75, 100,   1,   1, { 2589, }, { 2, }, { 2326, 2327, 2329, 2798, 3181, 3373, 4211, 4591, 5150, 5759, 5939, 5943, 6094, }, 0, },
				[3530]  = { true,  3530, 1,  3277,   nil,  80,  80, 115, 150,   1,   1, { 2592, }, { 1, }, { 2326, 2327, 2329, 2798, 3181, 3373, 4211, 4591, 5150, 5759, 5939, 5943, 6094, }, 0, },
				[6452]  = { true,  6452, 1,  7934,   nil,  80,  80, 115, 150,   3,   3, { 1475, }, { 1, }, { 2326, 2327, 2329, 2798, 3181, 3373, 4211, 4591, 5150, 5759, 5939, 5943, 6094, }, 0, },
				[3531]  = { true,  3531, 1,  3278,   nil, 115, 115, 150, 185,   1,   1, { 2592, }, { 2, }, { 2326, 2327, 2329, 2798, 3181, 3373, 4211, 4591, 5150, 5759, 5939, 5943, 6094, }, 0, },
				[6453]  = { true,  6453, 1,  7935,  6454, 130, 130, 165, 200,   3,   3, { 1288, }, { 1, }, },
				[6450]  = { true,  6450, 1,  7928,   nil, 150, 150, 180, 210,   1,   1, { 4306, }, { 1, }, { 2326, 2327, 2329, 2798, 3181, 3373, 4211, 4591, 5150, 5759, 5939, 5943, 6094, }, 0, },
				[6451]  = { true,  6451, 1,  7929, 16112, 180, 180, 210, 240,   1,   1, { 4306, }, { 2, }, },
				[8544]  = { true,  8544, 1, 10840, 16113, 210, 210, 240, 270,   1,   1, { 4338, }, { 1, }, },
				[8545]  = { true,  8545, 1, 10841,   nil, 240, 240, 270, 300,   1,   1, { 4338, }, { 2, }, { 12920, 12939, }, 0, },
				[14529] = { true, 14529, 1, 18629,   nil, 260, 260, 290, 320,   1,   1, { 14047, }, { 1, }, { 12920, 12939, }, 0, },
				[14530] = { true, 14530, 1, 18630,   nil, 290, 290, 320, 350,   1,   1, { 14047, }, { 2, }, { 12920, 12939, }, 0, },
				[19440] = {  nil, 19440, 3, 23787, 19442, 300, 300, 330, 360,   1,   1, { 19441, }, { 1, }, },
				[23684] = {  nil, 23684, 1, 30021, 23689, 300, 300, 330, 360,   4,   4, { 23567, 14047, }, { 1, 10, }, },
			},
			[2] = {
				[2852]  = { true,  2852, 1,  2662,   nil,   1,  50,  70,  90,   1,   1, { 2840, }, { 4, }, { 514, 957, 1241, 3174, 3557, 4605, 6299, 10266, 10277, 10278, }, 0, },
				[2853]  = { true,  2853, 1,  2663,   nil,   1,  20,  40,  60,   1,   1, { 2840, }, { 2, }, { 514, 957, 1241, 1383, 2836, 2998, 3174, 3355, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[10421] = { true, 10421, 1, 12260,   nil,   1,  15,  35,  55,   1,   1, { 2840, }, { 4, }, { 514, 957, 1241, 1383, 2836, 2998, 3174, 3355, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[3239]  = { true,  3239, 1,  3115,   nil,   1,  15,  35,  55,   1,   1, { 2835, 2589, }, { 1, 1, }, { 514, 957, 1241, 1383, 2836, 2998, 3174, 3355, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[2862]  = { true,  2862, 1,  2660,   nil,   1,  15,  35,  55,   1,   1, { 2835, }, { 1, }, { 514, 957, 1241, 1383, 2836, 2998, 3174, 3355, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[2844]  = { true,  2844, 1,  2737,   nil,  15,  55,  75,  95,   1,   1, { 2840, 2880, 2589, }, { 6, 1, 2, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[2845]  = { true,  2845, 1,  2738,   nil,  20,  60,  80, 100,   1,   1, { 2840, 2880, 2589, }, { 6, 1, 2, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[3469]  = { true,  3469, 1,  3319,   nil,  20,  60,  80, 100,   1,   1, { 2840, }, { 8, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[3470]  = { true,  3470, 1,  3320,   nil,  25,  45,  65,  85,   1,   1, { 2835, }, { 2, }, { 514, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[2847]  = { true,  2847, 1,  2739,   nil,  25,  65,  85, 105,   1,   1, { 2840, 2880, 2589, }, { 6, 1, 2, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[7166]  = { true,  7166, 1,  8880,   nil,  30,  70,  90, 110,   1,   1, { 2840, 2880, 3470, 2318, }, { 6, 1, 1, 1, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[7955]  = { true,  7955, 1,  9983,   nil,  30,  70,  90, 110,   1,   1, { 2840, 2880, 3470, 2318, }, { 10, 2, 1, 1, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[3488]  = { true,  3488, 1,  3293,   nil,  35,  75,  95, 115,   1,   1, { 2840, 2880, 774, 3470, 2318, }, { 12, 2, 2, 2, 2, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[3471]  = { true,  3471, 1,  3321,  3609,  35,  75,  95, 115,   1,   1, { 2840, 774, 3470, }, { 8, 1, 2, }, },
				[2851]  = { true,  2851, 1,  2661,   nil,  35,  75,  95, 115,   1,   1, { 2840, }, { 6, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[3472]  = { true,  3472, 1,  3323,   nil,  40,  80, 100, 120,   1,   1, { 2840, 3470, }, { 8, 2, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[3473]  = { true,  3473, 1,  3324,   nil,  45,  85, 105, 125,   1,   1, { 2840, 2321, 3470, }, { 8, 2, 3, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[3474]  = { true,  3474, 1,  3325,  3610,  60, 100, 120, 140,   1,   1, { 2840, 818, 774, }, { 8, 1, 1, }, },
				[3240]  = { true,  3240, 1,  3116,   nil,  65,  65,  72,  80,   1,   1, { 2836, 2592, }, { 1, 1, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[6214]  = { true,  6214, 1,  7408,   nil,  65, 105, 125, 145,   1,   1, { 2840, 2880, 2318, }, { 12, 2, 2, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[2863]  = { true,  2863, 1,  2665,   nil,  65,  65,  72,  80,   1,   1, { 2836, }, { 1, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[6730]  = {  nil,  6730, 1,  8366,   nil,  70, 110, 130, 150,   1,   1, { 2840, 774, 3470, }, { 12, 2, 2, }, { 514, 957, 1241, 1383, 2836, 2998, 3174, 3355, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[2857]  = { true,  2857, 1,  2666,   nil,  70, 110, 130, 150,   1,   1, { 2840, }, { 10, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[3489]  = { true,  3489, 1,  3294,   nil,  70, 110, 130, 150,   1,   1, { 2840, 2880, 2842, 3470, 2318, }, { 10, 2, 2, 2, 2, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[3478]  = { true,  3478, 1,  3326,   nil,  75,  75,  87, 100,   1,   1, { 2836, }, { 2, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[2864]  = { true,  2864, 1,  2667,  2881,  80, 120, 140, 160,   1,   1, { 2840, 1210, 3470, }, { 12, 1, 2, }, },
				[2854]  = { true,  2854, 1,  2664,   nil,  90, 115, 127, 140,   1,   1, { 2840, 3470, }, { 10, 3, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[3487]  = { true,  3487, 1,  3292,   nil,  90, 135, 155, 175,   1,   1, { 2840, 2880, 818, 2319, }, { 14, 2, 2, 2, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[6350]  = { true,  6350, 1,  7817,   nil,  95, 125, 140, 155,   1,   1, { 2841, 3470, }, { 6, 6, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[6338]  = { true,  6338, 1,  7818,   nil, 100, 105, 107, 110,   1,   1, { 2842, 3470, }, { 1, 2, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[15869] = { true, 15869, 1, 19666,   nil, 100, 100, 110, 120,   2,   2, { 2842, 3470, }, { 1, 1, }, { 1383, 2998, 3136, 3478, 4596, 5511, 10276, }, 0, },
				[3848]  = { true,  3848, 1,  3491,   nil, 100, 135, 150, 165,   1,   1, { 2841, 2880, 3470, 818, 2319, }, { 6, 4, 2, 1, 1, }, { 1383, 2998, 3136, 3478, 4596, 5511, 10276, }, 0, },
				[6731]  = { true,  6731, 1,  8367,  6735, 100, 140, 160, 180,   1,   1, { 2840, 818, 3470, }, { 16, 2, 3, }, },
				[2867]  = {  nil,  2867, 1,  2671,  5577, 100, 145, 160, 175,   1,   1, { 2841, }, { 4, }, },
				[2865]  = { true,  2865, 1,  2668,   nil, 105, 145, 160, 175,   1,   1, { 2841, }, { 6, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[2866]  = { true,  2866, 1,  2670,   nil, 105, 145, 160, 175,   1,   1, { 2841, }, { 7, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[2848]  = { true,  2848, 1,  2740,   nil, 110, 140, 155, 170,   1,   1, { 2841, 2880, 2319, }, { 6, 4, 1, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[3480]  = { true,  3480, 1,  3328,   nil, 110, 140, 155, 170,   1,   1, { 2841, 1210, 3478, }, { 5, 1, 1, }, { 1383, 2998, 3136, 3478, 4596, 5511, 10276, }, 0, },
				[2849]  = { true,  2849, 1,  2741,   nil, 115, 145, 160, 175,   1,   1, { 2841, 2880, 2319, }, { 7, 4, 1, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[5540]  = { true,  5540, 1,  6517,   nil, 115, 140, 155, 170,   1,   1, { 2841, 3466, 5498, 3478, }, { 6, 1, 2, 2, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[2868]  = { true,  2868, 1,  2672,   nil, 120, 150, 165, 180,   1,   1, { 2841, 3478, }, { 5, 2, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[2850]  = { true,  2850, 1,  2742,   nil, 120, 150, 165, 180,   1,   1, { 2841, 2880, 2319, }, { 5, 4, 2, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[2871]  = { true,  2871, 1,  2674,   nil, 125, 125, 132, 140,   1,   1, { 2838, }, { 1, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[3241]  = { true,  3241, 1,  3117,   nil, 125, 125, 132, 140,   1,   1, { 2838, 2592, }, { 1, 1, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[3486]  = { true,  3486, 1,  3337,   nil, 125, 125, 137, 150,   1,   1, { 2838, }, { 3, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[3490]  = { true,  3490, 1,  3295,  2883, 125, 155, 170, 185,   1,   1, { 2841, 3466, 2459, 1210, 3478, 2319, }, { 4, 1, 1, 2, 2, 2, }, },
				[3481]  = { true,  3481, 1,  3330,  2882, 125, 155, 170, 185,   1,   1, { 2841, 2842, 3478, }, { 8, 2, 2, }, },
				[7956]  = { true,  7956, 1,  9985,   nil, 125, 155, 170, 185,   1,   1, { 2841, 3466, 2319, }, { 8, 1, 1, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[3491]  = { true,  3491, 1,  3296,   nil, 130, 160, 175, 190,   1,   1, { 2841, 3466, 1206, 1210, 3478, 2319, }, { 8, 1, 1, 1, 2, 2, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[3482]  = { true,  3482, 1,  3331,   nil, 130, 160, 175, 190,   1,   1, { 2841, 2842, 3478, }, { 6, 1, 2, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[7957]  = { true,  7957, 1,  9986,   nil, 130, 160, 175, 190,   1,   1, { 2841, 3466, 2319, }, { 12, 2, 2, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[2869]  = { true,  2869, 1,  2673,  5578, 130, 160, 175, 190,   1,   1, { 2841, 2842, 3478, 1705, }, { 10, 2, 2, 1, }, },
				[3483]  = { true,  3483, 1,  3333,   nil, 135, 165, 180, 195,   1,   1, { 2841, 2842, 3478, }, { 8, 1, 2, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[7958]  = { true,  7958, 1,  9987,   nil, 135, 165, 180, 195,   1,   1, { 2841, 3466, 2319, }, { 14, 1, 2, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[6733]  = {  nil,  6733, 1,  8368,   nil, 140, 170, 185, 200,   1,   1, { 2841, 1210, 3478, }, { 8, 3, 4, }, { 514, 957, 1241, 1383, 2836, 2998, 3174, 3355, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[5541]  = { true,  5541, 1,  6518,  5543, 140, 170, 185, 200,   1,   1, { 2841, 3466, 5500, 3478, 2319, }, { 10, 1, 1, 2, 2, }, },
				[2870]  = { true,  2870, 1,  2675,   nil, 145, 175, 190, 205,   1,   1, { 2841, 1206, 1705, 5500, 2842, }, { 20, 2, 2, 2, 4, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[3492]  = { true,  3492, 1,  3297,  3608, 145, 175, 190, 205,   1,   1, { 3575, 3466, 3391, 1705, 3478, 2319, }, { 6, 2, 1, 2, 2, 2, }, },
				[3484]  = { true,  3484, 1,  3334,  3611, 145, 175, 190, 205,   1,   1, { 3575, 1705, 3478, 2605, }, { 4, 2, 2, 1, }, },
				[3485]  = { true,  3485, 1,  3336,  3612, 150, 180, 195, 210,   1,   1, { 3575, 5498, 3478, 2605, }, { 4, 2, 2, 1, }, },
				[11128] = { true, 11128, 1, 14379,   nil, 150, 155, 157, 160,   1,   1, { 3577, 3478, }, { 1, 2, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[6042]  = { true,  6042, 1,  7221,  6044, 150, 180, 195, 210,   1,   1, { 3575, 3478, }, { 6, 4, }, },
				[15870] = { true, 15870, 1, 19667,   nil, 150, 150, 160, 170,   2,   2, { 3577, 3486, }, { 1, 1, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[7071]  = { true,  7071, 1,  8768,   nil, 150, 150, 152, 155,   2,   2, { 3575, }, { 1, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 0, },
				[3851]  = { true,  3851, 1,  3494, 10858, 155, 180, 192, 205,   1,   1, { 3575, 3466, 3486, 2842, 4234, }, { 8, 2, 1, 4, 2, }, },
				[10423] = { true, 10423, 1, 12259, 10424, 155, 180, 192, 205,   1,   1, { 2841, 2842, 3478, }, { 12, 4, 2, }, },
				[3842]  = { true,  3842, 1,  3506,   nil, 155, 180, 192, 205,   1,   1, { 3575, 3486, 2605, }, { 8, 1, 1, }, { 2836, 3355, 4258, }, 0, },
				[3849]  = { true,  3849, 1,  3492, 12162, 160, 185, 197, 210,   1,   1, { 3575, 3466, 3486, 1705, 4234, }, { 6, 2, 1, 2, 3, }, },
				[7913]  = {  nil,  7913, 1,  9811,  7978, 160, 185, 197, 210,   1,   1, { 3575, 5635, 1210, 3486, }, { 8, 4, 2, 2, }, },
				[7914]  = {  nil,  7914, 1,  9813,  7979, 160, 185, 197, 210,   1,   1, { 3575, 3486, }, { 20, 4, }, },
				[3840]  = { true,  3840, 1,  3504,  3870, 160, 185, 197, 210,   1,   1, { 3575, 3486, 2605, }, { 7, 1, 1, }, },
				[6043]  = { true,  6043, 1,  7222,  6045, 165, 190, 202, 215,   1,   1, { 3575, 3478, 1705, }, { 4, 2, 1, }, },
				[3835]  = { true,  3835, 1,  3501,   nil, 165, 190, 202, 215,   1,   1, { 3575, 2605, }, { 6, 1, }, { 2836, 3355, 4258, }, 0, },
				[3843]  = { true,  3843, 1,  3507,  3872, 170, 195, 207, 220,   1,   1, { 3575, 3577, 3486, }, { 10, 2, 1, }, },
				[3836]  = { true,  3836, 1,  3502,   nil, 170, 195, 207, 220,   1,   1, { 3575, 3864, 2605, }, { 12, 1, 1, }, { 2836, 3355, 4258, }, 0, },
				[3852]  = { true,  3852, 1,  3495,  3867, 170, 195, 207, 220,   1,   1, { 3575, 3577, 1705, 3466, 4234, 3486, }, { 10, 4, 2, 2, 2, 2, }, },
				[7915]  = {  nil,  7915, 1,  9814,  7980, 175, 200, 212, 225,   1,   1, { 3575, 5637, 5635, }, { 10, 2, 2, }, },
				[3841]  = { true,  3841, 1,  3505,  3871, 175, 200, 212, 225,   1,   1, { 3859, 3577, 3486, }, { 6, 2, 1, }, },
				[3850]  = { true,  3850, 1,  3493,  3866, 175, 200, 212, 225,   1,   1, { 3575, 3466, 3486, 1529, 4234, }, { 8, 2, 2, 2, 3, }, },
				[7916]  = {  nil,  7916, 1,  9818,  7981, 180, 205, 217, 230,   1,   1, { 3575, 5637, 818, 3486, }, { 12, 4, 4, 2, }, },
				[3844]  = { true,  3844, 1,  3508,   nil, 180, 205, 217, 230,   1,   1, { 3575, 3486, 1529, 1206, 4255, }, { 20, 4, 2, 2, 1, }, { 2836, 3355, 4258, }, 0, },
				[12259] = { true, 12259, 1, 15972,   nil, 180, 205, 217, 230,   1,   1, { 3859, 3466, 1206, 7067, 4234, }, { 10, 2, 1, 1, 1, }, { 2836, 3355, 4258, }, 0, },
				[3853]  = { true,  3853, 1,  3496, 12163, 180, 205, 217, 230,   1,   1, { 3859, 3466, 3486, 1705, 4234, }, { 8, 2, 2, 3, 3, }, },
				[7917]  = {  nil,  7917, 1,  9820,  7982, 185, 210, 222, 235,   1,   1, { 3575, 3486, 5637, }, { 14, 3, 2, }, },
				[3846]  = { true,  3846, 1,  3513,  3874, 185, 210, 222, 235,   1,   1, { 3859, 3864, 1705, 3486, }, { 8, 1, 1, 2, }, },
				[6040]  = { true,  6040, 1,  7223,   nil, 185, 210, 222, 235,   1,   1, { 3859, 3486, }, { 5, 2, }, { 2836, 3355, 4258, }, 0, },
				[3855]  = { true,  3855, 1,  3498, 12164, 185, 210, 222, 235,   1,   1, { 3575, 3466, 3486, 3577, 4234, }, { 14, 2, 2, 4, 2, }, },
				[12260] = {  nil, 12260, 1, 15973, 12261, 190, 215, 227, 240,   1,   1, { 3859, 3577, 7068, 4234, }, { 10, 4, 2, 2, }, },
				[3837]  = { true,  3837, 1,  3503,  6047, 190, 215, 227, 240,   1,   1, { 3859, 3577, 3486, }, { 8, 2, 2, }, },
				[6041]  = {  nil,  6041, 1,  7224,  6046, 190, 215, 227, 240,   1,   1, { 3859, 3486, 4234, }, { 8, 2, 4, }, },
				[17704] = { true, 17704, 1, 21913, 17706, 190, 215, 227, 240,   1,   1, { 3859, 3829, 7070, 7069, 4234, }, { 10, 1, 2, 2, 2, }, },
				[3845]  = { true,  3845, 1,  3511,  3873, 195, 220, 232, 245,   1,   1, { 3859, 3577, 3486, 1529, }, { 12, 2, 4, 2, }, },
				[11144] = { true, 11144, 1, 14380,   nil, 200, 205, 207, 210,   1,   1, { 6037, 3486, }, { 1, 1, }, { 2836, 3355, 4258, }, 0, },
				[3856]  = { true,  3856, 1,  3500,  3869, 200, 225, 237, 250,   1,   1, { 3859, 3466, 3486, 3864, 3824, 4234, }, { 10, 2, 3, 2, 1, 3, }, },
				[15871] = { true, 15871, 1, 19668,   nil, 200, 200, 210, 220,   2,   2, { 6037, 7966, }, { 1, 1, }, { 2836, 3355, 4258, }, 0, },
				[7965]  = { true,  7965, 1,  9921,   nil, 200, 200, 205, 210,   1,   1, { 7912, 4306, }, { 1, 1, }, { 2836, 3355, 4258, }, 0, },
				[3854]  = { true,  3854, 1,  3497,  3868, 200, 225, 237, 250,   1,   1, { 3859, 3466, 3486, 1529, 3829, 4234, }, { 8, 2, 2, 2, 1, 4, }, },
				[7964]  = { true,  7964, 1,  9918,   nil, 200, 200, 205, 210,   1,   1, { 7912, }, { 1, }, { 2836, 3355, 4258, }, 0, },
				[3847]  = { true,  3847, 1,  3515,  3875, 200, 225, 237, 250,   1,   1, { 3859, 3577, 3486, 3864, }, { 10, 4, 4, 1, }, },
				[9060]  = { true,  9060, 1, 11454, 10713, 200, 225, 237, 250,   1,   1, { 3860, 3577, 6037, }, { 5, 1, 1, }, },
				[7966]  = { true,  7966, 1,  9920,   nil, 200, 200, 205, 210,   1,   1, { 7912, }, { 4, }, { 2836, 3355, 4258, }, 0, },
				[7963]  = { true,  7963, 1,  9916,   nil, 200, 225, 237, 250,   1,   1, { 3859, 3486, }, { 16, 3, }, { 2836, 3355, 4258, }, 0, },
				[7918]  = { true,  7918, 1,  9926,   nil, 205, 225, 235, 245,   1,   1, { 3860, 4234, }, { 8, 6, }, { 2836, 3355, 4258, }, 0, },
				[9366]  = { true,  9366, 1, 11643,  9367, 205, 225, 235, 245,   1,   1, { 3859, 3577, 3486, 3864, }, { 10, 4, 4, 1, }, },
				[7919]  = { true,  7919, 1,  9928,   nil, 205, 225, 235, 245,   1,   1, { 3860, 4338, }, { 6, 4, }, { 2836, 3355, 4258, }, 0, },
				[7920]  = { true,  7920, 1,  9931,   nil, 205, 230, 240, 250,   1,   1, { 3860, }, { 12, }, { 2836, 3355, 4258, }, 0, },
				[7941]  = { true,  7941, 1,  9993,   nil, 210, 235, 247, 260,   1,   1, { 3860, 3864, 7966, 4234, }, { 12, 2, 1, 4, }, { 2836, 3355, 4258, }, 0, },
				[7921]  = { true,  7921, 1,  9933,  7975, 210, 230, 240, 250,   1,   1, { 3860, 1705, }, { 10, 2, }, },
				[7935]  = { true,  7935, 1,  9972,   nil, 210, 260, 270, 280,   1,   1, { 3860, 6037, 7077, 7966, }, { 16, 6, 1, 1, }, { 2773, }, },
				[7936]  = { true,  7936, 1,  9979,   nil, 210, 265, 275, 285,   1,   1, { 3860, 6037, 4304, 7966, 7909, }, { 14, 2, 4, 1, 1, }, { 2772, }, },
				[7937]  = { true,  7937, 1,  9980,   nil, 210, 265, 275, 285,   1,   1, { 3860, 6037, 7971, 7966, }, { 16, 2, 1, 1, }, { 2771, }, },
				[7924]  = { true,  7924, 1,  9937,  7995, 215, 235, 245, 255,   1,   1, { 3860, 3864, }, { 8, 2, }, },
				[7967]  = { true,  7967, 1,  9939,  7976, 215, 235, 245, 255,   1,   1, { 3860, 6037, 7966, }, { 4, 2, 4, }, },
				[7929]  = {  nil,  7929, 1,  9957,   nil, 215, 250, 260, 270,   1,   1, { 3860, 7067, }, { 12, 1, }, { 2756, }, },
				[7922]  = { true,  7922, 1,  9935,   nil, 215, 235, 245, 255,   1,   1, { 3859, 7966, }, { 14, 1, }, { 2836, 3355, 4258, }, 0, },
				[7926]  = { true,  7926, 1,  9945,  7983, 220, 240, 250, 260,   1,   1, { 3860, 6037, 7966, 7909, }, { 12, 1, 1, 1, }, },
				[7925]  = {  nil,  7925, 1,  9942,   nil, 220, 240, 250, 260,   1,   1, { 3860, 4234, 4338, }, { 8, 6, 4, }, { 514, 957, 1241, 1383, 2836, 2998, 3174, 3355, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[7927]  = { true,  7927, 1,  9950,  7984, 220, 240, 250, 260,   1,   1, { 3860, 4338, 6037, 7966, }, { 10, 6, 1, 1, }, },
				[7942]  = { true,  7942, 1,  9995,  7992, 220, 245, 257, 270,   1,   1, { 3860, 7909, 7966, 4304, }, { 16, 2, 1, 4, }, },
				[7928]  = { true,  7928, 1,  9952,  7985, 225, 245, 255, 265,   1,   1, { 3860, 6037, 4304, }, { 12, 1, 6, }, },
				[7943]  = {  nil,  7943, 1,  9997,  8029, 225, 250, 262, 275,   1,   1, { 3860, 6037, 7966, 4304, }, { 14, 4, 1, 2, }, },
				[7930]  = { true,  7930, 1,  9959,   nil, 230, 250, 260, 270,   1,   1, { 3860, }, { 16, }, { 2836, 3355, 4258, }, 0, },
				[7931]  = { true,  7931, 1,  9961,   nil, 230, 250, 260, 270,   1,   1, { 3860, 4338, }, { 10, 6, }, { 2836, }, 0, },
				[7945]  = { true,  7945, 1, 10001,   nil, 230, 255, 267, 280,   1,   1, { 3860, 7971, 1210, 7966, 4304, }, { 16, 1, 4, 1, 2, }, { 2836, 3355, 4258, }, 0, },
				[7954]  = {  nil,  7954, 1, 10003,   nil, 235, 260, 272, 285,   1,   1, { 3860, 7075, 6037, 3864, 1529, 7966, 4304, }, { 24, 4, 6, 5, 5, 4, 4, }, { 7231, 7232, 11146, 11178, }, 0, },
				[7932]  = { true,  7932, 1,  9966,  7991, 235, 255, 265, 275,   1,   1, { 3860, 4304, 3864, }, { 14, 4, 4, }, },
				[7969]  = { true,  7969, 1,  9964,  7989, 235, 255, 265, 275,   1,   1, { 3860, 7966, }, { 4, 3, }, },
				[7933]  = { true,  7933, 1,  9968,   nil, 235, 255, 265, 275,   1,   1, { 3860, 4304, }, { 14, 4, }, { 2836, }, 0, },
				[7938]  = { true,  7938, 1,  9954,   nil, 240, 245, 255, 265,   1,   1, { 3860, 6037, 7909, 3864, 5966, 7966, }, { 10, 8, 3, 3, 1, 2, }, { 5164, 7230, 11177, }, 0, },
				[7944]  = { true,  7944, 1, 10005,  7993, 240, 265, 277, 290,   1,   1, { 3860, 7909, 1705, 1206, 7966, 4338, }, { 14, 1, 2, 2, 1, 2, }, },
				[7939]  = { true,  7939, 1,  9974,   nil, 245, 265, 275, 285,   1,   1, { 3860, 6037, 7910, 7971, 7966, }, { 12, 24, 4, 4, 2, }, { 5164, 7230, 11177, }, 0, },
				[7961]  = {  nil,  7961, 1, 10007,   nil, 245, 270, 282, 295,   1,   1, { 3860, 7081, 6037, 3823, 7909, 7966, 4304, }, { 28, 6, 8, 2, 6, 4, 2, }, { 7231, 7232, 11146, 11178, }, 0, },
				[7946]  = { true,  7946, 1, 10009,  8028, 245, 270, 282, 295,   1,   1, { 3860, 7075, 7966, 4304, }, { 18, 2, 1, 4, }, },
				[7934]  = { true,  7934, 1,  9970,  7990, 245, 255, 265, 275,   1,   1, { 3860, 7909, }, { 14, 1, }, },
				[12643] = { true, 12643, 1, 16640,   nil, 250, 255, 257, 260,   1,   1, { 12365, 14047, }, { 1, 1, }, { 2836, }, 0, },
				[12404] = { true, 12404, 1, 16641,   nil, 250, 255, 257, 260,   1,   1, { 12365, }, { 1, }, { 2836, }, 0, },
				[7959]  = {  nil,  7959, 1, 10011,   nil, 250, 275, 287, 300,   1,   1, { 3860, 7972, 6037, 7966, 4304, }, { 28, 10, 10, 6, 6, }, { 7231, 7232, 11146, 11178, }, 0, },
				[12644] = { true, 12644, 1, 16639,   nil, 250, 255, 257, 260,   1,   1, { 12365, }, { 4, }, { 2836, }, 0, },
				[12405] = { true, 12405, 1, 16642, 12682, 250, 270, 280, 290,   1,   1, { 12359, 12361, 11188, }, { 16, 1, 4, }, },
				[12406] = { true, 12406, 1, 16643, 12683, 250, 270, 280, 290,   1,   1, { 12359, 11186, }, { 12, 4, }, },
				[7947]  = {  nil,  7947, 1, 10013,  8030, 255, 280, 292, 305,   1,   1, { 3860, 6037, 7910, 7966, 4304, }, { 12, 6, 2, 1, 2, }, },
				[12408] = { true, 12408, 1, 16644, 12684, 255, 275, 285, 295,   1,   1, { 12359, 11184, }, { 12, 4, }, },
				[12764] = {  nil, 12764, 1, 16960,   nil, 260, 285, 297, 310,   1,   1, { 12359, 12644, 8170, }, { 16, 2, 4, }, { 514, 957, 1241, 1383, 2836, 2998, 3174, 3355, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[12416] = { true, 12416, 1, 16645, 12685, 260, 280, 290, 300,   1,   1, { 12359, 7077, }, { 10, 2, }, },
				[7960]  = {  nil,  7960, 1, 10015,   nil, 260, 285, 297, 310,   1,   1, { 3860, 6037, 7910, 7081, 7966, 4304, }, { 30, 16, 6, 4, 8, 6, }, { 7231, 7232, 11146, 11178, }, 0, },
				[11608] = {  nil, 11608, 1, 15292, 11610, 265, 285, 295, 305,   1,   1, { 11371, 7077, }, { 18, 4, }, },
				[12424] = { true, 12424, 1, 16647, 12688, 265, 285, 295, 305,   1,   1, { 12359, 8170, 7909, }, { 22, 6, 1, }, },
				[12428] = { true, 12428, 1, 16646, 12687, 265, 285, 295, 305,   1,   1, { 12359, 8170, 3864, }, { 24, 6, 2, }, },
				[12624] = { true, 12624, 1, 16650, 12691, 270, 290, 300, 310,   1,   1, { 12359, 12655, 12803, 8153, 12364, }, { 40, 2, 4, 4, 1, }, },
				[12415] = { true, 12415, 1, 16648, 12689, 270, 290, 300, 310,   1,   1, { 12359, 7077, 7910, }, { 18, 2, 1, }, },
				[11606] = {  nil, 11606, 1, 15293, 11614, 270, 290, 300, 310,   1,   1, { 11371, 7077, }, { 10, 2, }, },
				[12425] = { true, 12425, 1, 16649, 12690, 270, 290, 300, 310,   1,   1, { 12359, 7910, }, { 20, 1, }, },
				[12769] = {  nil, 12769, 1, 16965,   nil, 270, 295, 307, 320,   1,   1, { 12359, 12803, 8153, 12799, 12644, 8170, }, { 30, 6, 6, 6, 2, 8, }, { 514, 957, 1241, 1383, 2836, 2998, 3174, 3355, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[12772] = {  nil, 12772, 1, 16967,   nil, 270, 295, 307, 320,   1,   1, { 12359, 3577, 6037, 12361, 8170, }, { 30, 4, 2, 2, 4, }, { 514, 957, 1241, 1383, 2836, 2998, 3174, 3355, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[15872] = { true, 15872, 1, 19669,   nil, 275, 275, 280, 285,   2,   2, { 12360, 12644, }, { 1, 1, }, { 2836, }, 0, },
				[12774] = {  nil, 12774, 1, 16970, 12821, 275, 300, 312, 325,   1,   1, { 12359, 12655, 7910, 12361, 12644, 8170, }, { 30, 4, 4, 4, 2, 4, }, },
				[12645] = {  nil, 12645, 1, 16651, 12692, 275, 295, 305, 315,   1,   1, { 12359, 12644, 7076, }, { 4, 4, 2, }, },
				[11607] = {  nil, 11607, 1, 15294, 11611, 275, 295, 305, 315,   1,   1, { 11371, 7077, }, { 26, 4, }, },
				[16206] = { true, 16206, 1, 20201,   nil, 275, 275, 280, 285,   1,   1, { 12360, 12644, }, { 3, 1, }, { 2836, }, 0, },
				[12773] = {  nil, 12773, 1, 16969, 12819, 275, 300, 312, 325,   1,   1, { 12359, 12799, 12644, 8170, }, { 20, 2, 2, 4, }, },
				[12410] = { true, 12410, 1, 16653, 12694, 280, 300, 310, 320,   1,   1, { 12359, 7910, 11188, }, { 24, 1, 4, }, },
				[12777] = {  nil, 12777, 1, 16978, 12825, 280, 305, 317, 330,   1,   1, { 12655, 7078, 7077, 12800, 12644, }, { 10, 4, 4, 2, 2, }, },
				[11605] = {  nil, 11605, 1, 15295, 11615, 280, 300, 310, 320,   1,   1, { 11371, 7077, }, { 6, 1, }, },
				[12409] = { true, 12409, 1, 16652, 12693, 280, 300, 310, 320,   1,   1, { 12359, 8170, 11185, }, { 20, 8, 4, }, },
				[12775] = {  nil, 12775, 1, 16971, 12823, 280, 305, 317, 330,   1,   1, { 12359, 12644, 8170, }, { 40, 6, 6, }, },
				[12776] = {  nil, 12776, 1, 16973, 12824, 280, 305, 317, 330,   1,   1, { 12359, 12655, 12364, 12804, 8170, }, { 20, 6, 2, 4, 4, }, },
				[12628] = {  nil, 12628, 1, 16667, 12696, 285, 305, 315, 325,   1,   1, { 12359, 12662, 12361, 7910, }, { 40, 10, 4, 4, }, },
				[11604] = { true, 11604, 1, 15296, 11612, 285, 305, 315, 325,   1,   1, { 11371, 7077, }, { 20, 8, }, },
				[12418] = { true, 12418, 1, 16654, 12695, 285, 305, 315, 325,   1,   1, { 12359, 7077, }, { 18, 4, }, },
				[12779] = {  nil, 12779, 1, 16980,   nil, 285, 310, 322, 335,   1,   1, { 12359, 12799, 12644, 8170, }, { 30, 2, 2, 4, }, { 514, 957, 1241, 1383, 2836, 2998, 3174, 3355, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[12781] = {  nil, 12781, 1, 16983, 12827, 285, 310, 322, 335,   1,   1, { 12655, 12360, 12804, 12799, 12361, 12364, }, { 6, 2, 4, 2, 2, 1, }, },
				[12631] = {  nil, 12631, 1, 16655, 12699, 290, 310, 320, 330,   1,   1, { 12359, 12655, 7078, 7910, }, { 20, 6, 2, 4, }, },
				[12782] = {  nil, 12782, 1, 16985, 12830, 290, 315, 327, 340,   1,   1, { 12359, 12360, 12662, 12808, 12361, 12644, 8170, }, { 40, 2, 16, 8, 2, 2, 4, }, },
				[12419] = { true, 12419, 1, 16656, 12697, 290, 310, 320, 330,   1,   1, { 12359, 7077, }, { 14, 4, }, },
				[12792] = { true, 12792, 1, 16984, 12828, 290, 315, 327, 340,   1,   1, { 12359, 7077, 7910, 8170, }, { 30, 4, 4, 4, }, },
				[12625] = {  nil, 12625, 1, 16660, 12698, 290, 310, 320, 330,   1,   1, { 12359, 12360, 12364, 7080, }, { 20, 4, 2, 2, }, },
				[19051] = {  nil, 19051, 3, 23632, 19203, 290, 310, 320, 330,   1,   1, { 12359, 6037, 12811, }, { 8, 6, 1, }, },
				[19043] = {  nil, 19043, 3, 23628, 19202, 290, 310, 320, 330,   1,   1, { 12359, 7076, 12803, }, { 12, 3, 3, }, },
				[16989] = { true, 16989, 1, 20872, 17049, 295, 315, 325, 335,   1,   1, { 11371, 17010, 17011, }, { 6, 3, 3, }, },
				[12426] = { true, 12426, 1, 16657, 12700, 295, 315, 325, 335,   1,   1, { 12359, 7910, 7909, }, { 34, 1, 1, }, },
				[17014] = { true, 17014, 1, 20874, 17051, 295, 315, 325, 335,   1,   1, { 11371, 17010, 17011, }, { 4, 2, 2, }, },
				[12427] = { true, 12427, 1, 16658, 12701, 295, 315, 325, 335,   1,   1, { 12359, 7910, }, { 34, 2, }, },
				[12417] = { true, 12417, 1, 16659, 12702, 295, 315, 325, 335,   1,   1, { 12359, 7077, }, { 18, 4, }, },
				[12632] = { true, 12632, 1, 16661, 12703, 295, 315, 325, 335,   1,   1, { 12359, 12655, 7080, 12361, }, { 20, 4, 4, 4, }, },
				[19170] = {  nil, 19170, 3, 23650, 19210, 300, 320, 330, 340,   1,   1, { 17011, 17010, 12360, 11371, 12800, }, { 4, 7, 12, 8, 4, }, },
				[12639] = {  nil, 12639, 1, 16741, 12720, 300, 320, 330, 340,   1,   1, { 12360, 12655, 7076, 12361, 12799, }, { 15, 20, 10, 4, 4, }, },
				[22195] = {  nil, 22195, 5, 27588, 22214, 300, 320, 330, 340,   1,   1, { 22202, 12810, }, { 14, 4, }, },
				[12619] = { true, 12619, 1, 16744, 12726, 300, 320, 330, 340,   1,   1, { 12360, 12655, 7080, 12361, 12364, }, { 10, 20, 6, 2, 1, }, },
				[22196] = {  nil, 22196, 5, 27587, 22222, 300, 320, 330, 340,   1,   1, { 22203, 22202, 12655, 7076, 12364, }, { 18, 40, 12, 10, 4, }, },
				[12790] = {  nil, 12790, 1, 16990, 12834, 300, 320, 330, 340,   1,   1, { 12360, 12800, 12811, 12799, 12810, 12644, }, { 15, 8, 1, 4, 8, 2, }, },
				[12641] = {  nil, 12641, 1, 16746, 12728, 300, 320, 330, 340,   1,   1, { 12360, 12655, 12364, 12800, }, { 30, 30, 6, 6, }, },
				[22194] = {  nil, 22194, 5, 27589, 22220, 300, 320, 330, 340,   1,   1, { 22203, 22202, 12810, 13512, }, { 8, 24, 8, 1, }, },
				[22385] = {  nil, 22385, 5, 27829, 22388, 300, 320, 330, 340,   1,   1, { 12360, 12655, 7076, 13510, }, { 12, 20, 10, 2, }, },
				[19695] = {  nil, 19695, 4, 24141, 19781, 300, 320, 330, 340,   1,   1, { 12359, 19774, 12799, }, { 16, 10, 1, }, },
				[22384] = {  nil, 22384, 5, 27830, 22390, 300, 320, 330, 340,   1,   1, { 12360, 11371, 12808, 20520, 15417, 12753, }, { 15, 10, 20, 20, 10, 2, }, },
				[20551] = {  nil, 20551, 4, 24913, 20555, 300, 320, 330, 340,   1,   1, { 12359, 20520, 6037, 11754, }, { 16, 8, 8, 1, }, },
				[22764] = {  nil, 22764, 5, 28463, 22768, 300, 320, 330, 340,   1,   1, { 12655, 12803, }, { 6, 2, }, },
				[12783] = {  nil, 12783, 1, 16995, 12839, 300, 320, 330, 340,   1,   1, { 12360, 12655, 12810, 7910, 12800, 12799, 12644, }, { 10, 10, 2, 6, 6, 6, 4, }, },
				[19169] = {  nil, 19169, 3, 23653, 19212, 300, 320, 330, 340,   1,   1, { 17011, 17010, 12360, 11371, 12364, }, { 8, 5, 10, 12, 4, }, },
				[17013] = { true, 17013, 1, 20876, 17052, 300, 320, 330, 340,   1,   1, { 11371, 17010, 17011, }, { 16, 4, 6, }, },
				[19057] = {  nil, 19057, 3, 23633, 19205, 300, 320, 330, 340,   1,   1, { 12360, 6037, 12811, }, { 2, 10, 1, }, },
				[12633] = { true, 12633, 1, 16724, 12711, 300, 320, 330, 340,   1,   1, { 12359, 12655, 6037, 3577, 12800, }, { 20, 4, 6, 6, 2, }, },
				[22671] = {  nil, 22671, 6, 28244,   nil, 300, 320, 330, 340,   1,   1, { 22682, 12359, 12360, 7080, }, { 4, 12, 2, 2, }, { 16365, }, 0, { 9233, }, },
				[22197] = {  nil, 22197, 5, 27585, 22209, 300, 320, 330, 340,   1,   1, { 22202, 12655, 7076, }, { 14, 4, 2, }, },
				[12794] = {  nil, 12794, 1, 16993, 12837, 300, 320, 330, 340,   1,   1, { 12655, 12364, 12799, 7076, 12810, }, { 20, 8, 8, 6, 4, }, },
				[20549] = {  nil, 20549, 4, 24912, 20553, 300, 320, 330, 340,   1,   1, { 12359, 20520, 6037, 12810, }, { 12, 6, 6, 2, }, },
				[22383] = {  nil, 22383, 5, 27832, 22389, 300, 320, 330, 340,   1,   1, { 12360, 20725, 13512, 12810, }, { 12, 2, 2, 4, }, },
				[19167] = {  nil, 19167, 3, 23639, 19209, 300, 320, 330, 340,   1,   1, { 17011, 17010, 12360, 11371, }, { 5, 2, 16, 6, }, },
				[12422] = { true, 12422, 1, 16663, 12705, 300, 320, 330, 340,   1,   1, { 12359, 7910, }, { 40, 2, }, },
				[12429] = { true, 12429, 1, 16730, 12715, 300, 320, 330, 340,   1,   1, { 12359, 7910, }, { 44, 2, }, },
				[12611] = {  nil, 12611, 1, 16665, 12707, 300, 320, 330, 340,   1,   1, { 12359, 12360, 2842, }, { 20, 2, 10, }, },
				[19690] = {  nil, 19690, 4, 24136, 19776, 300, 320, 330, 340,   1,   1, { 12359, 19774, 19726, 7910, }, { 20, 10, 2, 2, }, },
				[19691] = {  nil, 19691, 4, 24137, 19777, 300, 320, 330, 340,   1,   1, { 12359, 19774, 19726, 7910, }, { 16, 8, 2, 1, }, },
				[12795] = {  nil, 12795, 1, 16986,   nil, 300, 325, 337, 350,   1,   1, { 12655, 12360, 12662, 7910, 12644, }, { 10, 10, 8, 10, 2, }, { 514, 957, 1241, 1383, 2836, 2998, 3174, 3355, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[12613] = {  nil, 12613, 1, 16731, 12718, 300, 320, 330, 340,   1,   1, { 12359, 12360, 7910, }, { 40, 2, 1, }, },
				[12797] = {  nil, 12797, 1, 16992, 12836, 300, 320, 330, 340,   1,   1, { 12360, 12361, 12800, 7080, 12644, 12810, }, { 18, 8, 8, 4, 2, 4, }, },
				[22669] = {  nil, 22669, 6, 28242,   nil, 300, 320, 330, 340,   1,   1, { 22682, 12359, 12360, 7080, }, { 7, 16, 2, 4, }, { 16365, }, 0, { 9233, }, },
				[19692] = {  nil, 19692, 4, 24138, 19778, 300, 320, 330, 340,   1,   1, { 12359, 19774, 19726, 12810, }, { 12, 6, 2, 4, }, },
				[12798] = {  nil, 12798, 1, 16991, 12835, 300, 320, 330, 340,   1,   1, { 12359, 12360, 12808, 12364, 12644, 12810, }, { 40, 12, 10, 8, 2, 4, }, },
				[17016] = {  nil, 17016, 1, 20897, 17060, 300, 320, 330, 340,   1,   1, { 11371, 17011, 11382, 12810, }, { 18, 12, 2, 2, }, },
				[17015] = {  nil, 17015, 1, 20890, 17059, 300, 320, 330, 340,   1,   1, { 11371, 17010, 11382, 12810, }, { 16, 12, 2, 2, }, },
				[19148] = {  nil, 19148, 3, 23636, 19206, 300, 320, 330, 340,   1,   1, { 17011, 17010, 11371, }, { 4, 2, 4, }, },
				[19693] = {  nil, 19693, 4, 24139, 19779, 300, 320, 330, 340,   1,   1, { 12359, 19774, 12799, }, { 20, 14, 2, }, },
				[19168] = {  nil, 19168, 3, 23652, 19211, 300, 320, 330, 340,   1,   1, { 17011, 17010, 12360, 11371, 12809, }, { 6, 6, 10, 6, 12, }, },
				[19164] = {  nil, 19164, 3, 23637, 19207, 300, 320, 330, 340,   1,   1, { 17011, 17010, 17012, 11371, 11382, }, { 3, 5, 4, 4, 2, }, },
				[12618] = { true, 12618, 1, 16745, 12727, 300, 320, 330, 340,   1,   1, { 12360, 12655, 7076, 7080, 12364, 12800, }, { 8, 24, 4, 4, 2, 2, }, },
				[12636] = {  nil, 12636, 1, 16728, 12716, 300, 320, 330, 340,   1,   1, { 12359, 12655, 8168, 12799, 12364, }, { 40, 4, 60, 6, 2, }, },
				[22763] = {  nil, 22763, 5, 28462, 22767, 300, 320, 330, 340,   1,   1, { 12655, 19726, 12803, }, { 8, 1, 2, }, },
				[22198] = {  nil, 22198, 5, 27586, 22219, 300, 320, 330, 340,   1,   1, { 22203, 22202, 12655, 7076, }, { 8, 24, 8, 4, }, },
				[12796] = {  nil, 12796, 1, 16988, 12833, 300, 320, 330, 340,   1,   1, { 12359, 12360, 12809, 12810, 7076, }, { 50, 15, 4, 6, 10, }, },
				[22670] = {  nil, 22670, 6, 28243,   nil, 300, 320, 330, 340,   1,   1, { 22682, 12359, 12360, 7080, }, { 5, 12, 2, 2, }, { 16365, }, 0, { 9233, }, },
				[12640] = {  nil, 12640, 1, 16729, 12717, 300, 320, 330, 340,   1,   1, { 12359, 12360, 8146, 12361, 12800, }, { 80, 12, 40, 10, 4, }, },
				[12414] = { true, 12414, 1, 16662, 12704, 300, 320, 330, 340,   1,   1, { 12359, 11186, }, { 26, 4, }, },
				[19166] = {  nil, 19166, 3, 23638, 19208, 300, 320, 330, 340,   1,   1, { 17011, 17010, 12360, 11382, 11371, }, { 3, 6, 12, 1, 4, }, },
				[19048] = {  nil, 19048, 3, 23629, 19204, 300, 320, 330, 340,   1,   1, { 12360, 7076, 12803, }, { 4, 6, 6, }, },
				[19694] = {  nil, 19694, 4, 24140, 19780, 300, 320, 330, 340,   1,   1, { 12359, 19774, 12799, }, { 18, 12, 2, }, },
				[18262] = {  nil, 18262, 1, 22757, 18264, 300, 300, 310, 320,   1,   1, { 7067, 12365, }, { 2, 3, }, },
				[20550] = {  nil, 20550, 4, 24914, 20554, 300, 320, 330, 340,   1,   1, { 12359, 20520, 6037, }, { 20, 10, 10, }, },
				[12784] = {  nil, 12784, 1, 16994, 12838, 300, 320, 330, 340,   1,   1, { 12360, 12810, 12644, }, { 20, 6, 2, }, },
				[20039] = {  nil, 20039, 3, 24399, 20040, 300, 320, 330, 340,   1,   1, { 17011, 17010, 17012, 11371, }, { 3, 3, 4, 6, }, },
				[12620] = {  nil, 12620, 1, 16742, 12725, 300, 320, 330, 340,   1,   1, { 12360, 12655, 7076, 12799, 12800, }, { 6, 16, 6, 2, 1, }, },
				[12614] = {  nil, 12614, 1, 16732, 12719, 300, 320, 330, 340,   1,   1, { 12359, 12360, 7910, }, { 40, 2, 1, }, },
				[12420] = { true, 12420, 1, 16725, 12713, 300, 320, 330, 340,   1,   1, { 12359, 7077, }, { 20, 4, }, },
				[12802] = {  nil, 12802, 1, 16987,   nil, 300, 325, 337, 350,   1,   1, { 12655, 12804, 12364, 12800, 12644, }, { 20, 20, 2, 2, 2, }, { 514, 957, 1241, 1383, 2836, 2998, 3174, 3355, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 0, },
				[12612] = {  nil, 12612, 1, 16726, 12714, 300, 320, 330, 340,   1,   1, { 12359, 12360, 6037, 12364, }, { 30, 2, 2, 1, }, },
				[16988] = { true, 16988, 1, 20873, 17053, 300, 320, 330, 340,   1,   1, { 11371, 17010, 17011, }, { 16, 4, 5, }, },
				[22762] = {  nil, 22762, 5, 28461, 22766, 300, 320, 330, 340,   1,   1, { 12655, 19726, 12360, 12803, }, { 12, 2, 2, 2, }, },
				[12610] = {  nil, 12610, 1, 16664, 12706, 300, 320, 330, 340,   1,   1, { 12359, 12360, 3577, }, { 20, 2, 6, }, },
				[17193] = {  nil, 17193, 1, 21161, 18592, 300, 325, 337, 350,   1,   1, { 17203, 11371, 12360, 7078, 11382, 17011, 17010, }, { 8, 20, 50, 25, 10, 10, 10, }, },
				[22191] = {  nil, 22191, 5, 27590, 22221, 300, 320, 330, 340,   1,   1, { 22203, 22202, 12810, 12809, 12800, }, { 15, 36, 12, 10, 4, }, },
			},
			[3] = {
				[2318]  = { true,  2318, 1,  2881,   nil,   1,  20,  30,  40,   1,   1, { 2934, }, { 3, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 7866, 7867, 7868, 7869, 7870, 11083, 11096, }, 0, },
				[2302]  = { true,  2302, 1,  2149,   nil,   1,  40,  55,  70,   1,   1, { 2318, 2320, }, { 2, 1, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 7866, 7867, 7868, 7869, 7870, 11083, 11096, }, 0, },
				[7276]  = { true,  7276, 1,  9058,   nil,   1,  40,  55,  70,   1,   1, { 2318, 2320, }, { 2, 1, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 7866, 7867, 7868, 7869, 7870, 11083, 11096, }, 0, },
				[5957]  = { true,  5957, 1,  7126,   nil,   1,  40,  55,  70,   1,   1, { 2318, 2320, }, { 3, 1, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 7866, 7867, 7868, 7869, 7870, 11083, 11096, }, 0, },
				[2304]  = { true,  2304, 1,  2152,   nil,   1,  30,  45,  60,   1,   1, { 2318, }, { 1, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 7866, 7867, 7868, 7869, 7870, 11083, 11096, }, 0, },
				[7277]  = { true,  7277, 1,  9059,   nil,   1,  40,  55,  70,   1,   1, { 2318, 2320, }, { 2, 3, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 7866, 7867, 7868, 7869, 7870, 11083, 11096, }, 0, },
				[2303]  = { true,  2303, 1,  2153,   nil,  15,  45,  60,  75,   1,   1, { 2318, 2320, }, { 4, 1, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 7866, 7867, 7868, 7869, 11083, 11096, }, 0, },
				[4237]  = { true,  4237, 1,  3753,   nil,  25,  55,  70,  85,   1,   1, { 2318, 2320, }, { 6, 1, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 7866, 7867, 7868, 7869, 11083, 11096, }, 0, },
				[7278]  = { true,  7278, 1,  9060,   nil,  30,  60,  75,  90,   1,   1, { 2318, 2320, }, { 4, 2, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 7866, 7867, 7868, 7869, 11083, 11096, }, 0, },
				[7279]  = { true,  7279, 1,  9062,   nil,  30,  60,  75,  90,   1,   1, { 2318, 2320, }, { 3, 4, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 11083, 11096, }, 0, },
				[4231]  = { true,  4231, 1,  3816,   nil,  35,  55,  65,  75,   1,   1, { 783, 4289, }, { 1, 1, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 7866, 7867, 7868, 7869, 11083, 11096, }, 0, },
				[7280]  = {  nil,  7280, 1,  9064,  7288,  35,  65,  80,  95,   1,   1, { 2318, 2320, }, { 5, 5, }, },
				[2300]  = { true,  2300, 1,  2160,   nil,  40,  70,  85, 100,   1,   1, { 2318, 2320, }, { 8, 4, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 7866, 7867, 7868, 7869, 11083, 11096, }, 0, },
				[5081]  = {  nil,  5081, 1,  5244,  5083,  40,  70,  85, 100,   1,   1, { 5082, 2318, 2320, }, { 3, 4, 1, }, },
				[2309]  = { true,  2309, 1,  2161,   nil,  55,  85, 100, 115,   1,   1, { 2318, 2320, }, { 8, 5, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 7866, 7867, 7868, 7869, 11083, 11096, }, 0, },
				[4239]  = { true,  4239, 1,  3756,   nil,  55,  85, 100, 115,   1,   1, { 2318, 2320, }, { 3, 2, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 11083, 11096, }, 0, },
				[2311]  = {  nil,  2311, 1,  2163,  2407,  60,  90, 105, 120,   1,   1, { 2318, 2320, 2324, }, { 8, 2, 1, }, },
				[2310]  = { true,  2310, 1,  2162,   nil,  60,  90, 105, 120,   1,   1, { 2318, 2320, }, { 5, 2, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 11083, 11096, }, 0, },
				[7281]  = { true,  7281, 1,  9065,   nil,  70, 100, 115, 130,   1,   1, { 2318, 2320, }, { 6, 4, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 7866, 7867, 7868, 7869, 8153, 11081, 11084, }, 0, },
				[2312]  = {  nil,  2312, 1,  2164,  2408,  75, 105, 120, 135,   1,   1, { 4231, 2318, 2320, }, { 1, 4, 2, }, },
				[4242]  = { true,  4242, 1,  3759,   nil,  75, 105, 120, 135,   1,   1, { 4231, 2318, 2320, }, { 1, 6, 2, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 8153, 11081, 11084, }, 0, },
				[4246]  = { true,  4246, 1,  3763,   nil,  80, 110, 125, 140,   1,   1, { 2318, 2320, }, { 6, 2, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 8153, 11081, 11084, }, 0, },
				[4243]  = { true,  4243, 1,  3761,   nil,  85, 115, 130, 145,   1,   1, { 4231, 2318, 2320, }, { 3, 6, 4, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 8153, 11081, 11084, }, 0, },
				[2308]  = { true,  2308, 1,  2159,   nil,  85, 105, 120, 135,   1,   1, { 2318, 2321, }, { 10, 2, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 7866, 7867, 7868, 7869, 8153, 11081, 11084, }, 0, },
				[6709]  = { true,  6709, 1,  8322,  6710,  90, 115, 130, 145,   1,   1, { 2318, 4231, 2320, 5498, }, { 6, 1, 4, 1, }, },
				[5780]  = { true,  5780, 1,  6702,  5786,  90, 120, 135, 150,   1,   1, { 5784, 2318, 2321, }, { 8, 6, 1, }, },
				[2307]  = {  nil,  2307, 1,  2158,  2406,  90, 120, 135, 150,   1,   1, { 2318, 2320, }, { 7, 2, }, },
				[6466]  = {  nil,  6466, 1,  7953,  6474,  90, 120, 135, 150,   1,   1, { 6470, 4231, 2321, }, { 8, 1, 1, }, },
				[7282]  = { true,  7282, 1,  9068,   nil,  95, 125, 140, 155,   1,   1, { 2318, 4231, 2321, }, { 10, 1, 1, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 7866, 7867, 7868, 7869, 8153, 11081, 11084, }, 0, },
				[5781]  = { true,  5781, 1,  6703,  5787,  95, 125, 140, 155,   1,   1, { 5784, 4231, 2318, 2321, }, { 12, 1, 8, 1, }, },
				[2315]  = { true,  2315, 1,  2167,   nil, 100, 125, 137, 150,   1,   1, { 2319, 2321, 4340, }, { 4, 2, 1, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 7866, 7867, 7868, 7869, 8153, 11081, 11084, }, 0, },
				[2317]  = {  nil,  2317, 1,  2169,  2409, 100, 125, 137, 150,   1,   1, { 2319, 2321, 4340, }, { 6, 1, 1, }, },
				[4233]  = { true,  4233, 1,  3817,   nil, 100, 115, 122, 130,   1,   1, { 4232, 4289, }, { 1, 1, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 8153, 11081, 11084, }, 0, },
				[4244]  = { true,  4244, 1,  3762,  4293, 100, 125, 137, 150,   1,   1, { 4243, 4231, 2320, }, { 1, 2, 2, }, },
				[2319]  = { true,  2319, 1, 20648,   nil, 100, 100, 105, 110,   1,   1, { 2318, }, { 4, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 8153, 11081, 11084, }, 0, },
				[20575] = {  nil, 20575, 1, 24940, 20576, 100, 125, 137, 150,   1,   1, { 2319, 7286, 4231, 2321, }, { 8, 8, 1, 2, }, },
				[7283]  = {  nil,  7283, 1,  9070,  7289, 100, 125, 137, 150,   1,   1, { 7286, 2319, 2321, }, { 12, 4, 1, }, },
				[2313]  = { true,  2313, 1,  2165,   nil, 100, 115, 122, 130,   1,   1, { 2319, 2320, }, { 4, 1, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 8153, 11081, 11084, }, 0, },
				[6467]  = {  nil,  6467, 1,  7954,  6475, 105, 130, 142, 155,   1,   1, { 6471, 6470, 2321, }, { 2, 6, 2, }, },
				[5958]  = {  nil,  5958, 1,  7133,  5972, 105, 130, 142, 155,   1,   1, { 2319, 2997, 2321, }, { 8, 1, 1, }, },
				[2316]  = { true,  2316, 1,  2168,   nil, 110, 135, 147, 160,   1,   1, { 2319, 2321, 4340, }, { 8, 1, 1, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 8153, 11081, 11084, }, 0, },
				[5961]  = { true,  5961, 1,  7135,   nil, 115, 140, 152, 165,   1,   1, { 2319, 4340, 2321, }, { 12, 1, 1, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 8153, 11081, 11084, }, 0, },
				[6468]  = {  nil,  6468, 1,  7955,  6476, 115, 140, 152, 165,   1,   1, { 6471, 6470, 2321, }, { 10, 10, 2, }, },
				[7285]  = { true,  7285, 1,  9074,   nil, 120, 145, 157, 170,   1,   1, { 2457, 2319, 2321, }, { 1, 6, 1, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 8153, 11081, 11084, }, 0, },
				[7284]  = {  nil,  7284, 1,  9072,  7290, 120, 145, 157, 170,   1,   1, { 7287, 2319, 2321, }, { 6, 4, 1, }, },
				[4248]  = {  nil,  4248, 1,  3765,  7360, 120, 155, 167, 180,   1,   1, { 2312, 4233, 2321, 4340, }, { 1, 1, 1, 1, }, },
				[2314]  = { true,  2314, 1,  2166,   nil, 120, 145, 157, 170,   1,   1, { 2319, 4231, 2321, }, { 10, 2, 2, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 7866, 7867, 7868, 7869, 8153, 11081, 11084, }, 0, },
				[4250]  = {  nil,  4250, 1,  3767,  4294, 120, 145, 157, 170,   1,   1, { 2319, 3383, 2321, }, { 8, 1, 2, }, },
				[7348]  = { true,  7348, 1,  9145,   nil, 125, 150, 162, 175,   1,   1, { 2319, 5116, 2321, }, { 8, 4, 2, }, { 3007, 4212, }, 0, },
				[4251]  = { true,  4251, 1,  3768,   nil, 130, 155, 167, 180,   1,   1, { 4233, 2319, 2321, }, { 1, 4, 1, }, { 3007, 4212, }, 0, },
				[7352]  = {  nil,  7352, 1,  9147,  7362, 135, 160, 172, 185,   1,   1, { 2319, 7067, 2321, }, { 6, 1, 2, }, },
				[7349]  = {  nil,  7349, 1,  9146,  7361, 135, 160, 172, 185,   1,   1, { 2319, 3356, 2321, }, { 8, 4, 2, }, },
				[4253]  = { true,  4253, 1,  3770,   nil, 135, 160, 172, 185,   1,   1, { 2319, 4233, 3389, 3182, 2321, }, { 4, 2, 2, 2, 2, }, { 3007, 4212, }, 0, },
				[4252]  = {  nil,  4252, 1,  3769,  4296, 140, 165, 177, 190,   1,   1, { 2319, 3390, 4340, 2321, }, { 12, 1, 1, 2, }, },
				[7358]  = {  nil,  7358, 1,  9148,  7363, 140, 165, 177, 190,   1,   1, { 2319, 5373, 2321, }, { 10, 2, 2, }, },
				[4247]  = {  nil,  4247, 1,  3764,   nil, 145, 170, 182, 195,   1,   1, { 2319, 2321, }, { 14, 4, }, { 3007, 4212, }, 0, },
				[7359]  = {  nil,  7359, 1,  9149,  7364, 145, 170, 182, 195,   1,   1, { 2319, 7067, 2997, 2321, }, { 12, 2, 2, 2, }, },
				[7371]  = {  nil,  7371, 1,  9193,   nil, 150, 170, 180, 190,   1,   1, { 4234, 2321, }, { 8, 2, }, { 3007, 4212, }, 0, },
				[4265]  = {  nil,  4265, 1,  3780,   nil, 150, 170, 180, 190,   1,   1, { 4234, 2321, }, { 5, 1, }, { 3007, 4212, }, 0, },
				[3719]  = {  nil,  3719, 1,  3760,   nil, 150, 170, 180, 190,   1,   1, { 4234, 2321, }, { 5, 2, }, { 3007, 4212, }, 0, },
				[7372]  = {  nil,  7372, 1,  9194,   nil, 150, 170, 180, 190,   1,   1, { 4234, 2321, }, { 8, 2, }, { 3007, 4212, }, 0, },
				[4249]  = { true,  4249, 1,  3766,   nil, 150, 150, 162, 175,   1,   1, { 4246, 4233, 2321, 4340, }, { 1, 1, 2, 1, }, { 3007, 4212, }, 0, },
				[18662] = {  nil, 18662, 2, 23190, 18731, 150, 150, 155, 160,   1,   1, { 4234, 2321, }, { 2, 1, }, },
				[4236]  = {  nil,  4236, 1,  3818,   nil, 150, 160, 165, 170,   1,   1, { 4235, 4289, }, { 1, 3, }, { 3007, 4212, }, 0, },
				[4234]  = {  nil,  4234, 1, 20649,   nil, 150, 150, 155, 160,   1,   1, { 2319, }, { 5, }, { 3007, 4212, }, 0, },
				[4254]  = {  nil,  4254, 1,  3771,  4297, 150, 170, 180, 190,   1,   1, { 4234, 5637, 2321, }, { 6, 2, 1, }, },
				[4255]  = {  nil,  4255, 1,  3772,  7613, 155, 175, 185, 195,   1,   1, { 4234, 2605, 2321, }, { 9, 2, 4, }, },
				[18948] = {  nil, 18948, 1, 23399, 18949, 155, 175, 185, 195,   1,   1, { 4234, 4236, 5498, 4461, 5637, }, { 8, 2, 4, 1, 4, }, },
				[4257]  = {  nil,  4257, 1,  3774,   nil, 160, 180, 190, 200,   1,   1, { 4236, 4234, 2321, 2605, 7071, }, { 1, 5, 1, 1, 1, }, { 3007, 4212, }, 0, },
				[5962]  = {  nil,  5962, 1,  7147,   nil, 160, 180, 190, 200,   1,   1, { 4234, 4305, 2321, }, { 12, 2, 2, }, { 3007, 4212, }, 0, },
				[4455]  = {  nil,  4455, 1,  4096, 13287, 165, 185, 195, 205,   1,   1, { 4461, 4234, 2321, }, { 6, 4, 2, }, },
				[4456]  = {  nil,  4456, 1,  4097, 13288, 165, 185, 195, 205,   1,   1, { 4461, 4234, 2321, }, { 4, 4, 2, }, },
				[7373]  = {  nil,  7373, 1,  9195,  7449, 165, 185, 195, 205,   1,   1, { 4234, 2325, 2321, }, { 10, 1, 2, }, },
				[5782]  = {  nil,  5782, 1,  6704,  5788, 170, 190, 200, 210,   1,   1, { 5785, 4236, 4234, 2321, }, { 12, 1, 10, 3, }, },
				[4258]  = {  nil,  4258, 1,  3775,  4298, 170, 190, 200, 210,   1,   1, { 4236, 4234, 2321, 7071, }, { 2, 4, 1, 1, }, },
				[5963]  = {  nil,  5963, 1,  7149,  5973, 170, 190, 200, 210,   1,   1, { 4234, 2321, 1206, }, { 10, 2, 1, }, },
				[7375]  = {  nil,  7375, 1,  9197,  7450, 175, 195, 205, 215,   1,   1, { 7392, 4234, 2321, }, { 4, 10, 2, }, },
				[4256]  = {  nil,  4256, 1,  3773,  4299, 175, 195, 205, 215,   1,   1, { 4236, 4234, 3824, 2321, }, { 2, 12, 1, 2, }, },
				[5964]  = {  nil,  5964, 1,  7151,   nil, 175, 195, 205, 215,   1,   1, { 4234, 4236, 2321, }, { 8, 1, 2, }, { 3007, 4212, }, 0, },
				[7374]  = {  nil,  7374, 1,  9196,   nil, 175, 195, 205, 215,   1,   1, { 4234, 3824, 2321, }, { 10, 1, 2, }, { 3007, 4212, }, 0, },
				[7378]  = {  nil,  7378, 1,  9201,   nil, 180, 205, 215, 225,   1,   1, { 4234, 2325, 4291, }, { 16, 1, 2, }, { 3007, 4212, }, 0, },
				[7377]  = {  nil,  7377, 1,  9198,   nil, 180, 200, 210, 220,   1,   1, { 4234, 7067, 7070, 2321, }, { 6, 2, 2, 2, }, { 3007, 4212, }, 0, },
				[4259]  = {  nil,  4259, 1,  3776,   nil, 180, 200, 210, 220,   1,   1, { 4236, 4234, 2605, 2321, }, { 2, 6, 1, 1, }, { 3007, 4212, }, 0, },
				[5965]  = {  nil,  5965, 1,  7153,  5974, 185, 205, 215, 225,   1,   1, { 4234, 4305, 4291, }, { 14, 2, 2, }, },
				[4262]  = {  nil,  4262, 1,  3778, 14635, 185, 205, 215, 225,   1,   1, { 4236, 5500, 1529, 3864, 2321, }, { 4, 2, 2, 1, 1, }, },
				[5966]  = {  nil,  5966, 1,  7156,   nil, 190, 210, 220, 230,   1,   1, { 4234, 4236, 4291, }, { 4, 1, 1, }, { 3007, 4212, }, 0, },
				[5783]  = {  nil,  5783, 1,  6705,  5789, 190, 210, 220, 230,   1,   1, { 5785, 4236, 4234, 4291, }, { 16, 1, 14, 1, }, },
				[5739]  = {  nil,  5739, 1,  6661,   nil, 190, 210, 220, 230,   1,   1, { 4234, 2321, 7071, }, { 14, 2, 1, }, { 3007, 4212, }, 0, },
				[7386]  = {  nil,  7386, 1,  9202,  7451, 190, 210, 220, 230,   1,   1, { 7392, 4234, 4291, }, { 6, 8, 2, }, },
				[17721] = {  nil, 17721, 1, 21943, 17722, 190, 210, 220, 230,   1,   1, { 4234, 7067, 4291, }, { 8, 4, 1, }, },
				[7387]  = {  nil,  7387, 1,  9206,   nil, 195, 215, 225, 235,   1,   1, { 4234, 4305, 2325, 7071, }, { 10, 2, 2, 1, }, { 3007, 4212, }, 0, },
				[4260]  = {  nil,  4260, 1,  3777,  4300, 195, 215, 225, 235,   1,   1, { 4234, 4236, 4291, }, { 6, 2, 1, }, },
				[4264]  = {  nil,  4264, 1,  3779,  4301, 200, 220, 230, 240,   1,   1, { 4234, 4236, 4096, 5633, 4291, 7071, }, { 6, 2, 2, 1, 1, 1, }, },
				[8174]  = {  nil,  8174, 1, 10490,  8384, 200, 220, 230, 240,   1,   1, { 4234, 4236, 4291, }, { 12, 2, 2, }, },
				[4304]  = {  nil,  4304, 1, 20650,   nil, 200, 200, 202, 205,   1,   1, { 4234, }, { 6, }, { 3007, 4212, }, 0, },
				[18238] = {  nil, 18238, 2, 22711, 18239, 200, 210, 220, 230,   1,   1, { 4304, 7428, 7971, 4236, 1210, 8343, }, { 6, 8, 2, 2, 4, 1, }, },
				[8172]  = {  nil,  8172, 1, 10482,   nil, 200, 200, 200, 200,   1,   1, { 8169, 8150, }, { 1, 1, }, { 3007, 4212, }, 0, },
				[8173]  = {  nil,  8173, 1, 10487,   nil, 200, 220, 230, 240,   1,   1, { 4304, 4291, }, { 5, 1, }, { 3007, 4212, }, 0, },
				[7390]  = {  nil,  7390, 1,  9207,  7452, 200, 220, 230, 240,   1,   1, { 4234, 7428, 3824, 4291, }, { 8, 2, 1, 2, }, },
				[7391]  = {  nil,  7391, 1,  9208,  7453, 200, 220, 230, 240,   1,   1, { 4234, 2459, 4337, 4291, }, { 10, 2, 2, 1, }, },
				[8176]  = {  nil,  8176, 1, 10507,   nil, 205, 225, 235, 245,   1,   1, { 4304, 4291, }, { 5, 2, }, { 11097, 11098, }, 0, },
				[8175]  = {  nil,  8175, 1, 10499,   nil, 205, 225, 235, 245,   1,   1, { 4304, 4291, }, { 7, 2, }, { 11097, 11098, }, 0, },
				[8187]  = {  nil,  8187, 1, 10509,  8385, 205, 225, 235, 245,   1,   1, { 4304, 8167, 8343, }, { 6, 8, 1, }, },
				[8192]  = {  nil,  8192, 1, 10516,  8409, 210, 230, 240, 250,   1,   1, { 4304, 4338, 4291, }, { 8, 6, 3, }, },
				[8189]  = {  nil,  8189, 1, 10511,   nil, 210, 230, 240, 250,   1,   1, { 4304, 8167, 8343, }, { 6, 12, 1, }, { 7870, 11097, 11098, }, 0, },
				[8198]  = {  nil,  8198, 1, 10518,   nil, 210, 230, 240, 250,   1,   1, { 4304, 8167, 8343, }, { 8, 12, 1, }, { 7870, 11097, 11098, }, 0, },
				[8200]  = {  nil,  8200, 1, 10520,  8386, 215, 235, 245, 255,   1,   1, { 4304, 8151, 8343, }, { 10, 4, 1, }, },
				[8203]  = {  nil,  8203, 1, 10525,  8395, 220, 240, 250, 260,   1,   1, { 4304, 8154, 4291, }, { 12, 12, 4, }, },
				[8210]  = {  nil,  8210, 1, 10529,  8403, 220, 240, 250, 260,   1,   1, { 4304, 8153, 8172, }, { 10, 1, 1, }, },
				[8205]  = {  nil,  8205, 1, 10533,  8397, 220, 240, 250, 260,   1,   1, { 4304, 8154, 4291, }, { 10, 4, 2, }, },
				[8201]  = {  nil,  8201, 1, 10531,  8387, 220, 240, 250, 260,   1,   1, { 4304, 8151, 8343, }, { 8, 6, 1, }, },
				[8217]  = {  nil,  8217, 1, 14930,   nil, 225, 245, 255, 265,   1,   1, { 4304, 8172, 8949, 4291, }, { 12, 1, 1, 4, }, { 7870, 11097, 11098, }, 0, },
				[8214]  = {  nil,  8214, 1, 10546,  8405, 225, 245, 255, 265,   1,   1, { 4304, 8153, 8172, }, { 10, 2, 1, }, },
				[8218]  = {  nil,  8218, 1, 14932,   nil, 225, 245, 255, 265,   1,   1, { 4304, 8172, 8951, 4291, }, { 10, 1, 1, 6, }, { 7870, 11097, 11098, }, 0, },
				[8204]  = {  nil,  8204, 1, 10542,  8398, 225, 245, 255, 265,   1,   1, { 4304, 8154, 4291, }, { 6, 8, 2, }, },
				[8211]  = {  nil,  8211, 1, 10544,  8404, 225, 245, 255, 265,   1,   1, { 4304, 8153, 8172, }, { 12, 2, 1, }, },
				[8345]  = {  nil,  8345, 1, 10621,   nil, 225, 245, 255, 265,   1,   1, { 4304, 8368, 8146, 8343, 8172, }, { 18, 2, 8, 4, 2, }, { 7870, 7871, }, 0, },
				[8347]  = {  nil,  8347, 1, 10619,   nil, 225, 245, 255, 265,   1,   1, { 4304, 8165, 8343, 8172, }, { 24, 12, 4, 2, }, { 7866, 7867, }, 0, },
				[8191]  = {  nil,  8191, 1, 10552,   nil, 230, 250, 260, 270,   1,   1, { 4304, 8167, 8343, }, { 14, 24, 1, }, { 7870, 11097, 11098, }, 0, },
				[8195]  = {  nil,  8195, 1, 10550,   nil, 230, 250, 260, 270,   1,   1, { 4304, 4291, }, { 12, 4, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 7866, 7867, 7868, 7869, 7870, 11083, 11096, }, 0, },
				[8346]  = {  nil,  8346, 1, 10630,   nil, 230, 250, 260, 270,   1,   1, { 4304, 7079, 7075, 8172, 8343, }, { 20, 8, 2, 1, 4, }, { 7868, 7869, }, 0, },
				[8193]  = {  nil,  8193, 1, 10548,   nil, 235, 250, 260, 270,   1,   1, { 4304, 4291, }, { 14, 4, }, { 7870, 11097, 11098, }, 0, },
				[8209]  = {  nil,  8209, 1, 10554,  8399, 235, 255, 265, 275,   1,   1, { 4304, 8154, 4291, }, { 12, 12, 6, }, },
				[8197]  = {  nil,  8197, 1, 10558,   nil, 235, 255, 265, 275,   1,   1, { 4304, 8343, }, { 16, 2, }, { 7870, 11097, 11098, }, 0, },
				[8185]  = {  nil,  8185, 1, 10556,   nil, 235, 255, 265, 275,   1,   1, { 4304, 8167, 8343, }, { 14, 28, 1, }, { 7870, 11097, 11098, }, 0, },
				[8202]  = {  nil,  8202, 1, 10560,  8389, 240, 260, 270, 280,   1,   1, { 4304, 8152, 8343, }, { 10, 6, 2, }, },
				[8207]  = {  nil,  8207, 1, 10564,  8400, 240, 260, 270, 280,   1,   1, { 4304, 8154, 8343, }, { 12, 16, 2, }, },
				[8216]  = {  nil,  8216, 1, 10562,  8390, 240, 260, 270, 280,   1,   1, { 4304, 8152, 8343, }, { 14, 4, 2, }, },
				[8206]  = {  nil,  8206, 1, 10568,  8401, 245, 265, 275, 285,   1,   1, { 4304, 8154, 8343, }, { 14, 8, 2, }, },
				[8213]  = {  nil,  8213, 1, 10566,  8406, 245, 265, 275, 285,   1,   1, { 4304, 8153, 8172, }, { 14, 4, 2, }, },
				[8170]  = {  nil,  8170, 1, 22331,   nil, 250, 250, 250, 250,   1,   1, { 4304, }, { 6, }, { 11097, 11098, }, 0, },
				[8349]  = {  nil,  8349, 1, 10647,   nil, 250, 270, 280, 290,   1,   1, { 4304, 8168, 7971, 8172, 8343, }, { 40, 40, 2, 4, 4, }, { 7870, 7871, 11097, 11098, }, 0, },
				[15407] = {  nil, 15407, 1, 19047,   nil, 250, 250, 255, 260,   1,   1, { 8171, 15409, }, { 1, 1, }, { 7870, 11097, 11098, }, 0, },
				[8212]  = {  nil,  8212, 1, 10572,  8407, 250, 270, 280, 290,   1,   1, { 4304, 8153, 8172, }, { 16, 6, 2, }, },
				[8215]  = {  nil,  8215, 1, 10574,  8408, 250, 270, 280, 290,   1,   1, { 4304, 8153, 8172, }, { 16, 6, 2, }, },
				[8208]  = {  nil,  8208, 1, 10570,  8402, 250, 270, 280, 290,   1,   1, { 4304, 8154, 8343, }, { 10, 20, 2, }, },
				[8348]  = {  nil,  8348, 1, 10632,   nil, 250, 270, 280, 290,   1,   1, { 4304, 7077, 7075, 8172, 8343, }, { 40, 8, 4, 2, 4, }, { 7868, 7869, }, 0, },
				[15564] = {  nil, 15564, 1, 19058,   nil, 250, 250, 260, 270,   1,   1, { 8170, }, { 5, }, { 7870, 11097, 11098, }, 0, },
				[15077] = {  nil, 15077, 1, 19048, 15724, 255, 275, 285, 295,   1,   1, { 8170, 15408, 14341, }, { 4, 4, 1, }, },
				[8367]  = {  nil,  8367, 1, 10650,   nil, 255, 275, 285, 295,   1,   1, { 4304, 8165, 8343, 8172, }, { 40, 30, 4, 4, }, { 7866, 7867, }, 0, },
				[15045] = {  nil, 15045, 1, 19050, 15726, 260, 280, 290, 300,   1,   1, { 8170, 15412, 14341, }, { 20, 25, 2, }, },
				[15083] = {  nil, 15083, 1, 19049, 15725, 260, 280, 290, 300,   1,   1, { 8170, 2325, 14341, }, { 8, 1, 1, }, },
				[15074] = {  nil, 15074, 1, 19053, 15729, 265, 285, 295, 305,   1,   1, { 8170, 15423, 14341, }, { 6, 6, 1, }, },
				[15084] = {  nil, 15084, 1, 19052, 15728, 265, 285, 295, 305,   1,   1, { 8170, 2325, 14341, }, { 8, 1, 1, }, },
				[15076] = {  nil, 15076, 1, 19051, 15727, 265, 285, 295, 305,   1,   1, { 8170, 15408, 14341, }, { 6, 6, 1, }, },
				[15067] = {  nil, 15067, 1, 19062, 15735, 270, 290, 300, 310,   1,   1, { 8170, 15420, 1529, 14341, }, { 24, 80, 2, 1, }, },
				[15091] = {  nil, 15091, 1, 19055, 15731, 270, 290, 300, 310,   1,   1, { 8170, 14047, 14341, }, { 10, 6, 1, }, },
				[15046] = {  nil, 15046, 1, 19060, 15733, 270, 290, 300, 310,   1,   1, { 8170, 15412, 14341, }, { 20, 25, 1, }, },
				[15061] = {  nil, 15061, 1, 19061, 15734, 270, 290, 300, 310,   1,   1, { 8170, 12803, 14341, }, { 12, 4, 1, }, },
				[15054] = {  nil, 15054, 1, 19059, 15732, 270, 290, 300, 310,   1,   1, { 8170, 7078, 7075, 14341, }, { 6, 1, 1, 1, }, },
				[15071] = {  nil, 15071, 1, 19066, 15740, 275, 295, 305, 315,   1,   1, { 8170, 15422, 14341, }, { 4, 6, 1, }, },
				[15073] = {  nil, 15073, 1, 19063, 15737, 275, 295, 305, 315,   1,   1, { 8170, 15423, 14341, }, { 4, 8, 1, }, },
				[15064] = {  nil, 15064, 1, 19068, 20253, 275, 295, 305, 315,   1,   1, { 8170, 15419, 14341, }, { 28, 12, 1, }, },
				[15057] = {  nil, 15057, 1, 19067, 15741, 275, 295, 305, 315,   1,   1, { 8170, 7080, 7082, 14341, }, { 16, 2, 2, 1, }, },
				[15092] = {  nil, 15092, 1, 19065, 15739, 275, 295, 305, 315,   1,   1, { 8170, 7971, 14047, 14341, }, { 6, 1, 6, 1, }, },
				[15078] = {  nil, 15078, 1, 19064, 15738, 275, 295, 305, 315,   1,   1, { 8170, 15408, 14341, }, { 6, 8, 1, }, },
				[20296] = {  nil, 20296, 1, 24655,   nil, 280, 300, 310, 320,   1,   1, { 8170, 15412, 15407, 14341, }, { 20, 30, 1, 2, }, { 7866, 7867, }, 0, },
				[15082] = {  nil, 15082, 1, 19070, 15743, 280, 300, 310, 320,   1,   1, { 8170, 15408, 14341, }, { 6, 8, 1, }, },
				[15093] = {  nil, 15093, 1, 19072, 15745, 280, 300, 310, 320,   1,   1, { 8170, 14047, 14341, }, { 12, 10, 1, }, },
				[15086] = {  nil, 15086, 1, 19071, 15744, 280, 300, 310, 320,   1,   1, { 8170, 2325, 14341, }, { 12, 1, 1, }, },
				[15072] = {  nil, 15072, 1, 19073, 15746, 280, 300, 310, 320,   1,   1, { 8170, 15423, 14341, }, { 8, 8, 1, }, },
				[15056] = {  nil, 15056, 1, 19079, 15753, 285, 305, 315, 325,   1,   1, { 8170, 7080, 7082, 15407, 14341, }, { 16, 3, 3, 1, 1, }, },
				[15048] = {  nil, 15048, 1, 19077, 15751, 285, 305, 315, 325,   1,   1, { 8170, 15415, 15407, 14341, }, { 28, 30, 1, 1, }, },
				[15060] = {  nil, 15060, 1, 19078, 15752, 285, 305, 315, 325,   1,   1, { 8170, 12803, 15407, 14341, }, { 16, 6, 1, 1, }, },
				[15065] = {  nil, 15065, 1, 19080, 20254, 285, 305, 315, 325,   1,   1, { 8170, 15419, 14341, }, { 24, 14, 1, }, },
				[18258] = {  nil, 18258, 1, 22815,   nil, 285, 285, 290, 295,   1,   1, { 8170, 14048, 18240, 14341, }, { 4, 2, 1, 1, }, { 5518, }, },
				[15079] = {  nil, 15079, 1, 19075, 15748, 285, 305, 315, 325,   1,   1, { 8170, 15408, 14341, }, { 8, 12, 1, }, },
				[15069] = {  nil, 15069, 1, 19074, 15747, 285, 305, 315, 325,   1,   1, { 8170, 15422, 14341, }, { 6, 8, 1, }, },
				[15053] = {  nil, 15053, 1, 19076, 15749, 285, 305, 315, 325,   1,   1, { 8170, 7078, 7076, 14341, }, { 8, 1, 1, 1, }, },
				[15066] = {  nil, 15066, 1, 19086, 15760, 290, 310, 320, 330,   1,   1, { 8170, 15420, 1529, 15407, 14341, }, { 40, 120, 1, 1, 1, }, },
				[15087] = {  nil, 15087, 1, 19083, 15757, 290, 310, 320, 330,   1,   1, { 8170, 15407, 2325, 14341, }, { 16, 1, 3, 1, }, },
				[15063] = {  nil, 15063, 1, 19084, 15758, 290, 310, 320, 330,   1,   1, { 8170, 15417, 14341, }, { 30, 8, 1, }, },
				[15094] = {  nil, 15094, 1, 19082, 15756, 290, 310, 320, 330,   1,   1, { 8170, 14047, 14341, }, { 14, 10, 1, }, },
				[15075] = {  nil, 15075, 1, 19081, 15755, 290, 310, 320, 330,   1,   1, { 8170, 15423, 14341, }, { 10, 10, 1, }, },
				[19052] = {  nil, 19052, 3, 23705, 19328, 290, 310, 320, 330,   1,   1, { 8170, 12809, 7080, 15407, 14341, }, { 30, 2, 4, 2, 2, }, },
				[19044] = {  nil, 19044, 3, 23703, 19326, 290, 310, 320, 330,   1,   1, { 8170, 12804, 12803, 15407, 14341, }, { 30, 2, 4, 2, 2, }, },
				[15050] = {  nil, 15050, 1, 19085, 15759, 290, 310, 320, 330,   1,   1, { 8170, 15416, 15407, 14341, }, { 40, 60, 1, 2, }, },
				[15049] = {  nil, 15049, 1, 19089, 15763, 295, 315, 325, 335,   1,   1, { 8170, 15415, 12810, 15407, 14341, }, { 28, 30, 2, 1, 1, }, },
				[16982] = {  nil, 16982, 1, 20853, 17022, 295, 315, 325, 335,   1,   1, { 17012, 17010, 17011, 14341, }, { 20, 6, 2, 2, }, },
				[15080] = {  nil, 15080, 1, 19088, 15762, 295, 315, 325, 335,   1,   1, { 8170, 15408, 15407, 14341, }, { 8, 12, 1, 1, }, },
				[15058] = {  nil, 15058, 1, 19090, 15764, 295, 315, 325, 335,   1,   1, { 8170, 7080, 7082, 12810, 14341, }, { 12, 3, 3, 2, 1, }, },
				[15070] = {  nil, 15070, 1, 19087, 15761, 295, 315, 325, 335,   1,   1, { 8170, 15422, 14341, }, { 6, 10, 1, }, },
				[15059] = {  nil, 15059, 1, 19095, 15771, 300, 320, 330, 340,   1,   1, { 8170, 12803, 14342, 15407, 14341, }, { 16, 8, 2, 1, 2, }, },
				[18509] = {  nil, 18509, 1, 22926, 18517, 300, 320, 330, 340,   1,   1, { 8170, 12607, 15416, 15414, 15407, 14341, }, { 30, 12, 30, 30, 5, 8, }, },
				[16983] = {  nil, 16983, 1, 20854, 17023, 300, 320, 330, 340,   1,   1, { 17012, 17010, 17011, 14341, }, { 15, 3, 6, 2, }, },
				[15095] = {  nil, 15095, 1, 19091, 15765, 300, 320, 330, 340,   1,   1, { 8170, 14047, 12810, 14341, }, { 18, 12, 2, 1, }, },
				[19157] = {  nil, 19157, 3, 23708, 19331, 300, 320, 330, 340,   1,   1, { 17010, 17011, 17012, 12607, 15407, 14227, }, { 5, 2, 4, 4, 4, 4, }, },
				[19689] = {  nil, 19689, 4, 24125, 19773, 300, 320, 330, 340,   1,   1, { 19768, 19726, 15407, 14341, }, { 25, 2, 3, 3, }, },
				[18506] = {  nil, 18506, 1, 22922, 18515, 300, 320, 330, 340,   1,   1, { 8170, 7082, 11754, 15407, 14341, }, { 12, 6, 4, 2, 4, }, },
				[20478] = {  nil, 20478, 5, 24851, 20511, 300, 320, 330, 340,   1,   1, { 20501, 20498, 18512, 15407, }, { 3, 40, 2, 2, }, },
				[22665] = {  nil, 22665, 6, 28224,   nil, 300, 320, 330, 340,   1,   1, { 22682, 15408, 7080, 15407, 14227, }, { 4, 16, 2, 2, 4, }, { 16365, }, 0, { 9233, }, },
				[22661] = {  nil, 22661, 6, 28219,   nil, 300, 320, 330, 340,   1,   1, { 22682, 12810, 7080, 15407, 14227, }, { 7, 16, 2, 4, 4, }, { 16365, }, 0, { 9233, }, },
				[19049] = {  nil, 19049, 3, 23704, 19327, 300, 320, 330, 340,   1,   1, { 12810, 12804, 12803, 15407, 14227, }, { 8, 6, 6, 2, 2, }, },
				[15068] = {  nil, 15068, 1, 19104, 15779, 300, 320, 330, 340,   1,   1, { 8170, 15422, 15407, 14341, }, { 12, 12, 1, 2, }, },
				[15138] = {  nil, 15138, 1, 19093,   nil, 300, 320, 330, 340,   1,   1, { 15410, 14044, 14341, }, { 1, 1, 1, }, { 7493, 7497, }, },
				[15051] = {  nil, 15051, 1, 19094, 15770, 300, 320, 330, 340,   1,   1, { 8170, 15416, 12810, 15407, 14341, }, { 44, 45, 2, 1, 1, }, },
				[15062] = {  nil, 15062, 1, 19097, 15772, 300, 320, 330, 340,   1,   1, { 8170, 15417, 15407, 14341, }, { 30, 14, 1, 1, }, },
				[15085] = {  nil, 15085, 1, 19098, 15773, 300, 320, 330, 340,   1,   1, { 8170, 15407, 14256, 2325, 14341, }, { 20, 2, 6, 4, 2, }, },
				[15055] = {  nil, 15055, 1, 19101, 15775, 300, 320, 330, 340,   1,   1, { 8170, 7078, 7076, 14341, }, { 10, 1, 1, 2, }, },
				[15052] = {  nil, 15052, 1, 19107, 15781, 300, 320, 330, 340,   1,   1, { 8170, 15416, 12810, 15407, 14341, }, { 40, 60, 4, 1, 2, }, },
				[15047] = {  nil, 15047, 1, 19054, 15730, 300, 320, 330, 340,   1,   1, { 8170, 15414, 14341, }, { 40, 30, 1, }, },
				[15096] = {  nil, 15096, 1, 19103, 15777, 300, 320, 330, 340,   1,   1, { 8170, 12810, 14047, 15407, 14341, }, { 16, 4, 18, 1, 2, }, },
				[19685] = {  nil, 19685, 4, 24121, 19769, 300, 320, 330, 340,   1,   1, { 19767, 15407, 12803, 14341, }, { 14, 5, 4, 4, }, },
				[15081] = {  nil, 15081, 1, 19100, 15774, 300, 320, 330, 340,   1,   1, { 8170, 15408, 15407, 14341, }, { 14, 14, 1, 2, }, },
				[20295] = {  nil, 20295, 1, 24654,   nil, 300, 320, 330, 340,   1,   1, { 8170, 15415, 15407, 14341, }, { 28, 36, 2, 2, }, { 7866, 7867, }, 0, },
				[19687] = {  nil, 19687, 4, 24123, 19771, 300, 320, 330, 340,   1,   1, { 19767, 15407, 12803, 14341, }, { 8, 3, 4, 3, }, },
				[20476] = {  nil, 20476, 5, 24849, 20509, 300, 320, 330, 340,   1,   1, { 20501, 20498, 18512, }, { 1, 20, 2, }, },
				[19162] = {  nil, 19162, 3, 23709, 19332, 300, 320, 330, 340,   1,   1, { 17010, 17012, 12810, 15407, 14227, }, { 8, 12, 10, 4, 4, }, },
				[22760] = {  nil, 22760, 5, 28473, 22770, 300, 320, 330, 340,   1,   1, { 12810, 18512, 12803, 15407, }, { 6, 2, 2, 2, }, },
				[18251] = {  nil, 18251, 1, 22727, 18252, 300, 320, 330, 340,   1,   1, { 17012, 14341, }, { 3, 2, }, },
				[22663] = {  nil, 22663, 6, 28221,   nil, 300, 320, 330, 340,   1,   1, { 22682, 12810, 7080, 15407, 14227, }, { 4, 12, 2, 2, 4, }, { 16365, }, 0, { 9233, }, },
				[20380] = {  nil, 20380, 5, 24703, 20382, 300, 320, 330, 340,   1,   1, { 12810, 20381, 12803, 15407, 14227, }, { 12, 6, 4, 4, 6, }, },
				[19149] = {  nil, 19149, 3, 23707, 19330, 300, 320, 330, 340,   1,   1, { 17011, 15407, 14227, }, { 5, 4, 4, }, },
				[18511] = {  nil, 18511, 1, 22928, 18519, 300, 320, 330, 340,   1,   1, { 8170, 7082, 12753, 12809, 15407, 14341, }, { 30, 12, 4, 8, 4, 8, }, },
				[22664] = {  nil, 22664, 6, 28222,   nil, 300, 320, 330, 340,   1,   1, { 22682, 15408, 7080, 15407, 14227, }, { 7, 24, 2, 4, 4, }, { 16365, }, 0, { 9233, }, },
				[22662] = {  nil, 22662, 6, 28220,   nil, 300, 320, 330, 340,   1,   1, { 22682, 12810, 7080, 15407, 14227, }, { 5, 12, 2, 3, 4, }, { 16365, }, 0, { 9233, }, },
				[19058] = {  nil, 19058, 3, 23706, 19329, 300, 320, 330, 340,   1,   1, { 12810, 12803, 12809, 15407, 14341, }, { 8, 4, 4, 2, 2, }, },
				[18510] = {  nil, 18510, 1, 22927, 18518, 300, 320, 330, 340,   1,   1, { 8170, 12803, 7080, 18512, 15407, 14341, }, { 30, 12, 10, 8, 3, 8, }, },
				[19688] = {  nil, 19688, 4, 24124, 19772, 300, 320, 330, 340,   1,   1, { 19768, 19726, 15407, 14341, }, { 35, 2, 3, 3, }, },
				[22666] = {  nil, 22666, 6, 28223,   nil, 300, 320, 330, 340,   1,   1, { 22682, 15408, 7080, 15407, 14227, }, { 5, 16, 2, 3, 4, }, { 16365, }, 0, { 9233, }, },
				[22759] = {  nil, 22759, 5, 28472, 22771, 300, 320, 330, 340,   1,   1, { 12810, 19726, 12803, 15407, }, { 12, 2, 2, 2, }, },
				[20477] = {  nil, 20477, 5, 24850, 20510, 300, 320, 330, 340,   1,   1, { 20501, 20498, 18512, 15407, }, { 2, 30, 2, 1, }, },
				[20481] = {  nil, 20481, 5, 24846, 20506, 300, 320, 330, 340,   1,   1, { 20500, 20498, 7078, }, { 1, 20, 2, }, },
				[22761] = {  nil, 22761, 5, 28474, 22769, 300, 320, 330, 340,   1,   1, { 12810, 12803, 15407, }, { 4, 2, 1, }, },
				[18504] = {  nil, 18504, 1, 22921, 18514, 300, 320, 330, 340,   1,   1, { 8170, 12804, 15407, 14341, }, { 12, 12, 2, 4, }, },
				[15141] = {  nil, 15141, 1, 19106, 15780, 300, 320, 330, 340,   1,   1, { 8170, 15410, 15416, 14341, }, { 40, 12, 60, 2, }, },
				[20480] = {  nil, 20480, 5, 24847, 20507, 300, 320, 330, 340,   1,   1, { 20500, 20498, 7078, 15407, }, { 2, 30, 2, 1, }, },
				[15088] = {  nil, 15088, 1, 19092, 15768, 300, 320, 330, 340,   1,   1, { 8170, 2325, 14341, }, { 14, 2, 2, }, },
				[18508] = {  nil, 18508, 1, 22923, 18516, 300, 320, 330, 340,   1,   1, { 8170, 18512, 15420, 15407, 14341, }, { 12, 8, 60, 4, 4, }, },
				[19686] = {  nil, 19686, 4, 24122, 19770, 300, 320, 330, 340,   1,   1, { 19767, 15407, 12803, 14341, }, { 10, 4, 4, 3, }, },
				[20479] = {  nil, 20479, 5, 24848, 20508, 300, 320, 330, 340,   1,   1, { 20500, 20498, 7078, 15407, }, { 3, 40, 2, 2, }, },
				[16984] = {  nil, 16984, 1, 20855, 17025, 300, 320, 330, 340,   1,   1, { 12810, 15416, 17010, 17011, 14341, }, { 6, 30, 4, 3, 2, }, },
				[15090] = {  nil, 15090, 1, 19102, 15776, 300, 320, 330, 340,   1,   1, { 8170, 12810, 14047, 15407, 14341, }, { 22, 4, 16, 1, 2, }, },
				[21278] = {  nil, 21278, 5, 26279, 21548, 300, 320, 330, 340,   1,   1, { 12810, 7080, 7082, 15407, 14227, }, { 6, 4, 4, 2, 2, }, },
				[19163] = {  nil, 19163, 3, 23710, 19333, 300, 320, 330, 340,   1,   1, { 17010, 17011, 7076, 15407, 14227, }, { 2, 7, 6, 4, 4, }, },
			},
			[4] = {
				[2454]  = { true,  2454, 1,  2329,   nil,   1,  55,  75,  95,   1,   1, { 2449, 765, 3371, }, { 1, 1, 1, }, { 1215, 1246, 1386, 1470, 2132, 2391, 3009, 3184, 3347, 3603, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 5500, 7948, 11041, 11042, 11044, 11046, 11047, }, 0, },
				[5997]  = { true,  5997, 1,  7183,   nil,   1,  55,  75,  95,   1,   1, { 765, 3371, }, { 2, 1, }, { 1215, 1246, 1386, 1470, 2132, 2391, 3009, 3184, 3347, 3603, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 5500, 7948, 11041, 11042, 11044, 11046, 11047, }, 0, },
				[118]   = { true,   118, 1,  2330,   nil,   1,  55,  75,  95,   1,   1, { 2447, 765, 3371, }, { 1, 1, 1, }, { 1215, 1246, 1386, 1470, 2132, 2391, 3009, 3184, 3347, 3603, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 5500, 7948, 11041, 11042, 11044, 11046, 11047, }, 0, },
				[8827]  = {  nil,  8827, 1, 11447,   nil,   1, 190, 210, 230,   1,   1, { 6370, 3357, 3372, }, { 1, 1, 1, }, },
				[17967] = {  nil, 17967, 1, 22430,   nil,   1, 315, 322, 330,   1,   1, { 15410, }, { 1, }, },
				[3382]  = {  nil,  3382, 1,  3170,   nil,  15,  60,  80, 100,   1,   1, { 2447, 2449, 3371, }, { 1, 2, 1, }, { 1215, 1246, 1386, 1470, 2132, 2391, 2837, 3184, 3347, 3603, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 5500, 7948, 11041, 11042, 11044, 11046, 11047, }, 0, },
				[2455]  = {  nil,  2455, 1,  2331,   nil,  25,  65,  85, 105,   1,   1, { 785, 765, 3371, }, { 1, 1, 1, }, { 1215, 1246, 1386, 1470, 2132, 2391, 2837, 3184, 3347, 3603, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 5500, 7948, 11041, 11042, 11044, 11046, 11047, }, 0, },
				[2456]  = {  nil,  2456, 1,  2332,   nil,  40,  70,  90, 110,   1,   1, { 785, 2447, 3371, }, { 2, 1, 1, }, { 1215, 1246, 1386, 1470, 2132, 2391, 2837, 3184, 3347, 3603, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 5500, 7948, 11041, 11042, 11044, 11046, 11047, }, 0, },
				[4596]  = {  nil,  4596, 1,  4508,  4597,  50,  80, 100, 120,   1,   1, { 3164, 2447, 3371, }, { 1, 1, 1, }, },
				[2457]  = {  nil,  2457, 1,  3230,  2553,  50,  80, 100, 120,   1,   1, { 2452, 765, 3371, }, { 1, 1, 1, }, },
				[2458]  = {  nil,  2458, 1,  2334,   nil,  50,  80, 100, 120,   1,   1, { 2449, 2447, 3371, }, { 2, 1, 1, }, { 1215, 1246, 1386, 1470, 2132, 2391, 2837, 3184, 3347, 3603, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 5500, 7948, 11041, 11042, 11044, 11046, 11047, }, 0, },
				[858]   = {  nil,   858, 1,  2337,   nil,  55,  85, 105, 125,   1,   1, { 118, 2450, }, { 1, 1, }, { 1215, 1246, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 3603, 3964, 4609, 4900, 5177, 5499, 5500, 11041, 11042, 11044, 11046, 11047, }, 0, },
				[2459]  = {  nil,  2459, 1,  2335,  2555,  60,  90, 110, 130,   1,   1, { 2452, 2450, 3371, }, { 1, 1, 1, }, },
				[5631]  = {  nil,  5631, 1,  6617,  5640,  60,  90, 110, 130,   1,   1, { 5635, 2450, 3371, }, { 1, 1, 1, }, },
				[2460]  = {  nil,  2460, 1,  2336,  2556,  70, 100, 120, 140,   1,   1, { 2449, 785, 3371, }, { 2, 2, 1, }, },
				[6370]  = {  nil,  6370, 1,  7836,   nil,  80,  80,  90, 100,   1,   1, { 6358, 3371, }, { 2, 1, }, { 1215, 1246, 1386, 1470, 2132, 2391, 2837, 3184, 3347, 3603, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 5500, 7948, 11041, 11042, 11044, 11046, 11047, }, 0, },
				[6662]  = {  nil,  6662, 1,  8240,  6663,  90, 120, 140, 160,   1,   1, { 6522, 2449, 3371, }, { 1, 1, 1, }, },
				[5996]  = {  nil,  5996, 1,  7179,   nil,  90, 120, 140, 160,   1,   1, { 3820, 6370, 3371, }, { 1, 2, 1, }, { 1215, 1246, 1386, 1470, 2132, 2391, 2837, 3184, 3347, 3603, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 5500, 7948, 11041, 11042, 11044, 11046, 11047, }, 0, },
				[3383]  = {  nil,  3383, 1,  3171,   nil,  90, 120, 140, 160,   1,   1, { 785, 2450, 3371, }, { 1, 2, 1, }, { 1215, 1246, 1386, 1470, 2132, 2391, 2837, 3184, 3347, 3603, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 5500, 7948, 11041, 11042, 11044, 11046, 11047, }, 0, },
				[6051]  = {  nil,  6051, 1,  7255,  6053, 100, 130, 150, 170,   1,   1, { 2453, 2452, 3371, }, { 1, 1, 1, }, },
				[6372]  = {  nil,  6372, 1,  7841,   nil, 100, 130, 150, 170,   1,   1, { 2452, 6370, 3371, }, { 1, 1, 1, }, { 1215, 1246, 1386, 1470, 2132, 2391, 2837, 3184, 3347, 3603, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 5500, 7948, 11041, 11042, 11044, 11046, 11047, }, 0, },
				[3384]  = {  nil,  3384, 1,  3172,  3393, 110, 135, 155, 175,   1,   1, { 785, 3355, 3371, }, { 3, 1, 1, }, },
				[929]   = {  nil,   929, 1,  3447,   nil, 110, 135, 155, 175,   1,   1, { 2453, 2450, 3372, }, { 1, 1, 1, }, { 1215, 1246, 1386, 1470, 2132, 2391, 2837, 3184, 3347, 3603, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 5500, 7948, 11041, 11042, 11044, 11046, 11047, }, 0, },
				[3386]  = {  nil,  3386, 1,  3174,  3394, 120, 145, 165, 185,   1,   1, { 1288, 2453, 3372, }, { 1, 1, 1, }, },
				[3385]  = {  nil,  3385, 1,  3173,   nil, 120, 145, 165, 185,   1,   1, { 785, 3820, 3371, }, { 1, 1, 1, }, { 1215, 1246, 1386, 1470, 2132, 2391, 2837, 3184, 3347, 3603, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 5500, 7948, 11041, 11042, 11044, 11046, 11047, }, 0, },
				[5632]  = {  nil,  5632, 1,  6619,  5641, 125, 150, 170, 190,   1,   1, { 5636, 3356, 3372, }, { 1, 1, 1, }, },
				[3388]  = {  nil,  3388, 1,  3176,   nil, 125, 150, 170, 190,   1,   1, { 2453, 2450, 3372, }, { 2, 2, 1, }, { 1215, 1246, 1386, 1470, 2132, 2391, 2837, 3184, 3347, 3603, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 5500, 7948, 11041, 11042, 11044, 11046, 11047, }, 0, },
				[6371]  = {  nil,  6371, 1,  7837,   nil, 130, 150, 160, 170,   1,   1, { 6359, 3371, }, { 2, 1, }, { 1215, 1246, 1386, 1470, 2132, 2391, 2837, 3184, 3347, 3603, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 5500, 7948, 11041, 11042, 11044, 11046, 11047, }, 0, },
				[3389]  = {  nil,  3389, 1,  3177,   nil, 130, 155, 175, 195,   1,   1, { 3355, 3820, 3372, }, { 1, 1, 1, }, { 1215, 1246, 1386, 1470, 2132, 2391, 2837, 3184, 3347, 3603, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 5500, 7948, 11041, 11042, 11044, 11046, 11047, }, 0, },
				[6048]  = {  nil,  6048, 1,  7256,  6054, 135, 160, 180, 200,   1,   1, { 3369, 3356, 3372, }, { 1, 1, 1, }, },
				[6373]  = {  nil,  6373, 1,  7845,   nil, 140, 165, 185, 205,   1,   1, { 6371, 3356, 3372, }, { 2, 1, 1, }, { 1215, 1246, 1386, 1470, 2132, 2391, 2837, 3184, 3347, 3603, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 5500, 7948, 11041, 11042, 11044, 11046, 11047, }, 0, },
				[3390]  = {  nil,  3390, 1,  2333,  3396, 140, 165, 185, 205,   1,   1, { 3355, 2452, 3372, }, { 1, 1, 1, }, },
				[5634]  = {  nil,  5634, 1,  6624,  5642, 150, 175, 195, 215,   1,   1, { 6370, 3820, 3372, }, { 2, 1, 1, }, },
				[3391]  = {  nil,  3391, 1,  3188,  6211, 150, 175, 195, 215,   1,   1, { 2449, 3356, 3372, }, { 1, 1, 1, }, },
				[1710]  = {  nil,  1710, 1,  7181,   nil, 155, 175, 195, 215,   1,   1, { 3357, 3356, 3372, }, { 1, 1, 1, }, { 1386, 4160, 4611, 7948, }, 0, },
				[3827]  = {  nil,  3827, 1,  3452,   nil, 160, 180, 200, 220,   1,   1, { 3820, 3356, 3372, }, { 1, 1, 1, }, { 1386, 4160, 4611, 7948, }, 0, },
				[3824]  = {  nil,  3824, 1,  3449,  6068, 165, 190, 210, 230,   1,   1, { 3818, 3369, 3372, }, { 4, 4, 1, }, },
				[3823]  = {  nil,  3823, 1,  3448,   nil, 165, 185, 205, 225,   1,   1, { 3818, 3355, 3372, }, { 1, 1, 1, }, { 1386, 4160, 4611, 7948, }, 0, },
				[6049]  = {  nil,  6049, 1,  7257,  6055, 165, 210, 230, 250,   1,   1, { 4402, 6371, 3372, }, { 1, 1, 1, }, },
				[3825]  = {  nil,  3825, 1,  3450,  3830, 175, 195, 215, 235,   1,   1, { 3355, 3821, 3372, }, { 1, 1, 1, }, },
				[5633]  = {  nil,  5633, 1,  6618,  5643, 175, 195, 215, 235,   1,   1, { 5637, 3356, 3372, }, { 1, 1, 1, }, },
				[3826]  = {  nil,  3826, 1,  3451,  3831, 180, 200, 220, 240,   1,   1, { 3357, 2453, 3372, }, { 1, 1, 1, }, },
				[8949]  = {  nil,  8949, 1, 11449,   nil, 185, 205, 225, 245,   1,   1, { 3820, 3821, 3372, }, { 1, 1, 1, }, { 1386, 4160, 4611, 7948, }, 0, },
				[6052]  = {  nil,  6052, 1,  7259,  6057, 190, 210, 230, 250,   1,   1, { 3357, 3820, 3372, }, { 1, 1, 1, }, },
				[17708] = {  nil, 17708, 1, 21923, 17709, 190, 210, 230, 250,   1,   1, { 3819, 3358, 3372, }, { 2, 1, 1, }, },
				[6050]  = {  nil,  6050, 1,  7258,  6056, 190, 205, 225, 245,   1,   1, { 3819, 3821, 3372, }, { 1, 1, 1, }, },
				[3828]  = {  nil,  3828, 1,  3453,  3832, 195, 215, 235, 255,   1,   1, { 3358, 3818, 3372, }, { 1, 1, 1, }, },
				[8951]  = {  nil,  8951, 1, 11450,   nil, 195, 215, 235, 255,   1,   1, { 3355, 3821, 3372, }, { 1, 1, 1, }, { 1386, 4160, 4611, 7948, }, 0, },
				[10592] = {  nil, 10592, 1, 12609,   nil, 200, 220, 240, 260,   1,   1, { 3821, 3818, 3372, }, { 1, 1, 1, }, { 1386, 4160, 4611, 7948, }, 0, },
				[3829]  = {  nil,  3829, 1,  3454, 14634, 200, 220, 240, 260,   1,   1, { 3358, 3819, 3372, }, { 4, 2, 1, }, },
				[8956]  = {  nil,  8956, 1, 11451,   nil, 205, 220, 240, 260,   1,   1, { 4625, 3821, 8925, }, { 1, 1, 1, }, { 1386, 7948, }, 0, },
				[6149]  = {  nil,  6149, 1, 11448,   nil, 205, 220, 240, 260,   1,   1, { 3358, 3821, 3372, }, { 1, 1, 1, }, { 1386, 7948, }, 0, },
				[9030]  = {  nil,  9030, 1, 11452,   nil, 210, 225, 245, 265,   1,   1, { 7067, 3821, 8925, }, { 1, 1, 1, }, { 1470, 6868, }, 0, { 2203, 2501, }, },
				[9061]  = {  nil,  9061, 1, 11456, 10644, 210, 225, 245, 265,   1,   1, { 4625, 9260, 3372, }, { 1, 1, 1, }, },
				[9036]  = {  nil,  9036, 1, 11453,  9293, 210, 225, 245, 265,   1,   1, { 3358, 8831, 8925, }, { 1, 1, 1, }, },
				[18294] = {  nil, 18294, 1, 22808,   nil, 215, 230, 250, 270,   1,   1, { 7972, 8831, 8925, }, { 1, 2, 1, }, { 1386, 7948, }, 0, },
				[3928]  = {  nil,  3928, 1, 11457,   nil, 215, 230, 250, 270,   1,   1, { 8838, 3358, 8925, }, { 1, 1, 1, }, { 1386, 7948, }, 0, },
				[4623]  = {  nil,  4623, 1,  4942,  4624, 215, 230, 250, 270,   1,   1, { 3858, 3821, 3372, }, { 1, 1, 1, }, },
				[9144]  = {  nil,  9144, 1, 11458,  9294, 225, 240, 260, 280,   1,   1, { 8153, 8831, 8925, }, { 1, 1, 1, }, },
				[9149]  = {  nil,  9149, 1, 11459,  9303, 225, 240, 260, 280,   1,   1, { 3575, 9262, 8831, 4625, }, { 4, 1, 4, 4, }, },
				[3577]  = {  nil,  3577, 1, 11479,  9304, 225, 240, 260, 280,   1,   1, { 3575, }, { 1, }, },
				[6037]  = {  nil,  6037, 1, 11480,  9305, 225, 240, 260, 280,   1,   1, { 3860, }, { 1, }, },
				[12190] = {  nil, 12190, 1, 15833,   nil, 230, 245, 265, 285,   1,   1, { 8831, 8925, }, { 3, 1, }, { 1386, 7948, }, 0, },
				[9154]  = {  nil,  9154, 1, 11460,   nil, 230, 245, 265, 285,   1,   1, { 8836, 8925, }, { 1, 1, }, { 1386, 7948, }, 0, },
				[9179]  = {  nil,  9179, 1, 11465,   nil, 235, 250, 270, 290,   1,   1, { 8839, 3358, 8925, }, { 1, 1, 1, }, { 1386, 7948, }, 0, },
				[9155]  = {  nil,  9155, 1, 11461,   nil, 235, 250, 270, 290,   1,   1, { 8839, 3821, 8925, }, { 1, 1, 1, }, { 1386, 7948, }, 0, },
				[9172]  = {  nil,  9172, 1, 11464,  9295, 235, 250, 270, 290,   1,   1, { 8845, 8838, 8925, }, { 1, 1, 1, }, },
				[9197]  = {  nil,  9197, 1, 11468,  9297, 240, 255, 275, 295,   1,   1, { 8831, 8925, }, { 3, 1, }, },
				[9088]  = {  nil,  9088, 1, 11466,  9296, 240, 255, 275, 295,   1,   1, { 8836, 8839, 8925, }, { 1, 1, 1, }, },
				[9187]  = {  nil,  9187, 1, 11467,   nil, 240, 255, 275, 295,   1,   1, { 8838, 3821, 8925, }, { 1, 1, 1, }, { 1386, 7948, }, 0, },
				[9210]  = {  nil,  9210, 1, 11473,  9302, 245, 260, 280, 300,   1,   1, { 8845, 4342, 8925, }, { 2, 1, 1, }, },
				[9206]  = {  nil,  9206, 1, 11472,  9298, 245, 260, 280, 300,   1,   1, { 8838, 8846, 8925, }, { 1, 1, 1, }, },
				[13423] = {  nil, 13423, 1, 17551,   nil, 250, 250, 255, 260,   1,   1, { 13422, 3372, }, { 1, 1, }, { 1386, 7948, }, 0, },
				[9233]  = {  nil,  9233, 1, 11478,   nil, 250, 265, 285, 305,   1,   1, { 8846, 8925, }, { 2, 1, }, { 1386, 7948, }, 0, },
				[9224]  = {  nil,  9224, 1, 11477,  9300, 250, 265, 285, 305,   1,   1, { 8846, 8845, 8925, }, { 1, 1, 1, }, },
				[21546] = {  nil, 21546, 5, 26277, 21547, 250, 265, 285, 305,   1,   1, { 6371, 4625, 8925, }, { 3, 3, 1, }, },
				[3387]  = {  nil,  3387, 1,  3175,  3395, 250, 275, 295, 315,   1,   1, { 8839, 8845, 8925, }, { 2, 1, 1, }, },
				[9264]  = {  nil,  9264, 1, 11476,  9301, 250, 265, 285, 305,   1,   1, { 8845, 8925, }, { 3, 1, }, },
				[13442] = {  nil, 13442, 1, 17552, 13476, 255, 270, 290, 310,   1,   1, { 8846, 8925, }, { 3, 1, }, },
				[13443] = {  nil, 13443, 1, 17553, 13477, 260, 275, 295, 315,   1,   1, { 8838, 8839, 8925, }, { 2, 2, 1, }, },
				[13445] = {  nil, 13445, 1, 17554, 13478, 265, 280, 300, 320,   1,   1, { 13423, 8838, 8925, }, { 2, 1, 1, }, },
				[13447] = {  nil, 13447, 1, 17555, 13479, 270, 285, 305, 325,   1,   1, { 13463, 13466, 8925, }, { 1, 2, 1, }, },
				[20002] = {  nil, 20002, 4, 24366, 20012, 275, 290, 310, 330,   1,   1, { 13463, 13464, 8925, }, { 2, 1, 1, }, },
				[20007] = {  nil, 20007, 4, 24365, 20011, 275, 290, 310, 330,   1,   1, { 13463, 13466, 8925, }, { 1, 2, 1, }, },
				[12808] = {  nil, 12808, 1, 17564, 13487, 275, 275, 282, 290,   1,   1, { 7080, }, { 1, }, },
				[12360] = {  nil, 12360, 1, 17187, 12958, 275, 275, 282, 290,   1,   1, { 12359, 12363, }, { 1, 1, }, },
				[13446] = {  nil, 13446, 1, 17556, 13480, 275, 290, 310, 330,   1,   1, { 13464, 13465, 8925, }, { 2, 1, 1, }, },
				[12803] = {  nil, 12803, 1, 17566, 13489, 275, 275, 282, 290,   1,   1, { 7076, }, { 1, }, },
				[7078]  = {  nil,  7078, 1, 17559, 13482, 275, 275, 282, 290,   1,   1, { 7082, }, { 1, }, },
				[7080]  = {  nil,  7080, 1, 17563, 13486, 275, 275, 282, 290,   1,   1, { 12808, }, { 1, }, },
				[13453] = {  nil, 13453, 1, 17557, 13481, 275, 290, 310, 330,   1,   1, { 8846, 13466, 8925, }, { 2, 2, 1, }, },
				[7076]  = {  nil,  7076, 1, 17560, 13483, 275, 275, 282, 290,   1,   1, { 7078, }, { 1, }, },
				[7082]  = {  nil,  7082, 1, 17562, 13485, 275, 275, 282, 290,   1,   1, { 7080, }, { 1, }, },
				[13452] = {  nil, 13452, 1, 17571, 13491, 280, 295, 315, 335,   1,   1, { 13465, 13466, 8925, }, { 2, 2, 1, }, },
				[13455] = {  nil, 13455, 1, 17570, 13490, 280, 295, 315, 335,   1,   1, { 13423, 10620, 8925, }, { 3, 1, 1, }, },
				[13454] = {  nil, 13454, 1, 17573, 13493, 285, 300, 320, 340,   1,   1, { 13463, 13465, 8925, }, { 3, 1, 1, }, },
				[20008] = {  nil, 20008, 4, 24367, 20013, 285, 300, 320, 340,   1,   1, { 13467, 13465, 10286, 8925, }, { 2, 2, 2, 1, }, },
				[13462] = {  nil, 13462, 1, 17572, 13492, 285, 300, 320, 340,   1,   1, { 13467, 13466, 8925, }, { 2, 2, 1, }, },
				[13459] = {  nil, 13459, 1, 17578, 13499, 290, 305, 325, 345,   1,   1, { 3824, 13463, 8925, }, { 1, 1, 1, }, },
				[20004] = {  nil, 20004, 4, 24368, 20014, 290, 305, 325, 345,   1,   1, { 8846, 13466, 8925, }, { 1, 2, 1, }, },
				[13460] = {  nil, 13460, 1, 17579, 13500, 290, 305, 325, 345,   1,   1, { 7069, 13463, 8925, }, { 1, 1, 1, }, },
				[13457] = {  nil, 13457, 1, 17574, 13494, 290, 305, 325, 345,   1,   1, { 7068, 13463, 8925, }, { 1, 1, 1, }, },
				[13456] = {  nil, 13456, 1, 17575, 13495, 290, 305, 325, 345,   1,   1, { 7070, 13463, 8925, }, { 1, 1, 1, }, },
				[13461] = {  nil, 13461, 1, 17577, 13497, 290, 305, 325, 345,   1,   1, { 11176, 13463, 8925, }, { 1, 1, 1, }, },
				[13458] = {  nil, 13458, 1, 17576, 13496, 290, 305, 325, 345,   1,   1, { 7067, 13463, 8925, }, { 1, 1, 1, }, },
				[13444] = {  nil, 13444, 1, 17580, 13501, 295, 310, 330, 350,   1,   1, { 13463, 13467, 8925, }, { 3, 2, 1, }, },
				[13512] = {  nil, 13512, 1, 17637, 13521, 300, 315, 322, 330,   1,   1, { 13463, 13465, 13468, 8925, }, { 30, 10, 1, 1, }, },
				[13513] = {  nil, 13513, 1, 17638, 13522, 300, 315, 322, 330,   1,   1, { 13467, 13465, 13468, 8925, }, { 30, 10, 1, 1, }, },
				[13503] = {  nil, 13503, 1, 17632, 13517, 300, 315, 322, 330,   1,   1, { 7078, 7076, 7082, 7080, 12803, 9262, 13468, }, { 8, 8, 8, 8, 8, 2, 4, }, },
				[13506] = {  nil, 13506, 1, 17634, 13518, 300, 315, 322, 330,   1,   1, { 13423, 13465, 13468, 8925, }, { 30, 10, 1, 1, }, },
				[13511] = {  nil, 13511, 1, 17636, 13520, 300, 315, 322, 330,   1,   1, { 13463, 13467, 13468, 8925, }, { 30, 10, 1, 1, }, },
				[19931] = {  nil, 19931, 1, 24266,   nil, 300, 315, 322, 330,   3,   3, { 12938, 19943, 12804, 13468, }, { 1, 1, 6, 1, }, 180368, },
				[13510] = {  nil, 13510, 1, 17635, 13519, 300, 315, 322, 330,   1,   1, { 8846, 13423, 13468, 8925, }, { 30, 10, 1, 1, }, },
				[7068]  = {  nil,  7068, 5, 25146, 20761, 300, 301, 305, 310,   3,   3, { 7077, }, { 1, }, },
				[18253] = {  nil, 18253, 1, 22732, 18257, 300, 310, 320, 330,   1,   1, { 10286, 13464, 13463, 18256, }, { 1, 4, 4, 1, }, },
			},
			[5] = nil,
			[6] = {
				[17197] = { true, 17197, 1, 21143, 17200,   1,  45,  65,  85,   1,   1, { 6889, 17194, }, { 1, 1, }, },
				[6290]  = { true,  6290, 1,  7751,  6325,   1,  45,  65,  85,   1,   1, { 6291, }, { 1, }, },
				[12224] = {  nil, 12224, 1, 15935, 12226,   1,  45,  65,  85,   1,   1, { 12223, 2678, }, { 1, 1, }, },
				[2679]  = { true,  2679, 1,  2538,   nil,   1,  45,  65,  85,   1,   1, { 2672, }, { 1, }, { 1355, 1382, 1430, 1699, 3026, 3067, 3087, 3399, 4210, 4552, 5159, 5482, 6286, 8306, }, 0, },
				[787]   = { true,   787, 1,  7752,  6326,   1,  45,  65,  85,   1,   1, { 6303, }, { 1, }, },
				[6888]  = { true,  6888, 1,  8604,   nil,   1,  45,  65,  85,   1,   1, { 6889, 2678, }, { 1, 1, }, { 1355, 1382, 1430, 1699, 3026, 3067, 3087, 3399, 4210, 4552, 5159, 5482, 6286, 8306, }, 0, },
				[2681]  = { true,  2681, 1,  2540,   nil,   1,  45,  65,  85,   1,   1, { 769, }, { 1, }, { 1355, 1382, 1430, 1699, 3026, 3067, 3087, 3399, 4210, 4552, 5159, 5482, 6286, 8306, }, 0, },
				[2680]  = { true,  2680, 1,  2539,   nil,  10,  50,  70,  90,   1,   1, { 2672, 2678, }, { 1, 1, }, { 1355, 1382, 1430, 1699, 3026, 3067, 3087, 3399, 4210, 4552, 5159, 5482, 6286, 8306, }, 0, },
				[5472]  = { true,  5472, 1,  6412,  5482,  10,  50,  70,  90,   1,   1, { 5465, }, { 1, }, },
				[5473]  = {  nil,  5473, 1,  6413,  5483,  20,  60,  80, 100,   1,   1, { 5466, }, { 1, }, },
				[2888]  = { true,  2888, 1,  2795,  2889,  25,  60,  80, 100,   1,   1, { 2886, 2894, }, { 1, 1, }, },
				[5474]  = {  nil,  5474, 1,  6414,  5484,  35,  75,  95, 115,   2,   2, { 5467, 2678, }, { 1, 1, }, },
				[17198] = { true, 17198, 1, 21144, 17201,  35,  75,  95, 115,   1,   1, { 6889, 1179, 17196, 17194, }, { 1, 1, 1, 1, }, },
				[6890]  = { true,  6890, 1,  8607,  6892,  40,  80, 100, 120,   1,   1, { 3173, }, { 1, }, },
				[5477]  = { true,  5477, 1,  6416,  5486,  50,  90, 110, 130,   2,   2, { 5469, 4536, }, { 1, 1, }, },
				[4592]  = { true,  4592, 1,  7753,  6328,  50,  90, 110, 130,   1,   1, { 6289, }, { 1, }, },
				[5476]  = { true,  5476, 1,  6415,  5485,  50,  90, 110, 130,   2,   2, { 5468, 2678, }, { 1, 1, }, },
				[724]   = { true,   724, 1,  2542,  2697,  50,  90, 110, 130,   1,   1, { 723, 2678, }, { 1, 1, }, },
				[5525]  = { true,  5525, 1,  6499,   nil,  50,  90, 110, 130,   1,   1, { 5503, 159, }, { 1, 1, }, { 1355, 1382, 1430, 1699, 3026, 3067, 3087, 3399, 4210, 4552, 5159, 5482, 6286, 8306, }, 0, },
				[5095]  = { true,  5095, 1,  7827,  6368,  50,  90, 110, 130,   1,   1, { 6361, }, { 1, }, },
				[6316]  = {  nil,  6316, 1,  7754,  6329,  50,  90, 110, 130,   1,   1, { 6317, 2678, }, { 1, 1, }, },
				[2684]  = { true,  2684, 1,  2541,   nil,  50,  90, 110, 130,   1,   1, { 2673, }, { 1, }, { 1355, 1382, 1430, 1699, 3026, 3067, 3087, 3399, 4210, 4552, 5159, 5482, 6286, 8306, }, 0, },
				[3220]  = { true,  3220, 1,  3371,  3679,  60, 100, 120, 140,   2,   2, { 3173, 3172, 3174, }, { 1, 1, 1, }, },
				[7676]  = {  nil,  7676, 1,  9513, 18160,  60, 100, 120, 140,   1,   1, { 2452, 159, }, { 1, 1, }, },
				[2683]  = { true,  2683, 1,  2544,   nil,  75, 115, 135, 155,   1,   1, { 2674, 2678, }, { 1, 1, }, { 1355, 1382, 1430, 1699, 3026, 3067, 3087, 3399, 4210, 4552, 5159, 5482, 6286, 8306, }, 0, },
				[733]   = { true,   733, 1,  2543,   728,  75, 115, 135, 155,   1,   1, { 729, 730, 731, }, { 1, 1, 1, }, },
				[3662]  = { true,  3662, 1,  3370,  3678,  80, 120, 140, 160,   1,   1, { 2924, 2678, }, { 1, 1, }, },
				[21072] = { true, 21072, 1, 25704, 21099,  80, 120, 140, 160,   1,   1, { 21071, 2678, }, { 1, 1, }, },
				[2687]  = { true,  2687, 1,  2546,   nil,  80, 120, 140, 160,   1,   1, { 2677, 2678, }, { 1, 1, }, { 1355, 1382, 1430, 1699, 3026, 3067, 3087, 3399, 4210, 4552, 5159, 5482, 6286, 8306, }, 0, },
				[2682]  = { true,  2682, 1,  2545,  2698,  85, 125, 145, 165,   1,   1, { 2675, 2678, }, { 1, 1, }, },
				[6657]  = {  nil,  6657, 1,  8238,  6661,  85, 125, 145, 165,   1,   1, { 6522, 2678, }, { 1, 1, }, },
				[5526]  = { true,  5526, 1,  6501,  5528,  90, 130, 150, 170,   1,   1, { 5503, 1179, 2678, }, { 1, 1, 1, }, },
				[3663]  = { true,  3663, 1,  3372,  3680,  90, 130, 150, 170,   1,   1, { 1468, 2692, }, { 2, 1, }, },
				[5478]  = {  nil,  5478, 1,  6417,  5487,  90, 130, 150, 170,   2,   2, { 5051, }, { 1, }, },
				[1082]  = { true,  1082, 1,  2547,  2699, 100, 135, 155, 175,   1,   1, { 1081, 1080, }, { 1, 1, }, },
				[1017]  = { true,  1017, 1,  2549,  2701, 100, 140, 160, 180,   3,   3, { 1015, 2665, }, { 2, 1, }, },
				[4593]  = { true,  4593, 1,  7755,  6330, 100, 140, 160, 180,   1,   1, { 6308, }, { 1, }, },
				[5479]  = {  nil,  5479, 1,  6418,  5488, 100, 140, 160, 180,   2,   2, { 5470, 2692, }, { 1, 1, }, },
				[3666]  = { true,  3666, 1,  3377,  3683, 110, 150, 170, 190,   1,   1, { 2251, 2692, }, { 2, 1, }, },
				[5480]  = { true,  5480, 1,  6419,  5489, 110, 150, 170, 190,   2,   2, { 5471, 2678, }, { 1, 4, }, },
				[3726]  = { true,  3726, 1,  3397,  3734, 110, 150, 170, 190,   1,   1, { 3730, 2692, }, { 1, 1, }, },
				[2685]  = { true,  2685, 1,  2548,  2700, 110, 130, 150, 170,   1,   1, { 2677, 2692, }, { 2, 1, }, },
				[3664]  = { true,  3664, 1,  3373,  3681, 120, 160, 180, 200,   1,   1, { 3667, 2692, }, { 1, 1, }, },
				[3727]  = { true,  3727, 1,  3398,  3735, 125, 175, 195, 215,   1,   1, { 3731, 2692, }, { 1, 1, }, },
				[12209] = { true, 12209, 1, 15853, 12227, 125, 165, 185, 205,   1,   1, { 1015, 2678, }, { 1, 1, }, },
				[10841] = { true, 10841, 1, 13028,   nil, 125, 215, 235, 255,   4,   4, { 3821, 159, }, { 1, 1, }, { 8696, }, 0, },
				[5527]  = { true,  5527, 1,  6500,   nil, 125, 165, 185, 205,   1,   1, { 5504, 2692, }, { 1, 1, }, { 1355, 1382, 1430, 1699, 3026, 3067, 3087, 3399, 4210, 4552, 5159, 5482, 6286, 8306, }, 0, },
				[3665]  = { true,  3665, 1,  3376,  3682, 130, 170, 190, 210,   1,   1, { 3685, 2692, }, { 1, 1, }, },
				[20074] = {  nil, 20074, 1, 24418, 20075, 150, 160, 180, 200,   1,   1, { 3667, 3713, }, { 2, 1, }, },
				[3728]  = { true,  3728, 1,  3399,  3736, 150, 190, 210, 230,   1,   1, { 3731, 3713, }, { 2, 1, }, },
				[6038]  = { true,  6038, 1,  7213,  6039, 175, 215, 235, 255,   1,   1, { 4655, 2692, }, { 1, 1, }, },
				[21217] = { true, 21217, 1, 25954, 21219, 175, 215, 235, 255,   1,   1, { 21153, 2692, }, { 1, 1, }, },
				[8364]  = { true,  8364, 1, 20916, 17062, 175, 215, 235, 255,   1,   1, { 8365, }, { 1, }, },
				[4457]  = { true,  4457, 1,  4094,  4609, 175, 215, 235, 255,   1,   1, { 3404, 2692, }, { 1, 1, }, },
				[4594]  = { true,  4594, 1,  7828,  6369, 175, 190, 210, 230,   1,   1, { 6362, }, { 1, }, },
				[12212] = { true, 12212, 1, 15861, 12231, 175, 215, 235, 255,   2,   2, { 12202, 159, 4536, }, { 1, 1, 2, }, },
				[12213] = { true, 12213, 1, 15863, 12232, 175, 215, 235, 255,   1,   1, { 12037, 2692, }, { 1, 1, }, },
				[13851] = { true, 13851, 1, 15856, 12229, 175, 215, 235, 255,   1,   1, { 12203, 2692, }, { 1, 1, }, },
				[3729]  = { true,  3729, 1,  3400,  3737, 175, 215, 235, 255,   1,   1, { 3712, 3713, }, { 1, 1, }, },
				[12210] = { true, 12210, 1, 15855, 12228, 175, 215, 235, 255,   1,   1, { 12184, 2692, }, { 1, 1, }, },
				[12214] = { true, 12214, 1, 15865, 12233, 175, 215, 235, 255,   1,   1, { 12037, 2596, }, { 1, 1, }, },
				[17222] = { true, 17222, 1, 21175,   nil, 200, 240, 260, 280,   1,   1, { 12205, }, { 2, }, { 1355, 1382, 1430, 1699, 3026, 3067, 3087, 3399, 4210, 4552, 5159, 5482, 6286, 8306, }, 0, },
				[12217] = { true, 12217, 1, 15906, 12239, 200, 240, 260, 280,   1,   1, { 12037, 4402, 2692, }, { 1, 1, 1, }, },
				[12215] = { true, 12215, 1, 15910, 12240, 200, 240, 260, 280,   2,   2, { 12204, 3713, 159, }, { 2, 1, 1, }, },
				[13927] = { true, 13927, 1, 18239, 13940, 225, 265, 285, 305,   1,   1, { 13754, 3713, }, { 1, 1, }, },
				[16766] = { true, 16766, 1, 20626, 16767, 225, 265, 285, 305,   2,   2, { 7974, 2692, 1179, }, { 2, 1, 1, }, },
				[6887]  = { true,  6887, 1, 18238, 13939, 225, 265, 285, 305,   1,   1, { 4603, }, { 1, }, },
				[13930] = { true, 13930, 1, 18241, 13941, 225, 265, 285, 305,   1,   1, { 13758, }, { 1, }, },
				[18045] = { true, 18045, 1, 22480, 18046, 225, 265, 285, 305,   1,   1, { 12208, 3713, }, { 1, 1, }, },
				[12216] = { true, 12216, 1, 15915, 16111, 225, 265, 285, 305,   1,   1, { 12206, 2692, }, { 1, 2, }, },
				[12218] = { true, 12218, 1, 15933, 16110, 225, 265, 285, 305,   1,   1, { 12207, 3713, }, { 1, 2, }, },
				[13928] = { true, 13928, 1, 18240, 13942, 240, 280, 300, 320,   1,   1, { 13755, 3713, }, { 1, 1, }, },
				[13929] = { true, 13929, 1, 18242, 13943, 240, 280, 300, 320,   1,   1, { 13756, 2692, }, { 1, 2, }, },
				[13931] = { true, 13931, 1, 18243, 13945, 250, 290, 310, 330,   1,   1, { 13759, 159, }, { 1, 1, }, },
				[13932] = { true, 13932, 1, 18244, 13946, 250, 290, 310, 330,   1,   1, { 13760, }, { 1, }, },
				[18254] = { true, 18254, 1, 22761, 18267, 275, 315, 335, 355,   1,   1, { 18255, 3713, }, { 1, 1, }, },
				[13933] = { true, 13933, 1, 18245, 13947, 275, 315, 335, 355,   1,   1, { 13888, 159, }, { 1, 1, }, },
				[13934] = { true, 13934, 1, 18246, 13948, 275, 315, 335, 355,   1,   1, { 13893, 2692, 3713, }, { 1, 1, 1, }, },
				[13935] = { true, 13935, 1, 18247, 13949, 275, 315, 335, 355,   1,   1, { 13889, 3713, }, { 1, 1, }, },
				[20452] = {  nil, 20452, 1, 24801,   nil, 285, 325, 345, 365,   1,   1, { 20424, 3713, }, { 1, 1, }, { 8313, }, },
				[21023] = {  nil, 21023, 5, 25659, 21025, 300, 325, 345, 365,   5,   5, { 2692, 9061, 8150, 21024, }, { 1, 1, 1, 1, }, },
				[23683] = {  nil, 23683, 1, 30047, 23690, 300, 325, 345, 365,   2,   2, { 23567, 8150, }, { 1, 1, }, },
			},
			[7] = {
				[2840]  = { true,  2840, 1,  2657,   nil,   1,  25,  47,  70,   1,   1, { 2770, }, { 1, }, { 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 6297, 8128, }, 0, },
				[2841]  = { true,  2841, 1,  2659,   nil,  65,  65,  90, 115,   2,   2, { 2840, 3576, }, { 1, 1, }, { 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 6297, 8128, }, 0, },
				[3576]  = { true,  3576, 1,  3304,   nil,  65,  65,  62,  75,   1,   1, { 2771, }, { 1, }, { 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 6297, 8128, }, 0, },
				[2842]  = { true,  2842, 1,  2658,   nil,  75, 100, 112, 125,   1,   1, { 2775, }, { 1, }, { 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 6297, 8128, }, 0, },
				[3575]  = { true,  3575, 1,  3307,   nil, 125, 130, 135, 140,   1,   1, { 2772, }, { 1, }, { 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 6297, 8128, }, 0, },
				[3577]  = {  nil,  3577, 1,  3308,   nil, 155, 170, 177, 185,   1,   1, { 2776, }, { 1, }, { 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 6297, 8128, }, 0, },
				[3859]  = {  nil,  3859, 1,  3569,   nil, 165, 165, 165, 165,   1,   1, { 3575, 3857, }, { 1, 1, }, { 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 6297, 8128, }, 0, },
				[3860]  = {  nil,  3860, 1, 10097,   nil, 175, 175, 175, 175,   1,   1, { 3858, }, { 1, }, { 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 6297, 8128, }, 0, },
				[11371] = {  nil, 11371, 1, 14891,   nil, 230, 230, 230, 230,   1,   1, { 11370, }, { 8, }, { 4083, }, },
				[6037]  = {  nil,  6037, 1, 10098,   nil, 230, 230, 230, 230,   1,   1, { 7911, }, { 1, }, { 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 6297, 8128, }, 0, },
				[12359] = {  nil, 12359, 1, 16153,   nil, 250, 250, 250, 250,   1,   1, { 10620, }, { 1, }, { 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 6297, 8128, }, 0, },
				[17771] = {  nil, 17771, 1, 22967,   nil, 300, 310, 315, 320,   1,   1, { 18562, 12360, 17010, 18567, }, { 1, 10, 1, 3, }, { 14401, }, 0, },
			},
			[8] = {
				[4344]  = { true,  4344, 1,  3915,   nil,   1,  35,  47,  60,   1,   1, { 2996, 2320, }, { 1, 1, }, { 1103, 1300, 1703, 2264, 2855, 3484, 3523, 3530, 3531, 4193, 4578, 9584, 11048, 11050, 11051, }, 0, },
				[10045] = { true, 10045, 1, 12044,   nil,   1,  35,  47,  60,   1,   1, { 2996, 2320, }, { 1, 1, }, { 1103, 1300, 1703, 2264, 2855, 3484, 3523, 3530, 3531, 4193, 4578, 9584, 11048, 11050, 11051, }, 0, },
				[2996]  = { true,  2996, 1,  2963,   nil,   1,  25,  37,  50,   1,   1, { 2589, }, { 2, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 0, },
				[2570]  = { true,  2570, 1,  2387,   nil,   1,  35,  47,  60,   1,   1, { 2996, 2320, }, { 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 0, },
				[2576]  = { true,  2576, 1,  2393,   nil,   1,  35,  47,  60,   1,   1, { 2996, 2320, 2324, }, { 1, 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 0, },
				[2568]  = { true,  2568, 1,  2385,   nil,  10,  45,  57,  70,   1,   1, { 2996, 2320, }, { 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 0, },
				[7026]  = { true,  7026, 1,  8776,   nil,  10,  50,  67,  85,   1,   1, { 2996, 2320, }, { 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 0, },
				[10046] = { true, 10046, 1, 12045,   nil,  20,  50,  67,  85,   1,   1, { 2996, 2318, 2320, }, { 2, 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 0, },
				[6238]  = { true,  6238, 1,  7623,   nil,  30,  55,  72,  90,   1,   1, { 2996, 2320, }, { 3, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 0, },
				[4343]  = { true,  4343, 1,  3914,   nil,  30,  55,  72,  90,   1,   1, { 2996, 2320, }, { 2, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 0, },
				[6241]  = { true,  6241, 1,  7624,   nil,  30,  55,  72,  90,   1,   1, { 2996, 2320, 2324, }, { 3, 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 0, },
				[4307]  = { true,  4307, 1,  3840,   nil,  35,  60,  77,  95,   1,   1, { 2996, 2320, }, { 2, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 0, },
				[2577]  = { true,  2577, 1,  2394,   nil,  40,  65,  82, 100,   1,   1, { 2996, 2320, 6260, }, { 2, 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 0, },
				[6786]  = { true,  6786, 1,  8465,   nil,  40,  65,  82, 100,   1,   1, { 2996, 2320, 6260, 2324, }, { 2, 1, 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 0, },
				[2572]  = { true,  2572, 1,  2389,  2598,  40,  65,  82, 100,   1,   1, { 2996, 2320, 2604, }, { 3, 2, 2, }, },
				[2575]  = { true,  2575, 1,  2392,   nil,  40,  65,  82, 100,   1,   1, { 2996, 2320, 2604, }, { 2, 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 0, },
				[4238]  = { true,  4238, 1,  3755,   nil,  45,  70,  87, 105,   1,   1, { 2996, 2320, }, { 3, 3, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 0, },
				[6239]  = { true,  6239, 1,  7629,  6271,  55,  80,  97, 115,   1,   1, { 2996, 2320, 2604, }, { 3, 1, 1, }, },
				[6240]  = {  nil,  6240, 1,  7630,  6270,  55,  80,  97, 115,   1,   1, { 2996, 2320, 6260, }, { 3, 1, 1, }, },
				[2580]  = { true,  2580, 1,  2397,   nil,  60,  85, 102, 120,   1,   1, { 2996, 2320, }, { 2, 3, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 0, },
				[4308]  = { true,  4308, 1,  3841,   nil,  60,  85, 102, 120,   1,   1, { 2996, 2320, 2605, }, { 3, 2, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 0, },
				[2569]  = { true,  2569, 1,  2386,   nil,  65,  90, 107, 125,   1,   1, { 2996, 2320, 2318, }, { 3, 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 0, },
				[5762]  = { true,  5762, 1,  6686,  5771,  70,  95, 112, 130,   1,   1, { 2996, 2321, 2604, }, { 4, 1, 1, }, },
				[2579]  = { true,  2579, 1,  2396,   nil,  70,  95, 112, 130,   1,   1, { 2996, 2321, 2605, }, { 3, 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 0, },
				[4309]  = { true,  4309, 1,  3842,   nil,  70,  95, 112, 130,   1,   1, { 2996, 2321, }, { 4, 2, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 0, },
				[6242]  = {  nil,  6242, 1,  7633,  6272,  70,  95, 112, 130,   1,   1, { 2996, 2320, 6260, }, { 4, 2, 2, }, },
				[2578]  = { true,  2578, 1,  2395,   nil,  70,  95, 112, 130,   1,   1, { 2996, 2318, 2321, }, { 4, 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 0, },
				[2997]  = { true,  2997, 1,  2964,   nil,  75,  90,  97, 105,   1,   1, { 2592, }, { 3, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 0, },
				[10047] = { true, 10047, 1, 12046,   nil,  75, 100, 117, 135,   1,   1, { 2996, 2321, }, { 4, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 0, },
				[2584]  = { true,  2584, 1,  2402,   nil,  75, 100, 117, 135,   1,   1, { 2997, 2321, }, { 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 0, },
				[4312]  = { true,  4312, 1,  3845,   nil,  80, 105, 122, 140,   1,   1, { 2996, 2318, 2321, }, { 5, 2, 1, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 0, },
				[4240]  = { true,  4240, 1,  3757,   nil,  80, 105, 122, 140,   1,   1, { 2997, 2321, }, { 3, 1, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 0, },
				[4310]  = { true,  4310, 1,  3843,   nil,  85, 110, 127, 145,   1,   1, { 2997, 2321, }, { 3, 1, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 0, },
				[2582]  = { true,  2582, 1,  2399,   nil,  85, 110, 127, 145,   1,   1, { 2997, 2321, 2605, }, { 2, 2, 1, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 0, },
				[6243]  = {  nil,  6243, 1,  7636,  6273,  90, 115, 132, 150,   1,   1, { 2997, 2321, 2605, }, { 3, 2, 1, }, },
				[5542]  = { true,  5542, 1,  6521,   nil,  90, 115, 132, 150,   1,   1, { 2997, 2321, 5498, }, { 3, 2, 1, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 0, },
				[4241]  = { true,  4241, 1,  3758,  4292,  95, 120, 137, 155,   1,   1, { 2997, 2605, 2321, }, { 4, 1, 1, }, },
				[4313]  = { true,  4313, 1,  3847,  4345,  95, 120, 137, 155,   1,   1, { 2997, 2318, 2321, 2604, }, { 4, 2, 1, 2, }, },
				[2583]  = { true,  2583, 1,  2401,   nil,  95, 120, 137, 155,   1,   1, { 2997, 2321, 2318, }, { 4, 2, 2, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 0, },
				[4311]  = { true,  4311, 1,  3844,  4346, 100, 125, 142, 160,   1,   1, { 2997, 2321, 5498, }, { 3, 2, 2, }, },
				[2587]  = { true,  2587, 1,  2406,   nil, 100, 110, 120, 130,   1,   1, { 2997, 2321, 4340, }, { 2, 1, 1, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 0, },
				[6263]  = { true,  6263, 1,  7639,  6274, 100, 125, 142, 160,   1,   1, { 2997, 2321, 6260, }, { 4, 2, 2, }, },
				[2585]  = { true,  2585, 1,  2403,  2601, 105, 130, 147, 165,   1,   1, { 2997, 2321, 4340, }, { 4, 3, 1, }, },
				[4316]  = { true,  4316, 1,  3850,   nil, 110, 135, 152, 170,   1,   1, { 2997, 2321, }, { 5, 4, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 0, },
				[4330]  = { true,  4330, 1,  3866,   nil, 110, 135, 152, 170,   1,   1, { 2997, 2604, 2321, }, { 3, 2, 1, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 0, },
				[6787]  = { true,  6787, 1,  8467,   nil, 110, 135, 152, 170,   1,   1, { 2997, 2324, 2321, }, { 3, 4, 1, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 0, },
				[4314]  = { true,  4314, 1,  3848,   nil, 110, 135, 152, 170,   1,   1, { 2997, 2321, }, { 3, 2, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 0, },
				[6264]  = { true,  6264, 1,  7643,  6275, 115, 140, 157, 175,   1,   1, { 2997, 2321, 2604, }, { 5, 3, 3, }, },
				[5763]  = { true,  5763, 1,  6688,  5772, 115, 140, 157, 175,   1,   1, { 2997, 2604, 2321, }, { 4, 1, 1, }, },
				[10048] = {  nil, 10048, 1, 12047, 10316, 120, 145, 162, 180,   1,   1, { 2997, 2604, 2321, }, { 5, 3, 1, }, },
				[6385]  = {  nil,  6385, 1,  7893,  6391, 120, 145, 162, 180,   1,   1, { 2997, 2605, 4340, 2321, }, { 4, 2, 1, 1, }, },
				[6384]  = { true,  6384, 1,  7892,  6390, 120, 145, 162, 180,   1,   1, { 2997, 6260, 4340, 2321, }, { 4, 2, 1, 1, }, },
				[4315]  = { true,  4315, 1,  3849,  4347, 120, 145, 162, 180,   1,   1, { 2997, 2319, 2321, }, { 6, 2, 2, }, },
				[4317]  = { true,  4317, 1,  3851,  4349, 125, 150, 167, 185,   1,   1, { 2997, 5500, 2321, }, { 6, 1, 3, }, },
				[4320]  = { true,  4320, 1,  3855,   nil, 125, 150, 167, 185,   1,   1, { 4305, 2319, 3182, 5500, }, { 2, 4, 4, 2, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 0, },
				[4331]  = { true,  4331, 1,  3868,  4348, 125, 150, 167, 185,   1,   1, { 2997, 5500, 2321, 2324, }, { 4, 1, 4, 2, }, },
				[4305]  = { true,  4305, 1,  3839,   nil, 125, 135, 140, 145,   1,   1, { 4306, }, { 4, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 0, },
				[4318]  = { true,  4318, 1,  3852,   nil, 130, 150, 165, 180,   1,   1, { 2997, 2321, 3383, }, { 4, 3, 1, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 0, },
				[4332]  = { true,  4332, 1,  3869, 14627, 135, 145, 150, 155,   1,   1, { 4305, 4341, 2321, }, { 1, 1, 1, }, },
				[5766]  = { true,  5766, 1,  6690,   nil, 135, 155, 170, 185,   1,   1, { 4305, 2321, 3182, }, { 2, 2, 2, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 0, },
				[7046]  = { true,  7046, 1,  8758,   nil, 140, 160, 175, 190,   1,   1, { 4305, 6260, 2321, }, { 4, 2, 3, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 0, },
				[7027]  = {  nil,  7027, 1,  8778,  7093, 140, 160, 175, 190,   1,   1, { 4305, 2319, 6048, 2321, }, { 3, 2, 1, 2, }, },
				[4321]  = {  nil,  4321, 1,  3856,  4350, 140, 160, 175, 190,   1,   1, { 4305, 3182, 2321, }, { 3, 1, 2, }, },
				[7048]  = { true,  7048, 1,  8760,   nil, 145, 155, 160, 165,   1,   1, { 4305, 6260, 2321, }, { 2, 2, 1, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 0, },
				[4319]  = {  nil,  4319, 1,  3854,  7114, 145, 165, 180, 195,   1,   1, { 4305, 4234, 6260, 2321, }, { 3, 2, 2, 2, }, },
				[7047]  = { true,  7047, 1,  8780,  7092, 145, 165, 180, 195,   1,   1, { 4305, 4234, 6048, 2321, }, { 3, 2, 2, 2, }, },
				[4324]  = { true,  4324, 1,  3859,   nil, 150, 170, 185, 200,   1,   1, { 4305, 6260, }, { 5, 4, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 0, },
				[4245]  = { true,  4245, 1,  3813,   nil, 150, 170, 185, 200,   1,   1, { 4305, 4234, 2321, }, { 3, 2, 3, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 0, },
				[7049]  = {  nil,  7049, 1,  8782,  7091, 150, 170, 185, 200,   1,   1, { 4305, 4234, 929, 2321, }, { 3, 2, 4, 1, }, },
				[5770]  = {  nil,  5770, 1,  6692,  5773, 150, 170, 185, 200,   1,   1, { 4305, 2321, 3182, }, { 4, 2, 2, }, },
				[4333]  = { true,  4333, 1,  3870,  6401, 155, 165, 170, 175,   1,   1, { 4305, 4340, 2321, }, { 2, 2, 1, }, },
				[7050]  = { true,  7050, 1,  8762,   nil, 160, 170, 175, 180,   1,   1, { 4305, 2321, }, { 3, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 0, },
				[6795]  = { true,  6795, 1,  8483,   nil, 160, 170, 175, 180,   1,   1, { 4305, 2324, 4291, }, { 3, 2, 1, }, { 1346, 2399, 4576, 11052, 11557, }, 0, },
				[7065]  = {  nil,  7065, 1,  8784,  7090, 165, 185, 200, 215,   1,   1, { 4305, 2605, 4291, }, { 5, 2, 1, }, },
				[4322]  = {  nil,  4322, 1,  3857, 14630, 165, 185, 200, 215,   1,   1, { 4305, 2321, 4337, }, { 3, 2, 2, }, },
				[4323]  = {  nil,  4323, 1,  3858,  4351, 170, 190, 205, 220,   1,   1, { 4305, 4291, 3824, }, { 4, 1, 1, }, },
				[4334]  = { true,  4334, 1,  3871,   nil, 170, 180, 185, 190,   1,   1, { 4305, 2324, 2321, }, { 3, 2, 1, }, { 1346, 2399, 4576, 11052, 11557, }, 0, },
				[7051]  = { true,  7051, 1,  8764,   nil, 170, 190, 205, 220,   1,   1, { 4305, 7067, 2321, }, { 3, 1, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 0, },
				[4339]  = { true,  4339, 1,  3865,   nil, 175, 180, 182, 185,   1,   1, { 4338, }, { 5, }, { 1346, 2399, 4576, 11052, 11557, }, 0, },
				[7055]  = { true,  7055, 1,  8772,   nil, 175, 195, 210, 225,   1,   1, { 4305, 7071, 2604, 4291, }, { 4, 1, 2, 1, }, { 1346, 2399, 4576, 11052, 11557, }, 0, },
				[4325]  = { true,  4325, 1,  3860,  4352, 175, 195, 210, 225,   1,   1, { 4305, 4291, 4337, }, { 4, 1, 2, }, },
				[7053]  = { true,  7053, 1,  8786,  7089, 175, 195, 210, 225,   1,   1, { 4305, 6260, 2321, }, { 3, 2, 2, }, },
				[6796]  = { true,  6796, 1,  8489,   nil, 175, 185, 190, 195,   1,   1, { 4305, 2604, 4291, }, { 3, 2, 1, }, { 1346, 2399, 4576, 11052, 11557, }, 0, },
				[5764]  = { true,  5764, 1,  6693,  5774, 175, 195, 210, 225,   1,   1, { 4305, 4234, 2321, 2605, }, { 4, 3, 3, 1, }, },
				[7052]  = { true,  7052, 1,  8766,   nil, 175, 195, 210, 225,   1,   1, { 4305, 7070, 6260, 2321, 7071, }, { 4, 1, 2, 2, 1, }, { 1346, 2399, 4576, 11052, 11557, }, 0, },
				[7056]  = {  nil,  7056, 1,  8789,  7087, 180, 200, 215, 230,   1,   1, { 4305, 2604, 6371, 4291, }, { 5, 2, 2, 1, }, },
				[4328]  = { true,  4328, 1,  3863,  4353, 180, 200, 215, 230,   1,   1, { 4305, 4337, 7071, }, { 4, 2, 1, }, },
				[7057]  = { true,  7057, 1,  8774,   nil, 180, 200, 215, 230,   1,   1, { 4305, 4291, }, { 5, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 0, },
				[4326]  = { true,  4326, 1,  3861,   nil, 185, 205, 220, 235,   1,   1, { 4305, 3827, 4291, }, { 4, 1, 1, }, { 1346, 2399, 4576, 11052, 11557, }, 0, },
				[4335]  = {  nil,  4335, 1,  3872,  4354, 185, 195, 200, 205,   1,   1, { 4305, 4342, 4291, }, { 4, 1, 1, }, },
				[5765]  = { true,  5765, 1,  6695,  5775, 185, 205, 220, 235,   1,   1, { 4305, 2325, 2321, }, { 5, 1, 4, }, },
				[7058]  = { true,  7058, 1,  8791,   nil, 185, 205, 215, 225,   1,   1, { 4305, 2604, 2321, }, { 4, 2, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 0, },
				[7059]  = { true,  7059, 1,  8793,  7084, 190, 210, 225, 240,   1,   1, { 4305, 6371, 2604, 4291, }, { 5, 2, 2, 2, }, },
				[7060]  = {  nil,  7060, 1,  8795,  7085, 190, 210, 225, 240,   1,   1, { 4305, 7072, 6260, 4291, }, { 6, 2, 2, 2, }, },
				[7054]  = { true,  7054, 1,  8770,   nil, 190, 210, 225, 240,   1,   1, { 4339, 7067, 7070, 7068, 7069, 4291, }, { 2, 2, 2, 2, 2, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 0, },
				[17723] = {  nil, 17723, 1, 21945, 17724, 190, 200, 205, 210,   1,   1, { 4305, 2605, 4291, }, { 5, 4, 1, }, },
				[7062]  = { true,  7062, 1,  8799,   nil, 195, 215, 225, 235,   1,   1, { 4305, 2604, 4291, }, { 4, 2, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 0, },
				[7061]  = { true,  7061, 1,  8797,  7086, 195, 215, 230, 245,   1,   1, { 4305, 7067, 4234, 7071, 4291, }, { 5, 4, 4, 1, 2, }, },
				[4329]  = {  nil,  4329, 1,  3864,  4356, 200, 220, 235, 250,   1,   1, { 4339, 4234, 3864, 7071, 4291, }, { 4, 4, 1, 1, 1, }, },
				[4336]  = {  nil,  4336, 1,  3873, 10728, 200, 210, 215, 220,   1,   1, { 4305, 2325, 4291, }, { 5, 1, 1, }, },
				[4327]  = {  nil,  4327, 1,  3862,  4355, 200, 220, 235, 250,   1,   1, { 4339, 4291, 3829, 4337, }, { 3, 2, 1, 2, }, },
				[7063]  = {  nil,  7063, 1,  8802,  7088, 205, 220, 235, 250,   1,   1, { 4305, 7068, 3827, 2604, 4291, }, { 8, 4, 2, 4, 1, }, },
				[9998]  = { true,  9998, 1, 12048,   nil, 205, 220, 235, 250,   1,   1, { 4339, 4291, }, { 2, 3, }, { 1346, 2399, 4576, 11052, 11557, }, 0, },
				[9999]  = { true,  9999, 1, 12049,   nil, 205, 220, 235, 250,   1,   1, { 4339, 4291, }, { 2, 3, }, { 1346, 2399, 4576, 11052, 11557, }, 0, },
				[10002] = {  nil, 10002, 1, 12052,   nil, 210, 225, 240, 255,   1,   1, { 4339, 10285, 8343, }, { 3, 2, 1, }, { 4578, 9584, }, 0, },
				[10001] = { true, 10001, 1, 12050,   nil, 210, 225, 240, 255,   1,   1, { 4339, 8343, }, { 3, 1, }, { 1346, 2399, 4576, 11052, 11557, }, 0, },
				[7064]  = { true,  7064, 1,  8804,   nil, 210, 225, 240, 255,   1,   1, { 4305, 7068, 6371, 4304, 2604, 4291, }, { 6, 2, 2, 2, 4, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 0, },
				[10004] = {  nil, 10004, 1, 12055,   nil, 215, 230, 245, 260,   1,   1, { 4339, 10285, 8343, }, { 3, 2, 1, }, { 4578, 9584, }, 0, },
				[10056] = { true, 10056, 1, 12061,   nil, 215, 220, 225, 230,   1,   1, { 4339, 6261, 8343, }, { 1, 1, 1, }, { 1346, 2399, 4576, 11052, 11557, }, 0, },
				[10007] = {  nil, 10007, 1, 12056, 10300, 215, 230, 245, 260,   1,   1, { 4339, 2604, 8343, }, { 3, 2, 1, }, },
				[10008] = {  nil, 10008, 1, 12059, 10301, 215, 220, 225, 230,   1,   1, { 4339, 2324, 8343, }, { 1, 1, 1, }, },
				[10009] = {  nil, 10009, 1, 12060, 10302, 215, 230, 245, 260,   1,   1, { 4339, 2604, 8343, }, { 3, 2, 1, }, },
				[10003] = { true, 10003, 1, 12053,   nil, 215, 230, 245, 260,   1,   1, { 4339, 8343, }, { 2, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 0, },
				[10010] = {  nil, 10010, 1, 12062, 10303, 220, 235, 250, 265,   1,   1, { 4339, 7079, 8343, }, { 4, 2, 2, }, },
				[10052] = {  nil, 10052, 1, 12064, 10311, 220, 225, 230, 235,   1,   1, { 4339, 6261, 8343, }, { 2, 2, 1, }, },
				[10011] = {  nil, 10011, 1, 12063, 10304, 220, 235, 250, 265,   1,   1, { 4339, 7079, 8343, }, { 3, 2, 2, }, },
				[10023] = {  nil, 10023, 1, 12071,   nil, 225, 240, 255, 270,   1,   1, { 4339, 10285, 8343, }, { 5, 5, 2, }, { 4578, 9584, }, 0, },
				[22246] = { true, 22246, 5, 27658, 22307, 225, 240, 255, 270,   1,   1, { 4339, 11137, 8343, }, { 4, 4, 2, }, },
				[10019] = { true, 10019, 1, 12067,   nil, 225, 240, 255, 270,   1,   1, { 4339, 8153, 10286, 8343, }, { 4, 4, 2, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 0, },
				[10042] = { true, 10042, 1, 12069,   nil, 225, 240, 255, 270,   1,   1, { 4339, 7077, 8343, }, { 5, 2, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 0, },
				[10018] = { true, 10018, 1, 12066, 10312, 225, 240, 255, 270,   1,   1, { 4339, 2604, 8343, }, { 3, 2, 2, }, },
				[10020] = {  nil, 10020, 1, 12068, 10313, 225, 240, 255, 270,   1,   1, { 4339, 7079, 8343, }, { 5, 3, 2, }, },
				[10021] = { true, 10021, 1, 12070,   nil, 225, 240, 255, 270,   1,   1, { 4339, 8153, 10286, 8343, }, { 6, 6, 2, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 0, },
				[10050] = { true, 10050, 1, 12065,   nil, 225, 240, 255, 270,   1,   1, { 4339, 4291, }, { 4, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 0, },
				[10026] = { true, 10026, 1, 12073,   nil, 230, 245, 260, 275,   1,   1, { 4339, 8343, 4304, }, { 3, 2, 2, }, { 2399, 11052, 11557, }, 0, },
				[10054] = {  nil, 10054, 1, 12075, 10314, 230, 235, 240, 245,   1,   1, { 4339, 4342, 8343, }, { 2, 2, 2, }, },
				[10027] = { true, 10027, 1, 12074,   nil, 230, 245, 260, 275,   1,   1, { 4339, 8343, }, { 3, 2, }, { 2399, 4578, 9584, 11052, 11557, }, 0, },
				[10024] = { true, 10024, 1, 12072,   nil, 230, 245, 260, 275,   1,   1, { 4339, 8343, }, { 3, 2, }, { 2399, 11052, 11557, }, 0, },
				[10029] = {  nil, 10029, 1, 12078, 10315, 235, 250, 265, 280,   1,   1, { 4339, 2604, 8343, }, { 4, 2, 3, }, },
				[10028] = {  nil, 10028, 1, 12076,   nil, 235, 250, 265, 280,   1,   1, { 4339, 10285, 8343, }, { 5, 4, 2, }, { 4578, 9584, }, 0, },
				[10053] = { true, 10053, 1, 12077,   nil, 235, 240, 245, 250,   1,   1, { 4339, 2325, 8343, 2324, }, { 3, 1, 1, 1, }, { 2399, 11052, 11557, }, 0, },
				[10051] = { true, 10051, 1, 12079,   nil, 235, 250, 265, 280,   1,   1, { 4339, 2604, 8343, }, { 4, 2, 2, }, { 2399, 11052, 11557, }, 0, },
				[10055] = {  nil, 10055, 1, 12080, 10317, 235, 240, 245, 250,   1,   1, { 4339, 10290, 8343, }, { 3, 1, 1, }, },
				[10034] = {  nil, 10034, 1, 12085, 10321, 240, 245, 250, 255,   1,   1, { 4339, 8343, }, { 4, 2, }, },
				[10031] = {  nil, 10031, 1, 12082,   nil, 240, 255, 270, 285,   1,   1, { 4339, 10285, 8343, 4304, }, { 6, 6, 3, 2, }, { 4578, 9584, }, 0, },
				[10030] = {  nil, 10030, 1, 12081, 10318, 240, 255, 270, 285,   1,   1, { 4339, 4589, 8343, }, { 3, 6, 2, }, },
				[10033] = {  nil, 10033, 1, 12084, 10320, 240, 255, 270, 285,   1,   1, { 4339, 2604, 8343, }, { 4, 2, 2, }, },
				[10032] = {  nil, 10032, 1, 12083, 10319, 240, 255, 270, 285,   1,   1, { 4339, 7079, 8343, }, { 4, 4, 2, }, },
				[10025] = { true, 10025, 1, 12086, 10463, 245, 260, 275, 290,   1,   1, { 4339, 10285, 8343, }, { 2, 8, 2, }, },
				[10035] = {  nil, 10035, 1, 12089, 10323, 245, 250, 255, 260,   1,   1, { 4339, 8343, }, { 4, 3, }, },
				[10044] = { true, 10044, 1, 12088,   nil, 245, 260, 275, 290,   1,   1, { 4339, 7077, 8343, 4304, }, { 5, 1, 3, 2, }, { 2399, 11052, 11557, }, 0, },
				[10038] = {  nil, 10038, 1, 12087, 10322, 245, 260, 275, 290,   1,   1, { 4339, 7079, 8343, }, { 5, 6, 3, }, },
				[21154] = {  nil, 21154, 1, 26403, 21722, 250, 265, 280, 295,   1,   1, { 14048, 4625, 2604, 14341, }, { 4, 2, 2, 1, }, },
				[10041] = { true, 10041, 1, 12092,   nil, 250, 265, 280, 295,   1,   1, { 4339, 8153, 10286, 8343, 6037, 1529, }, { 8, 4, 2, 3, 1, 1, }, { 2399, 11052, 11557, }, 0, },
				[10040] = {  nil, 10040, 1, 12091, 10325, 250, 255, 260, 265,   1,   1, { 4339, 8343, }, { 5, 3, }, },
				[10039] = {  nil, 10039, 1, 12090, 10324, 250, 265, 280, 295,   1,   1, { 4339, 7079, 8343, 4304, }, { 6, 6, 3, 2, }, },
				[14048] = { true, 14048, 1, 18401,   nil, 250, 255, 257, 260,   1,   1, { 14047, }, { 5, }, { 2399, 11052, 11557, }, 0, },
				[14342] = { true, 14342, 1, 18560, 14526, 250, 290, 305, 320,   1,   1, { 14256, }, { 2, }, },
				[21542] = {  nil, 21542, 1, 26407, 21723, 250, 265, 280, 295,   1,   1, { 14048, 4625, 2604, 14341, }, { 4, 2, 2, 1, }, },
				[10036] = {  nil, 10036, 1, 12093, 10326, 250, 265, 280, 295,   1,   1, { 4339, 8343, }, { 5, 3, }, },
				[13869] = {  nil, 13869, 1, 18403, 14466, 255, 270, 285, 300,   1,   1, { 14048, 7079, 14341, }, { 5, 2, 1, }, },
				[13856] = { true, 13856, 1, 18402,   nil, 255, 270, 285, 300,   1,   1, { 14048, 14341, }, { 3, 1, }, { 2399, 11052, 11557, }, 0, },
				[13868] = { true, 13868, 1, 18404, 14467, 255, 270, 285, 300,   1,   1, { 14048, 7079, 14341, }, { 5, 2, 1, }, },
				[14046] = { true, 14046, 1, 18405, 14468, 260, 275, 290, 305,   1,   1, { 14048, 8170, 14341, }, { 5, 2, 1, }, },
				[13858] = {  nil, 13858, 1, 18406, 14469, 260, 275, 290, 305,   1,   1, { 14048, 14227, 14341, }, { 5, 1, 1, }, },
				[21340] = { true, 21340, 1, 26085, 21358, 260, 275, 290, 305,   1,   1, { 14048, 8170, 7972, 14341, }, { 6, 4, 2, 1, }, },
				[14042] = {  nil, 14042, 1, 18408, 14471, 260, 275, 290, 305,   1,   1, { 14048, 7077, 14341, }, { 5, 3, 1, }, },
				[13857] = {  nil, 13857, 1, 18407, 14470, 260, 275, 290, 305,   1,   1, { 14048, 14227, 14341, }, { 5, 1, 1, }, },
				[14143] = {  nil, 14143, 1, 18410, 14473, 265, 280, 295, 310,   1,   1, { 14048, 9210, 14227, 14341, }, { 3, 2, 1, 1, }, },
				[13870] = {  nil, 13870, 1, 18411, 14474, 265, 280, 295, 310,   1,   1, { 14048, 7080, 14341, }, { 3, 1, 1, }, },
				[13860] = {  nil, 13860, 1, 18409, 14472, 265, 280, 295, 310,   1,   1, { 14048, 14227, 14341, }, { 4, 1, 1, }, },
				[14043] = {  nil, 14043, 1, 18412, 14476, 270, 285, 300, 315,   1,   1, { 14048, 7077, 14341, }, { 4, 3, 1, }, },
				[14101] = { true, 14101, 1, 18415, 14479, 270, 285, 300, 315,   1,   1, { 14048, 3577, 14341, }, { 4, 2, 1, }, },
				[14142] = {  nil, 14142, 1, 18413, 14477, 270, 285, 300, 315,   1,   1, { 14048, 9210, 14227, 14341, }, { 4, 2, 1, 1, }, },
				[14100] = { true, 14100, 1, 18414, 14478, 270, 285, 300, 315,   1,   1, { 14048, 3577, 14341, }, { 5, 2, 1, }, },
				[22251] = {  nil, 22251, 5, 27724, 22310, 275, 290, 305, 320,   1,   1, { 14048, 8831, 11040, 14341, }, { 5, 10, 8, 2, }, },
				[22248] = {  nil, 22248, 5, 27659, 22308, 275, 290, 305, 320,   1,   1, { 14048, 16203, 14341, }, { 5, 2, 2, }, },
				[14141] = {  nil, 14141, 1, 18416, 14480, 275, 290, 305, 320,   1,   1, { 14048, 9210, 14227, 14341, }, { 6, 4, 1, 1, }, },
				[14103] = { true, 14103, 1, 18420, 14484, 275, 290, 305, 320,   1,   1, { 14048, 3577, 14341, }, { 4, 2, 1, }, },
				[14107] = {  nil, 14107, 1, 18419, 14483, 275, 290, 305, 320,   1,   1, { 14048, 14256, 14341, }, { 5, 4, 1, }, },
				[14132] = {  nil, 14132, 1, 18421, 14485, 275, 290, 305, 320,   1,   1, { 14048, 11176, 14341, }, { 6, 1, 1, }, },
				[14044] = {  nil, 14044, 1, 18418, 14482, 275, 290, 305, 320,   1,   1, { 14048, 7078, 14341, }, { 5, 1, 1, }, },
				[13863] = { true, 13863, 1, 18417, 14481, 275, 290, 305, 320,   1,   1, { 14048, 8170, 14341, }, { 4, 4, 1, }, },
				[14134] = {  nil, 14134, 1, 18422, 14486, 275, 290, 305, 320,   1,   1, { 14048, 7078, 7077, 7068, 14341, }, { 6, 4, 4, 4, 1, }, },
				[13864] = {  nil, 13864, 1, 18423, 14488, 280, 295, 310, 325,   1,   1, { 14048, 14227, 8170, 14341, }, { 4, 2, 4, 1, }, },
				[13871] = {  nil, 13871, 1, 18424, 14489, 280, 295, 310, 325,   1,   1, { 14048, 7080, 14341, }, { 6, 1, 1, }, },
				[14045] = {  nil, 14045, 1, 18434, 14490, 280, 295, 310, 325,   1,   1, { 14048, 7078, 14341, }, { 6, 1, 1, }, },
				[21341] = { true, 21341, 1, 26086,   nil, 285, 300, 315, 330,   1,   1, { 14256, 12810, 20520, 14227, }, { 12, 6, 2, 4, }, 180794, },
				[13865] = { true, 13865, 1, 18438, 14491, 285, 300, 315, 330,   1,   1, { 14048, 14227, 14341, }, { 6, 2, 1, }, },
				[14108] = { true, 14108, 1, 18437, 14492, 285, 300, 315, 330,   1,   1, { 14048, 14256, 8170, 14341, }, { 6, 4, 4, 1, }, },
				[18258] = { true, 18258, 1, 22813,   nil, 285, 285, 290, 295,   1,   1, { 14048, 8170, 18240, 14341, }, { 2, 4, 1, 1, }, { 5519, }, },
				[14136] = {  nil, 14136, 1, 18436, 14493, 285, 300, 315, 330,   1,   1, { 14048, 14256, 12808, 7080, 14341, }, { 10, 12, 4, 4, 1, }, },
				[14104] = { true, 14104, 1, 18439, 14494, 290, 305, 320, 335,   1,   1, { 14048, 3577, 14227, 14341, }, { 6, 4, 1, 1, }, },
				[14137] = {  nil, 14137, 1, 18440, 14497, 290, 305, 320, 335,   1,   1, { 14048, 14342, 14341, }, { 6, 4, 1, }, },
				[14144] = {  nil, 14144, 1, 18441, 14495, 290, 305, 320, 335,   1,   1, { 14048, 9210, 14341, }, { 6, 4, 1, }, },
				[14111] = { true, 14111, 1, 18442, 14496, 290, 305, 320, 335,   1,   1, { 14048, 14256, 14341, }, { 5, 4, 1, }, },
				[19056] = {  nil, 19056, 3, 23664, 19216, 290, 305, 320, 335,   1,   1, { 14048, 12810, 13926, 12809, 14227, }, { 6, 4, 2, 2, 2, }, },
				[15802] = {  nil, 15802, 1, 19435,   nil, 290, 295, 310, 325,   1,   1, { 14048, 14342, 7971, 14341, }, { 6, 4, 2, 1, }, { 6032, }, },
				[19047] = {  nil, 19047, 3, 23662, 19215, 290, 305, 320, 335,   1,   1, { 14048, 7076, 12803, 14227, }, { 8, 3, 3, 2, }, },
				[13866] = { true, 13866, 1, 18444, 14498, 295, 310, 325, 340,   1,   1, { 14048, 14227, 14341, }, { 4, 2, 1, }, },
				[13867] = {  nil, 13867, 1, 18449, 14504, 300, 315, 330, 345,   1,   1, { 14048, 14227, 8170, 14341, }, { 7, 2, 4, 1, }, },
				[14112] = { true, 14112, 1, 18453, 14508, 300, 315, 330, 345,   1,   1, { 14048, 14256, 12662, 8170, 14341, }, { 7, 6, 4, 4, 2, }, },
				[18413] = {  nil, 18413, 1, 22870, 18418, 300, 315, 330, 345,   1,   1, { 14048, 12809, 12360, 14341, }, { 12, 4, 1, 2, }, },
				[19684] = {  nil, 19684, 4, 24093, 19766, 300, 315, 330, 345,   1,   1, { 14342, 19726, 12810, 14048, 14227, }, { 3, 3, 4, 4, 4, }, },
				[14106] = {  nil, 14106, 1, 18451, 14506, 300, 315, 330, 345,   1,   1, { 14048, 14256, 12662, 14341, }, { 8, 8, 4, 2, }, },
				[20537] = {  nil, 20537, 4, 24903, 20547, 300, 315, 330, 345,   1,   1, { 14048, 20520, 14256, 12810, 14227, }, { 4, 6, 4, 2, 2, }, },
				[22757] = {  nil, 22757, 5, 28481, 22773, 300, 315, 330, 345,   1,   1, { 14048, 14342, 12803, 14227, }, { 4, 2, 2, 2, }, },
				[19683] = {  nil, 19683, 4, 24092, 19765, 300, 315, 330, 345,   1,   1, { 14342, 19726, 12804, 14048, 14227, }, { 4, 4, 4, 4, 2, }, },
				[18486] = { true, 18486, 1, 22902, 18487, 300, 315, 330, 345,   1,   1, { 14048, 14342, 13926, 14341, }, { 6, 4, 2, 2, }, },
				[21342] = {  nil, 21342, 1, 26087, 21371, 300, 315, 330, 345,   1,   1, { 14256, 17012, 19726, 7078, 14227, }, { 20, 16, 8, 4, 4, }, },
				[19059] = {  nil, 19059, 3, 23665, 19217, 300, 315, 330, 345,   1,   1, { 14342, 12809, 14227, }, { 5, 2, 2, }, },
				[16979] = {  nil, 16979, 1, 20849, 17018, 300, 315, 330, 345,   1,   1, { 14048, 17010, 7078, 12810, 14341, }, { 8, 6, 4, 2, 2, }, },
				[22756] = {  nil, 22756, 5, 28480, 22774, 300, 315, 330, 345,   1,   1, { 14048, 19726, 12803, 14227, }, { 4, 2, 2, 2, }, },
				[19165] = {  nil, 19165, 3, 23667, 19220, 300, 315, 330, 345,   1,   1, { 14342, 17010, 17011, 7078, 14227, }, { 8, 5, 3, 10, 4, }, },
				[18263] = {  nil, 18263, 1, 22759, 18265, 300, 320, 335, 350,   1,   1, { 14342, 17010, 7078, 12810, 14341, }, { 6, 8, 2, 6, 4, }, },
				[14128] = {  nil, 14128, 1, 18446, 14500, 300, 315, 330, 345,   1,   1, { 14048, 11176, 14341, }, { 8, 2, 1, }, },
				[16980] = {  nil, 16980, 1, 20848, 17017, 300, 315, 330, 345,   1,   1, { 14048, 17010, 17011, 12810, 14341, }, { 12, 4, 4, 6, 2, }, },
				[18405] = {  nil, 18405, 1, 22866, 18414, 300, 315, 330, 345,   1,   1, { 14048, 9210, 14342, 7080, 7078, 14344, 14341, }, { 16, 10, 10, 12, 12, 6, 6, }, },
				[14155] = { true, 14155, 1, 18445, 14499, 300, 315, 330, 345,   1,   1, { 14048, 14342, 14341, }, { 4, 1, 1, }, },
				[22652] = {  nil, 22652, 6, 28207,   nil, 300, 315, 330, 345,   1,   1, { 22682, 14048, 7080, 14227, }, { 7, 8, 6, 8, }, { 16365, }, 0, { 9233, }, },
				[18407] = {  nil, 18407, 1, 22867, 18415, 300, 315, 330, 345,   1,   1, { 14048, 14256, 12662, 12808, 14341, }, { 12, 20, 6, 8, 2, }, },
				[14153] = {  nil, 14153, 1, 18458, 14514, 300, 315, 330, 345,   1,   1, { 14048, 12662, 14256, 7078, 12808, 14341, }, { 12, 20, 40, 12, 12, 2, }, },
				[19050] = {  nil, 19050, 3, 23663, 19218, 300, 315, 330, 345,   1,   1, { 14342, 7076, 12803, 14227, }, { 5, 5, 5, 2, }, },
				[22660] = {  nil, 22660, 5, 28210, 22683, 300, 315, 330, 345,   1,   1, { 19726, 14342, 12803, 14227, }, { 1, 2, 4, 4, }, },
				[18409] = {  nil, 18409, 1, 22869, 18417, 300, 315, 330, 345,   1,   1, { 14048, 14342, 13926, 14341, }, { 12, 6, 2, 2, }, },
				[19682] = {  nil, 19682, 4, 24091, 19764, 300, 315, 330, 345,   1,   1, { 14342, 19726, 12804, 14048, 14227, }, { 3, 5, 4, 4, 2, }, },
				[22252] = {  nil, 22252, 5, 27725, 22312, 300, 315, 330, 345,   1,   1, { 14048, 14342, 13468, 14227, }, { 6, 2, 1, 4, }, },
				[19156] = {  nil, 19156, 3, 23666, 19219, 300, 315, 330, 345,   1,   1, { 14342, 17010, 17011, 7078, 14227, }, { 10, 2, 3, 6, 4, }, },
				[22249] = {  nil, 22249, 1, 27660, 22309, 300, 315, 330, 345,   1,   1, { 14048, 14344, 12810, 14227, }, { 6, 4, 4, 4, }, },
				[20539] = {  nil, 20539, 4, 24902, 20548, 300, 315, 330, 345,   1,   1, { 14048, 20520, 14256, 12810, 14227, }, { 2, 6, 2, 2, 2, }, },
				[22658] = {  nil, 22658, 6, 28208,   nil, 300, 315, 330, 345,   1,   1, { 22682, 14048, 7080, 14227, }, { 5, 4, 2, 4, }, { 16365, }, 0, { 9233, }, },
				[14139] = {  nil, 14139, 1, 18448, 14507, 300, 315, 330, 345,   1,   1, { 14048, 14342, 14341, }, { 5, 5, 1, }, },
				[14138] = {  nil, 14138, 1, 18447, 14501, 300, 315, 330, 345,   1,   1, { 14048, 14342, 14341, }, { 6, 4, 1, }, },
				[14140] = {  nil, 14140, 1, 18452, 14509, 300, 315, 330, 345,   1,   1, { 14048, 14342, 12800, 12810, 14341, }, { 4, 6, 1, 2, 2, }, },
				[22655] = {  nil, 22655, 6, 28209,   nil, 300, 315, 330, 345,   1,   1, { 22682, 14048, 7080, 14227, }, { 4, 2, 2, 4, }, { 16365, }, 0, { 9233, }, },
				[14130] = {  nil, 14130, 1, 18450, 14505, 300, 315, 330, 345,   1,   1, { 14048, 11176, 7910, 14341, }, { 6, 4, 1, 1, }, },
				[22654] = {  nil, 22654, 6, 28205,   nil, 300, 315, 330, 345,   1,   1, { 22682, 14048, 7080, 14227, }, { 5, 4, 4, 4, }, { 16365, }, 0, { 9233, }, },
				[14146] = {  nil, 14146, 1, 18454, 14511, 300, 315, 330, 345,   1,   1, { 14048, 14342, 9210, 13926, 12364, 12810, 14341, }, { 10, 10, 10, 6, 6, 8, 2, }, },
				[14152] = {  nil, 14152, 1, 18457, 14513, 300, 315, 330, 345,   1,   1, { 14048, 7078, 7082, 7076, 7080, 14341, }, { 12, 10, 10, 10, 10, 2, }, },
				[18408] = {  nil, 18408, 1, 22868, 18416, 300, 315, 330, 345,   1,   1, { 14048, 7078, 7910, 14341, }, { 12, 10, 2, 2, }, },
				[20538] = {  nil, 20538, 4, 24901, 20546, 300, 315, 330, 345,   1,   1, { 14048, 20520, 14256, 14227, }, { 6, 8, 6, 2, }, },
				[14156] = {  nil, 14156, 1, 18455, 14510, 300, 315, 330, 345,   1,   1, { 14048, 14342, 14344, 17012, 14341, }, { 8, 12, 2, 2, 2, }, },
				[14154] = { true, 14154, 1, 18456, 14512, 300, 315, 330, 345,   1,   1, { 14048, 14342, 12811, 13926, 9210, 14341, }, { 12, 10, 4, 4, 10, 2, }, },
				[22758] = {  nil, 22758, 5, 28482, 22772, 300, 315, 330, 345,   1,   1, { 14048, 12803, 14227, }, { 2, 4, 2, }, },
			},
			[9] = {
				[10579] = {  nil, 10579, 1, 12719,   nil,   1, 210, 230, 250, 100, 100, { 3030, 10505, 3860, }, { 100, 2, 2, }, },
				[4358]  = { true,  4358, 1,  3919,   nil,   1,  30,  45,  60,   2,   2, { 4357, 2589, }, { 2, 1, }, { 1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037, }, 0, },
				[8067]  = { true,  8067, 1,  3920,   nil,   1,  30,  45,  60, 200, 200, { 4357, 2840, }, { 1, 1, }, { 1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037, }, 0, },
				[10580] = {  nil, 10580, 1, 12720,   nil,   1, 235, 245, 255,   1,   1, { 10561, 10505, 10558, 3860, }, { 1, 2, 1, 2, }, },
				[4357]  = { true,  4357, 1,  3918,   nil,   1,  20,  30,  40,   1,   1, { 2835, }, { 1, }, { 1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037, }, 0, },
				[10723] = {  nil, 10723, 1, 12904,   nil,   1, 240, 250, 260,   1,   1, { 10561, 3860, 4389, 10560, }, { 1, 2, 1, 1, }, },
				[10585] = {  nil, 10585, 1, 12722,   nil,   1, 240, 250, 260,   1,   1, { 10561, 3860, 4389, 10560, }, { 1, 2, 1, 1, }, },
				[10719] = {  nil, 10719, 1, 12900,   nil,   1, 205, 225, 245,   1,   1, { 10559, 10560, 3860, }, { 1, 1, 4, }, },
				[4360]  = { true,  4360, 1,  3923,   nil,  30,  60,  75,  90,   2,   2, { 2840, 4359, 4357, 2589, }, { 1, 1, 2, 1, }, { 1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037, }, 0, },
				[4359]  = { true,  4359, 1,  3922,   nil,  30,  45,  52,  60,   1,   1, { 2840, }, { 1, }, { 1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037, }, 0, },
				[6219]  = { true,  6219, 1,  7430,   nil,  50,  70,  80,  90,   1,   1, { 2840, }, { 6, }, { 1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037, }, 0, },
				[4362]  = { true,  4362, 1,  3925,   nil,  50,  80,  95, 110,   1,   1, { 4361, 4359, 4399, }, { 1, 1, 1, }, { 1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037, }, 0, },
				[4361]  = { true,  4361, 1,  3924,   nil,  50,  80,  95, 110,   1,   1, { 2840, 2880, }, { 2, 1, }, { 1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037, }, 0, },
				[4405]  = { true,  4405, 1,  3977,   nil,  60,  90, 105, 120,   1,   1, { 4361, 774, 4359, }, { 1, 1, 1, }, { 1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037, }, 0, },
				[4363]  = { true,  4363, 1,  3926,   nil,  65,  95, 110, 125,   1,   1, { 4359, 2840, 2589, }, { 2, 1, 2, }, { 1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037, }, 0, },
				[4364]  = { true,  4364, 1,  3929,   nil,  75,  85,  90,  95,   1,   1, { 2836, }, { 1, }, { 1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037, }, 0, },
				[8068]  = { true,  8068, 1,  3930,   nil,  75,  85,  90,  95, 200, 200, { 4364, 2840, }, { 1, 1, }, { 1676, 1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037, }, 0, },
				[4401]  = { true,  4401, 1,  3928,  4408,  75, 105, 120, 135,   1,   1, { 4363, 4359, 2840, 774, }, { 1, 1, 1, 2, }, },
				[4365]  = { true,  4365, 1,  3931,   nil,  75,  90,  97, 105,   1,   3, { 4364, 2589, }, { 3, 1, }, { 1676, 1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037, }, 0, },
				[4366]  = { true,  4366, 1,  3932,   nil,  85, 115, 130, 145,   1,   1, { 4363, 4359, 2841, 2592, }, { 1, 2, 1, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 0, },
				[4404]  = { true,  4404, 1,  3973,   nil,  90, 110, 125, 140,   5,   5, { 2842, }, { 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 0, },
				[4367]  = { true,  4367, 1,  3933,  4409, 100, 130, 145, 160,   1,   1, { 4364, 4363, 2318, 159, }, { 2, 1, 1, 1, }, },
				[6714]  = { true,  6714, 1,  8339,  6716, 100, 115, 122, 130,   1,   3, { 4364, 2592, }, { 4, 1, }, },
				[6712]  = { true,  6712, 1,  8334,   nil, 100, 115, 122, 130,   1,   1, { 2841, 4359, 2880, }, { 1, 2, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 0, },
				[4368]  = { true,  4368, 1,  3934,   nil, 100, 130, 145, 160,   1,   1, { 2318, 818, }, { 6, 2, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 0, },
				[4371]  = { true,  4371, 1,  3938,   nil, 105, 105, 130, 155,   1,   1, { 2841, 2880, }, { 2, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 0, },
				[4370]  = { true,  4370, 1,  3937,   nil, 105, 105, 130, 155,   2,   4, { 2840, 4364, 4404, }, { 3, 4, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 0, },
				[4369]  = { true,  4369, 1,  3936,   nil, 105, 130, 142, 155,   1,   1, { 4361, 4359, 4399, 2319, }, { 2, 4, 1, 2, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 0, },
				[4406]  = { true,  4406, 1,  3978,   nil, 110, 135, 147, 160,   1,   1, { 4371, 1206, }, { 1, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 0, },
				[4373]  = { true,  4373, 1,  3940,  4410, 120, 145, 157, 170,   1,   1, { 2319, 1210, }, { 4, 2, }, },
				[4372]  = { true,  4372, 1,  3939, 13309, 120, 145, 157, 170,   1,   1, { 4371, 4359, 4400, 1206, }, { 2, 2, 1, 3, }, },
				[4374]  = { true,  4374, 1,  3941,   nil, 120, 120, 145, 170,   1,   3, { 4364, 2841, 4404, 2592, }, { 4, 2, 1, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 0, },
				[8069]  = { true,  8069, 1,  3947,   nil, 125, 125, 135, 145, 200, 200, { 4377, 2841, }, { 1, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 0, },
				[4378]  = { true,  4378, 1,  3946,   nil, 125, 125, 135, 145,   1,   5, { 4377, 2592, }, { 2, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 0, },
				[4376]  = {  nil,  4376, 1,  3944,  4411, 125, 125, 150, 175,   1,   1, { 4375, 4402, }, { 1, 1, }, },
				[7506]  = { true,  7506, 1,  9269,  7560, 125, 150, 162, 175,   1,   1, { 2841, 4375, 814, 818, 774, }, { 6, 1, 2, 1, 1, }, },
				[4377]  = { true,  4377, 1,  3945,   nil, 125, 125, 135, 145,   1,   1, { 2838, }, { 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 0, },
				[21558] = {  nil, 21558, 1, 26416, 21724, 125, 125, 137, 150,   3,   3, { 4364, 2319, }, { 1, 1, }, },
				[21557] = {  nil, 21557, 1, 26418, 21726, 125, 125, 137, 150,   3,   3, { 4364, 2319, }, { 1, 1, }, },
				[4375]  = { true,  4375, 1,  3942,   nil, 125, 125, 150, 175,   1,   1, { 2841, 2592, }, { 2, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 0, },
				[21559] = {  nil, 21559, 1, 26417, 21725, 125, 125, 137, 150,   3,   3, { 4364, 2319, }, { 1, 1, }, },
				[4379]  = { true,  4379, 1,  3949,   nil, 130, 155, 167, 180,   1,   1, { 4371, 4375, 4400, 2842, }, { 2, 2, 1, 3, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 0, },
				[5507]  = { true,  5507, 1,  6458,   nil, 135, 160, 172, 185,   1,   1, { 4371, 4375, 4363, 1206, }, { 2, 2, 1, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 0, },
				[4381]  = { true,  4381, 1,  3952, 14639, 140, 165, 177, 190,   1,   1, { 4371, 4375, 2319, 1206, }, { 1, 2, 2, 1, }, },
				[4380]  = { true,  4380, 1,  3950,   nil, 140, 140, 165, 190,   2,   4, { 4377, 2841, 4404, }, { 2, 3, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 0, },
				[4382]  = { true,  4382, 1,  3953,   nil, 145, 145, 170, 195,   1,   1, { 2841, 2319, 2592, }, { 2, 1, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 0, },
				[4383]  = { true,  4383, 1,  3954,  4412, 145, 170, 182, 195,   1,   1, { 4371, 4375, 4400, 1705, }, { 3, 3, 1, 2, }, },
				[6533]  = { true,  6533, 1,  9271,   nil, 150, 150, 160, 170,   3,   3, { 2841, 6530, 4364, }, { 2, 1, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 0, },
				[4385]  = { true,  4385, 1,  3956,   nil, 150, 175, 187, 200,   1,   1, { 2319, 1206, 4368, }, { 4, 2, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 0, },
				[9312]  = { true,  9312, 1, 23067, 18649, 150, 150, 162, 175,   3,   3, { 4377, 4234, }, { 1, 1, }, },
				[4384]  = { true,  4384, 1,  3955,   nil, 150, 175, 187, 200,   1,   1, { 4382, 4375, 4377, 2592, }, { 1, 1, 2, 2, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 0, },
				[9318]  = {  nil,  9318, 1, 23066, 18647, 150, 150, 162, 175,   3,   3, { 4377, 4234, }, { 1, 1, }, },
				[10558] = { true, 10558, 1, 12584,   nil, 150, 150, 170, 190,   3,   3, { 3577, }, { 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 0, },
				[9313]  = { true,  9313, 1, 23068, 18648, 150, 150, 162, 175,   3,   3, { 4377, 4234, }, { 1, 1, }, },
				[4386]  = { true,  4386, 1,  3957, 13308, 155, 175, 185, 195,   1,   1, { 4375, 3829, }, { 1, 1, }, },
				[7148]  = { true,  7148, 1,  9273,  7561, 160, 160, 180, 200,   1,   1, { 3575, 4375, 814, 4306, 1210, 7191, }, { 6, 2, 2, 2, 2, 1, }, },
				[4388]  = { true,  4388, 1,  3959,  4413, 160, 180, 190, 200,   1,   1, { 4375, 4306, 1529, 4371, }, { 3, 2, 1, 1, }, },
				[4387]  = { true,  4387, 1,  3958,   nil, 160, 160, 170, 180,   1,   1, { 3575, }, { 2, }, { 5174, 8736, 11017, }, 0, },
				[4403]  = { true,  4403, 1,  3960,  4414, 165, 185, 195, 205,   1,   1, { 4371, 4387, 4377, 2319, }, { 4, 1, 4, 4, }, },
				[4389]  = { true,  4389, 1,  3961,   nil, 170, 170, 190, 210,   1,   1, { 3575, 10558, }, { 1, 1, }, { 5174, 8736, 11017, }, 0, },
				[10499] = { true, 10499, 1, 12587, 10601, 175, 195, 205, 215,   1,   1, { 4234, 3864, }, { 6, 2, }, },
				[21590] = {  nil, 21590, 1, 26421, 21728, 175, 175, 187, 200,   3,   3, { 4377, 4234, }, { 1, 1, }, },
				[4391]  = { true,  4391, 1,  3963,   nil, 175, 175, 195, 215,   1,   1, { 4387, 4382, 4389, 4234, }, { 2, 1, 2, 4, }, { 5174, 8736, 11017, }, 0, },
				[10498] = { true, 10498, 1, 12590,   nil, 175, 175, 195, 215,   1,   1, { 3859, }, { 4, }, { 5174, 8736, 11017, }, 0, },
				[4390]  = { true,  4390, 1,  3962,   nil, 175, 175, 195, 215,   2,   4, { 3575, 4377, 4306, }, { 1, 1, 1, }, { 5174, 8736, 11017, }, 0, },
				[10507] = { true, 10507, 1, 12586,   nil, 175, 175, 185, 195,   2,   2, { 10505, 4306, }, { 1, 1, }, { 5174, 8736, 11017, }, 0, },
				[21592] = {  nil, 21592, 1, 26422, 21729, 175, 175, 187, 200,   3,   3, { 4377, 4234, }, { 1, 1, }, },
				[21589] = {  nil, 21589, 1, 26420, 21727, 175, 175, 187, 200,   3,   3, { 4377, 4234, }, { 1, 1, }, },
				[10505] = { true, 10505, 1, 12585,   nil, 175, 175, 185, 195,   1,   1, { 7912, }, { 2, }, { 5174, 8736, 11017, }, 0, },
				[4407]  = { true,  4407, 1,  3979, 13310, 180, 200, 210, 220,   1,   1, { 4371, 1529, 3864, }, { 1, 1, 1, }, },
				[4393]  = { true,  4393, 1,  3966,  4415, 185, 205, 215, 225,   1,   1, { 4234, 3864, }, { 6, 2, }, },
				[4392]  = { true,  4392, 1,  3965,   nil, 185, 185, 205, 225,   1,   1, { 4387, 4382, 4389, 4234, }, { 1, 1, 1, 4, }, { 5174, 8736, 11017, }, 0, },
				[4852]  = {  nil,  4852, 1,  8243,  6672, 185, 185, 205, 225,   1,   1, { 4611, 4377, 4306, }, { 1, 1, 1, }, },
				[4394]  = { true,  4394, 1,  3967,   nil, 190, 190, 210, 230,   2,   2, { 3575, 4377, 4404, }, { 3, 3, 1, }, { 5174, 8736, 11017, }, 0, },
				[17716] = {  nil, 17716, 1, 21940, 17720, 190, 190, 210, 230,   1,   1, { 3860, 4389, 17202, 3829, }, { 8, 4, 4, 1, }, },
				[4395]  = { true,  4395, 1,  3968,  4416, 195, 215, 225, 235,   1,   1, { 4377, 3575, 4389, }, { 3, 2, 1, }, },
				[10559] = { true, 10559, 1, 12589,   nil, 195, 195, 215, 235,   1,   1, { 3860, }, { 3, }, { 5174, 8736, 11017, }, 0, },
				[18588] = { true, 18588, 1, 23069, 18650, 200, 200, 210, 220,   1,   1, { 10505, 4338, }, { 1, 2, }, },
				[10713] = { true, 10713, 1, 12895,   nil, 200, 205, 205, 205,   1,   1, { 10648, 10647, }, { 1, 1, }, { 7406, 7944, 8738, }, 0, },
				[11590] = { true, 11590, 1, 15255,   nil, 200, 200, 220, 240,   1,   1, { 3860, 4338, 10505, }, { 1, 1, 1, }, { 5174, 8736, 11017, }, 0, },
				[4397]  = { true,  4397, 1,  3971,  7742, 200, 220, 230, 240,   1,   1, { 4389, 1529, 1705, 3864, 7191, }, { 4, 2, 2, 2, 1, }, },
				[4396]  = { true,  4396, 1,  3969, 13311, 200, 220, 230, 240,   1,   1, { 4382, 4387, 4389, 3864, 7191, }, { 1, 4, 4, 2, 1, }, },
				[4398]  = { true,  4398, 1,  3972,  4417, 200, 200, 220, 240,   1,   1, { 10505, 4234, 159, }, { 2, 2, 1, }, },
				[10560] = { true, 10560, 1, 12591,   nil, 200, 200, 220, 240,   1,   1, { 3860, 4338, 10505, }, { 1, 1, 1, }, { 5174, 8736, 11017, }, 0, },
				[10646] = {  nil, 10646, 1, 12760,   nil, 205, 205, 225, 245,   1,   1, { 4338, 10505, 10560, }, { 1, 3, 1, }, { 8126, 8738, }, 0, },
				[11825] = {  nil, 11825, 1, 15628, 11828, 205, 205, 205, 205,   1,   1, { 4394, 7077, 7191, 3860, }, { 1, 1, 1, 6, }, },
				[10500] = { true, 10500, 1, 12594,   nil, 205, 225, 235, 245,   1,   1, { 4385, 3864, 7068, 4234, }, { 1, 2, 2, 4, }, { 5174, 8736, 11017, }, 0, },
				[11826] = {  nil, 11826, 1, 15633, 11827, 205, 205, 205, 205,   1,   1, { 7075, 4389, 7191, 3860, 6037, }, { 1, 2, 1, 2, 1, }, },
				[10644] = {  nil, 10644, 1, 12715,   nil, 205, 205, 205, 205,   1,   1, { 10648, 10647, }, { 1, 1, }, { 8126, 8738, }, 0, },
				[10542] = {  nil, 10542, 1, 12717,   nil, 205, 225, 235, 245,   1,   1, { 3860, 3864, 7067, }, { 8, 1, 4, }, { 8126, 8738, }, 0, },
				[10543] = {  nil, 10543, 1, 12718,   nil, 205, 225, 235, 245,   1,   1, { 3860, 3864, 7068, }, { 8, 1, 4, }, { 8126, 8738, }, 0, },
				[10716] = { true, 10716, 1, 12899,   nil, 205, 225, 235, 245,   1,   1, { 10559, 10560, 3860, 8151, 1529, }, { 1, 1, 4, 4, 2, }, { 7406, 7944, }, 0, },
				[10508] = { true, 10508, 1, 12595,   nil, 205, 225, 235, 245,   1,   1, { 10559, 10560, 4400, 3860, 7068, }, { 1, 1, 1, 4, 2, }, { 5174, 8736, 11017, }, 0, },
				[10720] = { true, 10720, 1, 12902,   nil, 210, 230, 240, 250,   1,   1, { 10559, 10285, 4337, 10505, 3860, }, { 1, 2, 4, 2, 4, }, { 7406, 7944, }, 0, },
				[10545] = { true, 10545, 1, 12897,   nil, 210, 230, 240, 250,   1,   1, { 10500, 10559, 10558, 8151, 4234, }, { 1, 1, 2, 2, 2, }, { 7406, 7944, }, 0, },
				[10512] = { true, 10512, 1, 12596,   nil, 210, 210, 230, 250, 200, 200, { 3860, 10505, }, { 1, 1, }, { 5174, 8736, 11017, }, 0, },
				[10546] = { true, 10546, 1, 12597, 10602, 210, 230, 240, 250,   1,   1, { 10559, 7909, 4304, }, { 1, 2, 2, }, },
				[10514] = { true, 10514, 1, 12603,   nil, 215, 215, 235, 255,   3,   3, { 10561, 10560, 10505, }, { 1, 1, 1, }, { 5174, 8736, 11017, }, 0, },
				[10721] = { true, 10721, 1, 12903,   nil, 215, 235, 245, 255,   1,   1, { 7387, 3860, 6037, 10560, 7909, }, { 1, 4, 2, 1, 2, }, { 7406, 7944, }, 0, },
				[10726] = { true, 10726, 1, 12907,   nil, 215, 255, 265, 275,   1,   1, { 3860, 6037, 10558, 7910, 4338, }, { 10, 4, 1, 2, 4, }, { 7406, 7944, }, 0, },
				[10561] = { true, 10561, 1, 12599,   nil, 215, 215, 235, 255,   1,   1, { 3860, }, { 3, }, { 5174, 8736, 11017, }, 0, },
				[10510] = { true, 10510, 1, 12614, 10604, 220, 240, 250, 260,   1,   1, { 10559, 10560, 4400, 3860, 3864, }, { 2, 1, 1, 6, 2, }, },
				[10501] = { true, 10501, 1, 12607, 10603, 220, 240, 250, 260,   1,   1, { 4304, 7909, 10592, }, { 4, 2, 1, }, },
				[10502] = { true, 10502, 1, 12615, 10605, 225, 245, 255, 265,   1,   1, { 4304, 7910, }, { 4, 2, }, },
				[10724] = { true, 10724, 1, 12905,   nil, 225, 245, 255, 265,   1,   1, { 10026, 10559, 4234, 10505, 4389, }, { 1, 2, 4, 8, 4, }, { 7406, 7944, }, 0, },
				[21574] = {  nil, 21574, 1, 26424, 21731, 225, 225, 237, 250,   3,   3, { 10505, 4304, }, { 1, 1, }, },
				[21576] = {  nil, 21576, 1, 26425, 21732, 225, 225, 237, 250,   3,   3, { 10505, 4304, }, { 1, 1, }, },
				[21571] = {  nil, 21571, 1, 26423, 21730, 225, 225, 237, 250,   3,   3, { 10505, 4304, }, { 1, 1, }, },
				[21569] = {  nil, 21569, 1, 26442, 21738, 225, 245, 255, 265,   1,   1, { 9060, 9061, 10560, 10561, }, { 1, 1, 1, 1, }, },
				[10586] = {  nil, 10586, 1, 12754,   nil, 225, 235, 255, 275,   2,   2, { 10561, 9061, 10507, 10560, }, { 1, 1, 6, 1, }, { 8126, 8738, }, 0, },
				[10518] = { true, 10518, 1, 12616, 10606, 225, 245, 255, 265,   1,   1, { 4339, 10285, 10560, 10505, }, { 4, 2, 1, 4, }, },
				[10577] = {  nil, 10577, 1, 13240,   nil, 225, 225, 235, 245,   1,   1, { 10577, 3860, 10505, }, { 1, 1, 3, }, { 8126, }, 0, },
				[7189]  = {  nil,  7189, 1,  8895,   nil, 225, 245, 255, 265,   1,   1, { 10026, 10559, 4234, 9061, 10560, }, { 1, 2, 4, 2, 1, }, { 8126, 8738, }, 0, },
				[10503] = { true, 10503, 1, 12618,   nil, 230, 250, 260, 270,   1,   1, { 4304, 7910, }, { 6, 2, }, { 8736, }, 0, },
				[10725] = { true, 10725, 1, 12906,   nil, 230, 250, 260, 270,   1,   1, { 10561, 6037, 3860, 9060, 10558, 1529, }, { 1, 6, 6, 2, 1, 2, }, { 7406, 7944, }, 0, },
				[10506] = { true, 10506, 1, 12617, 10607, 230, 250, 260, 270,   1,   1, { 3860, 10561, 6037, 818, 774, }, { 8, 1, 1, 4, 4, }, },
				[10587] = {  nil, 10587, 1, 12755,   nil, 230, 230, 250, 270,   1,   1, { 10561, 10505, 6037, 10560, 4407, }, { 2, 4, 6, 1, 2, }, { 8126, 8738, }, 0, },
				[10562] = { true, 10562, 1, 12619,   nil, 235, 235, 255, 275,   4,   4, { 10561, 10560, 10505, }, { 2, 1, 2, }, { 8736, }, 0, },
				[10588] = {  nil, 10588, 1, 12758,   nil, 235, 265, 275, 285,   1,   1, { 10543, 9061, 3860, 10560, }, { 1, 4, 4, 1, }, { 8126, 8738, }, 0, },
				[10548] = {  nil, 10548, 1, 12620, 10608, 240, 260, 270, 280,   1,   1, { 10559, 7910, 6037, }, { 1, 1, 2, }, },
				[10727] = {  nil, 10727, 1, 12908,   nil, 240, 260, 270, 280,   1,   1, { 10559, 9061, 3860, 6037, 10560, }, { 2, 4, 6, 6, 1, }, { 8126, 8738, }, 0, },
				[10645] = { true, 10645, 1, 12759,   nil, 240, 260, 270, 280,   1,   1, { 10559, 10560, 12808, 7972, 9060, }, { 2, 1, 1, 4, 1, }, { 7406, 7944, }, 0, },
				[10513] = { true, 10513, 1, 12621,   nil, 245, 245, 265, 285, 200, 200, { 3860, 10505, }, { 2, 2, }, { 8736, }, 0, },
				[10504] = { true, 10504, 1, 12622,   nil, 245, 265, 275, 285,   1,   1, { 4304, 1529, 7909, 10286, 8153, }, { 8, 3, 3, 2, 2, }, { 8736, }, 0, },
				[19026] = { true, 19026, 1, 23507, 19027, 250, 250, 260, 270,   4,   4, { 15992, 14047, 8150, }, { 2, 2, 1, }, },
				[21277] = {  nil, 21277, 1, 26011,   nil, 250, 320, 330, 340,   1,   1, { 15407, 15994, 7079, 18631, 10558, }, { 1, 4, 2, 2, 1, }, { 8798, }, },
				[15846] = { true, 15846, 1, 19567,   nil, 250, 270, 280, 290,   1,   1, { 10561, 12359, 10558, 10560, }, { 1, 6, 1, 4, }, { 8736, }, 0, },
				[15992] = { true, 15992, 1, 19788,   nil, 250, 250, 255, 260,   1,   1, { 12365, }, { 2, }, { 8736, }, 0, },
				[18641] = { true, 18641, 1, 23070,   nil, 250, 250, 260, 270,   2,   2, { 15992, 14047, }, { 2, 3, }, { 8736, }, 0, },
				[10576] = { true, 10576, 1, 12624, 10609, 250, 270, 280, 290,   1,   1, { 3860, 7077, 6037, 9060, 9061, 7910, }, { 14, 4, 4, 2, 2, 2, }, },
				[18660] = { true, 18660, 1, 23129, 18661, 260, 260, 265, 270,   1,   1, { 10561, 15994, 10558, 10560, 3864, }, { 1, 2, 1, 1, 1, }, },
				[18634] = { true, 18634, 1, 23077, 18652, 260, 280, 290, 300,   1,   1, { 15994, 18631, 12361, 7078, 3829, 13467, }, { 6, 2, 2, 4, 2, 4, }, },
				[15993] = { true, 15993, 1, 19790, 16041, 260, 280, 290, 300,   3,   3, { 15994, 12359, 15992, 14047, }, { 1, 3, 3, 3, }, },
				[15994] = { true, 15994, 1, 19791, 16042, 260, 280, 290, 300,   1,   1, { 12359, 14047, }, { 3, 1, }, },
				[15995] = { true, 15995, 1, 19792, 16043, 260, 280, 290, 300,   1,   1, { 10559, 10561, 15994, 12359, 10546, }, { 2, 2, 2, 4, 1, }, },
				[18631] = { true, 18631, 1, 23071, 18651, 260, 270, 275, 280,   1,   1, { 6037, 7067, 7069, }, { 2, 2, 1, }, },
				[18986] = { true, 18986, 1, 23489,   nil, 260, 285, 295, 305,   1,   1, { 3860, 18631, 7075, 7079, 7909, 9060, }, { 12, 2, 4, 2, 4, 1, }, { 8736, }, 0, },
				[18984] = {  nil, 18984, 1, 23486,   nil, 260, 285, 295, 305,   1,   1, { 3860, 18631, 7077, 7910, 10586, }, { 10, 1, 4, 2, 1, }, { 8736, }, 0, },
				[18587] = {  nil, 18587, 1, 23078, 18653, 265, 285, 295, 305,   1,   1, { 15994, 18631, 7191, 14227, 7910, }, { 2, 2, 2, 2, 2, }, },
				[15996] = {  nil, 15996, 1, 19793, 16044, 265, 285, 295, 305,   1,   1, { 12803, 15994, 10558, 8170, }, { 1, 4, 1, 1, }, },
				[18645] = { true, 18645, 1, 23096, 18654, 265, 275, 280, 285,   1,   1, { 12359, 15994, 8170, 7910, 7191, }, { 4, 2, 4, 1, 1, }, },
				[15999] = { true, 15999, 1, 19794, 16045, 270, 290, 300, 310,   1,   1, { 10502, 7910, 12810, 14047, }, { 1, 4, 2, 8, }, },
				[16004] = { true, 16004, 1, 19796, 16048, 275, 295, 305, 315,   1,   1, { 16000, 11371, 10546, 12361, 12799, 8170, }, { 2, 6, 2, 2, 2, 4, }, },
				[22728] = {  nil, 22728, 1, 28327, 22729, 275, 295, 305, 315,   1,   1, { 15994, 10561, 10558, }, { 2, 1, 1, }, },
				[16000] = { true, 16000, 1, 19795, 16047, 275, 295, 305, 315,   1,   1, { 12359, }, { 6, }, },
				[21716] = {  nil, 21716, 1, 26427, 21734, 275, 275, 280, 285,   3,   3, { 15992, 8170, }, { 1, 1, }, },
				[16023] = { true, 16023, 1, 19814, 16046, 275, 295, 305, 315,   1,   1, { 10561, 16000, 15994, 6037, 8170, 14047, }, { 1, 1, 2, 1, 2, 4, }, },
				[21570] = {  nil, 21570, 1, 26443, 21737, 275, 295, 305, 315,   1,   1, { 9060, 9061, 18631, 10561, }, { 4, 4, 2, 1, }, },
				[21718] = {  nil, 21718, 1, 26428, 21735, 275, 275, 280, 285,   3,   3, { 15992, 8170, }, { 1, 1, }, },
				[21714] = {  nil, 21714, 1, 26426, 21733, 275, 275, 280, 285,   3,   3, { 15992, 8170, }, { 1, 1, }, },
				[18594] = { true, 18594, 1, 23080, 18656, 275, 275, 285, 295,   1,   1, { 15994, 15992, 8170, 159, }, { 2, 3, 2, 1, }, },
				[18637] = { true, 18637, 1, 23079, 18655, 275, 285, 290, 295,   1,   1, { 16000, 18631, 14047, }, { 2, 1, 2, }, },
				[15997] = { true, 15997, 1, 19800, 16051, 285, 305, 315, 325, 200, 200, { 12359, 15992, }, { 2, 1, }, },
				[16005] = { true, 16005, 1, 19799, 16049, 285, 305, 315, 325,   3,   3, { 15994, 11371, 15992, 14047, }, { 2, 1, 3, 3, }, },
				[16006] = { true, 16006, 1, 19815, 16050, 285, 305, 315, 325,   1,   1, { 12360, 14227, }, { 1, 1, }, },
				[18638] = {  nil, 18638, 1, 23081, 18657, 290, 310, 320, 330,   1,   1, { 11371, 18631, 7080, 7910, 12800, }, { 4, 3, 6, 4, 2, }, },
				[16008] = {  nil, 16008, 1, 19825, 16053, 290, 310, 320, 330,   1,   1, { 10500, 12364, 12810, }, { 1, 2, 4, }, },
				[16009] = { true, 16009, 1, 19819, 16052, 290, 310, 320, 330,   1,   1, { 16006, 10558, 15994, 12799, }, { 2, 1, 1, 1, }, },
				[18639] = {  nil, 18639, 1, 23082, 18658, 300, 320, 330, 340,   1,   1, { 11371, 18631, 12803, 12808, 12800, 12799, }, { 8, 4, 6, 4, 2, 2, }, },
				[19998] = {  nil, 19998, 4, 24357, 20001, 300, 320, 330, 340,   1,   1, { 19726, 19774, 16006, 12804, 12810, }, { 5, 5, 1, 8, 4, }, },
				[19999] = {  nil, 19999, 4, 24356, 20000, 300, 320, 330, 340,   1,   1, { 19726, 19774, 16006, 12804, 12810, }, { 4, 5, 2, 8, 4, }, },
				[18282] = {  nil, 18282, 1, 22795, 18292, 300, 320, 330, 340,   1,   1, { 17010, 17011, 12360, 16006, 16000, }, { 4, 2, 6, 2, 2, }, },
				[16040] = { true, 16040, 1, 19831, 16055, 300, 320, 330, 340,   3,   3, { 16006, 12359, 14047, }, { 1, 3, 1, }, },
				[16007] = { true, 16007, 1, 19833, 16056, 300, 320, 330, 340,   1,   1, { 12360, 16000, 7078, 7076, 12800, 12810, }, { 10, 2, 2, 2, 2, 2, }, },
				[18232] = { true, 18232, 1, 22704, 18235, 300, 320, 330, 340,   1,   1, { 12359, 8170, 7191, 7067, 7068, }, { 12, 4, 1, 2, 1, }, },
				[16022] = { true, 16022, 1, 19830, 16054, 300, 320, 330, 340,   1,   1, { 10576, 16006, 12655, 15994, 10558, 12810, }, { 1, 8, 10, 6, 4, 6, }, },
				[18168] = {  nil, 18168, 1, 22797, 18291, 300, 320, 330, 340,   1,   1, { 12360, 16006, 7082, 12803, 7076, }, { 6, 2, 8, 12, 8, }, },
				[18283] = { true, 18283, 1, 22793, 18290, 300, 320, 330, 340,   1,   1, { 17011, 7076, 16006, 11371, 16000, }, { 2, 2, 4, 6, 1, }, },
			},
			[10] = {
				[7421]  = { true,  6218, 1,  7421,   nil,   1,   5,   7,  10,   1,   1, { 6217, 10940, 10938, }, { 1, 1, 1, }, { 1317, 3011, 3345, 3606, 4616, 5157, 5695, 7949, 11065, 11066, 11067, 11068, 11070, 11071, 11072, 11073, 11074, }, 0, },
				[22434] = {  nil, 17968, 1, 22434,   nil,   1, 320, 315, 310,   1,   1, { 17967, 16204, 16203, }, { 1, 2, 2, }, },
				[7418]  = { true,   nil, 1,  7418,   nil,   1,  70,  90, 110,   1,   1, { 10940, }, { 1, }, { 1317, 3011, 3345, 3606, 4616, 5157, 5695, 7949, 11065, 11066, 11067, 11068, 11070, 11071, 11072, 11073, 11074, }, 0, },
				[7420]  = { true,   nil, 1,  7420,   nil,  10,  70,  90, 110,   1,   1, { 10940, }, { 1, }, { 1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11065, 11066, 11067, 11068, 11070, 11071, 11072, 11073, 11074, }, 0, },
				[14293] = { true, 11287, 1, 14293,   nil,  10,  75,  95, 115,   1,   1, { 4470, 10938, }, { 1, 1, }, { 1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11065, 11066, 11067, 11068, 11070, 11071, 11072, 11073, 11074, }, 0, },
				[7443]  = { true,   nil, 1,  7443,  6342,  20,  80, 100, 120,   1,   1, { 10938, }, { 1, }, },
				[7426]  = { true,   nil, 1,  7426,   nil,  40,  90, 110, 130,   1,   1, { 10940, 10938, }, { 2, 1, }, { 1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11065, 11066, 11067, 11068, 11070, 11071, 11072, 11073, 11074, }, 0, },
				[25124] = {  nil, 20744, 5, 25124, 20758,  45,  55,  65,  75,   1,   1, { 10940, 17034, 3371, }, { 2, 1, 1, }, },
				[7454]  = { true,   nil, 1,  7454,   nil,  45,  95, 115, 135,   1,   1, { 10940, 10938, }, { 1, 2, }, { 1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11065, 11066, 11067, 11068, 11070, 11071, 11072, 11073, 11074, }, 0, },
				[7457]  = { true,   nil, 1,  7457,   nil,  50, 100, 120, 140,   1,   1, { 10940, }, { 3, }, { 1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11065, 11066, 11067, 11068, 11070, 11071, 11072, 11073, 11074, }, 0, },
				[7748]  = { true,   nil, 1,  7748,   nil,  60, 105, 125, 145,   1,   1, { 10940, 10938, }, { 2, 2, }, { 1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11065, 11066, 11067, 11068, 11070, 11071, 11072, 11073, 11074, }, 0, },
				[7766]  = { true,   nil, 1,  7766,  6344,  60, 105, 125, 145,   1,   1, { 10938, }, { 2, }, },
				[14807] = { true, 11288, 1, 14807,   nil,  70, 110, 130, 150,   1,   1, { 4470, 10939, }, { 1, 1, }, { 1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11065, 11066, 11067, 11068, 11070, 11071, 11072, 11073, 11074, }, 0, },
				[7771]  = { true,   nil, 1,  7771,   nil,  70, 110, 130, 150,   1,   1, { 10940, 10939, }, { 3, 1, }, { 1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11065, 11066, 11067, 11068, 11070, 11071, 11072, 11073, 11074, }, 0, },
				[7782]  = { true,   nil, 1,  7782,  6347,  80, 115, 135, 155,   1,   1, { 10940, }, { 5, }, },
				[7779]  = { true,   nil, 1,  7779,   nil,  80, 115, 135, 155,   1,   1, { 10940, 10939, }, { 2, 1, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 0, },
				[7776]  = {  nil,   nil, 1,  7776,  6346,  80, 115, 135, 155,   1,   1, { 10939, 10938, }, { 1, 1, }, },
				[7428]  = { true,   nil, 1,  7428,   nil,  80,  80, 100, 120,   1,   1, { 10938, 10940, }, { 1, 1, }, { 3011, 3345, 4213, 4616, 5157, 7949, }, 0, },
				[7786]  = { true,   nil, 1,  7786,  6348,  90, 120, 140, 160,   1,   1, { 10940, 10939, }, { 4, 2, }, },
				[7788]  = { true,   nil, 1,  7788,   nil,  90, 120, 140, 160,   1,   1, { 10940, 10939, 10978, }, { 2, 1, 1, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 0, },
				[7793]  = { true,   nil, 1,  7793,  6349, 100, 130, 150, 170,   1,   1, { 10939, }, { 3, }, },
				[7745]  = { true,   nil, 1,  7745,   nil, 100, 130, 150, 170,   1,   1, { 10940, 10978, }, { 4, 1, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 0, },
				[7795]  = { true,  6339, 1,  7795,   nil, 100, 130, 150, 170,   1,   1, { 6338, 10940, 10939, 1210, }, { 1, 6, 3, 1, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 0, },
				[13378] = { true,   nil, 1, 13378,   nil, 105, 130, 150, 170,   1,   1, { 10998, 10940, }, { 1, 2, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 0, },
				[13380] = { true,   nil, 1, 13380, 11038, 110, 135, 155, 175,   1,   1, { 10998, 10940, }, { 1, 6, }, },
				[13419] = { true,   nil, 1, 13419, 11039, 110, 135, 155, 175,   1,   1, { 10998, }, { 1, }, },
				[13421] = { true,   nil, 1, 13421,   nil, 115, 140, 160, 180,   1,   1, { 10940, 10978, }, { 6, 1, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 0, },
				[13464] = { true,   nil, 1, 13464, 11081, 115, 140, 160, 180,   1,   1, { 10998, 10940, 10978, }, { 1, 1, 1, }, },
				[7857]  = { true,   nil, 1,  7857,   nil, 120, 145, 165, 185,   1,   1, { 10940, 10998, }, { 4, 1, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 0, },
				[7859]  = { true,   nil, 1,  7859,  6375, 120, 145, 165, 185,   1,   1, { 10998, }, { 2, }, },
				[7863]  = { true,   nil, 1,  7863,   nil, 125, 150, 170, 190,   1,   1, { 10940, }, { 8, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 0, },
				[7861]  = { true,   nil, 1,  7861,   nil, 125, 150, 170, 190,   1,   1, { 6371, 10998, }, { 1, 1, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 0, },
				[7867]  = { true,   nil, 1,  7867,  6377, 125, 150, 170, 190,   1,   1, { 10940, 10998, }, { 6, 2, }, },
				[13485] = { true,   nil, 1, 13485,   nil, 130, 155, 175, 195,   1,   1, { 10998, 10940, }, { 2, 4, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 0, },
				[13501] = { true,   nil, 1, 13501,   nil, 130, 155, 175, 195,   1,   1, { 11083, }, { 2, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 0, },
				[13522] = { true,   nil, 1, 13522, 11098, 135, 160, 180, 200,   1,   1, { 11082, 6048, }, { 1, 1, }, },
				[13538] = { true,   nil, 1, 13538,   nil, 140, 165, 185, 205,   1,   1, { 10940, 11082, 11084, }, { 2, 1, 1, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 0, },
				[13503] = { true,   nil, 1, 13503,   nil, 140, 165, 185, 205,   1,   1, { 11083, 11084, }, { 2, 1, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 0, },
				[13536] = { true,   nil, 1, 13536, 11101, 140, 165, 185, 205,   1,   1, { 11083, }, { 2, }, },
				[13612] = { true,   nil, 1, 13612, 11150, 145, 170, 190, 210,   1,   1, { 11083, 2772, }, { 1, 3, }, },
				[13529] = { true,   nil, 1, 13529,   nil, 145, 170, 190, 210,   1,   1, { 11083, 11084, }, { 3, 1, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 0, },
				[13617] = {  nil,   nil, 1, 13617, 11151, 145, 170, 190, 210,   1,   1, { 11083, 3356, }, { 1, 3, }, },
				[13607] = { true,   nil, 1, 13607,   nil, 145, 170, 190, 210,   1,   1, { 11082, 10998, }, { 1, 2, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 0, },
				[13620] = { true,   nil, 1, 13620, 11152, 145, 170, 190, 210,   1,   1, { 11083, 6370, }, { 1, 3, }, },
				[13622] = { true,   nil, 1, 13622,   nil, 150, 175, 195, 215,   1,   1, { 11082, }, { 2, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 0, },
				[13628] = { true, 11130, 1, 13628,   nil, 150, 175, 195, 215,   1,   1, { 11128, 5500, 11082, 11083, }, { 1, 1, 2, 2, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 0, },
				[25125] = {  nil, 20745, 5, 25125, 20752, 150, 160, 170, 180,   1,   1, { 11083, 17034, 3372, }, { 3, 2, 1, }, },
				[13626] = { true,   nil, 1, 13626,   nil, 150, 175, 195, 215,   1,   1, { 11082, 11083, 11084, }, { 1, 1, 1, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 0, },
				[14809] = { true, 11289, 1, 14809,   nil, 155, 175, 195, 215,   1,   1, { 11291, 11134, 11083, }, { 1, 1, 1, }, { 11072, 11073, 11074, }, 0, },
				[13631] = { true,   nil, 1, 13631,   nil, 155, 175, 195, 215,   1,   1, { 11134, 11083, }, { 1, 1, }, { 11072, 11073, 11074, }, 0, },
				[13635] = { true,   nil, 1, 13635,   nil, 155, 175, 195, 215,   1,   1, { 11138, 11083, }, { 1, 3, }, { 11072, 11073, 11074, }, 0, },
				[13637] = { true,   nil, 1, 13637,   nil, 160, 180, 200, 220,   1,   1, { 11083, 11134, }, { 1, 1, }, { 11072, 11073, 11074, }, 0, },
				[13640] = { true,   nil, 1, 13640,   nil, 160, 180, 200, 220,   1,   1, { 11083, }, { 3, }, { 11072, 11073, 11074, }, 0, },
				[13642] = { true,   nil, 1, 13642,   nil, 165, 185, 205, 225,   1,   1, { 11134, }, { 1, }, { 11072, 11073, 11074, }, 0, },
				[13646] = { true,   nil, 1, 13646, 11163, 170, 190, 210, 230,   1,   1, { 11134, 11083, }, { 1, 2, }, },
				[13648] = { true,   nil, 1, 13648,   nil, 170, 190, 210, 230,   1,   1, { 11083, }, { 6, }, { 11072, 11073, 11074, }, 0, },
				[13644] = { true,   nil, 1, 13644,   nil, 170, 190, 210, 230,   1,   1, { 11083, }, { 4, }, { 11072, 11073, 11074, }, 0, },
				[13657] = { true,   nil, 1, 13657,   nil, 175, 195, 215, 235,   1,   1, { 11134, 7068, }, { 1, 1, }, { 11072, 11073, 11074, }, 0, },
				[13655] = { true,   nil, 1, 13655, 11165, 175, 195, 215, 235,   1,   1, { 11134, 7067, 11138, }, { 1, 1, 1, }, },
				[14810] = { true, 11290, 1, 14810,   nil, 175, 195, 215, 235,   1,   1, { 11291, 11135, 11137, }, { 1, 1, 1, }, { 11072, 11073, 11074, }, 0, },
				[13653] = { true,   nil, 1, 13653, 11164, 175, 195, 215, 235,   1,   1, { 11134, 5637, 11138, }, { 1, 2, 1, }, },
				[13661] = { true,   nil, 1, 13661,   nil, 180, 200, 220, 240,   1,   1, { 11137, }, { 1, }, { 11072, 11073, 11074, }, 0, },
				[13659] = { true,   nil, 1, 13659,   nil, 180, 200, 220, 240,   1,   1, { 11135, 11137, }, { 1, 1, }, { 11072, 11073, 11074, }, 0, },
				[13663] = { true,   nil, 1, 13663,   nil, 185, 205, 225, 245,   1,   1, { 11135, }, { 1, }, { 11072, 11073, 11074, }, 0, },
				[13687] = { true,   nil, 1, 13687, 11167, 190, 210, 230, 250,   1,   1, { 11135, 11134, }, { 1, 2, }, },
				[21931] = {  nil,   nil, 1, 21931, 17725, 190, 210, 230, 250,   1,   1, { 11135, 11137, 11139, 3819, }, { 3, 3, 1, 2, }, },
				[13693] = { true,   nil, 1, 13693,   nil, 195, 215, 235, 255,   1,   1, { 11135, 11139, }, { 2, 1, }, { 11072, 11073, 11074, }, 0, },
				[13689] = { true,   nil, 1, 13689, 11168, 195, 215, 235, 255,   1,   1, { 11135, 11137, 11139, }, { 2, 2, 1, }, },
				[13698] = { true,   nil, 1, 13698, 11166, 200, 220, 240, 260,   1,   1, { 11137, 7392, }, { 1, 3, }, },
				[13700] = { true,   nil, 1, 13700,   nil, 200, 220, 240, 260,   1,   1, { 11135, 11137, 11139, }, { 2, 2, 1, }, { 11072, 11073, 11074, }, 0, },
				[13702] = { true, 11145, 1, 13702,   nil, 200, 220, 240, 260,   1,   1, { 11144, 7971, 11135, 11137, }, { 1, 1, 2, 2, }, { 11072, 11073, 11074, }, 0, },
				[13695] = { true,   nil, 1, 13695,   nil, 200, 220, 240, 260,   1,   1, { 11137, 11139, }, { 4, 1, }, { 11072, 11073, 11074, }, 0, },
				[25126] = {  nil, 20746, 5, 25126, 20753, 200, 210, 220, 230,   1,   1, { 11137, 17035, 3372, }, { 3, 2, 1, }, },
				[13746] = { true,   nil, 1, 13746,   nil, 205, 225, 245, 265,   1,   1, { 11137, }, { 3, }, { 11072, 11073, 11074, }, 0, },
				[13794] = { true,   nil, 1, 13794,   nil, 205, 225, 245, 265,   1,   1, { 11174, }, { 1, }, { 11072, 11073, 11074, }, 0, },
				[13817] = { true,   nil, 1, 13817, 11202, 210, 230, 250, 270,   1,   1, { 11137, }, { 5, }, },
				[13822] = { true,   nil, 1, 13822,   nil, 210, 230, 250, 270,   1,   1, { 11174, }, { 2, }, { 11072, 11073, 11074, }, 0, },
				[13815] = { true,   nil, 1, 13815,   nil, 210, 230, 250, 270,   1,   1, { 11174, 11137, }, { 1, 1, }, { 11072, 11073, 11074, }, 0, },
				[13836] = { true,   nil, 1, 13836,   nil, 215, 235, 255, 275,   1,   1, { 11137, }, { 5, }, { 11072, 11073, 11074, }, 0, },
				[13841] = { true,   nil, 1, 13841, 11203, 215, 235, 255, 275,   1,   1, { 11137, 6037, }, { 3, 3, }, },
				[13846] = { true,   nil, 1, 13846, 11204, 220, 240, 260, 280,   1,   1, { 11174, 11137, }, { 3, 1, }, },
				[13858] = { true,   nil, 1, 13858,   nil, 220, 240, 260, 280,   1,   1, { 11137, }, { 6, }, { 11072, 11073, 11074, }, 0, },
				[13882] = { true,   nil, 1, 13882, 11206, 225, 245, 265, 285,   1,   1, { 11174, }, { 2, }, },
				[13868] = { true,   nil, 1, 13868, 11205, 225, 245, 265, 285,   1,   1, { 11137, 8838, }, { 3, 3, }, },
				[13887] = { true,   nil, 1, 13887,   nil, 225, 245, 265, 285,   1,   1, { 11174, 11137, }, { 2, 3, }, { 11072, 11073, 11074, }, 0, },
				[13890] = { true,   nil, 1, 13890,   nil, 225, 245, 265, 285,   1,   1, { 11177, 7909, 11174, }, { 1, 1, 1, }, { 11072, 11073, 11074, }, 0, },
				[13917] = { true,   nil, 1, 13917,   nil, 230, 250, 270, 290,   1,   1, { 11175, 11174, }, { 1, 2, }, { 11073, }, 0, },
				[13915] = { true,   nil, 1, 13915, 11208, 230, 250, 270, 290,   1,   1, { 11177, 11176, 9224, }, { 1, 2, 1, }, },
				[13905] = { true,   nil, 1, 13905,   nil, 230, 250, 270, 290,   1,   1, { 11175, 11176, }, { 1, 2, }, { 11073, }, 0, },
				[13933] = {  nil,   nil, 1, 13933, 11224, 235, 255, 275, 295,   1,   1, { 11178, 3829, }, { 1, 1, }, },
				[13935] = { true,   nil, 1, 13935,   nil, 235, 255, 275, 295,   1,   1, { 11175, }, { 2, }, { 11073, }, 0, },
				[13931] = { true,   nil, 1, 13931, 11223, 235, 255, 275, 295,   1,   1, { 11175, 11176, }, { 1, 2, }, },
				[13939] = { true,   nil, 1, 13939,   nil, 240, 260, 280, 300,   1,   1, { 11176, 11175, }, { 2, 1, }, { 11073, }, 0, },
				[13937] = { true,   nil, 1, 13937,   nil, 240, 260, 280, 300,   1,   1, { 11178, 11176, }, { 2, 2, }, { 11073, }, 0, },
				[13943] = { true,   nil, 1, 13943,   nil, 245, 265, 285, 305,   1,   1, { 11178, 11175, }, { 2, 2, }, { 11073, }, 0, },
				[13941] = { true,   nil, 1, 13941,   nil, 245, 265, 285, 305,   1,   1, { 11178, 11176, 11175, }, { 1, 3, 2, }, { 11073, }, 0, },
				[13945] = { true,   nil, 1, 13945, 11225, 245, 265, 285, 305,   1,   1, { 11176, }, { 5, }, },
				[25127] = {  nil, 20747, 5, 25127, 20754, 250, 260, 270, 280,   1,   1, { 11176, 8831, 8925, }, { 3, 2, 1, }, },
				[13948] = { true,   nil, 1, 13948,   nil, 250, 270, 290, 310,   1,   1, { 11178, 8153, }, { 2, 2, }, { 11073, }, 0, },
				[17181] = { true, 12810, 1, 17181,   nil, 250, 250, 255, 260,   1,   1, { 8170, 16202, }, { 1, 1, }, { 11073, }, 0, },
				[13947] = {  nil,   nil, 1, 13947, 11226, 250, 270, 290, 310,   1,   1, { 11178, 11176, }, { 2, 3, }, },
				[17180] = { true, 12655, 1, 17180,   nil, 250, 250, 255, 260,   1,   1, { 12359, 11176, }, { 1, 3, }, { 11073, }, 0, },
				[20008] = { true,   nil, 1, 20008, 16214, 255, 275, 295, 315,   1,   1, { 16202, }, { 3, }, },
				[20020] = { true,   nil, 1, 20020, 16215, 260, 280, 300, 320,   1,   1, { 11176, }, { 10, }, },
				[13898] = { true,   nil, 1, 13898, 11207, 265, 285, 305, 325,   1,   1, { 11177, 7078, }, { 4, 1, }, },
				[20017] = { true,   nil, 1, 20017, 16217, 265, 285, 305, 325,   1,   1, { 11176, }, { 10, }, },
				[20014] = {  nil,   nil, 1, 20014, 16216, 265, 285, 305, 325,   1,   1, { 16202, 7077, 7075, 7079, 7081, 7972, }, { 2, 1, 1, 1, 1, 1, }, },
				[15596] = { true, 11811, 1, 15596, 11813, 265, 285, 305, 325,   1,   1, { 11382, 7078, 14343, }, { 1, 1, 3, }, },
				[20012] = { true,   nil, 1, 20012, 16219, 270, 290, 310, 330,   1,   1, { 16202, 16204, }, { 3, 3, }, },
				[20009] = { true,   nil, 1, 20009, 16218, 270, 290, 310, 330,   1,   1, { 16202, 11176, }, { 3, 10, }, },
				[25128] = {  nil, 20750, 5, 25128, 20755, 275, 285, 295, 305,   1,   1, { 16204, 4625, 8925, }, { 3, 2, 1, }, },
				[20026] = { true,   nil, 1, 20026, 16221, 275, 295, 315, 335,   1,   1, { 16204, 14343, }, { 6, 1, }, },
				[20024] = { true,   nil, 1, 20024, 16220, 275, 295, 315, 335,   1,   1, { 16203, 16202, }, { 2, 1, }, },
				[20016] = { true,   nil, 1, 20016, 16222, 280, 300, 320, 340,   1,   1, { 16203, 16204, }, { 2, 4, }, },
				[20029] = { true,   nil, 1, 20029, 16223, 285, 305, 325, 345,   1,   1, { 14343, 7080, 7082, 13467, }, { 4, 1, 1, 1, }, },
				[20015] = { true,   nil, 1, 20015, 16224, 285, 305, 325, 345,   1,   1, { 16204, }, { 8, }, },
				[23799] = {  nil,   nil, 3, 23799, 19444, 290, 310, 330, 350,   1,   1, { 14344, 16203, 16204, 7076, }, { 6, 6, 4, 2, }, },
				[23800] = { true,   nil, 3, 23800, 19445, 290, 310, 330, 350,   1,   1, { 14344, 16203, 16204, 7082, }, { 6, 6, 4, 2, }, },
				[20028] = { true,   nil, 1, 20028, 16242, 290, 310, 330, 350,   1,   1, { 16203, 14343, }, { 3, 1, }, },
				[20051] = { true, 16207, 1, 20051, 16243, 290, 310, 330, 350,   1,   1, { 16206, 13926, 16204, 16203, 14343, 14344, }, { 1, 1, 10, 4, 4, 2, }, },
				[23801] = {  nil,   nil, 3, 23801, 19446, 290, 310, 330, 350,   1,   1, { 16204, 16203, 7080, }, { 16, 4, 2, }, },
				[27837] = {  nil,   nil, 5, 27837, 22392, 290, 310, 330, 350,   1,   1, { 14344, 16203, 16204, 7082, }, { 10, 6, 14, 4, }, },
				[20023] = { true,   nil, 1, 20023, 16245, 295, 315, 335, 355,   1,   1, { 16203, }, { 8, }, },
				[20030] = { true,   nil, 1, 20030, 16247, 295, 315, 335, 355,   1,   1, { 14344, 16204, }, { 4, 10, }, },
				[20013] = {  nil,   nil, 1, 20013, 16244, 295, 315, 335, 355,   1,   1, { 16203, 16204, }, { 4, 4, }, },
				[20010] = { true,   nil, 1, 20010, 16246, 295, 315, 335, 355,   1,   1, { 16204, 16203, }, { 6, 6, }, },
				[20033] = { true,   nil, 1, 20033, 16248, 295, 315, 335, 355,   1,   1, { 14344, 12808, }, { 4, 4, }, },
				[20031] = {  nil,   nil, 1, 20031, 16250, 300, 320, 340, 360,   1,   1, { 14344, 16203, }, { 2, 10, }, },
				[25078] = {  nil,   nil, 5, 25078, 20729, 300, 320, 340, 360,   1,   1, { 20725, 14344, 7078, }, { 2, 10, 4, }, },
				[22750] = {  nil,   nil, 1, 22750, 18260, 300, 320, 340, 360,   1,   1, { 14344, 16203, 12803, 7080, 12811, }, { 4, 8, 6, 6, 1, }, },
				[25130] = {  nil, 20748, 5, 25130, 20757, 300, 310, 320, 330,   1,   1, { 14344, 8831, 18256, }, { 2, 3, 1, }, },
				[25074] = {  nil,   nil, 5, 25074, 20728, 300, 320, 340, 360,   1,   1, { 20725, 14344, 7080, }, { 3, 10, 4, }, },
				[20036] = {  nil,   nil, 1, 20036, 16249, 300, 320, 340, 360,   1,   1, { 16203, 14344, }, { 12, 2, }, },
				[20032] = {  nil,   nil, 1, 20032, 16254, 300, 320, 340, 360,   1,   1, { 14344, 12808, 12803, }, { 6, 6, 6, }, },
				[20011] = { true,   nil, 1, 20011, 16251, 300, 320, 340, 360,   1,   1, { 16204, }, { 15, }, },
				[25083] = {  nil,   nil, 5, 25083, 20734, 300, 320, 340, 360,   1,   1, { 20725, 14344, 13468, }, { 3, 8, 2, }, },
				[23804] = {  nil,   nil, 3, 23804, 19449, 300, 320, 340, 360,   1,   1, { 14344, 16203, 16204, }, { 15, 12, 20, }, },
				[25084] = {  nil,   nil, 5, 25084, 20735, 300, 320, 340, 360,   1,   1, { 20725, 14344, 11754, }, { 4, 6, 2, }, },
				[20035] = { true,   nil, 1, 20035, 16255, 300, 320, 340, 360,   1,   1, { 16203, 14344, }, { 12, 2, }, },
				[25129] = {  nil, 20749, 5, 25129, 20756, 300, 310, 320, 330,   1,   1, { 14344, 4625, 18256, }, { 2, 3, 1, }, },
				[25073] = {  nil,   nil, 5, 25073, 20727, 300, 320, 340, 360,   1,   1, { 20725, 14344, 12808, }, { 3, 10, 6, }, },
				[25080] = {  nil,   nil, 5, 25080, 20731, 300, 320, 340, 360,   1,   1, { 20725, 14344, 7082, }, { 3, 8, 4, }, },
				[25081] = {  nil,   nil, 5, 25081, 20732, 300, 320, 340, 360,   1,   1, { 20725, 14344, 7078, }, { 3, 8, 4, }, },
				[23802] = {  nil,   nil, 3, 23802, 19447, 300, 320, 340, 360,   1,   1, { 14344, 16204, 16203, 12803, }, { 2, 20, 4, 6, }, },
				[23803] = {  nil,   nil, 3, 23803, 19448, 300, 320, 340, 360,   1,   1, { 14344, 16203, 16204, }, { 10, 8, 15, }, },
				[20025] = {  nil,   nil, 1, 20025, 16253, 300, 320, 340, 360,   1,   1, { 14344, 16204, 16203, }, { 4, 15, 10, }, },
				[25086] = {  nil,   nil, 5, 25086, 20736, 300, 320, 340, 360,   1,   1, { 20725, 14344, 12809, }, { 3, 8, 8, }, },
				[25079] = {  nil,   nil, 5, 25079, 20730, 300, 320, 340, 360,   1,   1, { 20725, 14344, 12811, }, { 3, 8, 1, }, },
				[22749] = {  nil,   nil, 1, 22749, 18259, 300, 320, 340, 360,   1,   1, { 14344, 16203, 7078, 7080, 7082, 13926, }, { 4, 12, 4, 4, 4, 2, }, },
				[20034] = { true,   nil, 1, 20034, 16252, 300, 320, 340, 360,   1,   1, { 14344, 12811, }, { 4, 2, }, },
				[25082] = {  nil,   nil, 5, 25082, 20733, 300, 320, 340, 360,   1,   1, { 20725, 14344, 12803, }, { 2, 8, 4, }, },
				[25072] = {  nil,   nil, 5, 25072, 20726, 300, 320, 340, 360,   1,   1, { 20725, 14344, 18512, }, { 4, 6, 8, }, },
			},
			[11] = nil,
			[12] = nil,
			[13] = {
				[6947]  = { true,  6947, 1,  8681,   nil,   1, 125, 150, 175,   1,   1, { 2928, 3371, }, { 1, 1, }, },
				[3775]  = { true,  3775, 1,  3420,   nil,   1, 125, 150, 175,   1,   1, { 2930, 3371, }, { 1, 1, }, },
				[5237]  = {  nil,  5237, 1,  5763,   nil, 100, 150, 175, 200,   1,   1, { 2928, 2930, 3371, }, { 1, 1, 1, }, },
				[6949]  = {  nil,  6949, 1,  8687,   nil, 120, 165, 190, 215,   1,   1, { 2928, 3372, }, { 3, 1, }, },
				[2892]  = {  nil,  2892, 1,  2835,   nil, 130, 175, 200, 225,   1,   1, { 5173, 3372, }, { 1, 1, }, },
				[10918] = {  nil, 10918, 1, 13220,   nil, 140, 185, 210, 235,   1,   1, { 2930, 5173, 3372, }, { 1, 1, 1, }, },
				[5530]  = {  nil,  5530, 1,  6510,   nil, 150, 170, 195, 220,   3,   3, { 3818, }, { 1, }, },
				[6950]  = {  nil,  6950, 1,  8691,   nil, 160, 205, 230, 255,   1,   1, { 8924, 3372, }, { 1, 1, }, },
				[2893]  = {  nil,  2893, 1,  2837,   nil, 170, 215, 240, 265,   1,   1, { 5173, 3372, }, { 2, 1, }, },
				[6951]  = {  nil,  6951, 1,  8694,   nil, 170, 215, 240, 265,   1,   1, { 2928, 2930, 3372, }, { 4, 4, 1, }, },
				[10920] = {  nil, 10920, 1, 13228,   nil, 180, 225, 250, 275,   1,   1, { 2930, 5173, 3372, }, { 1, 2, 1, }, },
				[8926]  = {  nil,  8926, 1, 11341,   nil, 200, 245, 270, 295,   1,   1, { 8924, 8925, }, { 2, 1, }, },
				[8984]  = {  nil,  8984, 1, 11357,   nil, 210, 255, 280, 305,   1,   1, { 5173, 8925, }, { 3, 1, }, },
				[10921] = {  nil, 10921, 1, 13229,   nil, 220, 265, 290, 315,   1,   1, { 8923, 5173, 8925, }, { 1, 2, 1, }, },
				[3776]  = {  nil,  3776, 1,  3421,   nil, 230, 275, 300, 325,   1,   1, { 8923, 8925, }, { 3, 1, }, },
				[9186]  = {  nil,  9186, 1, 11400,   nil, 240, 285, 310, 335,   1,   1, { 8924, 8923, 8925, }, { 2, 2, 1, }, },
				[8927]  = {  nil,  8927, 1, 11342,   nil, 240, 285, 310, 335,   1,   1, { 8924, 8925, }, { 3, 1, }, },
				[8985]  = {  nil,  8985, 1, 11358,   nil, 250, 295, 320, 345,   1,   1, { 5173, 8925, }, { 5, 1, }, },
				[10922] = {  nil, 10922, 1, 13230,   nil, 260, 305, 330, 355,   1,   1, { 8923, 5173, 8925, }, { 2, 2, 1, }, },
				[8928]  = {  nil,  8928, 1, 11343,   nil, 280, 325, 350, 375,   1,   1, { 8924, 8925, }, { 4, 1, }, },
				[20844] = {  nil, 20844, 5, 25347, 21302, 300, 300, 325, 350,   1,   1, { 5173, 8925, }, { 7, 1, }, },
			},
		};
		local xid_to_pid_hash = {  };	-- [xid] = { pid }
		local cid_to_pid_hash = {  };	-- [cid] = { pid }
		local sid_to_pid_hash = {  };	-- [sid] = pid
		local sid_to_cid_hash = {  };	-- [sid] = cid
		local sid_to_xid_hash = {  };
		local PROFESSION10_SID_TO_CID = {	-- [craft_spell_id] = item_id
			[14293] = 11287,
			[7421] = 6218,
			[7795] = 6339,
			[17181] = 12810,
			[13628] = 11130,
			[13702] = 11145,
			[14810] = 11290,
			[14807] = 11288,
			[14809] = 11289,
			[15596] = 11811,
			[17180] = 12655,
			[20051] = 16207,
			[22434] = 17968,
			[25127] = 20747,
			[25128] = 20750,
			[25129] = 20749,
			[25130] = 20748,
			[25124] = 20744,
			[25125] = 20745,
			[25126] = 20746,
		};
		-- [sid] = {  };
		local recipe_filter_by_sid = {			-- 2 VALID RECIPE
			[1] = {
				[18630] = true,
				[23787] = true,
				[10840] = true,
				[7934]  = true,
				[7928]  = true,
				[7929]  = true,
				[7935]  = true,
				[3276]  = true,
				[3275]  = true,
				[18629] = true,
				[10841] = true,
				[3278]  = true,
				[3277]  = true,
			},
			[2] = {
				[21161] = true,
				[9979]  = true,
				[9983]  = true,
				[9985]  = true,
				[9987]  = true,
				[9993]  = true,
				[9995]  = true,
				[9997]  = true,
				[10001] = true,
				[10003] = true,
				[10005] = true,
				[10007] = true,
				[10009] = true,
				[10011] = true,
				[10013] = true,
				[10015] = true,
				[16655] = true,
				[16659] = true,
				[16663] = true,
				[16667] = true,
				[8768]  = true,
				[14380] = true,
				[16970] = true,
				[16978] = true,
				[28461] = true,
				[16990] = true,
				[16994] = true,
				[24138] = true,
				[23632] = true,
				[23636] = true,
				[9814]  = true,
				[16741] = true,
				[9818]  = true,
				[3491]  = true,
				[7222]  = true,
				[3492]  = true,
				[7224]  = true,
				[3493]  = true,
				[3326]  = true,
				[3494]  = true,
				[24914] = true,
				[3495]  = true,
				[9920]  = true,
				[3496]  = true,
				[16639] = true,
				[3497]  = true,
				[3115]  = true,
				[3498]  = true,
				[3116]  = true,
				[15972] = true,
				[3117]  = true,
				[3500]  = true,
				[11643] = true,
				[3501]  = true,
				[11454] = true,
				[2737]  = true,
				[19668] = true,
				[2738]  = true,
				[9935]  = true,
				[2739]  = true,
				[27589] = true,
				[2740]  = true,
				[19667] = true,
				[2741]  = true,
				[16640] = true,
				[2742]  = true,
				[16648] = true,
				[16652] = true,
				[16656] = true,
				[16660] = true,
				[16664] = true,
				[19669] = true,
				[7818]  = true,
				[8880]  = true,
				[14379] = true,
				[20201] = true,
				[9921]  = true,
				[3513]  = true,
				[2660]  = true,
				[2665]  = true,
				[2674]  = true,
				[9916]  = true,
				[9918]  = true,
				[16971] = true,
				[16643] = true,
				[16724] = true,
				[16983] = true,
				[28462] = true,
				[16991] = true,
				[16995] = true,
				[24139] = true,
				[23633] = true,
				[15293] = true,
				[15295] = true,
				[6517]  = true,
				[6518]  = true,
				[23653] = true,
				[9937]  = true,
				[9950]  = true,
				[9952]  = true,
				[9954]  = true,
				[7221]  = true,
				[20872] = true,
				[20876] = true,
				[9939]  = true,
				[12259] = true,
				[9966]  = true,
				[9968]  = true,
				[9970]  = true,
				[9972]  = true,
				[9974]  = true,
				[16651] = true,
				[9964]  = true,
				[9980]  = true,
				[9945]  = true,
				[16644] = true,
				[9986]  = true,
				[16647] = true,
				[20874] = true,
				[7817]  = true,
				[27829] = true,
				[28244] = true,
				[24137] = true,
				[27586] = true,
				[27590] = true,
				[9931]  = true,
				[7223]  = true,
				[22757] = true,
				[16641] = true,
				[16645] = true,
				[16649] = true,
				[16653] = true,
				[16657] = true,
				[16661] = true,
				[27585] = true,
				[28463] = true,
				[3505]  = true,
				[16744] = true,
				[23628] = true,
				[27588] = true,
				[9926]  = true,
				[3502]  = true,
				[24141] = true,
				[3328]  = true,
				[3330]  = true,
				[3292]  = true,
				[3504]  = true,
				[3293]  = true,
				[9811]  = true,
				[3294]  = true,
				[16984] = true,
				[16988] = true,
				[16992] = true,
				[3296]  = true,
				[16745] = true,
				[24399] = true,
				[23638] = true,
				[9813]  = true,
				[2661]  = true,
				[23650] = true,
				[2662]  = true,
				[16730] = true,
				[2663]  = true,
				[9933]  = true,
				[2664]  = true,
				[3297]  = true,
				[20873] = true,
				[16732] = true,
				[2666]  = true,
				[24140] = true,
				[2667]  = true,
				[21913] = true,
				[20897] = true,
				[28243] = true,
				[2668]  = true,
				[3506]  = true,
				[2670]  = true,
				[15973] = true,
				[3507]  = true,
				[9957]  = true,
				[2672]  = true,
				[16725] = true,
				[2673]  = true,
				[19666] = true,
				[27830] = true,
				[3503]  = true,
				[2675]  = true,
				[27587] = true,
				[3325]  = true,
				[16729] = true,
				[24136] = true,
				[24913] = true,
				[16642] = true,
				[16646] = true,
				[16650] = true,
				[16654] = true,
				[16658] = true,
				[16662] = true,
				[16728] = true,
				[8367]  = true,
				[9928]  = true,
				[3320]  = true,
				[24912] = true,
				[3321]  = true,
				[15294] = true,
				[23629] = true,
				[9820]  = true,
				[3323]  = true,
				[23637] = true,
				[3324]  = true,
				[16969] = true,
				[16973] = true,
				[3508]  = true,
				[16726] = true,
				[16985] = true,
				[3336]  = true,
				[16993] = true,
				[16742] = true,
				[16746] = true,
				[15292] = true,
				[23639] = true,
				[15296] = true,
				[3511]  = true,
				[3331]  = true,
				[28242] = true,
				[16731] = true,
				[27832] = true,
				[3333]  = true,
				[3319]  = true,
				[3334]  = true,
				[9959]  = true,
				[9961]  = true,
				[3515]  = true,
				[12260] = true,
				[20890] = true,
				[3337]  = true,
				[7408]  = true,
				[3295]  = true,
				[23652] = true,
			},
			[3] = {
				[6661]  = true,
				[10487] = true,
				[22711] = true,
				[10499] = true,
				[22727] = true,
				[10507] = true,
				[10509] = true,
				[10511] = true,
				[7953]  = true,
				[7954]  = true,
				[7955]  = true,
				[10525] = true,
				[10529] = true,
				[10531] = true,
				[10533] = true,
				[24847] = true,
				[24851] = true,
				[24122] = true,
				[6702]  = true,
				[6703]  = true,
				[28473] = true,
				[28222] = true,
				[19050] = true,
				[19054] = true,
				[19058] = true,
				[19062] = true,
				[19066] = true,
				[20855] = true,
				[19074] = true,
				[19078] = true,
				[19082] = true,
				[19086] = true,
				[19090] = true,
				[19094] = true,
				[19098] = true,
				[22927] = true,
				[3816]  = true,
				[23190] = true,
				[23704] = true,
				[23708] = true,
				[3753]  = true,
				[9147]  = true,
				[8322]  = true,
				[10619] = true,
				[21943] = true,
				[19102] = true,
				[3756]  = true,
				[10482] = true,
				[9194]  = true,
				[2152]  = true,
				[24125] = true,
				[3780]  = true,
				[3759]  = true,
				[9062]  = true,
				[3760]  = true,
				[20648] = true,
				[3761]  = true,
				[10647] = true,
				[3762]  = true,
				[20649] = true,
				[3763]  = true,
				[20650] = true,
				[3764]  = true,
				[22331] = true,
				[3765]  = true,
				[5244]  = true,
				[3766]  = true,
				[9060]  = true,
				[3767]  = true,
				[24848] = true,
				[3768]  = true,
				[9145]  = true,
				[3769]  = true,
				[9149]  = true,
				[3770]  = true,
				[9193]  = true,
				[3771]  = true,
				[14930] = true,
				[3772]  = true,
				[24123] = true,
				[3773]  = true,
				[2881]  = true,
				[3774]  = true,
				[28219] = true,
				[28223] = true,
				[19047] = true,
				[19051] = true,
				[19055] = true,
				[19059] = true,
				[19063] = true,
				[19067] = true,
				[19071] = true,
				[24940] = true,
				[19079] = true,
				[19083] = true,
				[19087] = true,
				[19091] = true,
				[9197]  = true,
				[14932] = true,
				[22928] = true,
				[19107] = true,
				[9059]  = true,
				[23705] = true,
				[23709] = true,
				[9065]  = true,
				[23399] = true,
				[10490] = true,
				[3776]  = true,
				[26279] = true,
				[9201]  = true,
				[6705]  = true,
				[6704]  = true,
				[3777]  = true,
				[28474] = true,
				[19065] = true,
				[28221] = true,
				[22923] = true,
				[23707] = true,
				[4096]  = true,
				[10516] = true,
				[10518] = true,
				[10520] = true,
				[24849] = true,
				[28224] = true,
				[19049] = true,
				[3775]  = true,
				[3778]  = true,
				[9206]  = true,
				[3779]  = true,
				[19072] = true,
				[19095] = true,
				[19092] = true,
				[10542] = true,
				[10544] = true,
				[10546] = true,
				[10548] = true,
				[22921] = true,
				[10552] = true,
				[10554] = true,
				[10556] = true,
				[10558] = true,
				[10560] = true,
				[10562] = true,
				[24124] = true,
				[10566] = true,
				[10568] = true,
				[10570] = true,
				[28220] = true,
				[10574] = true,
				[19048] = true,
				[19052] = true,
				[23710] = true,
				[19060] = true,
				[19064] = true,
				[20853] = true,
				[9058]  = true,
				[19076] = true,
				[19080] = true,
				[19084] = true,
				[19088] = true,
				[9068]  = true,
				[9070]  = true,
				[9072]  = true,
				[19104] = true,
				[19070] = true,
				[2158]  = true,
				[23706] = true,
				[2159]  = true,
				[3817]  = true,
				[2160]  = true,
				[3818]  = true,
				[2161]  = true,
				[19061] = true,
				[2162]  = true,
				[19101] = true,
				[2163]  = true,
				[10630] = true,
				[2164]  = true,
				[19103] = true,
				[2165]  = true,
				[10564] = true,
				[2166]  = true,
				[9074]  = true,
				[2167]  = true,
				[19100] = true,
				[2168]  = true,
				[10650] = true,
				[2169]  = true,
				[2153]  = true,
				[9064]  = true,
				[9195]  = true,
				[10572] = true,
				[2149]  = true,
				[7133]  = true,
				[10632] = true,
				[7135]  = true,
				[24846] = true,
				[24850] = true,
				[19097] = true,
				[9146]  = true,
				[9148]  = true,
				[9198]  = true,
				[19075] = true,
				[24654] = true,
				[9207]  = true,
				[19068] = true,
				[24121] = true,
				[7147]  = true,
				[10621] = true,
				[7149]  = true,
				[28472] = true,
				[7151]  = true,
				[24655] = true,
				[7153]  = true,
				[19053] = true,
				[7126]  = true,
				[7156]  = true,
				[4097]  = true,
				[20854] = true,
				[19073] = true,
				[19077] = true,
				[19081] = true,
				[19085] = true,
				[19089] = true,
				[9196]  = true,
				[22922] = true,
				[22926] = true,
				[9202]  = true,
				[19093] = true,
				[23703] = true,
				[9208]  = true,
				[24703] = true,
			},
			[4] = {
				[17635] = true,
				[17637] = true,
				[26277] = true,
				[2333]  = true,
				[4508]  = true,
				[25146] = true,
				[2335]  = true,
				[7179]  = true,
				[3447]  = true,
				[7181]  = true,
				[3448]  = true,
				[2337]  = true,
				[17552] = true,
				[17554] = true,
				[17556] = true,
				[17560] = true,
				[17562] = true,
				[17564] = true,
				[17566] = true,
				[15833] = true,
				[17570] = true,
				[17572] = true,
				[17574] = true,
				[17576] = true,
				[17578] = true,
				[3452]  = true,
				[3230]  = true,
				[7255]  = true,
				[7256]  = true,
				[7257]  = true,
				[3450]  = true,
				[7258]  = true,
				[11448] = true,
				[7259]  = true,
				[7836]  = true,
				[11456] = true,
				[3170]  = true,
				[11449] = true,
				[7183]  = true,
				[3454]  = true,
				[3171]  = true,
				[3449]  = true,
				[8240]  = true,
				[11466] = true,
				[3172]  = true,
				[24266] = true,
				[7837]  = true,
				[17632] = true,
				[3173]  = true,
				[17636] = true,
				[17638] = true,
				[3453]  = true,
				[3174]  = true,
				[3451]  = true,
				[7841]  = true,
				[11468] = true,
				[3175]  = true,
				[22732] = true,
				[24368] = true,
				[11450] = true,
				[3176]  = true,
				[11478] = true,
				[7845]  = true,
				[2334]  = true,
				[3177]  = true,
				[24367] = true,
				[24365] = true,
				[24366] = true,
				[17571] = true,
				[17634] = true,
				[17551] = true,
				[17553] = true,
				[17555] = true,
				[17557] = true,
				[17559] = true,
				[17561] = true,
				[17563] = true,
				[17565] = true,
				[11451] = true,
				[11452] = true,
				[11453] = true,
				[17573] = true,
				[17575] = true,
				[17577] = true,
				[11457] = true,
				[11458] = true,
				[11459] = true,
				[11460] = true,
				[11461] = true,
				[2332]  = true,
				[17187] = true,
				[11464] = true,
				[11465] = true,
				[12609] = true,
				[11467] = true,
				[22808] = true,
				[6617]  = true,
				[21923] = true,
				[4942]  = true,
				[11472] = true,
				[11473] = true,
				[2329]  = true,
				[6624]  = true,
				[11476] = true,
				[11477] = true,
				[2330]  = true,
				[11479] = true,
				[11480] = true,
				[3188]  = true,
				[2331]  = true,
				[17580] = true,
				[6618]  = true,
			},
			[5] = {
				[19726] = true,
				[785]   = true,
				[19727] = true,
				[3369]  = true,
				[13468] = true,
				[3356]  = true,
				[8845]  = true,
				[2447]  = true,
				[2449]  = true,
				[3820]  = true,
				[2453]  = true,
				[3819]  = true,
				[3821]  = true,
				[3358]  = true,
				[8836]  = true,
				[13463] = true,
				[3355]  = true,
				[765]   = true,
				[13467] = true,
				[13464] = true,
				[3818]  = true,
				[4625]  = true,
				[8838]  = true,
				[8846]  = true,
				[2450]  = true,
				[8831]  = true,
				[8839]  = true,
				[13466] = true,
				[3357]  = true,
				[13465] = true,
			},
			[6] = {
				[15933] = true,
				[6412]  = true,
				[6413]  = true,
				[6414]  = true,
				[6415]  = true,
				[6416]  = true,
				[6417]  = true,
				[7751]  = true,
				[6418]  = true,
				[7752]  = true,
				[6419]  = true,
				[7753]  = true,
				[7754]  = true,
				[22761] = true,
				[7755]  = true,
				[24418] = true,
				[24801] = true,
				[25954] = true,
				[25704] = true,
				[20626] = true,
				[8604]  = true,
				[7827]  = true,
				[7828]  = true,
				[18239] = true,
				[18241] = true,
				[15853] = true,
				[18245] = true,
				[6499]  = true,
				[20916] = true,
				[6500]  = true,
				[8238]  = true,
				[6501]  = true,
				[15861] = true,
				[15863] = true,
				[15865] = true,
				[2538]  = true,
				[4094]  = true,
				[2539]  = true,
				[3397]  = true,
				[2540]  = true,
				[22480] = true,
				[3398]  = true,
				[25659] = true,
				[3399]  = true,
				[2542]  = true,
				[3400]  = true,
				[7213]  = true,
				[2544]  = true,
				[3370]  = true,
				[2545]  = true,
				[3371]  = true,
				[2546]  = true,
				[3372]  = true,
				[2547]  = true,
				[9513]  = true,
				[3373]  = true,
				[15906] = true,
				[21143] = true,
				[8607]  = true,
				[2543]  = true,
				[2548]  = true,
				[15910] = true,
				[15855] = true,
				[15856] = true,
				[13028] = true,
				[18238] = true,
				[15915] = true,
				[18242] = true,
				[18244] = true,
				[18246] = true,
				[18247] = true,
				[3377]  = true,
				[2541]  = true,
				[21175] = true,
				[2549]  = true,
				[3376]  = true,
				[18240] = true,
				[2795]  = true,
				[18243] = true,
				[15935] = true,
				[21144] = true,
			},
			[7] = {
				[10097] = true,
				[2657]  = true,
				[2658]  = true,
				[2659]  = true,
				[3304]  = true,
				[10098] = true,
				[22967] = true,
				[3569]  = true,
				[3307]  = true,
				[14891] = true,
				[16153] = true,
				[3308]  = true,
			},
			[8] = {
				[3849]  = true,
				[3850]  = true,
				[3851]  = true,
				[3852]  = true,
				[8465]  = true,
				[3854]  = true,
				[18404] = true,
				[3855]  = true,
				[18412] = true,
				[18416] = true,
				[18420] = true,
				[3857]  = true,
				[12053] = true,
				[18436] = true,
				[18440] = true,
				[18444] = true,
				[3860]  = true,
				[18452] = true,
				[18456] = true,
				[12067] = true,
				[3862]  = true,
				[12071] = true,
				[12073] = true,
				[8760]  = true,
				[12077] = true,
				[8764]  = true,
				[12081] = true,
				[6695]  = true,
				[8770]  = true,
				[8772]  = true,
				[12089] = true,
				[12091] = true,
				[12093] = true,
				[8780]  = true,
				[8782]  = true,
				[8784]  = true,
				[8786]  = true,
				[22867] = true,
				[28481] = true,
				[3872]  = true,
				[3873]  = true,
				[8802]  = true,
				[8804]  = true,
				[3755]  = true,
				[3757]  = true,
				[3758]  = true,
				[18401] = true,
				[18405] = true,
				[18409] = true,
				[18413] = true,
				[18417] = true,
				[18421] = true,
				[2963]  = true,
				[18437] = true,
				[18441] = true,
				[18445] = true,
				[18449] = true,
				[18453] = true,
				[18457] = true,
				[2964]  = true,
				[3839]  = true,
				[3865]  = true,
				[18560] = true,
				[26085] = true,
				[24091] = true,
				[26086] = true,
				[26087] = true,
				-- [27658] = true,
				[18407] = true,
				[27660] = true,
				[27724] = true,
				[12079] = true,
				[6686]  = true,
				[28207] = true,
				[6688]  = true,
				[7893]  = true,
				[6693]  = true,
				[22868] = true,
				[28482] = true,
				[12065] = true,
				[27725] = true,
				[18438] = true,
				[20848] = true,
				[3868]  = true,
				[6521]  = true,
				[23665] = true,
				[22759] = true,
				[8762]  = true,
				[8776]  = true,
				[8766]  = true,
				[3863]  = true,
				[2392]  = true,
				[3864]  = true,
				[12078] = true,
				[18410] = true,
				[2396]  = true,
				[12059] = true,
				[3858]  = true,
				[12088] = true,
				[8774]  = true,
				[3914]  = true,
				[8795]  = true,
				[2385]  = true,
				[2393]  = true,
				[2386]  = true,
				[12074] = true,
				[2387]  = true,
				[6690]  = true,
				[18402] = true,
				[18406] = true,
				[2389]  = true,
				[18414] = true,
				[18418] = true,
				[18422] = true,
				[12050] = true,
				[12052] = true,
				[18434] = true,
				[12056] = true,
				[18442] = true,
				[18446] = true,
				[18450] = true,
				[18454] = true,
				[18458] = true,
				[18448] = true,
				[12070] = true,
				[12072] = true,
				[2397]  = true,
				[12076] = true,
				[24092] = true,
				[12080] = true,
				[12082] = true,
				[12084] = true,
				[26403] = true,
				[26407] = true,
				[2401]  = true,
				[12092] = true,
				[2402]  = true,
				[28208] = true,
				[2403]  = true,
				[24901] = true,
				[3915]  = true,
				[8789]  = true,
				[8791]  = true,
				[8793]  = true,
				[2406]  = true,
				[8797]  = true,
				[20849] = true,
				[2394]  = true,
				[23662] = true,
				[23666] = true,
				[3866]  = true,
				[18424] = true,
				[3869]  = true,
				[3813]  = true,
				[3870]  = true,
				[8483]  = true,
				[3871]  = true,
				[8489]  = true,
				[12046] = true,
				[12061] = true,
				[12064] = true,
				[12075] = true,
				[12085] = true,
				[12044] = true,
				[12045] = true,
				[21945] = true,
				[7623]  = true,
				[7624]  = true,
				[12047] = true,
				[8758]  = true,
				[8799]  = true,
				[12049] = true,
				[7629]  = true,
				[7630]  = true,
				[18411] = true,
				[19435] = true,
				[7633]  = true,
				[18423] = true,
				[12060] = true,
				[18419] = true,
				[7892]  = true,
				[18439] = true,
				[7639]  = true,
				[18447] = true,
				[18451] = true,
				[18455] = true,
				[7643]  = true,
				[2395]  = true,
				[3856]  = true,
				[22869] = true,
				[18403] = true,
				[27659] = true,
				[24093] = true,
				[18415] = true,
				[3859]  = true,
				[22870] = true,
				[2399]  = true,
				[28210] = true,
				[23667] = true,
				[3861]  = true,
				[28205] = true,
				[28209] = true,
				[12086] = true,
				[24902] = true,
				[22866] = true,
				[28480] = true,
				[3843]  = true,
				[3840]  = true,
				[8467]  = true,
				[3841]  = true,
				[12066] = true,
				[3842]  = true,
				[23663] = true,
				[22902] = true,
				[12048] = true,
				[3844]  = true,
				[6692]  = true,
				[3845]  = true,
				[12055] = true,
				[18408] = true,
				[12069] = true,
				[3847]  = true,
				[24903] = true,
				[3848]  = true,
				[23664] = true,
				[22813] = true,
			},
			[9] = {
				[3977]  = true,
				[3978]  = true,
				[3979]  = true,
				[15633] = true,
				[22795] = true,
				[12585] = true,
				[12587] = true,
				[12589] = true,
				[23078] = true,
				[23082] = true,
				[12595] = true,
				[12597] = true,
				[12599] = true,
				[12603] = true,
				[19791] = true,
				[12607] = true,
				[19799] = true,
				[12615] = true,
				[12617] = true,
				[19819] = true,
				[12621] = true,
				[19831] = true,
				[6458]  = true,
				[12902] = true,
				[12906] = true,
				[12908] = true,
				[26011] = true,
				[22704] = true,
				[23489] = true,
				[15255] = true,
				[23067] = true,
				[23071] = true,
				[12717] = true,
				[23079] = true,
				[19788] = true,
				[26422] = true,
				[26426] = true,
				[19800] = true,
				[26442] = true,
				[12755] = true,
				[12759] = true,
				[21940] = true,
				[28327] = true,
				[23486] = true,
				[3918]  = true,
				[12895] = true,
				[3919]  = true,
				[8334]  = true,
				[3920]  = true,
				[23070] = true,
				[23077] = true,
				[19567] = true,
				[3922]  = true,
				[23096] = true,
				[3923]  = true,
				[3925]  = true,
				[3924]  = true,
				[3944]  = true,
				[22793] = true,
				[22797] = true,
				[3926]  = true,
				[23129] = true,
				[9269]  = true,
				[12586] = true,
				[9273]  = true,
				[12590] = true,
				[3929]  = true,
				[12594] = true,
				[12596] = true,
				[12619] = true,
				[3931]  = true,
				[12715] = true,
				[3932]  = true,
				[26423] = true,
				[26427] = true,
				[9271]  = true,
				[3934]  = true,
				[12614] = true,
				[12616] = true,
				[12618] = true,
				[12620] = true,
				[12622] = true,
				[12624] = true,
				[19833] = true,
				[3938]  = true,
				[3965]  = true,
				[3939]  = true,
				[19814] = true,
				[3940]  = true,
				[3933]  = true,
				[3941]  = true,
				[12897] = true,
				[3942]  = true,
				[3936]  = true,
				[12903] = true,
				[12905] = true,
				[12907] = true,
				[23080] = true,
				[3945]  = true,
				[3928]  = true,
				[3946]  = true,
				[15628] = true,
				[3947]  = true,
				[19793] = true,
				[3937]  = true,
				[19792] = true,
				[3949]  = true,
				[8339]  = true,
				[3950]  = true,
				[23507] = true,
				[19794] = true,
				[19796] = true,
				[3952]  = true,
				[23066] = true,
				[3953]  = true,
				[12760] = true,
				[3954]  = true,
				[12584] = true,
				[3955]  = true,
				[26421] = true,
				[3956]  = true,
				[26418] = true,
				[3957]  = true,
				[12899] = true,
				[3958]  = true,
				[19830] = true,
				[3959]  = true,
				[23069] = true,
				[3960]  = true,
				[12718] = true,
				[24356] = true,
				[8243]  = true,
				[3962]  = true,
				[3961]  = true,
				[3963]  = true,
				[26416] = true,
				[19790] = true,
				[26424] = true,
				[26428] = true,
				[3930]  = true,
				[3966]  = true,
				[26425] = true,
				[3967]  = true,
				[26420] = true,
				[3968]  = true,
				[23081] = true,
				[3969]  = true,
				[12754] = true,
				[23068] = true,
				[12758] = true,
				[3971]  = true,
				[19795] = true,
				[3972]  = true,
				[26443] = true,
				[3973]  = true,
				[26417] = true,
				[8895]  = true,
				[19825] = true,
				[12591] = true,
				[19815] = true,
				[24357] = true,
				[7430]  = true,
			},
			[10] = {
				[7426]  = true,
				[7428]  = true,
				[13822] = true,
				[7443]  = true,
				[13836] = true,
				[23799] = true,
				[25078] = true,
				[25082] = true,
				[25086] = true,
				[7454]  = true,
				[13858] = true,
				[13607] = true,
				[20014] = true,
				[13868] = true,
				[20026] = true,
				[20030] = true,
				[20034] = true,
				[13882] = true,
				[13631] = true,
				[13378] = true,
				[13380] = true,
				[13637] = true,
				[13898] = true,
				[13653] = true,
				[13655] = true,
				[13657] = true,
				[13659] = true,
				[13661] = true,
				[13663] = true,
				[7745]  = true,
				[21931] = true,
				[7748]  = true,
				[13687] = true,
				[13689] = true,
				[13948] = true,
				[13695] = true,
				[7766]  = true,
				[23800] = true,
				[23804] = true,
				[25083] = true,
				[7771]  = true,
				[7776]  = true,
				[20015] = true,
				[20023] = true,
				[25127] = true,
				[20031] = true,
				[20035] = true,
				[7786]  = true,
				[7788]  = true,
				[7793]  = true,
				[7795]  = true,
				[13522] = true,
				[14293] = true,
				[14807] = true,
				[14809] = true,
				[13536] = true,
				[13538] = true,
				[15596] = true,
				[13815] = true,
				[13817] = true,
				[27837] = true,
				[22749] = true,
				[13841] = true,
				[25072] = true,
				[23801] = true,
				[25080] = true,
				[25084] = true,
				[20008] = true,
				[20012] = true,
				[20016] = true,
				[13612] = true,
				[25124] = true,
				[25128] = true,
				[20032] = true,
				[20036] = true,
				[13622] = true,
				[13626] = true,
				[13628] = true,
				[13887] = true,
				[13640] = true,
				[7857]  = true,
				[13644] = true,
				[13646] = true,
				[13648] = true,
				[7861]  = true,
				[7863]  = true,
				[13915] = true,
				[13917] = true,
				[13419] = true,
				[13421] = true,
				[13933] = true,
				[13935] = true,
				[13937] = true,
				[13939] = true,
				[13941] = true,
				[13943] = true,
				[13945] = true,
				[13947] = true,
				[7418]  = true,
				[13698] = true,
				[13700] = true,
				[22750] = true,
				[7457]  = true,
				[7782]  = true,
				[7779]  = true,
				[7859]  = true,
				[14810] = true,
				[13642] = true,
				[25073] = true,
				[23802] = true,
				[25081] = true,
				[17180] = true,
				[13846] = true,
				[13931] = true,
				[25130] = true,
				[20010] = true,
				[25126] = true,
				[20009] = true,
				[20013] = true,
				[20017] = true,
				[13485] = true,
				[25125] = true,
				[25129] = true,
				[13746] = true,
				[20011] = true,
				[13905] = true,
				[7867]  = true,
				[25079] = true,
				[13501] = true,
				[13503] = true,
				[17181] = true,
				[25074] = true,
				[13620] = true,
				[23803] = true,
				[13617] = true,
				[13693] = true,
				[20025] = true,
				[20029] = true,
				[20033] = true,
				[13702] = true,
				[20028] = true,
				[20051] = true,
				[13529] = true,
				[13890] = true,
				[7420]  = true,
				[7421]  = true,
				[13464] = true,
				[13794] = true,
				[20020] = true,
				[13635] = true,
				[20024] = true,
			},
			[13] = {
				[11343] = true,
				[13220] = true,
				[13228] = true,
				[8687]  = true,
				[13229] = true,
				[3420]  = true,
				[8681]  = true,
				[2835]  = true,
				[2837]  = true,
				[6510]  = true,
				[25347] = true,
				[11341] = true,
				[5763]  = true,
				[11357] = true,
				[8694]  = true,
				[11342] = true,
				[11400] = true,
				[11358] = true,
				[13230] = true,
				[8691]  = true,
			},
		};
		-- [xid] = {  };
		local recipe_filter = {				-- 6 VALID RECIPE
			[1] = {
				[6451]  = true,
				[6452]  = true,
				[6453]  = true,
				[14530] = true,
				[1251]  = true,
				[3530]  = true,
				[8545]  = true,
				[3531]  = true,
				[14529] = true,
				[8544]  = true,
				[2581]  = true,
				[6450]  = true,
				[19440] = true,
			},
			[2] = {
				[7936]  = true,
				[3849]  = true,
				[12784] = true,
				[7939]  = true,
				[22197] = true,
				[3851]  = true,
				[7942]  = true,
				[3852]  = true,
				[7944]  = true,
				[3853]  = true,
				[7946]  = true,
				[3854]  = true,
				[19169] = true,
				[3855]  = true,
				[3473]  = true,
				[15870] = true,
				[15872] = true,
				[22763] = true,
				[7955]  = true,
				[7956]  = true,
				[7957]  = true,
				[7958]  = true,
				[7959]  = true,
				[7960]  = true,
				[7961]  = true,
				[7963]  = true,
				[7964]  = true,
				[7965]  = true,
				[7966]  = true,
				[7967]  = true,
				[3482]  = true,
				[2845]  = true,
				[3483]  = true,
				[3484]  = true,
				[2847]  = true,
				[3485]  = true,
				[2848]  = true,
				[3486]  = true,
				[2849]  = true,
				[3487]  = true,
				[2850]  = true,
				[3488]  = true,
				[2851]  = true,
				[3489]  = true,
				[17014] = true,
				[3490]  = true,
				[2853]  = true,
				[12625] = true,
				[22385] = true,
				[3492]  = true,
				[12631] = true,
				[12633] = true,
				[3239]  = true,
				[12639] = true,
				[3240]  = true,
				[12643] = true,
				[3241]  = true,
				[6214]  = true,
				[2862]  = true,
				[12406] = true,
				[2863]  = true,
				[12410] = true,
				[2864]  = true,
				[12414] = true,
				[12416] = true,
				[12418] = true,
				[19166] = true,
				[12422] = true,
				[12424] = true,
				[9366]  = true,
				[19692] = true,
				[2869]  = true,
				[22764] = true,
				[2870]  = true,
				[2871]  = true,
				[17704] = true,
				[12619] = true,
				[12641] = true,
				[7947]  = true,
				[3847]  = true,
				[7931]  = true,
				[12798] = true,
				[3469]  = true,
				[22383] = true,
				[12613] = true,
				[20039] = true,
				[22669] = true,
				[18262] = true,
				[3845]  = true,
				[11604] = true,
				[2852]  = true,
				[19043] = true,
				[11608] = true,
				[19051] = true,
				[17015] = true,
				[12620] = true,
				[12794] = true,
				[12782] = true,
				[2857]  = true,
				[3844]  = true,
				[12776] = true,
				[11607] = true,
				[19164] = true,
				[3472]  = true,
				[7071]  = true,
				[12259] = true,
				[2854]  = true,
				[12773] = true,
				[12775] = true,
				[12777] = true,
				[3471]  = true,
				[12781] = true,
				[12783] = true,
				[22191] = true,
				[22195] = true,
				[20549] = true,
				[3470]  = true,
				[7919]  = true,
				[6731]  = true,
				[12797] = true,
				[12636] = true,
				[12427] = true,
				[19167] = true,
				[12428] = true,
				[12405] = true,
				[15869] = true,
				[19693] = true,
				[6040]  = true,
				[6041]  = true,
				[6042]  = true,
				[6043]  = true,
				[20551] = true,
				[12426] = true,
				[3491]  = true,
				[3474]  = true,
				[11144] = true,
				[3837]  = true,
				[5540]  = true,
				[5541]  = true,
				[22384] = true,
				[12420] = true,
				[2868]  = true,
				[7969]  = true,
				[11605] = true,
				[12260] = true,
				[2866]  = true,
				[22194] = true,
				[2865]  = true,
				[12796] = true,
				[20550] = true,
				[7921]  = true,
				[16988] = true,
				[19694] = true,
				[12610] = true,
				[12612] = true,
				[12614] = true,
				[19048] = true,
				[12618] = true,
				[17016] = true,
				[12404] = true,
				[12624] = true,
				[11606] = true,
				[12628] = true,
				[9060]  = true,
				[12632] = true,
				[19170] = true,
				[16206] = true,
				[15871] = true,
				[12640] = true,
				[22670] = true,
				[6338]  = true,
				[12792] = true,
				[7913]  = true,
				[3840]  = true,
				[3481]  = true,
				[3480]  = true,
				[19695] = true,
				[11128] = true,
				[22196] = true,
				[7935]  = true,
				[12409] = true,
				[19148] = true,
				[6350]  = true,
				[12415] = true,
				[12417] = true,
				[12419] = true,
				[19168] = true,
				[3846]  = true,
				[12425] = true,
				[19690] = true,
				[12429] = true,
				[7933]  = true,
				[22762] = true,
				[3856]  = true,
				[3850]  = true,
				[7920]  = true,
				[7937]  = true,
				[7938]  = true,
				[2844]  = true,
				[3478]  = true,
				[22198] = true,
				[7941]  = true,
				[12644] = true,
				[19691] = true,
				[7943]  = true,
				[7945]  = true,
				[10421] = true,
				[10423] = true,
				[17193] = true,
				[12408] = true,
				[12790] = true,
				[3835]  = true,
				[12645] = true,
				[3836]  = true,
				[7954]  = true,
				[16989] = true,
				[7914]  = true,
				[7915]  = true,
				[7916]  = true,
				[7917]  = true,
				[7918]  = true,
				[17013] = true,
				[19057] = true,
				[3841]  = true,
				[7922]  = true,
				[3842]  = true,
				[7924]  = true,
				[3843]  = true,
				[7926]  = true,
				[7927]  = true,
				[7928]  = true,
				[7929]  = true,
				[7930]  = true,
				[22671] = true,
				[7932]  = true,
				[12774] = true,
				[7934]  = true,
				[3848]  = true,
				[7166]  = true,
			},
			[3] = {
				[8191]  = true,
				[2319]  = true,
				[15079] = true,
				[15081] = true,
				[15083] = true,
				[15085] = true,
				[15087] = true,
				[19149] = true,
				[15091] = true,
				[19157] = true,
				[15095] = true,
				[8212]  = true,
				[8214]  = true,
				[8216]  = true,
				[8218]  = true,
				[22759] = true,
				[20476] = true,
				[20480] = true,
				[18504] = true,
				[18508] = true,
				[16982] = true,
				[20380] = true,
				[8210]  = true,
				[19163] = true,
				[6709]  = true,
				[2308]  = true,
				[8205]  = true,
				[2314]  = true,
				[18506] = true,
				[15094] = true,
				[15049] = true,
				[8346]  = true,
				[15075] = true,
				[22664] = true,
				[15048] = true,
				[15072] = true,
				[6466]  = true,
				[6467]  = true,
				[6468]  = true,
				[8207]  = true,
				[5958]  = true,
				[5961]  = true,
				[5962]  = true,
				[5963]  = true,
				[5964]  = true,
				[5965]  = true,
				[5966]  = true,
				[5957]  = true,
				[2311]  = true,
				[20296] = true,
				[19162] = true,
				[8345]  = true,
				[19685] = true,
				[15064] = true,
				[19688] = true,
				[8348]  = true,
				[15067] = true,
				[22760] = true,
				[20295] = true,
				[7377]  = true,
				[20477] = true,
				[20481] = true,
				[8209]  = true,
				[8197]  = true,
				[15062] = true,
				[4455]  = true,
				[4456]  = true,
				[22661] = true,
				[4253]  = true,
				[21278] = true,
				[15096] = true,
				[15073] = true,
				[2317]  = true,
				[8367]  = true,
				[18238] = true,
				[2316]  = true,
				[2315]  = true,
				[5739]  = true,
				[18509] = true,
				[16983] = true,
				[2313]  = true,
				[7276]  = true,
				[7277]  = true,
				[7278]  = true,
				[7279]  = true,
				[7280]  = true,
				[7281]  = true,
				[7282]  = true,
				[7283]  = true,
				[15046] = true,
				[7285]  = true,
				[15050] = true,
				[15052] = true,
				[15054] = true,
				[15056] = true,
				[15058] = true,
				[4231]  = true,
				[22665] = true,
				[4233]  = true,
				[4234]  = true,
				[15068] = true,
				[15070] = true,
				[4237]  = true,
				[15074] = true,
				[4239]  = true,
				[8193]  = true,
				[15080] = true,
				[4242]  = true,
				[4243]  = true,
				[4244]  = true,
				[8203]  = true,
				[4246]  = true,
				[4247]  = true,
				[4248]  = true,
				[4249]  = true,
				[4250]  = true,
				[5781]  = true,
				[4252]  = true,
				[19689] = true,
				[4254]  = true,
				[4255]  = true,
				[4256]  = true,
				[4257]  = true,
				[4258]  = true,
				[20478] = true,
				[4260]  = true,
				[7375]  = true,
				[4262]  = true,
				[2310]  = true,
				[4264]  = true,
				[4265]  = true,
				[15061] = true,
				[2309]  = true,
				[4236]  = true,
				[15066] = true,
				[15138] = true,
				[17721] = true,
				[19058] = true,
				[15090] = true,
				[15082] = true,
				[7284]  = true,
				[18251] = true,
				[18510] = true,
				[16984] = true,
				[15063] = true,
				[20575] = true,
				[19687] = true,
				[15078] = true,
				[19044] = true,
				[15084] = true,
				[19052] = true,
				[15077] = true,
				[8215]  = true,
				[7348]  = true,
				[7349]  = true,
				[8208]  = true,
				[8206]  = true,
				[7352]  = true,
				[8213]  = true,
				[8202]  = true,
				[22662] = true,
				[22666] = true,
				[19686] = true,
				[7358]  = true,
				[7359]  = true,
				[8211]  = true,
				[8204]  = true,
				[15088] = true,
				[19049] = true,
				[4304]  = true,
				[15093] = true,
				[8187]  = true,
				[22761] = true,
				[4251]  = true,
				[8189]  = true,
				[15045] = true,
				[7371]  = true,
				[7372]  = true,
				[7373]  = true,
				[7374]  = true,
				[18662] = true,
				[5081]  = true,
				[8347]  = true,
				[7378]  = true,
				[4259]  = true,
				[5780]  = true,
				[15564] = true,
				[8217]  = true,
				[20479] = true,
				[8201]  = true,
				[15060] = true,
				[7386]  = true,
				[7387]  = true,
				[8200]  = true,
				[2300]  = true,
				[7390]  = true,
				[7391]  = true,
				[15407] = true,
				[2302]  = true,
				[8198]  = true,
				[2303]  = true,
				[8192]  = true,
				[2304]  = true,
				[15076] = true,
				[8349]  = true,
				[15086] = true,
				[18511] = true,
				[5782]  = true,
				[2307]  = true,
				[15092] = true,
				[8170]  = true,
				[5783]  = true,
				[8172]  = true,
				[8173]  = true,
				[8174]  = true,
				[8175]  = true,
				[8176]  = true,
				[15047] = true,
				[2312]  = true,
				[15051] = true,
				[15053] = true,
				[15055] = true,
				[15057] = true,
				[15059] = true,
				[22663] = true,
				[8185]  = true,
				[15065] = true,
				[3719]  = true,
				[15069] = true,
				[15071] = true,
				[2318]  = true,
				[18948] = true,
			},
			[4] = {
				[3824]  = true,
				[2459]  = true,
				[8949]  = true,
				[19931] = true,
				[8951]  = true,
				[9206]  = true,
				[3826]  = true,
				[3382]  = true,
				[8956]  = true,
				[3827]  = true,
				[3383]  = true,
				[3828]  = true,
				[6037]  = true,
				[3384]  = true,
				[3829]  = true,
				[3385]  = true,
				[9224]  = true,
				[3386]  = true,
				[3577]  = true,
				[3387]  = true,
				[13423] = true,
				[9233]  = true,
				[3928]  = true,
				[3389]  = true,
				[6048]  = true,
				[6049]  = true,
				[3390]  = true,
				[6050]  = true,
				[6051]  = true,
				[3391]  = true,
				[6052]  = true,
				[12803] = true,
				[5633]  = true,
				[6371]  = true,
				[13444] = true,
				[13442] = true,
				[12808] = true,
				[6373]  = true,
				[13445] = true,
				[13446] = true,
				[13447] = true,
				[9088]  = true,
				[118]   = true,
				[9264]  = true,
				[5634]  = true,
				[5996]  = true,
				[7076]  = true,
				[5997]  = true,
				[13455] = true,
				[13456] = true,
				[13457] = true,
				[13458] = true,
				[13459] = true,
				[12190] = true,
				[7080]  = true,
				[13462] = true,
				[6370]  = true,
				[9210]  = true,
				[929]   = true,
				[3825]  = true,
				[9149]  = true,
				[17708] = true,
				[13454] = true,
				[18294] = true,
				[2457]  = true,
				[858]   = true,
				[9155]  = true,
				[10592] = true,
				[9030]  = true,
				[9179]  = true,
				[13452] = true,
				[12360] = true,
				[2456]  = true,
				[9154]  = true,
				[9036]  = true,
				[9144]  = true,
				[13461] = true,
				[5631]  = true,
				[7078]  = true,
				[13453] = true,
				[13443] = true,
				[1710]  = true,
				[13506] = true,
				[9172]  = true,
				[2458]  = true,
				[20007] = true,
				[3823]  = true,
				[20002] = true,
				[20004] = true,
				[6372]  = true,
				[20008] = true,
				[2454]  = true,
				[3388]  = true,
				[4623]  = true,
				[18253] = true,
				[2455]  = true,
				[13503] = true,
				[21546] = true,
				[9187]  = true,
				[9061]  = true,
				[7082]  = true,
				[7068]  = true,
				[4596]  = true,
				[13510] = true,
				[13511] = true,
				[13512] = true,
				[13513] = true,
				[6662]  = true,
				[9197]  = true,
				[6149]  = true,
			},
			[5] = {
				[13464] = true,
				[4236]  = true,
			},
			[6] = {
				[3665]  = true,
				[2681]  = true,
				[3729]  = true,
				[3666]  = true,
				[21072] = true,
				[2683]  = true,
				[5525]  = true,
				[16766] = true,
				[5526]  = true,
				[2684]  = true,
				[20074] = true,
				[6290]  = true,
				[2685]  = true,
				[6038]  = true,
				[2687]  = true,
				[1082]  = true,
				[13927] = true,
				[5472]  = true,
				[13929] = true,
				[13930] = true,
				[13931] = true,
				[5474]  = true,
				[17197] = true,
				[13934] = true,
				[13935] = true,
				[5095]  = true,
				[5477]  = true,
				[5478]  = true,
				[21023] = true,
				[5479]  = true,
				[5480]  = true,
				[4592]  = true,
				[4593]  = true,
				[4594]  = true,
				[8364]  = true,
				[6887]  = true,
				[6316]  = true,
				[6888]  = true,
				[6890]  = true,
				[20452] = true,
				[18045] = true,
				[13851] = true,
				[1017]  = true,
				[787]   = true,
				[12210] = true,
				[10841] = true,
				[12212] = true,
				[12213] = true,
				[12214] = true,
				[12215] = true,
				[12216] = true,
				[724]   = true,
				[12218] = true,
				[17198] = true,
				[2888]  = true,
				[13928] = true,
				[12217] = true,
				[13932] = true,
				[12224] = true,
				[13933] = true,
				[7676]  = true,
				[3220]  = true,
				[733]   = true,
				[5473]  = true,
				[2682]  = true,
				[17222] = true,
				[12209] = true,
				[6657]  = true,
				[3662]  = true,
				[5476]  = true,
				[3726]  = true,
				[5527]  = true,
				[3663]  = true,
				[18254] = true,
				[3727]  = true,
				[21217] = true,
				[3664]  = true,
				[2680]  = true,
				[3728]  = true,
				[4457]  = true,
				[2679]  = true,
			},
			[7] = {
				[17771] = true,
				[3577]  = true,
				[6037]  = true,
				[12359] = true,
				[3860]  = true,
				[11371] = true,
				[3576]  = true,
				[3575]  = true,
				[2842]  = true,
				[2840]  = true,
				[2841]  = true,
				[3859]  = true,
			},
			[8] = {
				[2575]  = true,
				[2576]  = true,
				[2577]  = true,
				[2578]  = true,
				[2579]  = true,
				[9999]  = true,
				[18408] = true,
				[10003] = true,
				[14342] = true,
				[22249] = true,
				[2583]  = true,
				[2584]  = true,
				[10019] = true,
				[10021] = true,
				[14103] = true,
				[10025] = true,
				[10027] = true,
				[10029] = true,
				[13856] = true,
				[13858] = true,
				[13860] = true,
				[13864] = true,
				[13866] = true,
				[13868] = true,
				[10045] = true,
				[10047] = true,
				[10051] = true,
				[10053] = true,
				[10055] = true,
				[14137] = true,
				[14139] = true,
				[14141] = true,
				[14143] = true,
				[21341] = true,
				[19050] = true,
				[14153] = true,
				[14155] = true,
				[22652] = true,
				[22660] = true,
				[21154] = true,
				[13870] = true,
				[10033] = true,
				[22756] = true,
				[21542] = true,
				[10042] = true,
				[18405] = true,
				[18409] = true,
				[18413] = true,
				[14042] = true,
				[2996]  = true,
				[10004] = true,
				[2997]  = true,
				[10041] = true,
				[5770]  = true,
				[4311]  = true,
				[9998]  = true,
				[6238]  = true,
				[6239]  = true,
				[6240]  = true,
				[6241]  = true,
				[6242]  = true,
				[18486] = true,
				[2587]  = true,
				[10018] = true,
				[7061]  = true,
				[14104] = true,
				[19047] = true,
				[7057]  = true,
				[20537] = true,
				[5764]  = true,
				[22655] = true,
				[16979] = true,
				[10054] = true,
				[4315]  = true,
				[19165] = true,
				[2582]  = true,
				[19683] = true,
				[14101] = true,
				[21342] = true,
				[7026]  = true,
				[19684] = true,
				[19059] = true,
				[6264]  = true,
				[22248] = true,
				[13869] = true,
				[10031] = true,
				[7046]  = true,
				[14106] = true,
				[10009] = true,
				[6263]  = true,
				[5762]  = true,
				[5763]  = true,
				[14046] = true,
				[5765]  = true,
				[6786]  = true,
				[6787]  = true,
				[4238]  = true,
				[6384]  = true,
				[4240]  = true,
				[4241]  = true,
				[7047]  = true,
				[7048]  = true,
				[7049]  = true,
				[7050]  = true,
				[7051]  = true,
				[7052]  = true,
				[7053]  = true,
				[7054]  = true,
				[7055]  = true,
				[7056]  = true,
				[10002] = true,
				[7058]  = true,
				[7059]  = true,
				[10008] = true,
				[22251] = true,
				[7062]  = true,
				[7063]  = true,
				[7064]  = true,
				[7065]  = true,
				[14100] = true,
				[14107] = true,
				[10024] = true,
				[10026] = true,
				[14108] = true,
				[10030] = true,
				[14112] = true,
				[10034] = true,
				[10036] = true,
				[13863] = true,
				[13865] = true,
				[13867] = true,
				[10044] = true,
				[20538] = true,
				[14128] = true,
				[14130] = true,
				[14132] = true,
				[14134] = true,
				[14136] = true,
				[14138] = true,
				[14140] = true,
				[14142] = true,
				[14144] = true,
				[14146] = true,
				[15802] = true,
				[19056] = true,
				[14152] = true,
				[14154] = true,
				[14156] = true,
				[10048] = true,
				[17723] = true,
				[10046] = true,
				[22654] = true,
				[22658] = true,
				[10052] = true,
				[10056] = true,
				[6796]  = true,
				[4320]  = true,
				[6795]  = true,
				[14111] = true,
				[4245]  = true,
				[4319]  = true,
				[13871] = true,
				[18407] = true,
				[4305]  = true,
				[2585]  = true,
				[4307]  = true,
				[4308]  = true,
				[4309]  = true,
				[4310]  = true,
				[19156] = true,
				[4312]  = true,
				[4313]  = true,
				[4314]  = true,
				[19682] = true,
				[4316]  = true,
				[4317]  = true,
				[4318]  = true,
				[22758] = true,
				[22252] = true,
				[4321]  = true,
				[4322]  = true,
				[4323]  = true,
				[4324]  = true,
				[4325]  = true,
				[4326]  = true,
				[4327]  = true,
				[4328]  = true,
				[4329]  = true,
				[4330]  = true,
				[4331]  = true,
				[4332]  = true,
				[4333]  = true,
				[4334]  = true,
				[4335]  = true,
				[4336]  = true,
				[2580]  = true,
				[20539] = true,
				[4339]  = true,
				[10040] = true,
				[22757] = true,
				[14048] = true,
				[4343]  = true,
				[4344]  = true,
				[6385]  = true,
				[7060]  = true,
				[21340] = true,
				[10001] = true,
				[5542]  = true,
				[10007] = true,
				[14044] = true,
				[10023] = true,
				[18263] = true,
				[10028] = true,
				[2568]  = true,
				[10035] = true,
				[2569]  = true,
				[13857] = true,
				[2570]  = true,
				[14043] = true,
				[14045] = true,
				[16980] = true,
				[2572]  = true,
				[10050] = true,
				[22246] = true,
				[5766]  = true,
				[18258] = true,
			},
			[9] = {
				[4366]  = true,
				[4367]  = true,
				[4368]  = true,
				[15846] = true,
				[4370]  = true,
				[18631] = true,
				[4372]  = true,
				[18639] = true,
				[4374]  = true,
				[10503] = true,
				[4376]  = true,
				[10507] = true,
				[4378]  = true,
				[4379]  = true,
				[10513] = true,
				[4381]  = true,
				[4382]  = true,
				[4383]  = true,
				[4384]  = true,
				[4385]  = true,
				[4386]  = true,
				[4387]  = true,
				[4388]  = true,
				[4389]  = true,
				[4390]  = true,
				[4391]  = true,
				[4392]  = true,
				[4393]  = true,
				[4394]  = true,
				[21277] = true,
				[18986] = true,
				[4397]  = true,
				[4398]  = true,
				[11826] = true,
				[4401]  = true,
				[10559] = true,
				[10561] = true,
				[4405]  = true,
				[4406]  = true,
				[4407]  = true,
				[21592] = true,
				[10587] = true,
				[6714]  = true,
				[9318]  = true,
				[18588] = true,
				[22728] = true,
				[21716] = true,
				[18660] = true,
				[15994] = true,
				[15996] = true,
				[10645] = true,
				[16004] = true,
				[16006] = true,
				[16008] = true,
				[16022] = true,
				[19999] = true,
				[17716] = true,
				[21557] = true,
				[16040] = true,
				[21569] = true,
				[21589] = true,
				[18282] = true,
				[10713] = true,
				[10721] = true,
				[10725] = true,
				[5507]  = true,
				[6533]  = true,
				[8067]  = true,
				[8068]  = true,
				[8069]  = true,
				[18637] = true,
				[18641] = true,
				[18645] = true,
				[10504] = true,
				[10506] = true,
				[10508] = true,
				[10510] = true,
				[10512] = true,
				[10514] = true,
				[10518] = true,
				[10542] = true,
				[18984] = true,
				[10546] = true,
				[10548] = true,
				[11825] = true,
				[21558] = true,
				[10558] = true,
				[10560] = true,
				[10562] = true,
				[21574] = true,
				[11590] = true,
				[21590] = true,
				[10576] = true,
				[10586] = true,
				[9313]  = true,
				[18594] = true,
				[19998] = true,
				[7189]  = true,
				[19026] = true,
				[4404]  = true,
				[21570] = true,
				[16000] = true,
				[18634] = true,
				[18638] = true,
				[10588] = true,
				[4396]  = true,
				[4395]  = true,
				[21714] = true,
				[21718] = true,
				[15993] = true,
				[15995] = true,
				[15997] = true,
				[15999] = true,
				[18168] = true,
				[21576] = true,
				[16005] = true,
				[16007] = true,
				[16009] = true,
				[10500] = true,
				[10543] = true,
				[4403]  = true,
				[4377]  = true,
				[10724] = true,
				[10726] = true,
				[16023] = true,
				[10727] = true,
				[4380]  = true,
				[4369]  = true,
				[6712]  = true,
				[18232] = true,
				[4373]  = true,
				[4360]  = true,
				[21559] = true,
				[10498] = true,
				[10499] = true,
				[21571] = true,
				[4852]  = true,
				[7148]  = true,
				[10501] = true,
				[10502] = true,
				[7506]  = true,
				[10505] = true,
				[18283] = true,
				[10644] = true,
				[10646] = true,
				[4375]  = true,
				[10545] = true,
				[15992] = true,
				[10716] = true,
				[9312]  = true,
				[10720] = true,
				[4357]  = true,
				[4358]  = true,
				[4359]  = true,
				[18587] = true,
				[4361]  = true,
				[4362]  = true,
				[4363]  = true,
				[4364]  = true,
				[4365]  = true,
				[4371]  = true,
				[6219]  = true,
			},
			[10] = {
				[7426]  = true,
				[7428]  = true,
				[13822] = true,
				[7443]  = true,
				[13836] = true,
				[23799] = true,
				[25078] = true,
				[25082] = true,
				[25086] = true,
				[7454]  = true,
				[13858] = true,
				[20010] = true,
				[20014] = true,
				[13868] = true,
				[20026] = true,
				[20030] = true,
				[20034] = true,
				[13882] = true,
				[13631] = true,
				[13378] = true,
				[13380] = true,
				[13637] = true,
				[13898] = true,
				[13653] = true,
				[13655] = true,
				[13657] = true,
				[13659] = true,
				[13661] = true,
				[13663] = true,
				[7745]  = true,
				[21931] = true,
				[7748]  = true,
				[13687] = true,
				[13689] = true,
				[13948] = true,
				[13695] = true,
				[7766]  = true,
				[23800] = true,
				[23804] = true,
				[25083] = true,
				[7771]  = true,
				[7776]  = true,
				[20015] = true,
				[20023] = true,
				[25127] = true,
				[20031] = true,
				[20035] = true,
				[7786]  = true,
				[7788]  = true,
				[7793]  = true,
				[7795]  = true,
				[13522] = true,
				[14293] = true,
				[14807] = true,
				[14809] = true,
				[13536] = true,
				[13538] = true,
				[15596] = true,
				[13815] = true,
				[13817] = true,
				[27837] = true,
				[22749] = true,
				[13841] = true,
				[25072] = true,
				[23801] = true,
				[25080] = true,
				[25084] = true,
				[20008] = true,
				[20012] = true,
				[20016] = true,
				[13612] = true,
				[25124] = true,
				[25128] = true,
				[20032] = true,
				[20036] = true,
				[13622] = true,
				[13626] = true,
				[13628] = true,
				[13887] = true,
				[13640] = true,
				[7857]  = true,
				[13644] = true,
				[7859]  = true,
				[13648] = true,
				[7861]  = true,
				[7863]  = true,
				[13915] = true,
				[13917] = true,
				[13419] = true,
				[13931] = true,
				[13933] = true,
				[13935] = true,
				[13937] = true,
				[13939] = true,
				[13941] = true,
				[13943] = true,
				[13945] = true,
				[13947] = true,
				[20024] = true,
				[13698] = true,
				[13700] = true,
				[22750] = true,
				[13635] = true,
				[20020] = true,
				[7779]  = true,
				[13464] = true,
				[7421]  = true,
				[25130] = true,
				[25073] = true,
				[23802] = true,
				[25081] = true,
				[17180] = true,
				[13890] = true,
				[13529] = true,
				[20051] = true,
				[20028] = true,
				[13702] = true,
				[20009] = true,
				[20013] = true,
				[20017] = true,
				[13485] = true,
				[25125] = true,
				[25129] = true,
				[13746] = true,
				[20033] = true,
				[20029] = true,
				[20025] = true,
				[13693] = true,
				[13501] = true,
				[13503] = true,
				[13617] = true,
				[23803] = true,
				[13620] = true,
				[25074] = true,
				[17181] = true,
				[25126] = true,
				[13646] = true,
				[25079] = true,
				[7867]  = true,
				[13905] = true,
				[20011] = true,
				[13421] = true,
				[7418]  = true,
				[13642] = true,
				[7420]  = true,
				[14810] = true,
				[7457]  = true,
				[13794] = true,
				[13846] = true,
				[7782]  = true,
				[13607] = true,
			},
			[13] = {
				[8926]  = true,
				[10918] = true,
				[20844] = true,
				[8927]  = true,
				[8928]  = true,
				[10920] = true,
				[5530]  = true,
				[2893]  = true,
				[10921] = true,
				[8984]  = true,
				[6949]  = true,
				[9186]  = true,
				[3775]  = true,
				[8985]  = true,
				[5237]  = true,
				[10922] = true,
				[6950]  = true,
				[6947]  = true,
				[2892]  = true,
				[6951]  = true,
			},
		};
		-- [xid] = phase,
		local recipe_phase = {				-- 3 REGEN BY recipe_info
			[1] = {
				[19440] = 3,
			},
			[2] = {
				[19166] = 3,
				[19167] = 3,
				[19168] = 3,
				[19043] = 3,
				[22194] = 5,
				[22195] = 5,
				[22385] = 5,
				[22197] = 5,
				[22198] = 5,
				[19051] = 3,
				[19057] = 3,
				[19690] = 4,
				[19691] = 4,
				[19692] = 4,
				[19693] = 4,
				[19694] = 4,
				[19695] = 4,
				[22669] = 6,
				[22670] = 6,
				[22671] = 6,
				[19148] = 3,
				[22384] = 5,
				[22196] = 5,
				[22383] = 5,
				[22762] = 5,
				[22764] = 5,
				[20039] = 3,
				[22191] = 5,
				[19169] = 3,
				[19048] = 3,
				[19170] = 3,
				[20550] = 4,
				[20549] = 4,
				[19164] = 3,
				[20551] = 4,
				[22763] = 5,
			},
			[3] = {
				[18662] = 2,
				[22663] = 6,
				[18238] = 2,
				[19685] = 4,
				[19163] = 3,
				[19689] = 4,
				[21278] = 5,
				[19686] = 4,
				[20380] = 5,
				[22666] = 6,
				[22665] = 6,
				[19157] = 3,
				[19049] = 3,
				[22661] = 6,
				[20476] = 5,
				[22662] = 6,
				[20477] = 5,
				[19687] = 4,
				[20478] = 5,
				[22664] = 6,
				[20479] = 5,
				[19162] = 3,
				[20480] = 5,
				[22759] = 5,
				[20481] = 5,
				[22760] = 5,
				[19149] = 3,
				[22761] = 5,
				[19052] = 3,
				[19044] = 3,
				[19058] = 3,
				[19688] = 4,
			},
			[4] = {
				[21546] = 5,
				[20007] = 4,
				[20008] = 4,
				[20002] = 4,
				[7068]  = 5,
				[20004] = 4,
			},
			[6] = {
				[21023] = 5,
			},
			[8] = {
				[19059] = 3,
				[22658] = 6,
				[19047] = 3,
				[19683] = 4,
				[22660] = 5,
				[20537] = 4,
				[19050] = 3,
				[22655] = 6,
				[20539] = 4,
				[22756] = 5,
				[20538] = 4,
				[22757] = 5,
				-- [22246] = 5,
				[22758] = 5,
				[19156] = 3,
				[22252] = 5,
				[22248] = 5,
				[19682] = 4,
				[22652] = 6,
				[19165] = 3,
				[22654] = 6,
				[19684] = 4,
				[22251] = 5,
				[19056] = 3,
			},
			[9] = {
				[19998] = 4,
				[19999] = 4,
			},
			[10] = {
				[25073] = 5,
				[25074] = 5,
				[23804] = 3,
				[25124] = 5,
				[25078] = 5,
				[25125] = 5,
				[25079] = 5,
				[25126] = 5,
				[25080] = 5,
				[25127] = 5,
				[25081] = 5,
				[25128] = 5,
				[25082] = 5,
				[25129] = 5,
				[25083] = 5,
				[25130] = 5,
				[25084] = 5,
				[23803] = 3,
				[23802] = 3,
				[23799] = 3,
				[25086] = 5,
				[23800] = 3,
				[23801] = 3,
				[25072] = 5,
				[27837] = 5,
			},
			[13] = {
				[20844] = 5,
			},
		};
		-- { xid, }
		local recipe_list = {				-- 4
			[1] = {
				1251,
				2581,
				6452,
				3530,
				3531,
				6453,
				6450,
				6451,
				8544,
				8545,
				14529,
				14530,
				19440,
				23684,
			},
			[2] = {
				2852,
				2853,
				3239,
				2862,
				10421,
				2844,
				3469,
				2845,
				2847,
				3470,
				7955,
				7166,
				3471,
				2851,
				3488,
				3472,
				3473,
				3474,
				6214,
				2863,
				3240,
				3489,
				2857,
				6730,
				3478,
				2864,
				3487,
				2854,
				6350,
				6731,
				2867,
				15869,
				6338,
				3848,
				2866,
				2865,
				3480,
				2848,
				2849,
				5540,
				2868,
				2850,
				7956,
				3481,
				3486,
				3490,
				3241,
				2871,
				7957,
				3482,
				2869,
				3491,
				7958,
				3483,
				6733,
				5541,
				3484,
				3492,
				2870,
				3485,
				6042,
				15870,
				7071,
				11128,
				3851,
				3842,
				10423,
				3840,
				3849,
				7913,
				7914,
				6043,
				3835,
				3852,
				3836,
				3843,
				3850,
				7915,
				3841,
				3853,
				12259,
				7916,
				3844,
				3855,
				6040,
				3846,
				7917,
				17704,
				6041,
				12260,
				3837,
				3845,
				3854,
				7963,
				7965,
				7964,
				15871,
				3856,
				7966,
				9060,
				11144,
				3847,
				9366,
				7918,
				7919,
				7920,
				7936,
				7921,
				7941,
				7937,
				7935,
				7967,
				7922,
				7924,
				7929,
				7925,
				7927,
				7942,
				7926,
				7943,
				7928,
				7945,
				7931,
				7930,
				7954,
				7969,
				7933,
				7932,
				7938,
				7944,
				7961,
				7946,
				7939,
				7934,
				7959,
				12643,
				12404,
				12406,
				12405,
				12644,
				7947,
				12408,
				12416,
				12764,
				7960,
				12428,
				12424,
				11608,
				12772,
				12624,
				11606,
				12415,
				12425,
				12769,
				11607,
				12645,
				12773,
				12774,
				16206,
				15872,
				11605,
				12775,
				12777,
				12776,
				12410,
				12409,
				12418,
				12628,
				12779,
				12781,
				11604,
				12782,
				12631,
				19043,
				19051,
				12625,
				12792,
				12419,
				12426,
				12427,
				17014,
				12632,
				12417,
				16989,
				22197,
				12794,
				19691,
				12611,
				12613,
				12633,
				12641,
				19170,
				19057,
				22764,
				19693,
				19694,
				12636,
				20039,
				18262,
				19164,
				12784,
				12422,
				12798,
				17015,
				12420,
				12790,
				22385,
				19169,
				12783,
				22191,
				22195,
				19695,
				12795,
				12797,
				19166,
				19167,
				17013,
				17016,
				17193,
				20549,
				20550,
				16988,
				19692,
				12610,
				12612,
				12614,
				19048,
				12618,
				12620,
				12640,
				22670,
				20551,
				22198,
				22194,
				22669,
				22763,
				19148,
				19168,
				19690,
				12429,
				22671,
				22762,
				22383,
				22196,
				12619,
				12639,
				12414,
				12796,
				12802,
				22384,
			},
			[3] = {
				2318,
				5957,
				7276,
				7277,
				2302,
				2304,
				2303,
				4237,
				7278,
				7279,
				7280,
				4231,
				5081,
				2300,
				2309,
				4239,
				2310,
				2311,
				7281,
				4242,
				2312,
				4246,
				4243,
				2308,
				6709,
				6466,
				5780,
				2307,
				5781,
				7282,
				2319,
				2317,
				2313,
				20575,
				2315,
				7283,
				4233,
				4244,
				5958,
				6467,
				2316,
				6468,
				5961,
				7285,
				7284,
				4248,
				4250,
				2314,
				7348,
				4251,
				7349,
				7352,
				4253,
				7358,
				4252,
				4247,
				7359,
				4234,
				4236,
				4254,
				4265,
				3719,
				7371,
				7372,
				18662,
				18948,
				4255,
				5962,
				4257,
				4455,
				4456,
				7373,
				5963,
				4258,
				5782,
				4256,
				7375,
				5964,
				7374,
				4259,
				7377,
				7378,
				5965,
				4262,
				5966,
				5783,
				17721,
				5739,
				7386,
				4260,
				7387,
				18238,
				4264,
				8174,
				4304,
				7390,
				7391,
				8172,
				8173,
				8187,
				8176,
				8175,
				8192,
				8198,
				8189,
				8200,
				8201,
				8203,
				8205,
				8210,
				8204,
				8214,
				8218,
				8347,
				8217,
				8211,
				8345,
				8191,
				8195,
				8346,
				8197,
				8185,
				8193,
				8209,
				8202,
				8216,
				8207,
				8206,
				8213,
				8212,
				15564,
				8348,
				4249,
				8215,
				8170,
				8208,
				15407,
				8349,
				8367,
				15077,
				15045,
				15083,
				15074,
				15076,
				15084,
				15061,
				15091,
				15054,
				15046,
				15067,
				15092,
				15057,
				15071,
				15078,
				15064,
				15073,
				20296,
				15093,
				15082,
				15086,
				15072,
				15079,
				15060,
				15048,
				15056,
				15065,
				15053,
				15069,
				18258,
				15075,
				15094,
				15087,
				15050,
				15066,
				19044,
				19052,
				15063,
				16982,
				15070,
				15058,
				15049,
				15080,
				15081,
				15085,
				19157,
				15095,
				19687,
				22759,
				20476,
				20480,
				15141,
				18504,
				18508,
				20295,
				22664,
				18510,
				19162,
				19688,
				22760,
				20477,
				20481,
				21278,
				15062,
				18509,
				16983,
				15052,
				22661,
				22665,
				15068,
				22761,
				20478,
				15090,
				15138,
				18506,
				16984,
				15088,
				22662,
				22666,
				19163,
				19049,
				19058,
				18251,
				19149,
				19686,
				19689,
				20479,
				19685,
				15096,
				18511,
				15047,
				15051,
				15055,
				15059,
				22663,
				20380,
			},
			[4] = {
				8827,
				17967,
				5997,
				2454,
				118,
				3382,
				2455,
				2456,
				4596,
				2457,
				2458,
				858,
				2459,
				5631,
				2460,
				6370,
				3383,
				5996,
				6662,
				6051,
				6372,
				3384,
				929,
				3385,
				3386,
				3388,
				5632,
				3389,
				6371,
				6048,
				3390,
				6373,
				3391,
				5634,
				1710,
				3827,
				3824,
				6049,
				3823,
				3825,
				5633,
				3826,
				8949,
				6050,
				6052,
				17708,
				8951,
				3828,
				3829,
				10592,
				8956,
				6149,
				9061,
				9030,
				9036,
				3928,
				18294,
				4623,
				6037,
				3577,
				9144,
				9149,
				9154,
				12190,
				9172,
				9155,
				9179,
				9088,
				9187,
				9197,
				9206,
				9210,
				9224,
				3387,
				13423,
				9233,
				9264,
				21546,
				13442,
				13443,
				13445,
				13447,
				12803,
				12808,
				7076,
				7078,
				7082,
				20007,
				13446,
				20002,
				7080,
				12360,
				13453,
				13455,
				13452,
				20008,
				13454,
				13462,
				13456,
				13458,
				13459,
				13460,
				13461,
				13457,
				20004,
				13444,
				13513,
				18253,
				13510,
				19931,
				7068,
				13506,
				13503,
				13511,
				13512,
			},
			[6] = {
				2681,
				6290,
				6888,
				12224,
				17197,
				787,
				2679,
				5472,
				2680,
				5473,
				2888,
				5474,
				17198,
				6890,
				5525,
				2684,
				5095,
				5477,
				4592,
				6316,
				724,
				5476,
				7676,
				3220,
				2683,
				733,
				21072,
				2687,
				3662,
				2682,
				6657,
				5526,
				5478,
				3663,
				1082,
				5479,
				4593,
				1017,
				3666,
				2685,
				5480,
				3726,
				3664,
				12209,
				10841,
				3727,
				5527,
				3665,
				20074,
				3728,
				3729,
				6038,
				4457,
				4594,
				8364,
				13851,
				12210,
				12212,
				12213,
				12214,
				21217,
				12217,
				12215,
				17222,
				16766,
				13927,
				18045,
				12216,
				12218,
				13930,
				6887,
				13928,
				13929,
				13931,
				13932,
				13933,
				13934,
				13935,
				18254,
				20452,
				21023,
				23683,
			},
			[7] = {
				2840,
				2841,
				3576,
				2842,
				3575,
				3577,
				3859,
				3860,
				11371,
				6037,
				12359,
				17771,
			},
			[8] = {
				2576,
				10045,
				2996,
				4344,
				2570,
				7026,
				2568,
				10046,
				6238,
				6241,
				4343,
				4307,
				2575,
				2577,
				6786,
				2572,
				4238,
				6239,
				6240,
				2580,
				4308,
				2569,
				2578,
				2579,
				6242,
				5762,
				4309,
				2584,
				10047,
				2997,
				4240,
				4312,
				2582,
				4310,
				6243,
				5542,
				2583,
				4241,
				4313,
				4311,
				6263,
				2587,
				2585,
				6787,
				4314,
				4316,
				4330,
				6264,
				5763,
				6384,
				10048,
				4315,
				6385,
				4320,
				4305,
				4317,
				4331,
				4318,
				4332,
				5766,
				7027,
				4321,
				7046,
				4319,
				7047,
				7048,
				7049,
				4245,
				4324,
				5770,
				4333,
				7050,
				6795,
				4322,
				7065,
				7051,
				4323,
				4334,
				5764,
				7055,
				6796,
				7052,
				7053,
				4325,
				4339,
				7056,
				7057,
				4328,
				5765,
				4326,
				4335,
				7058,
				17723,
				7054,
				7059,
				7060,
				7061,
				7062,
				4327,
				4329,
				4336,
				9999,
				9998,
				7063,
				10001,
				10002,
				7064,
				10003,
				10007,
				10009,
				10008,
				10004,
				10056,
				10011,
				10010,
				10052,
				10019,
				22246,
				10018,
				10020,
				10042,
				10050,
				10021,
				10023,
				10024,
				10054,
				10027,
				10026,
				10029,
				10051,
				10053,
				10055,
				10028,
				10031,
				10033,
				10030,
				10032,
				10034,
				10025,
				10044,
				10038,
				10035,
				14342,
				21154,
				10041,
				10040,
				10039,
				14048,
				10036,
				21542,
				13868,
				13869,
				13856,
				14046,
				13858,
				14042,
				21340,
				13857,
				13860,
				13870,
				14143,
				14100,
				14101,
				14142,
				14043,
				14103,
				14107,
				14141,
				13863,
				14044,
				22248,
				22251,
				14132,
				14134,
				13864,
				13871,
				14045,
				21341,
				18258,
				14136,
				13865,
				14108,
				14137,
				14111,
				14104,
				14144,
				19056,
				19047,
				15802,
				13866,
				19683,
				14139,
				19050,
				14153,
				14155,
				22652,
				22660,
				13867,
				14130,
				18405,
				19684,
				18413,
				16980,
				22249,
				20537,
				14112,
				16979,
				21342,
				19059,
				22757,
				22756,
				14106,
				18486,
				14138,
				14140,
				14146,
				14152,
				14154,
				14156,
				18407,
				22654,
				22658,
				18408,
				18409,
				14128,
				19156,
				19682,
				22758,
				22252,
				20539,
				19165,
				18263,
				20538,
				22655,
			},
			[9] = {
				10579,
				10585,
				10719,
				10723,
				8067,
				10580,
				4357,
				4358,
				4359,
				4360,
				6219,
				4361,
				4362,
				4405,
				4363,
				4401,
				8068,
				4364,
				4365,
				4366,
				4404,
				4367,
				4368,
				6714,
				6712,
				4369,
				4370,
				4371,
				4406,
				4372,
				4374,
				4373,
				4375,
				4377,
				4378,
				21557,
				8069,
				21558,
				4376,
				21559,
				7506,
				4379,
				5507,
				4380,
				4381,
				4382,
				4383,
				4384,
				4385,
				9318,
				6533,
				10558,
				9313,
				9312,
				4386,
				4387,
				4388,
				4403,
				7148,
				4389,
				10505,
				4390,
				4391,
				21592,
				21589,
				21590,
				10498,
				10499,
				10507,
				4407,
				4392,
				4393,
				4852,
				17716,
				4394,
				10559,
				4395,
				4397,
				4398,
				18588,
				10713,
				10560,
				11590,
				4396,
				10543,
				11826,
				10577,
				10500,
				10508,
				10542,
				11825,
				10644,
				10646,
				10716,
				10512,
				10546,
				10545,
				10720,
				10561,
				10721,
				10514,
				10726,
				10510,
				10501,
				21569,
				10518,
				21574,
				10586,
				7189,
				10502,
				21576,
				10724,
				21571,
				10587,
				10725,
				10506,
				10503,
				10562,
				10588,
				10727,
				10548,
				10645,
				10504,
				10513,
				10576,
				15846,
				19026,
				18641,
				21277,
				15992,
				18986,
				18660,
				15994,
				18984,
				18634,
				15993,
				15995,
				18631,
				15996,
				18645,
				18587,
				15999,
				22728,
				21716,
				16000,
				16004,
				18637,
				21570,
				18594,
				21714,
				21718,
				16023,
				16006,
				15997,
				16005,
				16008,
				18638,
				16009,
				18639,
				19998,
				16022,
				19999,
				16040,
				18282,
				18168,
				16007,
				18232,
				18283,
			},
			[10] = {
				22434,
				7418,
				7421,
				14293,
				7420,
				7443,
				7426,
				7454,
				25124,
				7457,
				7748,
				7766,
				7771,
				14807,
				7428,
				7779,
				7782,
				7776,
				7786,
				7788,
				7745,
				7793,
				7795,
				13378,
				13419,
				13380,
				13421,
				13464,
				7857,
				7859,
				7861,
				7863,
				7867,
				13485,
				13501,
				13522,
				13536,
				13538,
				13503,
				13620,
				13607,
				13617,
				13529,
				13612,
				13622,
				13626,
				13628,
				25125,
				13631,
				14809,
				13635,
				13637,
				13640,
				13642,
				13644,
				13648,
				13646,
				13653,
				13655,
				13657,
				14810,
				13659,
				13661,
				13663,
				21931,
				13687,
				13689,
				13693,
				13695,
				13698,
				13700,
				25126,
				13702,
				13746,
				13794,
				13822,
				13815,
				13817,
				13836,
				13841,
				13858,
				13846,
				13868,
				13882,
				13890,
				13887,
				13915,
				13905,
				13917,
				13933,
				13935,
				13931,
				13937,
				13939,
				13941,
				13943,
				13945,
				13948,
				25127,
				13947,
				17181,
				17180,
				20008,
				20020,
				20014,
				13898,
				15596,
				20017,
				20012,
				20009,
				20026,
				25128,
				20024,
				20016,
				20015,
				20029,
				23800,
				27837,
				23801,
				20028,
				20051,
				23799,
				20010,
				20030,
				20013,
				20023,
				20033,
				25074,
				25078,
				25082,
				25086,
				20034,
				23804,
				25083,
				20011,
				20031,
				22749,
				25072,
				25080,
				25084,
				20032,
				22750,
				25130,
				25073,
				23802,
				25081,
				25129,
				20036,
				20035,
				25079,
				20025,
				23803,
			},
			[13] = {
				6947,
				3775,
				5237,
				6949,
				2892,
				10918,
				5530,
				6950,
				2893,
				6951,
				10920,
				8926,
				8984,
				10921,
				3776,
				8927,
				9186,
				8985,
				10922,
				8928,
				20844,
			},
		};
		local recipe_hash = {  };		-- Mixin	-- [pid][xid] = data_index_in_tradeframe	-- default -1 for not-learned
		local tradeskill_name = {  };	-- [pid] = prof_name
		local tradeskill_hash = {  };	-- [prof_name] = pid
		function prof.db_init()
			for i = 1, 20 do
				if tradeskill_id[i] then
					local name = GetSpellInfo(tradeskill_id[i]);
					tradeskill_name[i] = name;
					tradeskill_hash[name] = i;
				end
			end
			for i, id in pairs(tradeskill_check_id) do
				local name = GetSpellInfo(id);
				if name and GetSpellInfo(name) then
					tinsert(player_prof, i);
					_log_("LEARNED", id, name);
				end
			end
			for pid, pt in pairs(recipe_list) do
				local filter = recipe_filter[pid];
				if filter then
					for i = #pt, 1, -1 do
						if not filter[pt[i]] then
							tremove(pt, i);
						end
					end
				end
			end
			for pid, pt in pairs(recipe_list) do
				recipe_hash[pid] = {  };
				for _, xid in pairs(pt) do
					recipe_hash[pid][xid] = -1;
				end
			end
			for pid, pt in pairs(recipe_phase) do
				if recipe_info[pid] then
					local info = recipe_info[pid];
					for xid, p in pairs(recipe_info) do
						if info[xid] then
							pt[xid] = info[xid][index_phase];
						else
							pt[xid] = nil;
						end
					end
				else
					recipe_phase[pid] = nil;
				end
			end
			-- HASH
			for pid, pt in pairs(recipe_list) do
				local rpt = recipe_info[pid];
				if rpt then
					for _, xid in pairs(pt) do
						local info = rpt[xid];
						if info then
							xid_to_pid_hash[xid] = xid_to_pid_hash[xid] or {  };
							tinsert(xid_to_pid_hash[xid], pid);
							if info[index_sid] then
								sid_to_pid_hash[info[index_sid]] = pid;
								sid_to_xid_hash[info[index_sid]] = xid;
							end
							if info[index_cid] then
								local t = cid_to_pid_hash[info[index_cid]];
								if not t then
									t = {  };
									cid_to_pid_hash[info[index_cid]] = t;
								end
								tinsert(t, pid);
							end
							if info[index_sid] and info[index_cid] then
								sid_to_cid_hash[info[index_sid]] = info[index_cid];
							end
						end
					end
				end
			end
			-- PRELOAD
			for pid, pt in pairs(recipe_list) do
				local info = recipe_info[pid];
				if info then
					for _, v in pairs(info) do
						if v[index_cid] then
							C_Item.RequestLoadItemDataByID(v[index_cid]);
						end
						if v[index_sid] then
							C_Spell.RequestLoadSpellData(v[index_sid]);
						end
						if v[index_rid] then
							C_Item.RequestLoadItemDataByID(v[index_rid]);
						end
						if v[index_reagents_id] then
							for _, rid in pairs(v[index_reagents_id]) do
								C_Item.RequestLoadItemDataByID(rid);
							end
						end
					end
				end
			end
			-- DEV
			do
			end
		end
		function prof.db_get_pid(pname)
			return tradeskill_hash[pname];
		end
		function prof.db_get_difficult(pid, xid)
			if recipe_info[pid] and recipe_info[pid][xid] then
				local t = recipe_info[pid][xid];
				return t[index_learn_rank], t[index_yellow_rank], t[index_green_rank], t[index_grey_rank];
			end
		end
		function prof.db_get_difficult_text(pname, xid)
			if not pname or not xid then
				return "";
			end
			local pid = prof.db_get_pid(pname);
			if pid and xid then
				local red, yellow, green, grey = prof.db_get_difficult(pid, xid);
				if red and yellow and green and grey then
					if red < yellow then
						return "\124cffff8f00" .. red .. " \124cffffff00" .. yellow .. " \124cff8fff00" .. green .. " \124cff8f8f8f" .. grey;
					else
						return "\124cffffff00" .. yellow .. " \124cff8fff00" .. green .. " \124cff8f8f8f" .. grey;
					end
				else
					return "";
				end
			else
				return "";
			end
		end
		function prof.db_get_list(pid, list, hash)
			if not recipe_list[pid] or not recipe_hash[pid] then
				return;
			end
			if list then
				wipe(list);
			else
				list = {  };
			end
			if hash then
				wipe(hash);
			else
				hash = {  };
			end
			Mixin(list, recipe_list[pid]);
			Mixin(hash, recipe_hash[pid]);
			return list, hash;
		end
		function prof.db_get_ordered_list(pid, list, hash, rank, rankReversed, showHighRank, displayPhase)
			if not recipe_list[pid] or not recipe_hash[pid] then
				return;
			end
			local recipe = recipe_list[pid];
			local info = recipe_info[pid];
			if list then
				wipe(list);
			else
				list = {  };
			end
			if hash then
				wipe(hash);
			else
				hash = {  };
			end
			if rank and rank > 0 then
				if rankReversed then
					if showHighRank then
						for i = 1, #recipe do
							local xid = recipe[i];
							if info[xid][index_learn_rank] > rank then
								tinsert(list, xid);
							end
						end
					end
					for index = index_yellow_rank, index_grey_rank do
						for i = 1, #recipe do
							local xid = recipe[i];
							if info[xid][index - 1] <= rank and info[xid][index] > rank then
								tinsert(list, xid);
							end
						end
					end
					for i = 1, #recipe do
						local xid = recipe[i];
						if info[xid][index_grey_rank] <= rank then
							tinsert(list, xid);
						end
					end
				else
					if showHighRank then
						for i = #recipe, 1, -1 do
							local xid = recipe[i];
							if info[xid][index_learn_rank] > rank then
								tinsert(list, xid);
							end
						end
					end
					for index = index_yellow_rank, index_grey_rank do
						for i = #recipe, 1, -1 do
							local xid = recipe[i];
							if info[xid][index - 1] <= rank and info[xid][index] > rank then
								tinsert(list, xid);
							end
						end
					end
					for i = #recipe, 1, -1 do
						local xid = recipe[i];
						if info[xid][index_grey_rank] <= rank then
							tinsert(list, xid);
						end
					end
				end
			else	--	NEVER???
				if rankReversed then
					if showHighRank then
						Mixin(list, recipe);
					else
						for i = 1, #recipe do
							local xid = recipe[i];
							if info[xid][index_learn_rank] <= rank then
								tinsert(list, xid);
							end
						end
					end
				else
					if showHighRank then
						for i = #recipe, 1, -1 do
							local xid = recipe[i];
							tinsert(list, xid);
						end
					else
						for i = #recipe, 1, -1 do
							local xid = recipe[i];
							if info[xid][index_learn_rank] <= rank then
								tinsert(list, xid);
							end
						end
					end
				end
			end
			if displayPhase then
				local phase = recipe_phase[pid];
				if phase then
					for i = #list, 1, -1 do
						if phase[list[i]] and phase[list[i]] > displayPhase then
							tremove(list, i);
						end
					end
				end
			end
			Mixin(hash, recipe_hash[pid]);
			return list, hash;
		end
		function prof.db_exist_recipe_info(pid)
			return recipe_info[pid] ~= nil;
		end
		function prof.db_get_recipe_info(pid, xid, phase)
			phase = phase or BIG_NUMBER;
			if recipe_info[pid] and (not recipe_phase[pid] or (recipe_phase[pid][xid] or - 1) < phase) then
				return recipe_info[pid][xid];
			end
		end
		function prof.db_get_recipe_info2(xid)
			for pid, meta in pairs(recipe_info) do
				if meta[xid] then
					return pid, meta[xid];
				end
			end
		end
		function prof.db_get_recipe_phase(pid, xid)
			if recipe_phase[pid] then
				return recipe_phase[pid][xid] or 1;
			else
				return 1;
			end
		end
		function prof.db_get_texture_by_pid(pid)
			return tradeskill_texture[pid];
		end
		function prof.db_get_name_by_pid(pid)
			if not tradeskill_name[pid] then
				local name = GetSpellInfo(tradeskill_id[pid]);
				if name then
					tradeskill_name[pid] = name;
					tradeskill_hash[name] = pid;
				end
			end
			return tradeskill_name[pid];
		end
		--
		function prof.db_is_tradeskill_sid(sid)
			return sid_to_pid_hash[sid] ~= nil;
		end
		function prof.db_is_tradeskill_cid(cid)
			return cid_to_pid_hash[cid] ~= nil;
		end
		function prof.db_get_cid_by_sid(sid)
			return sid_to_cid_hash[sid];
		end
		function prof.db_get_pid_by_sid(sid)
			return sid_to_pid_hash[sid];
		end
		function prof.db_get_pid_by_xid(xid)
			return xid_to_pid_hash[xid];
		end
		function prof.db_get_tradeskill_info_by_pid_xid(pid, xid)
			local hash = xid_to_pid_hash[xid];
			for _, v in pairs(hash) do
				if v == pid then
					return recipe_info[pid][xid];
				end
			end
			return nil;
		end
		function prof.db_get_tradeskill_info_by_sid(sid)
			local pid = sid_to_pid_hash[sid];
			local xid = sid_to_xid_hash[sid];
			if pid and xid then
				return pid, recipe_info[pid][xid];
			end
			return nil;
		end
		function prof.db_get_tradeskill_num_made_by_sid(sid)
			local pid = sid_to_pid_hash[sid];
			local xid = sid_to_xid_hash[sid];
			if pid and xid then
				local pt = recipe_info[pid];
				if pt and pt[xid] then
					local info = pt[xid];
					return (info[index_num_made_min] + info[index_num_made_max]) / 2, info[index_num_made_min], info[index_num_made_max];
				end
			end
			return nil;
		end
		function prof.db_get_tradeskill_num_made_by_pid_cid(pid, cid)
			local pt = recipe_info[pid];
			if pt and pt[cid] then
				local info = pt[cid];
				return (info[index_num_made_min] + info[index_num_made_max]) / 2, info[index_num_made_min], info[index_num_made_max];
			end
		end
		function prof.db_get_tradeskill_learn_rank_by_pid_xid(pid, xid)
			local pt = recipe_info[pid];
			if pt and pt[xid] then
				return pt[xid][index_learn_rank];
			end
		end
		function prof.db_get_tradeskill_cid_by_pid_xid(pid, xid)
			local pt = recipe_info[pid];
			if pt and pt[xid] then
				return pt[xid][index_cid];
			end
		end
		function prof.db_get_tradeskill_learn_rank_by_sid(sid)
			local pid = sid_to_pid_hash[sid];
			local xid = sid_to_xid_hash[sid];
			if pid and xid then
				return prof.db_get_tradeskill_learn_rank_by_pid_xid(pid, xid);
			end
			return nil;
		end
		--
		local tradeskill_mtsl_name = {
			[1] = "First Aid",
			[2] = "Blacksmithing",
			[3] = "Leatherworking",
			[4] = "Alchemy",
			[6] = "Cooking",
			[7] = "Mining",
			[8] = "Tailoring",
			[9] = "Engineering",
			[10] = "Enchanting",
		};
		function prof.db_get_mtsl_pname(pid)
			return tradeskill_mtsl_name[pid];
		end
		function prof.db_validate()
			local atlas = AtlasLoot.Data.Profession;
			if atlas then
				for pid, meta in pairs(recipe_info) do
					for cid, v in pairs(meta) do
						if v[index_sid] then
							local data = atlas.GetProfessionData(v[index_sid]);
							if data then
								if v[index_learn_rank] ~= data[3] or v[index_yellow_rank] ~= data[4] or v[index_grey_rank] ~= data[5] then
									print(format("\124cffff0000invalid_3\124r %2d %4d %4d %4d %4d %4d %4d %4d %4d", pid, cid, v[index_learn_rank], v[index_yellow_rank], v[index_grey_rank], data[3], data[4], data[5]));
								end
							else
								print("\124cffff0000invalid_2\124r", pid, cid);
							end
						else
							print("\124cffff0000invalid_1\124r", pid, cid);
						end
					end
				end
			end
		end
		function prof.dev()
		end
		function prof.dev2(frame)
		end
	end

	do	-- UI
		local function add_to_fav(frame, sv, cid)
			if not sv[cid] then
				sv[cid] = 1;
			end
			_EventHandler:frame_update_on_next_tick(frame);
		end
		local function sub_to_fav(frame, sv, cid)
			if sv[cid] then
				sv[cid] = nil;
			end
			_EventHandler:frame_update_on_next_tick(frame);
		end
		function prof.process_profit_update(profitFrame, frame)
			if not profitFrame:IsShown() then
				return;
			end
			local xid_list = frame.list;
			local xid_hash = frame.hash;
			local meta = frame.meta;
			local list = profitFrame.list;
			local hash = profitFrame.hash;
			wipe(list);
			wipe(hash);
			local pname, cur_rank, max_rank = meta.pinfo();
			local pid = prof.db_get_pid(pname);
			if not pid then
				return;
			end
			prof.gen_profit_price_list(pid, xid_list, xid_hash, list, hash);
			profitFrame.scroll:SetNumValue(#list);
			profitFrame.scroll:Update();
		end
		function prof.process_update(frame)
			if frame.mute_update then
				return;
			end
			local list = frame.list;
			local hash = frame.hash;
			wipe(list);
			wipe(hash);
			local meta = frame.meta;
			local pname, cur_rank, max_rank = meta.pinfo();
			local pid = prof.db_get_pid(pname);
			if not pid then
				return;
			end
			prof.dev2(frame);
			local C = config[pid];
			if C.shown then
				frame.mute_update = true;
				frame:Show();
				frame.call:SetText(L["Close"]);
				if frame.searchEdit:GetText() ~= C.searchText then
					frame.searchEdit:SetText(C.searchText or "");
				end
				frame.mute_update = false;
				if C.showConfig then
					frame.configFrame:Show();
				else
					frame.configFrame:Hide();
				end
				if C.showProfit then
					frame.profitFrame:Show();
				else
					frame.profitFrame:Hide();
				end
			else
				frame:Hide();
				frame.call:SetText(L["Open"]);
				return;
			end
			local num = meta.recipe_num();
			if num <= 0 then
				return;
			end
			if not C.coverMode then
				if C.showRank then
					frame:SetWidth(ui_style.frame_width);
				else
					frame:SetWidth(ui_style.frame_width_narrow);
				end
			end
			frame:RefreshConfigFrame();
			prof.toggle_cover_mode(frame, C.coverMode);
			local num_recipe_real = 0;
			do
				local showKnown, showUnkown, rankReversed, showHighRank, displayPhase = C.showKnown, C.showUnkown, C.rankReversed, C.showHighRank, C.phase;
				prof.db_get_ordered_list(pid, list, hash, cur_rank, rankReversed, showHighRank, displayPhase);
				do
					local C_top = 1;
					local index = 1;
					while index <= #list do
						local id = list[index];
						if C[id] then
							tremove(list, index);
							tinsert(list, C_top, id);
							C_top = C_top + 1;
						end
						index = index + 1;
					end
				end
				local filter = frame.filter;
				if showKnown then
					if filter then
						for i = 1, num do
							local name, rank = meta.info(i);
							if name and rank and rank ~= 'header' then
								local link = meta.link(i);
								local cid = meta.itemId(i);
								if cid then
									if strfind(name, filter) or strfind(tostring(cid), filter) then
										hash[cid] = i;
									else
										local num_reagent = meta.num_reagent(i);
										for j = 1, num_reagent do
											local reagent_name = meta.reagent_info(i, j);
											if reagent_name and strfind(reagent_name, filter) then
												hash[cid] = i;
											end
										end
									end
								end
								num_recipe_real = num_recipe_real + 1;
							end
						end
					else
						for i = 1, num do
							local name, rank = meta.info(i);
							if name and rank and rank ~= 'header' then
								local cid = meta.itemId(i);
								if cid then
									hash[cid] = i;
								end
								num_recipe_real = num_recipe_real + 1;
							end
						end
					end
				else
					for i = 1, num do
						local name, rank = meta.info(i);
						if name and rank and rank ~= 'header' then
							local cid = meta.itemId(i);
							if cid then
								hash[cid] = i;
							end
						end
					end
					for i = #list, 1, -1 do
						if hash[list[i]] > 0 then
							tremove(list, i);
						end
					end
				end
				if showUnkown then
					if filter then
						if prof.db_exist_recipe_info(pid) then
							for i = #list, 1, -1 do
								local cid = list[i];
								local info = prof.db_get_recipe_info(pid, cid);
								local name, link = meta.itemInfo(cid);
								local sname = GetSpellInfo(info[index_sid]);
								if not ((sname and strfind(sname, filter)) or (link and strfind(link, filter))) then
									local matched = false;
									for _, id in pairs(info[index_reagents_id]) do
										local _, link = GetItemInfo(id);
										if link and strfind(link, filter) then
											matched = true;
											break;
										end
									end
									if not matched then
										tremove(list, i);
									end
								end
							end
						else
							for i = #list, 1, -1 do
								if hash[list[i]] < 0 then
									tremove(list, i);
								end
							end
						end
					end
				else
					for i = #list, 1, -1 do
						if hash[list[i]] < 0 then
							tremove(list, i);
						end
					end
				end
				prof.process_profit_update(frame.profitFrame, frame);
			end
			-- FEEDBACK
			if num_recipe_real > #list then
				-- TODO FEEDBACK ENTRY
			end
			--
			frame.scroll:SetNumValue(#list);
			frame.scroll:Update();
		end
		do
			local MTSL_LOCALE = mtsl_locale_list[LOCALE] or mtsl_locale_list.def;
			local tooltip_set_quest;
			local tooltip_set_item;
			local tooltip_set_object;
			local function mtsl_get_npc(nid, A, H, N, HOS)
				local npcs = MTSL_DATA["npcs"];
				if npcs then
					for _, nv in pairs(npcs) do
						if nv.id == nid then
							if (A and nv.reacts == "Alliance") or (H and nv.reacts == "Horde") or (N and nv.reacts == "Neutral") or (HOS and nv.reacts == "Hostile") then
								local line = nv.name[MTSL_LOCALE] or "";
								if nv.xp_level then
									if nv.xp_level.min ~= nv.xp_level.max then
										line = line .. "Lv" .. nv.xp_level.min .. "-" .. nv.xp_level.max;
									else
										line = line .. "Lv" .. nv.xp_level.min;
									end
									if nv.xp_level.is_elite > 0 then
										line = line .. L["elite"];
									end
								end
								line = line .. " [" .. C_Map.GetAreaInfo(nv.zone_id);
								if nv.location and nv.location.x ~= "-" and nv.location.y ~= "-" then
									line = line .. " " .. nv.location.x .. ", " .. nv.location.y .. "]";
								else
									line = line .. "]";
								end
								if nv.phase and nv.phase > curPhase then
									line = line .. " " .. L["phase"] .. nv.phase;
								end
								if nv.special_action and nv.special_action[MTSL_LOCALE] then
									if strlen(nv.special_action[MTSL_LOCALE]) > 36 then
										line = line .. "\n" .. nv.special_action[MTSL_LOCALE];
									else
										line = line .. nv.special_action[MTSL_LOCALE];
									end
								end
								return line;
							end
						end
					end
				end
			end
			tooltip_set_quest = function(pid, qid, label, stack_size)
				if stack_size > 8 then
					return;
				end
				if MTSL_DATA then
					local quests = MTSL_DATA["quests"];
					if quests then
						for _, qv in pairs(quests) do
							if qv.id == qid then
								local line = "[" .. qv.name[MTSL_LOCALE] .. "]";
								if qv.min_xp_level then
									line = line .. "Lv" .. qv.min_xp_level;
								end
								if qv.phase and qv.phase > curPhase then
									line = line .. " " .. L["phase"] .. qv.phase;
								end
								if qv.special_action and qv.special_action[MTSL_LOCALE] then
									if strlen(qv.special_action[MTSL_LOCALE]) > 36 then
										line = line .. "\n" .. qv.special_action[MTSL_LOCALE];
									else
										line = line .. qv.special_action[MTSL_LOCALE];
									end
								end
								GameTooltip:AddDoubleLine(label, L["quest_reward"] .. ": \124cffffff00" .. line .. "\124r");
								if qv.npcs then
									local A = UnitFactionGroup('player') == "Alliance";
									local available = false;
									for _, nid in pairs(qv.npcs) do
										local line = mtsl_get_npc(nid, A, not A, true, true);
										if line then
											GameTooltip:AddDoubleLine(" ", L["quest_accepted_from"] .. ": \124cffffff00" .. line .. "\124r");
											available = true;
										end
									end
									if not available then
										GameTooltip:AddDoubleLine(" ", "\124cffff0000" .. L["not_available_for_player's_faction"] .. "\124r");
									end
								elseif qv.items then
									for _, iid in pairs(qv.items) do
										tooltip_set_item(pid, iid, " ", stack_size + 1);
									end
								elseif qv.objects then
									for _, oid in pairs(qv.objects) do
										tooltip_set_object(pid, oid, " ", stack_size + 1);
									end
								end
								GameTooltip:Show();
								return;
							end
						end
					end
				end
				GameTooltip:AddDoubleLine(label, "\124cffffff00" .. L["quest"] .. "\124r ID: " .. qid);
				GameTooltip:Show();
			end
			tooltip_set_item = function(pid, iid, label, stack_size)
				if stack_size > 8 then
					return;
				end
				local _, line, _, _, _, _, _, _, _, _, _, _, _, bind = GetItemInfo(iid);
				if not line then
					return;
				end
				if bind ~= 1 and bind ~= 4 then
					line = line .. "(\124cff00ff00" .. L["tradable"] .. "\124r)";
					if merc then
						local price = merc.query_ah_price_by_id(iid);
						if price and price > 0 then
							line = line .. " \124cff00ff00AH\124r " .. merc.MoneyString(price);
						end
					end
				else
					line = line .. "(\124cffff0000" .. L["non_tradable"] .. "\124r)";
				end
				if MTSL_DATA then
					local name = prof.db_get_mtsl_pname(pid);
					local data = MTSL_DATA["items"][name];
					if data then
						for i, iv in pairs(data) do
							if iv.id == iid then
								if iv.special_action and iv.special_action[MTSL_LOCALE] then
									if strlen(iv.special_action[MTSL_LOCALE]) > 36 then
										line = line .. "\n" .. iv.special_action[MTSL_LOCALE];
									else
										line = line .. iv.special_action[MTSL_LOCALE];
									end
								end
								GameTooltip:AddDoubleLine(label, line);
								--
								if iv.vendors then
									local A = UnitFactionGroup('player') == "Alliance";
									local available = false;
									for _, nid in pairs(iv.vendors.sources) do
										local line = mtsl_get_npc(nid, A, not A, true, true);
										if line then
											GameTooltip:AddDoubleLine(" ", L["sold_by"] .. ": \124cff00ff00" .. line .. "]\124r");
											available = true;
										end
										if not available then
											GameTooltip:AddDoubleLine(" ", "\124cffff0000" .. L["not_available_for_player's_faction"] .. "\124r");
										end
									end
								elseif iv.drops then
									if iv.drops.mobs then
										local A = UnitFactionGroup('player') == "Alliance";
										for _, nid in pairs(iv.drops.mobs) do
											local line = mtsl_get_npc(nid, not A, A, true, true);
											if line then
												GameTooltip:AddDoubleLine(" ", L["dropped_by"] .. ": \124cffff0000" .. line .. "]\124r");
											end
										end
									elseif iv.drops.mobs_range then
										if iv.drops.mobs_range.min_xp_level and iv.drops.mobs_range.max_xp_level then
											local line = iv.drops.mobs_range.min_xp_level .. "-" .. iv.drops.mobs_range.max_xp_level;
											GameTooltip:AddDoubleLine(" ", L["world_drop"] .. ": \124cffff0000" .. L["dropped_by_mod_level"] .. line .. "\124r");
										else
											GameTooltip:AddDoubleLine(" ", L["world_drop"]);
										end
									end
								elseif iv.quests then
									for _, qid in pairs(iv.quests) do
										tooltip_set_quest(pid, qid, " ", stack_size + 1);
									end
								elseif iv.objects then
									for _, oid in pairs(iv.objects) do
										tooltip_set_object(pid, oid, " ", stack_size + 1);
									end
								else
									GameTooltip:AddDoubleLine("  ", "\124cffff0000unkown\124r, itemID: " .. iid);
								end
								GameTooltip:Show();
								return;
							end
						end
					end
				end
				GameTooltip:AddDoubleLine(label, line .. " ID: " .. iid);
				GameTooltip:Show();
			end
			tooltip_set_object = function(pid, oid, label, stack_size)
				if stack_size > 8 then
					return;
				end
				local objects = MTSL_DATA["objects"];
				if objects then
					for _, ov in pairs(objects) do
						if ov.id == oid then
							local line = ov.name[MTSL_LOCALE];
							line = line .. " [" .. C_Map.GetAreaInfo(ov.zone_id);
							if ov.location and ov.location.x ~= "-" and ov.location.y ~= "-" then
								line = line .. " " .. ov.location.x .. ", " .. ov.location.y .. "]";
							else
								line = line .. "]";
							end
							if ov.phase and ov.phase > curPhase then
								line = line .. " " .. L["phase"] .. ov.phase;
							end
							if ov.special_action and ov.special_action[MTSL_LOCALE] then
								if strlen(ov.special_action[MTSL_LOCALE]) > 36 then
									line = line .. "\n" .. ov.special_action[MTSL_LOCALE];
								else
									line = line .. ov.special_action[MTSL_LOCALE];
								end
							end
							GameTooltip:AddDoubleLine(label, L["item"] .. ": \124cffffffff" .. line .. "\124r");
							GameTooltip:Show();
							return;
						end
					end
				end
				GameTooltip:AddDoubleLine(label, "\124cffffffff" .. L["item"] .. "\124r ID: " .. oid);
				GameTooltip:Show();
			end
			function prof.set_tooltip(pid, cid)
				local info = prof.db_get_recipe_info(pid, cid);
				if info then
					if info[index_rid] then					-- recipe
						tooltip_set_item(pid, info[index_rid], L["get_from"] .. ":", 1)
					elseif info[index_trainer] then			-- trainer
						GameTooltip:AddDoubleLine(L["get_from"] .. ":", "\124cffff00ff" .. L["trainer"] .. "\124r");
						GameTooltip:Show();
					elseif info[index_quest] then			-- quests
						for _, qid in pairs(info[index_quest]) do
							tooltip_set_quest(pid, qid, L["get_from"] .. ":", 1);
						end
					elseif info[index_object] then			-- objects
						if type(info[index_object]) == 'table' then
							for _, oid in pairs(info[index_object]) do
								tooltip_set_object(pid, oid, L["get_from"] .. ":", 1);
							end
						else
							tooltip_set_object(pid, info[index_object], L["get_from"] .. ":", 1);
						end
					end
				end
			end
		end
		local onEnter_identity = 0;
		local function button_OnEnter(self)
			local meta = self.meta;
			local pid = prof.db_get_pid(meta.pname());
			if not pid then
				return;
			end
			local cid = self.list[self:GetDataIndex()];
			if type(cid) == 'table' then
				cid = cid[1];
			end
			local info = prof.db_get_recipe_info(pid, cid);
			local data = self.hash[cid];
			if info then
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
				if config[pid].showItemInsteadOfSpell and info[index_cid] then
					GameTooltip:SetItemByID(info[index_cid]);
				else
					GameTooltip:SetSpellByID(info[index_sid]);
				end
				local phase = prof.db_get_recipe_phase(pid, cid);
				if phase > curPhase then
					GameTooltip:AddLine("\124cffff0000" .. L["available_in_phase_"] .. phase .. "\124r");
				end
				GameTooltip:Show();
			else
				local link = data > 0 and meta.link(data) or select(2, meta.itemInfo(cid));
				if link then
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
					GameTooltip:SetHyperlink(link);
					local phase = prof.db_get_recipe_phase(pid, cid);
					if phase > curPhase then
						GameTooltip:AddLine("\124cffff0000" .. L["available_in_phase_"] .. phase .. "\124r");
					end
					GameTooltip:Show();
				end
			end
			onEnter_identity = onEnter_identity + 1;
			if onEnter_identity >= 4294967295 then
				onEnter_identity = 1;
			end
			local identity = onEnter_identity;
			C_Timer.After(0.15, function()
				if onEnter_identity ~= identity then
					return;
				end
				local red, yellow, green, grey = prof.db_get_difficult(pid, cid);
				if red and yellow and green and grey then
					if red < yellow then
						GameTooltip:AddDoubleLine(L["rank_level"] .. ":", "\124cffff8f00" .. red .. " \124cffffff00" .. yellow .. " \124cff8fff00" .. green .. " \124cff8f8f8f" .. grey);
					else
						GameTooltip:AddDoubleLine(L["rank_level"] .. ":", "\124cffffff00" .. yellow .. " \124cff8fff00" .. green .. " \124cff8f8f8f" .. grey);
					end
					GameTooltip:Show();
				end
				if data < 0 then
					prof.set_tooltip(pid, cid);
				end
			end);
		end
		local drop_add_fav = {
			handler = function(_, ...) add_to_fav(...); end,
			text = L["add_fav"],
			para = {  },
		};
		local drop_sub_fav = {
			handler = function(_, ...) sub_to_fav(...); end,
			text = L["sub_fav"],
			para = {  },
		};
		local drop = {
			handler = _noop_,
			elements = {  },
		};
		local function button_OnClick(self, button)
			local meta = self.meta;
			local list = self.list;
			local hash = self.hash;
			local cid = list[self:GetDataIndex()];
			if type(cid) == 'table' then
				cid = cid[1];
			end
			if button == "LeftButton" then
				local data = hash[cid];
				if IsShiftKeyDown() then
					local link = nil;
					if data > 0 then
						link = meta.link(data);
					else
						local _;
						_, link = meta.itemInfo(cid);
					end
					ChatEdit_InsertLink(link, ADDON);
					-- local editBox = ChatEdit_ChooseBoxForSend();
					-- editBox:Show();
					-- editBox:SetFocus();
					-- editBox:Insert(link);
				elseif IsAltKeyDown() then
					local text1 = nil;
					local text2 = nil;
					if data > 0 then
						local n = meta.num_reagent(data);
						if n and n > 0 then
							local m1, m2 = meta.num_made(data);
							if m1 == m2 then
								text1 = meta.link(data) .. "x" .. m1 .. L["Needs: "];
							else
								text1 = meta.link(data) .. "x" .. m1 .. "-" .. m2 .. L["Needs: "];
							end
							text2 = "";
							if n > 4 then
								for i = 1, n do
									text2 = text2 .. meta.reagent_info(data, i) .. "x" .. select(3, meta.reagent_info(data, i));
								end
							else
								for i = 1, n do
									text2 = text2 .. meta.reagent_link(data, i) .. "x" .. select(3, meta.reagent_info(data, i));
								end
							end
						end
					else
						local pid = prof.db_get_pid(meta.pinfo());
						local info = prof.db_get_recipe_info(pid, cid);
						if info then
							text1 = (select(2, meta.itemInfo(cid)) or L["Unk"]) .. "x" .. (info[index_num_made_min] == info[index_num_made_max] and info[index_num_made_min] or (info[index_num_made_min] .. "-" .. info[index_num_made_max])) .. L["Needs: "];
							text2 = "";
							if #info[index_reagents_id] > 4 then
								for i = 1, #info[index_reagents_id] do
									text2 = text2 .. (GetItemInfo(info[index_reagents_id][i]) or L["Unk"]) .. "x" .. info[index_reagents_count][i];
								end
							else
								for i = 1, #info[index_reagents_id] do
									text2 = text2 .. (select(2, GetItemInfo(info[index_reagents_id][i])) or L["Unk"]) .. "x" .. info[index_reagents_count][i];
								end
							end
						end
					end
					if text1 and text2 then
						local editBox = ChatEdit_ChooseBoxForSend();
						editBox:Show();
						editBox:SetFocus();
						editBox:Insert(text1 .. " " .. text2);
						-- ChatEdit_InsertLink(text1 .. " " .. text2, false);
					end
				elseif IsControlKeyDown() then
					-- if meta.craft and data > 0 then
					-- 	-- local cur = time();
					-- 	-- if self.prev and self.prev <= cur then
					-- 	-- 	self.prev = nil;
					-- 		meta.craft(data);
					-- 	-- else
					-- 		-- self.prev = cur + 0.5;
					-- 	-- end
					-- end
					--	IsDressableItem
					local link = nil;
					if data > 0 then
						link = meta.link(data);
					else
						local _;
						_, link = meta.itemInfo(cid);
					end
					if link then
						DressUpItemLink(link);
					end
				else
					if data < 0 then
						return;
					end
					meta.select(data);
					meta.update();
					self.searchEdit:ClearFocus();
					local num = meta.recipe_num();
					local minVal, maxVal = meta.scroll:GetMinMaxValues();
					local step = meta.scroll:GetValueStep();
					local cur = meta.scroll:GetValue() + step;
					local value = step * (data - 1);
					if value < cur or value > (cur + num * step - maxVal) then
						meta.scroll:SetValue(min(maxVal, value));
					end
					-- prof.funcToSetButton(self, self:GetDataIndex());
					self.frame.scroll:Update();
				end
			elseif button == "RightButton" then
				self.searchEdit:ClearFocus();
				local name, sub = meta.info(hash[cid]);
				if sub ~= 'header' then
					local pid = prof.db_get_pid(meta.pname());
					local sv = config[pid];
					if sv[cid] then
						drop_sub_fav.para[1] = self.frameframe or self.frame;
						drop_sub_fav.para[2] = sv;
						drop_sub_fav.para[3] = cid;
						drop.elements[1] = drop_sub_fav;
					else
						drop_add_fav.para[1] = self.frameframe or self.frame;
						drop_add_fav.para[2] = sv;
						drop_add_fav.para[3] = cid;
						drop.elements[1] = drop_add_fav;
					end
					ALADROP(self, "BOTTOMLEFT", drop);
				end
			end
		end
		function prof.funcToCreateProfitButton(parent, index, buttonHeight)
			local button = CreateFrame("Button", nil, parent);
			button:SetHeight(buttonHeight);
			button:SetBackdrop(ui_style.buttonBackdrop);
			button:SetBackdropColor(unpack(ui_style.buttonBackdropColor));
			button:SetBackdropBorderColor(unpack(ui_style.buttonBackdropBorderColor));
			button:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar");
			button:EnableMouse(true);
			button:Show();

			local icon = button:CreateTexture(nil, "BORDER");
			icon:SetTexture("Interface\\Icons\\inv_misc_questionmark");
			icon:SetSize(buttonHeight - 4, buttonHeight - 4);
			icon:SetPoint("LEFT", 8, 0);
			button.icon = icon;

			local title = button:CreateFontString(nil, "OVERLAY");
			title:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
			title:SetPoint("LEFT", icon, "RIGHT", 4, 0);
			title:SetWidth(160);
			title:SetMaxLines(1);
			title:SetJustifyH("LEFT");
			button.title = title;

			local note = button:CreateFontString(nil, "ARTWORK");
			note:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
			note:SetPoint("RIGHT", -4, 0);
			button.note = note;

			local quality_glow = button:CreateTexture(nil, "ARTWORK");
			quality_glow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border");
			quality_glow:SetBlendMode("ADD");
			quality_glow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
			quality_glow:SetSize(buttonHeight - 2, buttonHeight - 2);
			quality_glow:SetPoint("CENTER", icon);
			-- quality_glow:SetAlpha(0.75);
			quality_glow:Show();
			button.quality_glow = quality_glow;

			local star = button:CreateTexture(nil, "OVERLAY");
			star:SetTexture("interface\\collections\\collections");
			star:SetTexCoord(100 / 512, 118 / 512, 10 / 512, 28 / 512);
			star:SetSize(buttonHeight * 0.75, buttonHeight * 0.75);
			star:SetPoint("CENTER", button, "TOPLEFT", buttonHeight * 0.25, - buttonHeight * 0.25);
			star:Hide();
			button.star = star;

			local glow = button:CreateTexture(nil, "OVERLAY");
			glow:SetTexture("Interface\\Buttons\\WHITE8X8");
			-- glow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
			glow:SetVertexColor(0.25, 0.25, 0.25, 0.75);
			glow:SetAllPoints(true);
			glow:SetBlendMode("ADD");
			glow:Hide();
			button.glow = glow;

			button:SetScript("OnEnter", button_OnEnter);
			button:SetScript("OnLeave", button_info_OnLeave);
			button:RegisterForClicks("AnyUp");
			button:SetScript("OnClick", button_OnClick);
			button:RegisterForDrag("LeftButton");
			button:SetScript("OnHide", function()
				ALADROP(button);
			end);

			function button:Select()
				glow:Show();
			end
			function button:Deselect()
				glow:Hide();
			end

			local frame = parent:GetParent():GetParent();
			button.frame = frame;
			button.frameframe = frame:GetParent();
			button.meta = frame.meta;
			button.list = frame.list;
			button.hash = frame.hash;
			button.searchEdit = frame:GetParent().searchEdit;

			return button;
		end
		function prof.funcToSetProfitButton(button, data_index)
			local list = button.list;
			local hash = button.hash;
			ALADROP(button);
			if data_index <= #list then
				local meta = button.meta;
				local pid = prof.db_get_pid(meta.pname());
				if not pid then
					button:Hide();
					return;
				end
				local cid = list[data_index][1];
				local data = hash[cid];
				if data > 0 then
					local name, rank, num = meta.info(data);
					if not name then
						button:Hide();
						return;
					end
					if rank == 'header' then
						button:Hide();
						return;
					end
					button:Show();
					local _, _, quality = meta.itemInfo(cid);
					button.icon:SetTexture(meta.icon(data));
					button.icon:SetVertexColor(1.0, 1.0, 1.0, 1.0);
					if num > 0 then
						button.title:SetText(name .. " [" .. num .. "]");
					else
						button.title:SetText(name);
					end
					button.title:SetTextColor(unpack(rank_color[rank]));
					button.note:SetText(merc.MoneyString(list[data_index][2]));
					if quality then
						local r, g, b, code = GetItemQualityColor(quality);
						button.quality_glow:SetVertexColor(r, g, b);
						button.quality_glow:Show();
					else
						button.quality_glow:Hide();
					end
					if config[pid][cid] then
						button.star:Show();
					else
						button.star:Hide();
					end
					if GetMouseFocus() == button then
						button_OnEnter(button);
					end
					if data == meta.get_select() then
						button:Select();
					else
						button:Deselect();
					end
				else
					if pid and prof.db_exist_recipe_info(pid) then
						local info = prof.db_get_recipe_info(pid, cid);
						if not info then
							button:Hide();
							return;
						end
						button:Show();
						local _, link, quality, _, _, _, _, _, _, icon = meta.itemInfo(cid);
						local name = GetSpellInfo(info[index_sid]);
						button.icon:SetTexture(icon);
						button.icon:SetVertexColor(1.0, 0.0, 0.0, 1.0);
						button.title:SetText(name);
						button.title:SetTextColor(1.0, 0.0, 0.0, 1.0);
						button.note:SetText(merc.MoneyString(list[data_index][2]));
						if quality then
							local r, g, b, code = GetItemQualityColor(quality);
							button.quality_glow:SetVertexColor(r, g, b);
							button.quality_glow:Show();
						else
							button.quality_glow:Hide();
						end
						if config[pid][cid] then
							button.star:Show();
						else
							button.star:Hide();
						end
						if GetMouseFocus() == button then
							button_OnEnter(button);
						end
						button:Deselect();
					else
						button:Hide();
					end
				end
			else
				button:Hide();
			end
		end
		function prof.funcToCreateButton(parent, index, buttonHeight)
			local button = CreateFrame("Button", nil, parent);
			button:SetHeight(buttonHeight);
			button:SetBackdrop(ui_style.buttonBackdrop);
			button:SetBackdropColor(unpack(ui_style.buttonBackdropColor));
			button:SetBackdropBorderColor(unpack(ui_style.buttonBackdropBorderColor));
			button:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar");
			button:EnableMouse(true);
			button:Show();

			local icon = button:CreateTexture(nil, "BORDER");
			icon:SetTexture("Interface\\Icons\\inv_misc_questionmark");
			icon:SetSize(buttonHeight - 4, buttonHeight - 4);
			icon:SetPoint("LEFT", 8, 0);
			button.icon = icon;

			local title = button:CreateFontString(nil, "OVERLAY");
			title:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
			title:SetPoint("LEFT", icon, "RIGHT", 4, 0);
			title:SetWidth(160);
			title:SetMaxLines(1);
			title:SetJustifyH("LEFT");
			button.title = title;

			local note = button:CreateFontString(nil, "ARTWORK");
			note:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
			note:SetPoint("RIGHT", -4, 0);
			button.note = note;

			local quality_glow = button:CreateTexture(nil, "ARTWORK");
			quality_glow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border");
			quality_glow:SetBlendMode("ADD");
			quality_glow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
			quality_glow:SetSize(buttonHeight - 2, buttonHeight - 2);
			quality_glow:SetPoint("CENTER", icon);
			-- quality_glow:SetAlpha(0.75);
			quality_glow:Show();
			button.quality_glow = quality_glow;

			local star = button:CreateTexture(nil, "OVERLAY");
			star:SetTexture("interface\\collections\\collections");
			star:SetTexCoord(100 / 512, 118 / 512, 10 / 512, 28 / 512);
			star:SetSize(buttonHeight * 0.75, buttonHeight * 0.75);
			star:SetPoint("CENTER", button, "TOPLEFT", buttonHeight * 0.25, - buttonHeight * 0.25);
			star:Hide();
			button.star = star;

			local glow = button:CreateTexture(nil, "OVERLAY");
			glow:SetTexture("Interface\\Buttons\\WHITE8X8");
			-- glow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
			glow:SetVertexColor(0.25, 0.25, 0.25, 0.75);
			glow:SetAllPoints(true);
			glow:SetBlendMode("ADD");
			glow:Hide();
			button.glow = glow;

			button:SetScript("OnEnter", button_OnEnter);
			button:SetScript("OnLeave", button_info_OnLeave);
			button:RegisterForClicks("AnyUp");
			button:SetScript("OnClick", button_OnClick);
			button:RegisterForDrag("LeftButton");
			button:SetScript("OnHide", function()
				ALADROP(button);
			end);

			function button:Select()
				glow:Show();
			end
			function button:Deselect()
				glow:Hide();
			end

			local frame = parent:GetParent():GetParent();
			button.frame = frame;
			button.meta = frame.meta;
			button.list = frame.list;
			button.hash = frame.hash;
			button.searchEdit = frame.searchEdit;

			return button;
		end
		function prof.funcToSetButton(button, data_index)
			local list = button.list;
			local hash = button.hash;
			ALADROP(button);
			if data_index <= #list then
				local meta = button.meta;
				local pid = prof.db_get_pid(meta.pname());
				if not pid then
					button:Hide();
					return;
				end
				local cid = list[data_index];
				local data = hash[cid];
				if data > 0 then
					local name, rank, num = meta.info(data);
					if not name then
						button:Hide();
						return;
					end
					if rank == 'header' then
						button:Hide();
						return;
					end
					button:Show();
					local _, _, quality = meta.itemInfo(cid);
					button.icon:SetTexture(meta.icon(data));
					button.icon:SetVertexColor(1.0, 1.0, 1.0, 1.0);
					if num > 0 then
						button.title:SetText(name .. " [" .. num .. "]");
					else
						button.title:SetText(name);
					end
					button.title:SetTextColor(unpack(rank_color[rank]));
					local C = config[pid];
					if C.showRank then
						button.note:SetText(prof.db_get_difficult_text(meta.pinfo(), cid));
					else
						button.note:SetText("");
					end
					if quality then
						local r, g, b, code = GetItemQualityColor(quality);
						button.quality_glow:SetVertexColor(r, g, b);
						button.quality_glow:Show();
					else
						button.quality_glow:Hide();
					end
					if C[cid] then
						button.star:Show();
					else
						button.star:Hide();
					end
					if GetMouseFocus() == button then
						button_OnEnter(button);
					end
					if data == meta.get_select() then
						button:Select();
					else
						button:Deselect();
					end
				else
					if pid and prof.db_exist_recipe_info(pid) then
						local info = prof.db_get_recipe_info(pid, cid);
						if not info then
							button:Hide();
							return;
						end
						button:Show();
						local _, link, quality, _, _, _, _, _, _, icon = meta.itemInfo(cid);
						local name = GetSpellInfo(info[index_sid]);
						button.icon:SetTexture(icon);
						button.icon:SetVertexColor(1.0, 0.0, 0.0, 1.0);
						button.title:SetText(name);
						button.title:SetTextColor(1.0, 0.0, 0.0, 1.0);
						local C = config[pid];
						if C.showRank then
							button.note:SetText(prof.db_get_difficult_text(meta.pinfo(), cid));
						else
							button.note:SetText("");
						end
						if quality then
							local r, g, b, code = GetItemQualityColor(quality);
							button.quality_glow:SetVertexColor(r, g, b);
							button.quality_glow:Show();
						else
							button.quality_glow:Hide();
						end
						if C[cid] then
							button.star:Show();
						else
							button.star:Hide();
						end
						if GetMouseFocus() == button then
							button_OnEnter(button);
						end
						button:Deselect();
					else
						button:Hide();
					end
				end
			else
				button:Hide();
			end
		end
		function prof.toggle_cover_mode(frame, enabled)
			if frame.cover_mode == enabled then
				return;
			end
			frame.cover_mode = enabled;
			local hooked = frame.hooked;
			local meta = frame.meta;
			if enabled then
				frame:ClearAllPoints();
				frame:SetPoint("TOP", meta.cover_anchor_top, "BOTTOM", 0, 0);
				frame:SetPoint("BOTTOM", meta.cover_anchor_bottom, "BOTTOM", 0, - 4);
				frame:SetPoint("LEFT", meta.cover_anchor_left, "LEFT", - 8, 0);
				frame:SetPoint("RIGHT", meta.cover_anchor_right, "RIGHT", 8, 0);
				frame.configFrame:ClearAllPoints();
				frame.configFrame:SetPoint("LEFT", frame);
				frame.configFrame:SetPoint("RIGHT", frame);
				frame.configFrame:SetPoint("BOTTOM", frame.call, "TOP", 0, 0);
				meta.clear_filter();
			else
				frame:ClearAllPoints();
				frame:SetPoint("TOPLEFT", meta.normal_anchor_top, "TOPRIGHT", - 4, 0);
				frame:SetPoint("BOTTOMLEFT", meta.normal_anchor_bottom, "BOTTOMRIGHT", - 4, 0);
				local pid = prof.db_get_pid(meta.pname());
				if pid and config[pid].showRank then
					frame:SetWidth(ui_style.frame_width);
				else
					frame:SetWidth(ui_style.frame_width_narrow);
				end
				frame.configFrame:ClearAllPoints();
				frame.configFrame:SetPoint("LEFT", frame);
				frame.configFrame:SetPoint("RIGHT", frame);
				frame.configFrame:SetPoint("BOTTOM", frame, "TOP", 0, 0);
			end
		end
		function prof.hook(hooked, meta)
			local frame = CreateFrame("Frame", nil, hooked);
			frame.hooked = hooked;
			frame.meta = meta;
			frame.list = {  };
			frame.hash = {  };
			frame.filter = nil;
			frame:SetBackdrop(ui_style.frameBackdrop);
			frame:SetBackdropColor(unpack(ui_style.frameBackdropColor));
			frame:SetBackdropBorderColor(unpack(ui_style.frameBackdropBorderColor));
			frame:SetWidth(ui_style.frame_width);
			frame:SetFrameStrata("HIGH");
			frame:EnableMouse(true);
			frame:Hide();

			local scroll = ALASCR(frame, nil, nil, ui_style.button_height, prof.funcToCreateButton, prof.funcToSetButton);
			scroll:SetPoint("BOTTOMLEFT", 4, 4);
			scroll:SetPoint("TOPRIGHT", - 4, - 24);
			frame.scroll = scroll;

			function frame.update_func()
				if not frame.mute_update then
					prof.process_update(frame);
				end
			end

			do	-- search_box
				local searchEditOK = CreateFrame("Button", nil, frame);
				searchEditOK:SetSize(32, 16);
				searchEditOK:SetPoint("TOPRIGHT", frame, "TOPRIGHT", - 24, - 4);
				searchEditOK:Disable();
				local searchEditOKTexture = searchEditOK:CreateTexture(nil, "ARTWORK");
				searchEditOKTexture:SetPoint("TOPLEFT");
				searchEditOKTexture:SetPoint("BOTTOMRIGHT");
				searchEditOKTexture:SetColorTexture(0.25, 0.25, 0.25, 0.5);
				searchEditOKTexture:SetAlpha(0.75);
				searchEditOKTexture:SetBlendMode("ADD");
				local searchEditOKText = searchEditOK:CreateFontString(nil, "OVERLAY");
				searchEditOKText:SetFont(ui_style.frameFont, ui_style.frameFontSize);
				searchEditOKText:SetTextColor(1.0, 1.0, 1.0, 0.5);
				searchEditOKText:SetPoint("CENTER");
				searchEditOKText:SetText(L["OK"]);
				searchEditOK:SetFontString(searchEditOKText);
				searchEditOK:SetPushedTextOffset(1, - 1);

				local searchEdit = CreateFrame("EditBox", nil, frame);
				searchEdit:SetHeight(16);
				searchEdit:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				searchEdit:SetAutoFocus(false);
				searchEdit:SetJustifyH("LEFT");
				searchEdit:Show();
				searchEdit:EnableMouse(true);
				searchEdit:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, - 4);
				searchEdit:SetPoint("RIGHT", searchEditOK, "LEFT", - 4, 0);
				local searchEditTexture = searchEdit:CreateTexture(nil, "ARTWORK");
				searchEditTexture:SetPoint("TOPLEFT");
				searchEditTexture:SetPoint("BOTTOMRIGHT");
				searchEditTexture:SetTexture("Interface\\Buttons\\greyscaleramp64");
				searchEditTexture:SetTexCoord(0.0, 0.25, 0.0, 0.25);
				searchEditTexture:SetAlpha(0.75);
				searchEditTexture:SetBlendMode("ADD");
				searchEditTexture:SetVertexColor(0.25, 0.25, 0.25);
				local searchEditNote = searchEdit:CreateFontString(nil, "OVERLAY");
				searchEditNote:SetFont(ui_style.frameFont, ui_style.frameFontSize);
				searchEditNote:SetTextColor(1.0, 1.0, 1.0, 0.5);
				searchEditNote:SetPoint("LEFT", 4, 0);
				searchEditNote:SetText(L["Search"]);
				searchEditNote:Show();
				local searchCancel = CreateFrame("Button", nil, searchEdit);
				searchCancel:SetSize(16, 16);
				searchCancel:SetPoint("RIGHT", searchEdit);
				searchCancel:Hide();
				searchCancel:SetNormalTexture("interface\\petbattles\\deadpeticon")

				searchCancel:SetScript("OnClick", function(self) searchEdit:SetText(""); searchEdit:ClearFocus(); end);
				searchEditOK:SetScript("OnClick", function(self) searchEdit:ClearFocus(); end);
				searchEditOK:SetScript("OnEnable", function(self) searchEditOKText:SetTextColor(1.0, 1.0, 1.0, 1.0); end);
				searchEditOK:SetScript("OnDisable", function(self) searchEditOKText:SetTextColor(1.0, 1.0, 1.0, 0.5); end);

				searchEdit:SetScript("OnEnterPressed", function(self) self:ClearFocus(); end);
				searchEdit:SetScript("OnEscapePressed", function(self) self:ClearFocus(); end);
				function frame:Search(text)
					local pid = prof.db_get_pid(meta.pname());
					if pid then
						config[pid].searchText = text;
					end
					if text == "" then
						frame.filter = nil;
						if not searchEdit:HasFocus() then
							searchEditNote:Show();
						end
						searchCancel:Hide();
					else
						frame.filter = text;
						searchCancel:Show();
						searchEditNote:Hide();
					end
					_EventHandler:frame_update_on_next_tick(frame);
				end
				searchEdit:SetScript("OnTextChanged", function(self, isUserInput)
					frame:Search(searchEdit:GetText());
				end);
				searchEdit:SetScript("OnEditFocusGained", function(self)
					searchEditNote:Hide();
					searchEditOK:Enable();
				end);
				searchEdit:SetScript("OnEditFocusLost", function(self)
					if searchEdit:GetText() == "" then
						searchEditNote:Show();
					end
					searchEditOK:Disable();
				end);
				searchEdit:ClearFocus();
				frame.searchEdit = searchEdit;
				frame.searchEditOK = searchEditOK;
			end

			do	-- I feel lucky
				local call = CreateFrame("Button", nil, frame);
				call:SetSize(20, 20);
				call:SetNormalTexture("interface\\buttons\\ui-grouploot-coin-up");
				call:SetPushedTexture("interface\\buttons\\ui-grouploot-coin-down");
				call:SetHighlightTexture("interface\\buttons\\ui-grouploot-coin-highlight");
				call:SetPoint("RIGHT", meta.normal_anchor_top, "LEFT", - 2, -2);
				call:SetScript("OnEnter", button_info_OnEnter);
				call:SetScript("OnLeave", button_info_OnLeave);
				call.info_lines = {};
				local temp_id = 1;
				while true do
					local line = L["PROFIT_FRAME_CALL_INFO" .. temp_id];
					if line then
						tinsert(call.info_lines, line);
					else
						break;
					end
					temp_id = temp_id + 1;
				end
				local profitFrame = CreateFrame("Frame", nil, frame);
				profitFrame.meta = meta;
				profitFrame.list = {  };
				profitFrame.hash = {  };
				profitFrame:SetBackdrop(ui_style.frameBackdrop);
				profitFrame:SetBackdropColor(unpack(ui_style.frameBackdropColor));
				profitFrame:SetBackdropBorderColor(unpack(ui_style.frameBackdropBorderColor));
				profitFrame:SetFrameStrata("HIGH");
				profitFrame:EnableMouse(true);
				profitFrame:Hide();
				profitFrame:SetSize(320, 320);
				profitFrame:SetPoint("TOPLEFT", frame, "TOPRIGHT", 2, 0);
				local close = CreateFrame("Button", nil, profitFrame);
				close:SetSize(16, 16);
				close:SetNormalTexture("interface\\common\\voicechat-muted");
				close:GetNormalTexture():SetTexCoord(0.0, 0.95, 0.0, 1.0);
				close:SetPushedTexture("interface\\common\\voicechat-muted");
				close:GetPushedTexture():SetTexCoord(0.05, 1.0, 0.0, 1.0);
				close:SetHighlightTexture("interface\\common\\voicechat-muted");
				close:SetPoint("CENTER", profitFrame, "TOPRIGHT", 0, 0);
				close:SetScript("OnClick", function()
					local pid = prof.db_get_pid(meta.pname());
					if pid then
						config[pid].showProfit = false;
					end
					profitFrame:Hide();
				end);
				profitFrame.close = close;
				local scroll = ALASCR(profitFrame, nil, nil, ui_style.button_height, prof.funcToCreateProfitButton, prof.funcToSetProfitButton);
				scroll:SetPoint("BOTTOMLEFT", 4, 4);
				scroll:SetPoint("TOPRIGHT", - 4, - 4);
				profitFrame.scroll = scroll;
				call:SetScript("OnClick", function()
					if not merc then
						return;
					end
					local pid = prof.db_get_pid(meta.pname());
					if pid then
						config[pid].showProfit = not profitFrame:IsShown();
					end
					if profitFrame:IsShown() then
						profitFrame:Hide();
					else
						profitFrame:Show();
						if frame:IsShown() then
						end
					end
				end);
				profitFrame:SetScript("OnShow", function()
					if not merc then
						profitFrame:Hide();
					end
					prof.process_profit_update(profitFrame, frame);
					call:SetNormalTexture("interface\\buttons\\ui-grouploot-coin-down");
					call:SetPushedTexture("interface\\buttons\\ui-grouploot-coin-up");
				end);
				profitFrame:SetScript("OnHide", function()
					call:SetNormalTexture("interface\\buttons\\ui-grouploot-coin-up");
					call:SetPushedTexture("interface\\buttons\\ui-grouploot-coin-down");
				end);
				frame.profitCall = call;
				frame.profitFrame = profitFrame;
			end

			do	-- config_frame
				local configFrame = CreateFrame("Frame", nil, frame);
				configFrame:SetBackdrop(ui_style.frameBackdrop);
				configFrame:SetBackdropColor(unpack(ui_style.frameBackdropColor));
				configFrame:SetBackdropBorderColor(unpack(ui_style.frameBackdropBorderColor));
				configFrame:SetFrameStrata("HIGH");
				configFrame:Hide();
				configFrame:SetHeight(96);
				frame.configFrame = configFrame;

				local button = CreateFrame("Button", nil, frame);
				button:SetSize(16, 16);
				button:SetNormalTexture("interface\\buttons\\ui-optionsbutton");
				button:SetPoint("TOPRIGHT", frame, "TOPRIGHT", - 4, - 4);
				button:SetScript("OnClick", function()
					local pid = prof.db_get_pid(meta.pname());
					if configFrame:IsShown() then
						configFrame:Hide();
						if pid then
							config[pid].showConfig = false;
						end
					else
						configFrame:Show();
						if pid then
							config[pid].showConfig = true;
						end
					end
				end);

				local showUnkownCheckBox = CreateFrame("CheckButton", nil, configFrame, "OptionsBaseCheckButtonTemplate");
				showUnkownCheckBox:SetSize(24, 24);
				showUnkownCheckBox:SetHitRectInsets(0, 0, 0, 0);
				showUnkownCheckBox:ClearAllPoints();
				showUnkownCheckBox:Show();
				showUnkownCheckBox:SetChecked(false);
				showUnkownCheckBox:SetPoint("TOPLEFT", 4, 0);
				showUnkownCheckBox:SetScript("OnClick", function(self)
					local pid = prof.db_get_pid(meta.pname());
					if pid then
						config[pid].showUnkown = showUnkownCheckBox:GetChecked();
					end
					_EventHandler:frame_update_on_next_tick(frame);
				end);
				configFrame.showUnkownCheckBox = showUnkownCheckBox;

				local showUnkownCheckBoxFontString = configFrame:CreateFontString(nil, "ARTWORK");
				showUnkownCheckBoxFontString:SetFont(ui_style.frameFont, 13, "OUTLINE");
				showUnkownCheckBoxFontString:SetText(L["showUnkown"]);
				showUnkownCheckBox.fontString = showUnkownCheckBoxFontString;
				showUnkownCheckBoxFontString:SetPoint("LEFT", showUnkownCheckBox, "RIGHT", 0, 0);

				local showKnownCheckBox = CreateFrame("CheckButton", nil, configFrame, "OptionsBaseCheckButtonTemplate");
				showKnownCheckBox:SetSize(24, 24);
				showKnownCheckBox:SetHitRectInsets(0, 0, 0, 0);
				showKnownCheckBox:ClearAllPoints();
				showKnownCheckBox:Show();
				showKnownCheckBox:SetChecked(false);
				showKnownCheckBox:SetPoint("LEFT", showUnkownCheckBox, "LEFT", 78, 0);
				showKnownCheckBox:SetScript("OnClick", function(self)
					local pid = prof.db_get_pid(meta.pname());
					if pid then
						config[pid].showKnown = showKnownCheckBox:GetChecked();
					end
					_EventHandler:frame_update_on_next_tick(frame);
				end);
				configFrame.showKnownCheckBox = showKnownCheckBox;

				local showKnownCheckBoxFontString = configFrame:CreateFontString(nil, "ARTWORK");
				showKnownCheckBoxFontString:SetFont(ui_style.frameFont, 13, "OUTLINE");
				showKnownCheckBoxFontString:SetText(L["showKnown"]);
				showKnownCheckBox.fontString = showKnownCheckBoxFontString;
				showKnownCheckBoxFontString:SetPoint("LEFT", showKnownCheckBox, "RIGHT", 0, 0);

				local showHighRankCheckBox = CreateFrame("CheckButton", nil, configFrame, "OptionsBaseCheckButtonTemplate");
				showHighRankCheckBox:SetSize(24, 24);
				showHighRankCheckBox:SetHitRectInsets(0, 0, 0, 0);
				showHighRankCheckBox:ClearAllPoints();
				showHighRankCheckBox:Show();
				showHighRankCheckBox:SetChecked(false);
				showHighRankCheckBox:SetPoint("LEFT", showKnownCheckBox, "LEFT", 78, 0);
				showHighRankCheckBox:SetScript("OnClick", function(self)
					local pid = prof.db_get_pid(meta.pname());
					if pid then
						config[pid].showHighRank = showHighRankCheckBox:GetChecked();
					end
					_EventHandler:frame_update_on_next_tick(frame);
				end);
				configFrame.showHighRankCheckBox = showHighRankCheckBox;

				local showHighRankCheckBoxFontString = configFrame:CreateFontString(nil, "ARTWORK");
				showHighRankCheckBoxFontString:SetFont(ui_style.frameFont, 13, "OUTLINE");
				showHighRankCheckBoxFontString:SetText(L["showHighRank"]);
				showHighRankCheckBox.fontString = showHighRankCheckBoxFontString;
				showHighRankCheckBoxFontString:SetPoint("LEFT", showHighRankCheckBox, "RIGHT", 0, 0);

				local showItemInsteadOfSpellCheckBox = CreateFrame("CheckButton", nil, configFrame, "OptionsBaseCheckButtonTemplate");
				showItemInsteadOfSpellCheckBox:SetSize(24, 24);
				showItemInsteadOfSpellCheckBox:SetHitRectInsets(0, 0, 0, 0);
				showItemInsteadOfSpellCheckBox:ClearAllPoints();
				showItemInsteadOfSpellCheckBox:Show();
				showItemInsteadOfSpellCheckBox:SetChecked(false);
				showItemInsteadOfSpellCheckBox:SetPoint("TOPLEFT", showUnkownCheckBox, "BOTTOMLEFT", 0, 0);
				showItemInsteadOfSpellCheckBox:SetScript("OnClick", function(self)
					local pid = prof.db_get_pid(meta.pname());
					if pid then
						config[pid].showItemInsteadOfSpell = showItemInsteadOfSpellCheckBox:GetChecked();
					end
					frame.scroll:Update();
				end);
				configFrame.showItemInsteadOfSpellCheckBox = showItemInsteadOfSpellCheckBox;

				local showItemInsteadOfSpellCheckBoxFontString = configFrame:CreateFontString(nil, "ARTWORK");
				showItemInsteadOfSpellCheckBoxFontString:SetFont(ui_style.frameFont, 13, "OUTLINE");
				showItemInsteadOfSpellCheckBoxFontString:SetText(L["showItemInsteadOfSpell"]);
				showItemInsteadOfSpellCheckBox.fontString = showItemInsteadOfSpellCheckBoxFontString;
				showItemInsteadOfSpellCheckBoxFontString:SetPoint("LEFT", showItemInsteadOfSpellCheckBox, "RIGHT", 0, 0);

				local showRankCheckBox = CreateFrame("CheckButton", nil, configFrame, "OptionsBaseCheckButtonTemplate");
				showRankCheckBox:SetSize(24, 24);
				showRankCheckBox:SetHitRectInsets(0, 0, 0, 0);
				showRankCheckBox:ClearAllPoints();
				showRankCheckBox:Show();
				showRankCheckBox:SetChecked(false);
				showRankCheckBox:SetPoint("LEFT", showItemInsteadOfSpellCheckBox, "LEFT", 78, 0);
				showRankCheckBox:SetScript("OnClick", function(self)
					local pid = prof.db_get_pid(meta.pname());
					if pid then
						config[pid].showRank = showRankCheckBox:GetChecked();
						if not config[pid].coverMode then
							if config[pid].showRank then
								frame:SetWidth(ui_style.frame_width);
							else
								frame:SetWidth(ui_style.frame_width_narrow);
							end
						end
					end
					-- _EventHandler:frame_update_on_next_tick(frame);
					frame.scroll:Update();
				end);
				configFrame.showRankCheckBox = showRankCheckBox;

				local showRankCheckBoxFontString = configFrame:CreateFontString(nil, "ARTWORK");
				showRankCheckBoxFontString:SetFont(ui_style.frameFont, 13, "OUTLINE");
				showRankCheckBoxFontString:SetText(L["showRank"]);
				showRankCheckBox.fontString = showRankCheckBoxFontString;
				showRankCheckBoxFontString:SetPoint("LEFT", showRankCheckBox, "RIGHT", 0, 0);

				local coverModeCheckBox = CreateFrame("CheckButton", nil, configFrame, "OptionsBaseCheckButtonTemplate");
				coverModeCheckBox:SetSize(24, 24);
				coverModeCheckBox:SetHitRectInsets(0, 0, 0, 0);
				coverModeCheckBox:ClearAllPoints();
				coverModeCheckBox:Show();
				coverModeCheckBox:SetChecked(false);
				coverModeCheckBox:SetPoint("LEFT", showRankCheckBox, "LEFT", 78, 0);
				coverModeCheckBox:SetScript("OnClick", function(self)
					local pid = prof.db_get_pid(meta.pname());
					if pid then
						config[pid].coverMode = coverModeCheckBox:GetChecked();
					end
					prof.toggle_cover_mode(frame, config[pid].coverMode);
				end);
				configFrame.coverModeCheckBox = coverModeCheckBox;

				local coverModeCheckBoxFontString = configFrame:CreateFontString(nil, "ARTWORK");
				coverModeCheckBoxFontString:SetFont(ui_style.frameFont, 13, "OUTLINE");
				coverModeCheckBoxFontString:SetText(L["coverMode"]);
				coverModeCheckBox.fontString = coverModeCheckBoxFontString;
				coverModeCheckBoxFontString:SetPoint("LEFT", coverModeCheckBox, "RIGHT", 0, 0);

				local phaseSlider = CreateFrame("Slider", nil, configFrame, "OptionsSliderTemplate");
				phaseSlider:ClearAllPoints();
				phaseSlider:SetPoint("BOTTOM", 0, 20);
				phaseSlider:SetPoint("LEFT", 4, 0);
				phaseSlider:SetPoint("RIGHT", -4, 0);
				phaseSlider:SetHeight(20);
				phaseSlider:SetMinMaxValues(1, 6)
				phaseSlider:SetValueStep(1);
				phaseSlider:SetObeyStepOnDrag(true);

				phaseSlider.Text:ClearAllPoints();
				phaseSlider.Text:SetPoint("TOP", phaseSlider, "BOTTOM", 0, 3);
				phaseSlider.Low:ClearAllPoints();
				phaseSlider.Low:SetPoint("TOPLEFT", phaseSlider, "BOTTOMLEFT", 4, 3);
				phaseSlider.High:ClearAllPoints();
				phaseSlider.High:SetPoint("TOPRIGHT", phaseSlider, "BOTTOMRIGHT", -4, 3);
				phaseSlider.Low:SetText("\124cff00ff001\124r");
				phaseSlider.High:SetText("\124cffff00006\124r");

				phaseSlider:HookScript("OnValueChanged", function(self, value, userInput)
					if userInput then
						local pid = prof.db_get_pid(meta.pname());
						if pid then
							config[pid].phase = value;
							_EventHandler:frame_update_on_next_tick(frame);
						end
					end
					self.Text:SetText("\124cffffff00" .. L["phase"] .. "\124r " .. value);
				end);

				function frame:RefreshConfigFrame()
					local pid = prof.db_get_pid(meta.pname());
					if pid then
						local C = config[pid];
						showUnkownCheckBox:SetChecked(C.showUnkown);
						showKnownCheckBox:SetChecked(C.showKnown);
						showHighRankCheckBox:SetChecked(C.showHighRank);
						showItemInsteadOfSpellCheckBox:SetChecked(C.showItemInsteadOfSpell);
						showRankCheckBox:SetChecked(C.showRank);
						coverModeCheckBox:SetChecked(C.coverMode);
						phaseSlider:SetValue(C.phase);
					end
				end
			end

			frame:SetScript("OnShow", function()
				_EventHandler:frame_update_on_next_tick(frame);
			end);
			if meta.hooked_update then
				for _, func_name in pairs(meta.hooked_update) do
					hooksecurefunc(func_name, function()
						_EventHandler:frame_update_on_next_tick(frame);
					end);
				end
			end
			if meta.events_update then
				for _, event in pairs(meta.events_update) do
					frame:RegisterEvent(event);
				end
				frame:SetScript("OnEvent", function(self, event, _1, ...)
					_EventHandler:frame_update_on_next_tick(frame);
				end);
			end
			if merc.add_cache_callback then
				merc.add_cache_callback(function() prof.process_update(frame); end);
			end

			local note = meta.relative_note:CreateFontString(nil, "OVERLAY");	-- rank color
			note:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
			note:SetPoint("TOPRIGHT", meta.relative_note, "TOPRIGHT", -5, -5);
			frame.note_in_frame = note;
			hooksecurefunc(meta.update_func_name, function()
				note:SetText(prof.db_get_difficult_text(meta.pinfo(), meta.itemId(meta.get_select())));
			end);
			meta.update = _G[meta.update_func_name];

			local button = CreateFrame("Button", nil, hooked, "UIPanelButtonTemplate");
			button:SetSize(80, 20);
			button:SetPoint("RIGHT", meta.normal_anchor_top, "LEFT", - 24, 0);
			button:SetText(L["Open"]);
			-- button:SetHitRectInsets(0, 0, - 4, - 4);
			button:SetFrameLevel(125);
			button:SetScript("OnClick", function()
				local pid = prof.db_get_pid(meta.pname());
				if pid then
					config[pid].shown = not frame:IsShown();
				end
				if frame:IsShown() then
					frame:Hide();
					button:SetText(L["Open"]);
				else
					frame:Show();
					button:SetText(L["Close"]);
				end
			end);
			-- button:SetScript("OnEnter", Info_OnEnter);
			-- button:SetScript("OnLeave", Info_OnLeave);

			ALA_HOOK_ChatEdit_InsertLink(function(link, addon)
				if frame.searchEdit:IsShown() and addon ~= ADDON and not (BrowseName and BrowseName:IsVisible()) then
					local name = GetItemInfo(link);
					if name and name ~= "" then
						frame.searchEdit:SetText(name);
						frame.searchEdit:ClearFocus();
						return true;
					end
				end
			end);
			ALA_HOOK_ChatEdit_InsertName(function(name, addon)
				if frame.searchEdit:IsShown() and addon ~= ADDON and not (BrowseName and BrowseName:IsVisible()) then
					if name and name ~= "" then
						frame.searchEdit:SetText(name);
						frame.searchEdit:ClearFocus();
						return true;
					end
				end
			end);

			frame.call = button;

			return frame;
		end
		function prof.toggle_mtsl(show)
			if show then
				MTSLUI_ToggleButton:SetAlpha(1);
				MTSLUI_ToggleButton:EnableMouse(true);
				MTSLUI_ToggleButton:Show();
				MTSLUI_MissingTradeSkillsFrame:SetAlpha(1);
				MTSLUI_MissingTradeSkillsFrame:EnableMouse(true);
				MTSLUI_MissingTradeSkillsFrame:Show();
			else
				MTSLUI_ToggleButton:SetAlpha(0);
				MTSLUI_ToggleButton:EnableMouse(false);
				MTSLUI_ToggleButton:Hide();
				MTSLUI_MissingTradeSkillsFrame:SetAlpha(0);
				MTSLUI_MissingTradeSkillsFrame:EnableMouse(false);
				MTSLUI_MissingTradeSkillsFrame:Hide();
			end
		end
	end

	local function price_info_func(meta, need_update)
		local index = meta.get_select();
		local price_info = meta.price_info;
		if index <= 0 then
			if price_info[1] then price_info[1]:SetText(nil); end
			if price_info[2] then price_info[2]:SetText(nil); end
			if price_info[3] then price_info[3]:SetText(nil); end
			return;
		end

		local pid = prof.db_get_pid(meta.pinfo());
		if not pid then
			return;
		end
		local cid = meta.itemId(index);
		if cid == 0 then
			return;
		end
		local nMade, minMade, maxMade = prof.db_get_tradeskill_num_made_by_pid_cid(pid, cid);
		local price_a_product, _, price_a_material, unk_in = prof.gen_price_info_by_cid(pid, cid, nMade);
		if price_a_material > 0 then
			price_info[2]:SetText(
				L["COST_PRICE"] .. ": " ..
				(unk_in > 0 and (merc.MoneyString(price_a_material) .. " (\124cffff0000" .. unk_in .. L["ITEMS_UNK"] .. "\124r)") or merc.MoneyString(price_a_material))
			);
		else
			price_info[2]:SetText(
				L["COST_PRICE"] .. ": " ..
				"\124cffff0000" .. L["Unk"] .. "\124r"
			);
		end

		if price_info[1] then
			-- local price_a_product = merc.query_ah_price_by_id(cid);
			local price_v_product = select(11, GetItemInfo(cid));
			-- local minMade, maxMade = meta.num_made(index);
			-- local nMade = (minMade + maxMade) / 2;
			-- price_a_product = price_a_product and price_a_product * nMade;
			price_v_product = price_v_product and price_v_product * nMade;
			if price_a_product and price_a_product > 0 then
				price_info[1]:SetText(
					L["AH_PRICE"] .. ": " ..
					merc.MoneyString(price_a_product) .. " (" .. L["VENDOR_RPICE"] .. (price_v_product and merc.MoneyString(price_v_product) or L["NEED_UPDATE"]) .. ")"
				);
				if price_a_material > 0 then
					local diff = price_a_product - price_a_material;
					if diff > 0 then
						price_info[3]:SetText(L["PRICE_DIFF+"] .. ": " .. merc.MoneyString(diff));
					elseif diff < 0 then
						price_info[3]:SetText(L["PRICE_DIFF-"] .. ": " .. merc.MoneyString(-diff));
					else
						price_info[3]:SetText(L["PRICE_DIFF0"]);
					end
				else
					price_info[3]:SetText(nil);
				end
			else
				price_info[1]:SetText(
					L["AH_PRICE"] .. ": " ..
					"\124cffff0000" .. L["Unk"] .. "\124r (" .. L["VENDOR_RPICE"] .. (price_v_product and merc.MoneyString(price_v_product) or L["NEED_UPDATE"]) .. ")"
				);
				price_info[3]:SetText(nil);
			end
			if need_update then
				C_Timer.After(0.5, function()
					price_info_func(meta, false);
				end);
			end
		end
	end
	function prof.hook_Blizzard_TradeSkillUI()
		local meta = {
			pname = GetTradeSkillLine,
			pinfo = GetTradeSkillLine,
			clear_filter = function()
				-- for i = 1, #GetTradeSkillSubClasses() do
				-- 	SetTradeSkillSubClassFilter(i, 0);
				-- end
				SetTradeSkillSubClassFilter(0, 1, 1);
				UIDropDownMenu_SetSelectedID(TradeSkillSubClassDropDown, 1);
				-- for i = 1, #GetTradeSkillInvSlots() do
				-- 	SetTradeSkillInvSlotFilter(i, 0);
				-- end
				SetTradeSkillInvSlotFilter(0, 1, 1);
				UIDropDownMenu_SetSelectedID(TradeSkillInvSlotDropDown, 1);
				-- for i = GetNumTradeSkills(), 1, -1 do
				-- 	local _, rank = GetTradeSkillInfo(i);
				-- 	if rank == 'header' then
				-- 		ExpandTradeSkillSubClass(i);
				-- 	end
				-- end
				ExpandTradeSkillSubClass(0);
				if TradeSkillCollapseAllButton then
					TradeSkillCollapseAllButton.collapsed = nil;
				end
			end,
			-- expand = ExpandTradeSkillSubClass,
			-- collapse = CollapseTradeSkillSubClass,
			recipe_num = GetNumTradeSkills,
			info = GetTradeSkillInfo,
				-- skillName, difficult & header, numAvailable, isExpanded = GetTradeSkillInfo(skillIndex)
			itemId = function(arg1) local link = GetTradeSkillItemLink(arg1); return link and tonumber(select(3, strfind(link, "[a-zA-Z]:(%d+)"))) or 0; end,
			link = GetTradeSkillItemLink,
			itemInfo = GetItemInfo,
			icon = GetTradeSkillIcon,
			desc = function() return ""; end,
			need = GetTradeSkillTools,
			cool = GetTradeSkillCooldown,
			num_reagent = GetTradeSkillNumReagents,
			reagent_link = GetTradeSkillReagentItemLink,
			reagent_id = function(i, j) return tonumber(select(3, strfind(GetTradeSkillReagentItemLink(i, j), "[a-zA-Z]:(%d+)"))); end,
			reagent_info = GetTradeSkillReagentInfo,
				-- name, texture, numRequired, numHave = GetTradeSkillReagentInfo(tradeSkillRecipeId, reagentId);
			select = TradeSkillFrame_SetSelection,		-- SelectTradeSkill
			get_select = GetTradeSkillSelectionIndex,
			num_made = GetTradeSkillNumMade,
			craft = DoTradeSkill,
			close = CloseTradeSkill,
			update = TradeSkillFrame_Update,
			update_func_name = "TradeSkillFrame_Update",
			scroll = TradeSkillListScrollFrameScrollBar,
			normal_anchor_top = TradeSkillFrameCloseButton,
			normal_anchor_bottom = TradeSkillCancelButton,
			cover_anchor_top = TradeSkillRankFrame,
			cover_anchor_bottom = TradeSkillListScrollFrame,
			cover_anchor_left = TradeSkillListScrollFrame,
			cover_anchor_right = TradeSkillListScrollFrameScrollBar,
			relative_note = TradeSkillDetailScrollChildFrame,
			hooked_update = {
				"TradeSkillFrame_OnShow",
				"TradeSkillInvSlotDropDownButton_OnClick",
				"TradeSkillSubClassDropDownButton_OnClick",
				-- "CollapseTradeSkillSubClass";
				-- "ExpandTradeSkillSubClass",
			};
			events_update = {
				"NEW_RECIPE_LEARNED",
				"TRADE_SKILL_UPDATE",
			};
			--[[

				CollapseTradeSkillSubClass,
				ExpandTradeSkillSubClass,

				GetTradeSkillSubClasses,
				GetTradeSkillSubClassFilter,
				SetTradeSkillSubClassFilter,
				GetTradeSkillInvSlots,
				GetTradeSkillInvSlotFilter,
				SetTradeSkillInvSlotFilter,

				GetTradeSkillItemStats,		-- unk

				GetNumPrimaryProfessions,

				SetSelectedSkill,
				GetSelectedSkill,
				GetNumSkillLines,
				GetSkillLineInfo,
				GetTradeSkillLine,
				ExpandSkillHeader,
				CollapseSkillHeader,
			--]]
		};
		local frame = prof.hook(TradeSkillFrame, meta);
		do	-- price_info
			local price_info = {  };
			meta.price_info = price_info;
			price_info[1] = TradeSkillDetailScrollChildFrame:CreateFontString(nil, "OVERLAY");
			price_info[1]:SetFont(GameFontNormal:GetFont(), 14, "OUTLINE");
			price_info[1]:SetPoint("TOPLEFT", TradeSkillDetailScrollChildFrame, "TOPLEFT", 8, -47);
			price_info[1]:Hide();
			price_info[2] = TradeSkillDetailScrollChildFrame:CreateFontString(nil, "OVERLAY");
			price_info[2]:SetFont(GameFontNormal:GetFont(), 14, "OUTLINE");
			price_info[2]:SetPoint("TOPLEFT", price_info[1], "BOTTOMLEFT", 0, 0);
			price_info[2]:Hide();
			price_info[3] = TradeSkillDetailScrollChildFrame:CreateFontString(nil, "OVERLAY");
			price_info[3]:SetFont(GameFontNormal:GetFont(), 14, "OUTLINE");
			price_info[3]:SetPoint("TOPLEFT", price_info[2], "BOTTOMLEFT", 0, 0);
			price_info[3]:Hide();
			local ON = false;
			local function hook()
				if ON and merc then
					C_Timer.After(0.1, function()
						price_info_func(meta, true);
					end)
				end
			end
			hooksecurefunc("TradeSkillFrame_Update", hook);
			-- hooksecurefunc("TradeSkillFrame_SetSelection", hook);
			if merc.add_cache_callback then
				merc.add_cache_callback(hook);
			end
			function prof.price_info_switch_TradeSkillFrame(on)
				if on then
					price_info[1]:Show();
					price_info[2]:Show();
					price_info[3]:Show();
					TradeSkillReagentLabel:ClearAllPoints();
					TradeSkillReagentLabel:SetPoint("TOPLEFT", price_info[3], "BOTTOMLEFT", 0, -3);
					ON = true;
					hook();
				else
					price_info[1]:Hide();
					price_info[2]:Hide();
					price_info[3]:Hide();
					TradeSkillReagentLabel:ClearAllPoints();
					TradeSkillReagentLabel:SetPoint("TOPLEFT", TradeSkillDetailScrollChildFrame, "TOPLEFT", 8, -47);
					ON = false;
				end
			end
			prof.price_info_switch_TradeSkillFrame(config.show_tradeskill_frame_price_info);
		end
		do	-- mouse click
			for i = 1, 8 do
				local icon = _G["TradeSkillReagent" .. i];
				icon:HookScript("OnClick", function(self)
					if IsShiftKeyDown() then
						local editBox = ChatEdit_ChooseBoxForSend();
						if not editBox:HasFocus() then
							local name = GetTradeSkillReagentInfo(GetTradeSkillSelectionIndex(), self:GetID());
							if name and name ~= "" then
								ALA_INSERT_NAME(name);
							end
						end
					end
				end);
			end
			TradeSkillSkillIcon:HookScript("OnClick", function(self)
				if IsShiftKeyDown() then
					local editBox = ChatEdit_ChooseBoxForSend();
					if not editBox:HasFocus() then
						local name = GetTradeSkillInfo(GetTradeSkillSelectionIndex());
						if name and name ~= "" then
							ALA_INSERT_NAME(name);
						end
					end
				end
			end);
		end
		meta.update = _G[meta.update_func_name];
	end
	function prof.hook_Blizzard_CraftUI()
		local meta = {
			pname = GetCraftName,
			pinfo = GetCraftDisplaySkillLine,
			clear_filter = _noop_,
			-- expand = ExpandCraftSkillLine,
			-- collapse = CollapseCraftSkillLine,
			recipe_num = GetNumCrafts,
			info = function(arg1) local _1, _2, _3, _4, _5, _6, _7 = GetCraftInfo(arg1); return _1, _3, _4, _5, _6, _7; end,
				-- craftName, craftSubSpellName(""), craftType(difficult), numAvailable, isExpanded, trainingPointCost, requiredLevel = GetCraftInfo(index)
			itemId = function(arg1) local link = GetCraftItemLink(arg1); return link and tonumber(select(3, strfind(link, "[a-zA-Z]:(%d+)"))) or 0; end,
			link = GetCraftItemLink,
			itemInfo = function(arg1)
				if prof.db_get_pid(GetCraftName()) == 10 then
					local name, _, icon, _, _, _, id = GetSpellInfo(arg1);
					if name then
						local link = "\124cffffffff\124Henchant:" .. id .. "\124h[" .. name .. "]\124h\124r";
						return name, link, nil, 0, 0, nil, nil, nil, nil, icon;
					else
						return nil;
					end
				else
					return GetItemInfo(arg1);
				end
			end,
			icon = GetCraftIcon,
			desc = GetCraftDescription,
			need = GetCraftSpellFocus,
			cool = function() return 0; end,
			num_reagent = GetCraftNumReagents,
			reagent_link = GetCraftReagentItemLink,
			reagent_id = function(i, j) return tonumber(select(3, strfind(GetCraftReagentItemLink(i, j), "[a-zA-Z]:(%d+)"))); end,
			reagent_info = GetCraftReagentInfo,
				-- name, texture, numRequired, numHave = GetCraftReagentInfo(tradeSkillRecipeId, reagentId);
			select = CraftFrame_SetSelection,		-- SelectCraft
			get_select = GetCraftSelectionIndex,
			num_made = function() return 1, 1; end,
			-- craft = DoCraft,
			close = CloseCraft,
			update = CraftFrame_Update,
			update_func_name = "CraftFrame_Update",
			scroll = CraftListScrollFrameScrollBar,
			normal_anchor_top = CraftFrameCloseButton,
			normal_anchor_bottom = CraftCancelButton,
			cover_anchor_top = CraftRankFrame,
			cover_anchor_bottom = CraftListScrollFrame,
			cover_anchor_left = CraftListScrollFrame,
			cover_anchor_right = CraftListScrollFrameScrollBar,
			relative_note = CraftDetailScrollChildFrame,
			hooked_update = {
				"CraftFrame_OnShow",
			};
			events_update = {
				"LEARNED_SPELL_IN_TAB",
				"CRAFT_UPDATE",
			};
			--[[
				unk_2 = GetCraftButtonToken,
				ExpandCraftSkillLine,
				CollapseCraftSkillLine,
			]]
		};
		local frame = prof.hook(CraftFrame, meta);
		do	-- price_info
			local price_info = {  };
			meta.price_info = price_info;
			price_info[2] = CraftDetailScrollChildFrame:CreateFontString(nil, "OVERLAY");
			price_info[2]:SetFont(GameFontNormal:GetFont(), 14, "OUTLINE");
			price_info[2]:SetPoint("TOPLEFT", CraftDetailScrollChildFrame, "TOPLEFT", 5, -50);
			price_info[2]:Hide();
			local ON = false;
			local function hook()
				if ON and merc then
					C_Timer.After(0.1, function()
						price_info_func(meta, true);
					end)
				end
			end
			hooksecurefunc("CraftFrame_Update", hook);
			-- hooksecurefunc("CraftFrame_SetSelection", hook);
			if merc.add_cache_callback then
				merc.add_cache_callback(hook);
			end
			function prof.price_info_switch_CraftFrame(on)
				if on then
					price_info[2]:Show();
					CraftDescription:ClearAllPoints();
					CraftDescription:SetPoint("TOPLEFT", price_info[2], "BOTTOMLEFT", 0, -3);
					ON = true;
					hook();
				else
					price_info[2]:Hide();
					CraftDescription:ClearAllPoints();
					CraftDescription:SetPoint("TOPLEFT", CraftDetailScrollChildFrame, "TOPLEFT", 5, -50);
					ON = false;
				end
			end
			prof.price_info_switch_CraftFrame(config.show_tradeskill_frame_price_info);
		end
		do	-- mouse click
			for i = 1, 8 do
				local icon = _G["CraftReagent" .. i];
				icon:HookScript("OnClick", function(self)
					if IsShiftKeyDown() then
						local editBox = ChatEdit_ChooseBoxForSend();
						if not editBox:HasFocus() then
							local name = GetCraftReagentInfo(GetCraftSelectionIndex(), self:GetID());
							if name and name ~= "" then
								ALA_INSERT_NAME(name);
							end
						end
					end
				end);
			end
		end
		do	-- auto filter recipe when trading
			local LOC = LOCALIZED_LOC[LOCALE];
			_EventHandler:RegisterEvent("TRADE_SHOW");
			_EventHandler:RegisterEvent("TRADE_CLOSED");
			_EventHandler:RegisterEvent("TRADE_UPDATE");
			_EventHandler:RegisterEvent("TRADE_TARGET_ITEM_CHANGED");
			local function process_link()
				local link = GetTradeTargetItemLink(7);
				if link then
					local _, _, _, _, _, itemType, itemSubType, _, loc, _, _, itemTypeID, itemSubTypeID, bindType = GetItemInfo(link);
					if LOC[loc] then
						frame.searchEdit:SetText(LOC[loc]);
					else
						frame.searchEdit:SetText(LOC.NONE);
					end
				end
			end
			_EventHandler:HookScript("OnEvent", function(self, event, _1)
				if event == "TRADE_SHOW" then
				elseif event == "TRADE_CLOSED" then
					frame.searchEdit:SetText("");
				elseif event == "TRADE_TARGET_ITEM_CHANGED" then
					if _1 == 7 then
						process_link();
					end
				elseif event == "TRADE_UPDATE" then
					process_link();
				end
			end);
			frame:HookScript("OnShow", function()
				if CraftFrame and CraftFrame:IsShown() then
					_EventHandler:run_on_next_tick(process_link);
				end
			end);
		end
		meta.update = _G[meta.update_func_name];
	end

	do	-- tooltip tradeskill price
		local recipe_black_list_sid = {
			--	元素精华
			[17559] = 1,	--	7078
			[17560] = 1,	--	7076
			[17561] = 1,	--	7080
			[17562] = 1,	--	7082
			[17563] = 1,	--	7080
			[17564] = 1,	--	12808
			[17565] = 1,	--	7076
			[17566] = 1,	--	12803
			--	奥金锭
			[17187] = 1,	--	12360
			--	月布
			[18560] = 1,	--	14342
			--	熟化毛皮
			[19047] = 1,	--	15407
		};
		local recipe_black_list_cid = {
			--	元素精华
			[7078] = 1,
			[7076] = 1,
			[7082] = 1,
			[7080] = 1,
			[12808] = 1,
			[12803] = 1,
			--	奥金锭
			[12360] = 1,
			--	月布
			[14342] = 1,
			--	熟化毛皮
			[15407] = 1,
		};
		local sr_format = "^" .. SPELL_REAGENTS .. "(.+)";
		local _temp_guid = 0;
		local n_space = 4;
		function prof.gen_price_info_by_cid(pid, cid, num, lines, stack_level, is_enchanting)
			num = num or 1;
			stack_level = stack_level or 0;
			local cost = nil;
			local cost_known = 0;
			local missing = 0;
			local nMade = 1;
			local detail_lines = lines and {  };
			if stack_level <= 4 and (stack_level == 0 or not recipe_black_list_cid[cid]) then
				local info = prof.db_get_recipe_info(pid, cid, stack_level > 0 and curPhase);
				if info then
					nMade = (info[index_num_made_min] + info[index_num_made_max]) / 2;
					local reagid = info[index_reagents_id];
					local reagnum = info[index_reagents_count];
					cost = 0;
					for i = 1, #reagid do
						local id = reagid[i];
						local num = reagnum[i];
						local pa, pc = prof.gen_price_info_by_cid(pid, id, num, detail_lines, stack_level + 1);
						if not pa and not pc then
							cost = nil;
							if stack_level > 0 then
								break;
							end
							missing = missing + 1;
						elseif cost then
							cost = cost + (pa or pc or 0);
						end
						cost_known = cost_known + (pa or pc or 0);
					end
				end
			end
			local vendorPrice = merc.get_material_vendor_price_by_id(cid);
			local price = merc.query_ah_price_by_id(cid);
			if vendorPrice then
				if price == nil or vendorPrice < price then
					price = vendorPrice;
				end
			end
			price = price and price * num;
			cost = cost and cost * num / nMade;
			cost_known = cost_known and cost_known * num / nMade;
			local name = (merc.query_name_by_id(id) or GetItemInfo(cid) or (L["UNK_ITEM_ID"] .. cid));
			local quality = merc.query_quality_by_id(cid) or select(3, GetItemInfo(cid));
			if quality then
				local _, _, _, code = GetItemQualityColor(quality);
				name = "\124c" .. code .. name .. "\124r";
			end
			if stack_level == 0 then
				if lines then
					for _, line in pairs(detail_lines) do
						tinsert(lines, line);
					end
					if is_enchanting then
						if cost then
							tinsert(lines, "\124cffffffff" .. GetSpellInfo(cid) .. "\124r" or L["COST_PRICE"]);
							tinsert(lines, L["COST_PRICE"] .. merc.MoneyString(cost));
						else
							tinsert(lines, "\124cffffffff" .. GetSpellInfo(cid) .. "\124r" or L["COST_PRICE"]);
							tinsert(lines, L["COST_PRICE_KNOWN"] .. merc.MoneyString(cost_known));
						end
					else
						if cost then
							tinsert(lines, name .. "x" .. num);
							tinsert(lines, L["COST_PRICE"] .. merc.MoneyString(cost));
						else
							tinsert(lines, name .. "x" .. num);
							tinsert(lines, L["COST_PRICE_KNOWN"] .. merc.MoneyString(cost_known));
						end
						if price then
							tinsert(lines, name .. "x" .. num);
							tinsert(lines, L["AH_PRICE"] .. merc.MoneyString(price));
						else
						end
						if cost and price then
							local diff = price - cost;
							if diff > 0 then
								tinsert(lines, L["PRICE_DIFF+"]);
								tinsert(lines, L["PRICE_DIFF_INFO+"] .. "\124cff00ff00" .. merc.MoneyString(diff) .. "\124r");
							elseif diff < 0 then
								tinsert(lines, L["PRICE_DIFF-"]);
								tinsert(lines, L["PRICE_DIFF_INFO-"] .. "\124cffff0000" .. merc.MoneyString(- diff) .. "\124r");
							end
						end
					end
				end
			else
				if price and (not cost or (cost and cost >= price)) then
					if lines then
						tinsert(lines, strrep(" ", (stack_level - 1) * n_space) .. name .. "x" .. num);
						tinsert(lines, merc.MoneyString(price));
					end
					cost = nil;
				elseif cost and (not price or (price and cost < price)) then
					if lines then
						tinsert(lines, strrep(" ", (stack_level - 1) * n_space) .. name .. "x" .. num);
						tinsert(lines, merc.MoneyString(cost));
						for _, line in pairs(detail_lines) do
							tinsert(lines, line);
						end
					end
					price = nil;
				else
					if lines then
						tinsert(lines, strrep(" ", (stack_level - 1) * n_space) .. name .. "x" .. num);
						tinsert(lines, L["UNKOWN_PRICE"]);
					end
				end
			end
			return price, cost, cost_known, missing;
		end
		local function set_tip_by_sid(tip, sid)
			local pid = prof.db_get_pid_by_sid(sid);
			local cid = prof.db_get_cid_by_sid(sid);
			if pid == 10 and cid == nil then
				cid = sid;
			end
			if pid and cid then
				local detail_lines = {  };
				prof.gen_price_info_by_cid(pid, cid, prof.db_get_tradeskill_num_made_by_pid_cid(pid, cid), detail_lines, 0, cid == sid);
				if #detail_lines > 0 then
					tip:AddLine(L["CRAFT_INFO"]);
					for i = 1, #detail_lines, 2 do
						tip:AddDoubleLine(detail_lines[i], detail_lines[i + 1]);
					end
					tip:Show();
				end
			end
			return nil, nil;
		end
		local function set_tip_by_cid(tip, cid)
			local pids = prof.db_get_pid_by_xid(cid);
			if pids then
				if #pids > 0 then
					tip:AddLine(L["CRAFT_INFO"]);
					for _, pid in pairs(pids) do
						local rank = prof.db_get_tradeskill_learn_rank_by_pid_xid(pid, cid);
						local texture = prof.db_get_texture_by_pid(pid);
						local name = prof.db_get_name_by_pid(pid) or L["UNKONWN_PROFESSION"];
						if texture then
							name = "\124T" .. texture .. ":12:12:0:0\124t " .. name;
						end
						if rank then
							name = name .. "(" .. rank .. ")";
						end
						tip:AddLine("\124cff00afff" .. name .. "\124r");
						local detail_lines = {  };
						prof.gen_price_info_by_cid(pid, cid, prof.db_get_tradeskill_num_made_by_pid_cid(pid, cid), detail_lines, 0);
						for i = 1, #detail_lines, 2 do
							tip:AddDoubleLine(detail_lines[i], detail_lines[i + 1]);
						end
						tip:Show();
					end
				end
			end
		end
		local function hook_tradeskill_tip_hyperlink(tip, link)
			if not merc then
				return;
			end
			if not config.show_tradeskill_tip_price then
				return;
			end
			local _, sid = tip:GetSpell();
			if sid then
				if prof.db_is_tradeskill_sid(sid) then
					set_tip_by_sid(tip, sid);
				end
				return;
			end
			if link then
				local cid = tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
				if cid and prof.db_is_tradeskill_cid(cid) then
					set_tip_by_cid(tip, cid);
				end
			end
		end
		local function hook_tradeskill_tip_item(tip)
			if not merc then
				return;
			end
			if not config.tradeskill_crafted_item_price then
				return;
			end
			local _, link = tip:GetItem();
			if link then
				local cid = tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
				if cid and prof.db_is_tradeskill_cid(cid) then
					set_tip_by_cid(tip, cid);
				end
			end
		end
		local function hook_tradeskill_tip_spellbyid(tip, sid)
			if not merc then
				return;
			end
			if not config.show_tradeskill_tip_price then
				return;
			end
			if sid and prof.db_is_tradeskill_sid(sid) then
				set_tip_by_sid(tip, sid);
			end
		end
		local function hook_tradeskill_tip_itembyid(tip, cid)
			if not merc then
				return;
			end
			if not config.tradeskill_crafted_item_price then
				return;
			end
			if cid and prof.db_is_tradeskill_cid(cid) then
				set_tip_by_cid(tip, cid);
			end
		end
		function prof.hook_tradeskill_tooltip_show_price()
			hooksecurefunc(GameTooltip, "SetHyperlink", hook_tradeskill_tip_hyperlink);
			hooksecurefunc(ItemRefTooltip, "SetHyperlink", hook_tradeskill_tip_hyperlink);
			hooksecurefunc(GameTooltip, "SetSpellByID", hook_tradeskill_tip_spellbyid);
			hooksecurefunc(ItemRefTooltip, "SetSpellByID", hook_tradeskill_tip_spellbyid);
			hooksecurefunc(GameTooltip, "SetItemByID", hook_tradeskill_tip_itembyid);
			hooksecurefunc(ItemRefTooltip, "SetItemByID", hook_tradeskill_tip_itembyid);
			hooksecurefunc(GameTooltip, "SetMerchantItem", hook_tradeskill_tip_item);
			hooksecurefunc(GameTooltip, "SetBuybackItem", hook_tradeskill_tip_item);
			hooksecurefunc(GameTooltip, "SetBagItem", hook_tradeskill_tip_item);
			hooksecurefunc(GameTooltip, "SetAuctionItem", hook_tradeskill_tip_item);
			hooksecurefunc(GameTooltip, "SetAuctionSellItem", hook_tradeskill_tip_item);
			hooksecurefunc(GameTooltip, "SetLootItem", hook_tradeskill_tip_item);
			hooksecurefunc(GameTooltip, "SetLootRollItem", hook_tradeskill_tip_item);
			hooksecurefunc(GameTooltip, "SetInventoryItem", hook_tradeskill_tip_item);
			hooksecurefunc(GameTooltip, "SetTradePlayerItem", hook_tradeskill_tip_item);
			hooksecurefunc(GameTooltip, "SetTradeTargetItem", hook_tradeskill_tip_item);
			hooksecurefunc(GameTooltip, "SetQuestItem", hook_tradeskill_tip_item);
			hooksecurefunc(GameTooltip, "SetQuestLogItem", hook_tradeskill_tip_item);
			hooksecurefunc(GameTooltip, "SetInboxItem", hook_tradeskill_tip_item);
			hooksecurefunc(GameTooltip, "SetSendMailItem", hook_tradeskill_tip_item);
			hooksecurefunc(GameTooltip, "SetTradeSkillItem", hook_tradeskill_tip_item);
			hooksecurefunc(GameTooltip, "SetCraftItem", hook_tradeskill_tip_item);
		end
		--
		function prof.gen_profit_price_list(pid, xid_list, xid_hash, list, hash)
			if list then
				wipe(list);
			else
				list = {  };
			end
			if hash then
				wipe(hash);
			else
				hash = {  };
			end
			for _, xid in pairs(xid_list) do
				local cid = prof.db_get_tradeskill_cid_by_pid_xid(pid, xid);
				if cid then
					local nMade, minMade, maxMade = prof.db_get_tradeskill_num_made_by_pid_cid(pid, cid);
					local price_a_product, price_a_material, price_a_material_known, unk_in = prof.gen_price_info_by_cid(pid, cid, nMade);
					if price_a_product and price_a_material then
						if price_a_product > price_a_material then
							tinsert(list, { xid, price_a_product - price_a_material, });
						end
					end
				end
			end
			sort(list, function(v1, v2) return v1[2] > v2[2]; end);
			for _, v in pairs(list) do
				hash[v[1]] = xid_hash[v[1]];
			end
			return list, hash;
		end
	end
end


function prof.PLAYER_ENTERING_WORLD()
	_EventHandler:UnregisterEvent("PLAYER_ENTERING_WORLD");
	-- _EventHandler:SetScript("OnEvent", nil);
	prof.dev();
	prof.db_init();
	if alaTradeFrameSV then
		if not alaTradeFrameSV._version or alaTradeFrameSV._version < 191210.1 then
			wipe(alaTradeFrameSV);
		end
		local default_showProfit_pid = {
			[1] = false,
			[2] = true,
			[3] = true,
			[4] = true,
			[6] = false,
			[7] = true,
			[8] = true,
			[9] = true,
			[10] = false,
			[13] = false,
		}
		if not alaTradeFrameSV._version or alaTradeFrameSV._version < 200114.0 then
			for GUID, F in pairs(alaTradeFrameSV) do
				if type(F) == 'table' then
					for pid, v in pairs(F) do
						if type(v) == 'table' then
							v.showProfit = default_showProfit_pid[pid];
						end
					end
				end
			end
		end
		if not alaTradeFrameSV._version or alaTradeFrameSV._version < 200222.2 then
			for GUID, F in pairs(alaTradeFrameSV) do
				if type(F) == 'table' then
					for pid, v in pairs(F) do
						if type(pid) == 'number' and type(v) == 'table' then
							local P = alaTradeFrameSV[pid];
							if not P then
								P = Mixin({  }, default);
								alaTradeFrameSV[pid] = P;
							end
							for key, val in pairs(v) do
								P[key] = val;
							end
							P.show_tradeskill_tip_price = nil;
							P.show_tradeskill_frame_price_info = nil;
							P.tradeskill_crafted_item_price = nil;
							F[pid] = nil;
						end
					end
				end
			end
		end
		for GUID, F in pairs(alaTradeFrameSV) do
			if type(F) == 'table' then
				for pid, v in pairs(F) do
					if type(v) == 'table' then
						for k, d in pairs(default) do
							if v[k] == nil then
								v[k] = d;
							end
						end
					end
				end
			end
		end
		for GUID, F in pairs(alaTradeFrameSV) do	-- clear searchText
			if type(F) == 'table' then
				for pid, v in pairs(F) do
					if type(v) == 'table' then
						v.searchText = nil;
					end
				end
			end
		end
	else
		_G.alaTradeFrameSV = {  };
	end
	alaTradeFrameSV._version = 200222.2;
	do
		local _protected = not not select(2, GetAddOnInfo('\33\33\33\49\54\51\85\73\33\33\33'));
		for GUID, F in pairs(alaTradeFrameSV) do
			if type(GUID) == 'string' and type(F) == 'table' then
				F.show_tradeskill_tip_price = _protected;
				F.show_tradeskill_frame_price_info = _protected;
				F.tradeskill_crafted_item_price = _protected;
			end
		end
	end
	local GUID = UnitGUID('player');
	alaTradeFrameSV[GUID] = alaTradeFrameSV[GUID] or {  };
	config = setmetatable(alaTradeFrameSV[GUID], {
		__index = function(t, pid)
			local temp = alaTradeFrameSV[pid];
			if not temp then
				temp = Mixin({  }, default);
				alaTradeFrameSV[pid] = temp;
			end
			return temp;
		end,
	});

	do
		if IsAddOnLoaded("Blizzard_TradeSkillUI") then
			prof.hook_Blizzard_TradeSkillUI();
		else
			local f = CreateFrame("Frame");
			f:RegisterEvent("ADDON_LOADED");
			f:SetScript("OnEvent", function(self, event, addon)
				if addon == "Blizzard_TradeSkillUI" then
					prof.hook_Blizzard_TradeSkillUI();
					f:UnregisterAllEvents();
					f:SetScript("OnEvent", nil);
					f = nil;
				end
			end);
		end
		if IsAddOnLoaded("Blizzard_CraftUI") then
			prof.hook_Blizzard_CraftUI();
		else
			local f = CreateFrame("Frame");
			f:RegisterEvent("ADDON_LOADED");
			f:SetScript("OnEvent", function(self, event, addon)
				if addon == "Blizzard_CraftUI" then
					prof.hook_Blizzard_CraftUI();
					f:UnregisterAllEvents();
					f:SetScript("OnEvent", nil);
					f = nil;
				end
			end);
		end
		if IsAddOnLoaded("MissingTradeSkillsList") then
			if alaTradeFrameSV.hide_mtsl then
				prof.toggle_mtsl(false);
			end
		else
			local f = CreateFrame("Frame");
			f:RegisterEvent("ADDON_LOADED");
			f:SetScript("OnEvent", function(self, event, addon)
				if addon == "MissingTradeSkillsList" then
					if alaTradeFrameSV.hide_mtsl then
						prof.toggle_mtsl(false);
					end
					f:UnregisterAllEvents();
					f:SetScript("OnEvent", nil);
					f = nil;
				end
			end);
		end
	end
	merc = __ala_meta__.merc or prof.meta_alt_merc_Auctionator() or prof.meta_alt_merc_aux() or prof.meta_alt_merc_AuctionFaster() or prof.meta_alt_merc_AuctionMaster();
	-- prof.db_validate();
	prof.hook_tradeskill_tooltip_show_price();
end
function prof.ADDON_LOADED(addon)
	if addon == "alaTrade" then
		-- _EventHandler:UnregisterEvent("ADDON_LOADED");
		merc = __ala_meta__.merc;
	elseif addon == "Auctionator" then
		merc = prof.meta_alt_merc_Auctionator();
	elseif addon == "aux-addon" then
		merc = prof.meta_alt_merc_aux();
	elseif addon == "_AuctionFaster" then
		merc = prof.meta_alt_merc_AuctionFaster();
	elseif addon == "AuctionMaster" then
		merc = prof.meta_alt_merc_AuctionMaster();
	end
end

local function OnEvent(self, event, ...)
	return prof[event](...);
end
function _EventHandler:RegEvent(event)
	prof[event] = prof[event] or _noop_;
	self:RegisterEvent(event);
	self:SetScript("OnEvent", OnEvent);
end
_EventHandler:RegEvent("PLAYER_ENTERING_WORLD");
_EventHandler:RegEvent("ADDON_LOADED");
local run_on_next_tick_func = {  };
local function run_on_next_tick_handler()
	_EventHandler:SetScript("OnUpdate", nil);
	for i = #run_on_next_tick_func, 1, -1 do
		tremove(run_on_next_tick_func, i)();
	end
end
function _EventHandler:run_on_next_tick(func)
	for i = 1, #run_on_next_tick_func do
		if func == run_on_next_tick_func[i] then
			return;
		end
	end
	_EventHandler:SetScript("OnUpdate", run_on_next_tick_handler);
	tinsert(run_on_next_tick_func, func);
end
function _EventHandler:frame_update_on_next_tick(frame)
	if not frame.mute_update then
		_EventHandler:run_on_next_tick(frame.update_func);
	end
end

function _G.toggle_tradeskill_frame_price_info(on)
	config.show_tradeskill_frame_price_info = on;
	if prof.price_info_switch_TradeSkillFrame then
		prof.price_info_switch_TradeSkillFrame(on);
	end
	if prof.price_info_switch_CraftFrame then
		prof.price_info_switch_CraftFrame(on);
	end
end
function _G.toggle_tradeskill_tip_price(on)
	config.show_tradeskill_tip_price = on;
end
function _G.toggle_tradeskill_crafted_item_price(on)
	config.tradeskill_crafted_item_price = on;
end

_G._163_tradeskill_frame_price_toggle = toggle_tradeskill_frame_price_info;
_G._163_tradeskill_tip_price_toggle = toggle_tradeskill_tip_price;
_G._163_tradeskill_tip_crafted_item_toggle = toggle_tradeskill_crafted_item_price;



do	--	EXTERN SUPPORT
	local alt_merc = {  };
	-- CREDIT Auctionator
	local material_sold_by_vendor = {
		--	BLACKSMITHING	ENGINEERING
		-- [5956] = 18,		-- 铁匠之锤
		-- [2901] = 81,		-- 矿工锄
		[2880] = 100,		-- 弱效助熔剂
		[3466] = 2000,		-- 强效助熔剂
		[3857] = 500,		-- 煤块
		[18567] = 150000,	-- 元素助熔剂
		[4399] = 200,		-- 木柴
		[4400] = 2000,		-- 沉重的树干
		[10648] = 500,		-- 空白的羊皮纸
		[10647] = 2000,		-- 墨水
		[6530] = 100,		-- 夜色虫
		--	ALCHEMY
		[3371] = 4,			-- 空瓶
		[3372] = 40,		-- 铅瓶
		[8925] = 500,		-- 水晶瓶
		[18256] = 30000,	-- 灌魔之瓶
		--	ENCHANGING
		[6217] = 124,		-- 铜棒
		[4470] = 38,		-- 普通木柴
		[11291] = 4500,		-- 星木
		--	TAILORING	LEATHERWORKING
		[2320] = 10,		-- 粗线
		[2321] = 100,		-- 细线
		[4291] = 500,		-- 丝线
		[8343] = 2000,		-- 粗丝线
		[14341] = 5000,		-- 符文线
		[2324] = 25,		-- 漂白剂
		[2604] = 50,		-- 红色染料
		[6260] = 50,		-- 蓝色染料
		[2605] = 100,		-- 绿色染料
		[4341] = 500,		-- 黄色染料
		[4340] = 350,		-- 灰色染料
		[6261] = 1000,		-- 橙色染料
		[2325] = 1000,		-- 灰色染料
		[4342] = 2500,		-- 紫色染料
		[10290] = 2500,		-- 粉红燃料
		[4289] = 50,		-- 盐
		--	COOKING
		[159] = 5,			-- 清凉的泉水
		[1179] = 125,		-- 冰镇牛奶
		[2678] = 2,			-- 甜香料
		[2692] = 40,		-- 辣椒
		[3713] = 160,		-- 舒心草
		[2596] = 120,		-- 矮人烈酒
	};
	local material_sold_by_vendor_by_name = {  };
	local function cache_item_info(id)
		local name = GetItemInfo(id);
		if name then
			material_sold_by_vendor_by_name[name] = material_sold_by_vendor[id];
			return true;
		else
			return false;
		end
	end
	do
		local num_material_sold_by_vendor = 0;
		for id, price in pairs(material_sold_by_vendor) do
			num_material_sold_by_vendor = num_material_sold_by_vendor + 1;
		end
		local frame = CreateFrame("Frame");
		frame:RegisterEvent("ITEM_DATA_LOAD_RESULT");
		frame:SetScript("OnEvent", function(self, event, arg1, arg2)
			num_material_sold_by_vendor = num_material_sold_by_vendor - 1;
			if arg2 and material_sold_by_vendor[arg1] then
				cache_item_info(arg1);
			end
			if num_material_sold_by_vendor <= 0 then
				self:SetScript("OnEvent", nil);
				self:UnregisterAllEvents();
				frame = nil;
			end
		end);
		for id, price in pairs(material_sold_by_vendor) do
			C_Item.RequestLoadItemDataByID(id);
		end
	end
	--
	function alt_merc.get_material_vendor_price_by_link(link, num)
		local id = tonumber(select(3, strfind(link, "item:(%d+)")));
		return id and alt_merc.get_material_vendor_price_by_id(id, num);
	end
	function alt_merc.get_material_vendor_price_by_id(id, num)
		local p = material_sold_by_vendor[id];
		if p then
			if num then
				return p * num;
			else
				return p;
			end
		else
			return nil;
		end
	end
	function alt_merc.get_material_vendor_price_by_name(name, num)
		local p = material_sold_by_vendor_by_name[name];
		if p then
			if num then
				return p * num;
			else
				return p;
			end
		else
			return nil;
		end
	end

	function alt_merc.query_name_by_id(id)
		return nil;
	end
	function alt_merc.query_quality_by_id(id)
		return nil;
	end
	local goldicon    = "\124TInterface\\MoneyFrame\\UI-GoldIcon:12:12:0:0\124t"
	local silvericon  = "\124TInterface\\MoneyFrame\\UI-SilverIcon:12:12:0:0\124t"
	local coppericon  = "\124TInterface\\MoneyFrame\\UI-CopperIcon:12:12:0:0\124t"
	function alt_merc.MoneyString(copper)
		-- GetCoinTextureString
		local g = floor(copper / 10000);
		copper = copper % 10000;
		local s = floor(copper / 100);
		copper = copper % 100;
		local c = floor(copper);
		if g > 0 then
			return format("%d%s %02d%s %02d%s", g, goldicon, s, silvericon, c, coppericon);
		elseif s > 0 then
			return format("%d%s %02d%s", s, silvericon, c, coppericon);
		else
			return format("%d%s", c, coppericon);
		end
	end
	----------------
	do	--	Auctionator
		local function query_ah_price_by_name(name, num)
			if not name then return nil; end
			num = num or 1;
			local vp = alt_merc.get_material_vendor_price_by_name(name, num);
			if vp then
				return vp;
			end
			if Atr_GetAuctionPrice then
				local ap = Atr_GetAuctionPrice(name);
				if ap then
					return ap * num;
				end
			end
			return nil;
		end
		local function query_ah_price_by_id(id, num)
			if not id then return nil; end
			num = num or 1;
			local vp = alt_merc.get_material_vendor_price_by_id(id, num);
			if vp then
				return vp;
			end
			if Atr_GetAuctionPrice then
				local name = GetItemInfo(id);
				if name then
					local ap = Atr_GetAuctionPrice(name);
					if ap and ap > 0 then
						return ap * num;
					end
				end
			end
		end
		function prof.meta_alt_merc_Auctionator()
			if IsAddOnLoaded("Auctionator") then
				return Mixin({ query_ah_price_by_name = query_ah_price_by_name, query_ah_price_by_id = query_ah_price_by_id, }, alt_merc);
			end
		end
	end
	--------
	do	--	AUX
		local history = nil;
		local function query_ah_price_by_name(name, num)
			return nil;
		end
		local function query_ah_price_by_id(id, num)
			if not id then return nil; end
			num = num or 1;
			local vp = alt_merc.get_material_vendor_price_by_id(id, num);
			if vp then
				return vp;
			end
			if history then
				local ap = history.market_value(id .. ":0");
				if ap and ap > 0 then
					return ap * num;
				end
			end
		end
		function prof.meta_alt_merc_aux()
			if IsAddOnLoaded("aux-addon") then
				if require then
					history = require 'aux.core.history';
				end
				return Mixin({ query_ah_price_by_name = query_ah_price_by_name, query_ah_price_by_id = query_ah_price_by_id, }, alt_merc);
			end
		end
	end
	--------
	do	--	AuctionFaster
		local GetItemFromCache = nil;
		local function query_ah_price_by_name(name, num)
			return nil;
		end
		local function query_ah_price_by_id(id, num)
			if not id then return nil; end
			num = num or 1;
			local vp = alt_merc.get_material_vendor_price_by_id(id, num);
			if vp then
				return vp;
			end
			if GetItemFromCache then
				local name = GetItemInfo(id);
				if name then
					local cacheItem = GetItemFromCache(nil, id, name, true);
					if cacheItem then
						local ap = cacheItem.buy;
						if ap and ap > 0 then
							return ap * num;
						end
					end
				end
			end
		end
		function prof.meta_alt_merc_AuctionFaster()
			if IsAddOnLoaded("AuctionFaster") then
				GetItemFromCache = AuctionFaster.modules.ItemCache.GetItemFromCache;
				return Mixin({ query_ah_price_by_name = query_ah_price_by_name, query_ah_price_by_id = query_ah_price_by_id, }, alt_merc);
			end
		end
	end
	--------
	do	--	AuctionMaster
		local Gatherer = nil;
		local function query_ah_price_by_name(name, num)
			return nil;
		end
		local function query_ah_price_by_id(id, num)
			if not id then return nil; end
			num = num or 1;
			local vp = alt_merc.get_material_vendor_price_by_id(id, num);
			if vp then
				return vp;
			end
			if Gatherer then
				local _, link = GetItemInfo(id);
				if link then
					local bid, ap = Gatherer:GetCurrentAuctionInfo(link)
					if ap and ap > 0 then
						return ap * num;
					end
				end
			end
		end
		function prof.meta_alt_merc_AuctionMaster()
			if IsAddOnLoaded("AuctionMaster") then
				Gatherer = vendor.Gatherer;
				return Mixin({ query_ah_price_by_name = query_ah_price_by_name, query_ah_price_by_id = query_ah_price_by_id, }, alt_merc);
			end
		end
	end
	--------
	--------
end
