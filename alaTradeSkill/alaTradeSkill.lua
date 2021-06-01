--[[--
	by ALA @ 163UI
	复用代码请在显著位置标注来源【ALA@网易有爱】
	RECIPES DATA CREDITS ATLASLOOT & MTSL. DATA QUERIED FROM 'db.nfuwow.com'. API QUERIED FROM 'wow.gamepedia.com/World_of_Warcraft_API'
	配方数据来源于AtlasLoot和MissingTradeSkillList, 修改数据来源于nfu数据库, API查询自gamepedia
	Please Keep WOW Addon open-source & Reduce barriers for others.
	请勿加密、乱码、删除空格tab换行符、设置加载依赖
	##	2019-11-27
		Initial release
	##	2020-01-10
		New Feature: Standalone Profit List
	##	2020-02-18
		Modify recipe:	Dark Iron Boots	黑铁长靴	sid = 24399, pid = 2, cid = 20039, MOD: phase = 3
	##	2020-02-29
		Support Auctionator, AUX, AuctionFaster, AuctionMaster now.
	##	2020-04-08
		Rebuild: Using spellId instead of itemId.	!!!Assuming that combination { tradeskill, spellName, itemId } is unique!!!
	##	2020-04-14
		New Feature: Explorer List, Tradeskill Tab
	##	2020-05-09
		Communication: Query who can craft by sid. Broadcast pid to guild.
	##	2020-05-13
		Config Frame
	##	2020-05-27
		Wide Frame, Flat Style, Regular Exp, More setting options.
	##	2020-05-30
		DEL
			pid = 3, sid = 10550	夜色披风
			pid = 9, sid = 28327	蒸汽车控制器	existence and phase?	temporily del
		REAGENTS		checked all
			Tailoring		12091	regeant:	{ 4339, 8343, }, { 5, 3, } >> { 4339, 8343, 2324, }, { 5, 3, 1, }
		LEARN_RANK		checked by recipe tip
			pid = 2, sid = 6517     115 >> 110,
			pid = 2, sid = 3491     100 >> 105,
			pid = 2, sid = 9931     205 >> 210,
			pid = 2, sid = 9954     240 >> 225,
			pid = 8, sid = 8776     10 >> 15,
			pid = 9, sid = 12754	225 >> 235
			pid = 9, sid = 12758	235 >> 245
			pid = 9, sid = 12907    215 >> 235,
			pid = 9, sid = 12895    200 >> 205,
		YELLOW_GREEN_GREY_RANK
			pid = 9, sid = 12716	205, 205, 205 >> 225, 235, 245,		LEARN_RANK need validate
		PHASE
			Tailoring		22813,22866,22867,22868,22869,22870,22902: 1>>2		27658:	5>>1	27660: 1>>5
			Cooking			22761:	1>>2		24801:	1>>4
			Blacksmithing	16742,16744,16745:	1>>2
			Mining			22967:	1>>3
			Engineering		23079:	1>>2
			Leatherworking	22921,22922,22923,22926,22927,22928:	1>>2
			Alchemy			24266:	1>>4
		OTHER
			Engineering		8895 trainer, price: 2200
	##	2020-06-05
		pid = 4, sid = 3450		add trainer
	##	2020-06-10
		New feature: what can be crafted by tip item
	##	2020-06-13
		LERN_RANK
			pid = 3, sid = 10548	235 >> 230
		TRAIN_PRICE
	##	2020-07-01
		Leatrix_Plus	Fired on VARIABLES_LOADED: LeaPlusDB["EnhanceProfessions"] = "Off"
	##	2020-07-28
		28461, 28462, 28463		phase 5 >> 6
	##	TODO
		Communication Func, query from others or broadcast to others
		query skill & query specified sid
--]]--
----------------------------------------------------------------------------------------------------
local ADDON, NS = ...;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
__ala_meta__.prof = NS;

local _G = _G;
do
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

local curPhase = 6;
----------------------------------------------------------------------------------------------------upvalue
	----------------------------------------------------------------------------------------------------LUA
	local math, table, string, bit = math, table, string, bit;
	local type, tonumber, tostring = type, tonumber, tostring;
	local getfenv, setfenv, pcall, xpcall, assert, error, loadstring = getfenv, setfenv, pcall, xpcall, assert, error, loadstring;
	local abs, ceil, floor, max, min, random, sqrt = abs, ceil, floor, max, min, random, sqrt;
	local format, gmatch, gsub, strbyte, strchar, strfind, strlen, strlower, strmatch, strrep, strrev, strsub, strupper, strtrim, strsplit, strjoin, strconcat =
			format, gmatch, gsub, strbyte, strchar, strfind, strlen, strlower, strmatch, strrep, strrev, strsub, strupper, strtrim, strsplit, strjoin, strconcat;
	local getmetatable, setmetatable, rawget, rawset = getmetatable, setmetatable, rawget, rawset;
	local next, ipairs, pairs, sort, tContains, tinsert, tremove, wipe, unpack = next, ipairs, pairs, sort, tContains, tinsert, tremove, wipe, unpack;
	local tConcat = table.concat;
	local select = select;
	local date, time = date, time;
	----------------------------------------------------------------------------------------------------GAME
	local print = print;
	local GetServerTime = GetServerTime;
	local CreateFrame = CreateFrame;
	local IsAltKeyDown = IsAltKeyDown;
	local IsControlKeyDown = IsControlKeyDown;
	local IsShiftKeyDown = IsShiftKeyDown;
	--------------------------------------------------
	local RequestLoadSpellData = RequestLoadSpellData or C_Spell.RequestLoadSpellData;
	local RequestLoadItemDataByID = RequestLoadItemDataByID or C_Item.RequestLoadItemDataByID;
	--------------------------------------------------
	local RegisterAddonMessagePrefix = RegisterAddonMessagePrefix or C_ChatInfo.RegisterAddonMessagePrefix;
	local IsAddonMessagePrefixRegistered = IsAddonMessagePrefixRegistered or C_ChatInfo.IsAddonMessagePrefixRegistered;
	local GetRegisteredAddonMessagePrefixes = GetRegisteredAddonMessagePrefixes or C_ChatInfo.GetRegisteredAddonMessagePrefixes;
	local SendAddonMessage = SendAddonMessage or C_ChatInfo.SendAddonMessage;
	local SendAddonMessageLogged = SendAddonMessageLogged or C_ChatInfo.SendAddonMessageLogged;
	--------------------------------------------------
	local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
	local _ = nil;
	local function _log_(...)
		-- print(date('\124cff00ff00%H:%M:%S\124r'), ...);
	end
	local function _error_(header, child, ...)
		-- print(date('\124cffff0000%H:%M:%S\124r'), header, child, ...);
		-- if alaTradeSkillSV then
		-- 	local err = alaTradeSkillSV.err;
		-- 	if not err then
		-- 		err = {  };
		-- 		alaTradeSkillSV.err = err;
		-- 	end
		-- 	err[header] = err[header] or {  };
		-- 	err[header][child] = (err[header][child] or 0) + 1;
		-- end
	end
	local function _noop_()
	end
----------------------------------------------------------------------------------------------------
	-- "Interface\\Buttons\\WHITE8X8",	-- "Interface\\Tooltips\\UI-Tooltip-Background", -- "Interface\\ChatFrame\\ChatFrameBackground"
	local ui_style = {
		texture_white = "Interface\\Buttons\\WHITE8X8",
		texture_unk = "Interface\\Icons\\inv_misc_questionmark",
		texture_highlight = "Interface\\Buttons\\UI-Common-MouseHilight",
		texture_triangle = "interface\\transmogrify\\transmog-tooltip-arrow",
		texture_color_select = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\ColorSelect",
		texture_alpha_ribbon = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\AlphaRibbon",
		texture_config = "interface\\buttons\\ui-optionsbutton",
		texture_explorer = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\explorer",

		texture_modern_arrow_down = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\ArrowDown",
		texture_modern_arrow_up = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\ArrowUp",
		texture_modern_arrow_left = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\ArrowLeft",
		texture_modern_arrow_right = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\ArrowRight",
		texture_modern_button_minus = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\MinusButton",
		texture_modern_button_plus = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\PlusButton",
		texture_modern_button_close = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\Close",
		texture_modern_check_button_border = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\CheckButtonBorder",
		texture_modern_check_button_center = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\CheckButtonCenter",

		color_white = { 1.0, 1.0, 1.0, 1.0, },

		modernFrameBackdrop = {
			bgFile = "Interface\\Buttons\\WHITE8X8",
			edgeFile = nil,
			tile = false,
			tileSize = 16,
			edgeSize = 16,
			insets = { left = 0, right = 0, top = 0, bottom = 0, },
		},
		blzFrameBackdrop = {
			bgFile = "Interface\\FrameGeneral\\UI-BackGround-Marble",
			edgeFile = "Interface\\Dialogframe\\UI-DialogBox-Border",
			tile = false,
			tileSize = 32,
			edgeSize = 24,
			insets = { left = 4, right = 4, top = 4, bottom = 4, },
		},
		frameBackdrop = {
			bgFile = "Interface\\Buttons\\WHITE8X8",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = false,
			tileSize = 16,
			edgeSize = 2,
			insets = { left = 2, right = 2, top = 2, bottom = 2, },
		},
		frameBackdropColor = { 0.05, 0.05, 0.05, 1.0, },
		frameBackdropBorderColor = { 0.0, 0.0, 0.0, 1.0, },
		modernDividerColor = { 0.75, 1.0, 1.0, 0.125, },

		scrollBackdrop = {
			bgFile = nil,
			edgeFile = "Interface\\Buttons\\WHITE8X8",
			tile = false,
			tileSize = 16,
			edgeSize = 1,
			insets = { left = 0, right = 0, top = 0, bottom = 0, },
		},
		modernScrollBackdropBorderColor = { 0.25, 0.25, 0.25, 1.0, },
		blzScrollBackdropBorderColor = { 0.5, 0.5, 0.5, 0.5, },

		textureButtonColorNormal = { 0.75, 0.75, 0.75, 0.75, },
		textureButtonColorPushed = { 0.25, 0.25, 0.25, 1.0, },
		textureButtonColorHighlight= { 0.25, 0.25, 0.75, 1.0, },
		textureButtonColorDisabled= { 0.5, 0.5, 0.5, 0.25, },
		modernButtonBackdrop = {
			bgFile = "Interface\\Buttons\\WHITE8X8",
			edgeFile = "Interface\\Buttons\\WHITE8X8",
			tile = false,
			tileSize = 16,
			edgeSize = 1,
			insets = { left = 1, right = 1, top = 1, bottom = 1, },
		},
		modernButtonBackdropColor = { 0.0, 0.0, 0.0, 0.25, },
		modernButtonBackdropBorderColor = { 0.75, 1.0, 1.0, 0.25, },
		modernColorButtonColorNormal = { 0.0, 0.0, 0.0, 0.25, },
		modernColorButtonColorPushed = { 0.75, 1.0, 1.0, 0.125, },
		modernColorButtonColorHighlight = { 0.75, 1.0, 1.0, 0.125, },
		modernColorButtonColorDisabled = { 0.5, 0.5, 0.5, 0.25, },

		modernCheckButtonColorNormal = { 0.75, 1.0, 1.0, 0.25, },
		modernCheckButtonColorPushed = { 0.75, 1.0, 1.0, 0.50, },
		modernCheckButtonColorHighlight = { 0.75, 1.0, 1.0, 0.25, },
		modernCheckButtonColorChecked = { 0.75, 1.0, 1.0, 0.50, },
		modernCheckButtonColorDisabled = { 0.5, 0.5, 0.5, 0.25, },
		modernCheckButtonColorDisabledChecked = { 0.5, 0.5, 0.5, 0.4, },


		skillListButtonHeight = 15,
		supremeListButtonHeight = 32,
		listButtonBackdrop = {
			bgFile = "Interface\\Buttons\\WHITE8X8",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = false,
			tileSize = 16,
			edgeSize = 1,
			insets = { left = 1, right = 1, top = 1, bottom = 1 },
		},
		listButtonBackdropColor_Enabled = { 0.0, 0.0, 0.0, 0.0, },
		listButtonBackdropColor_Disabled = { 0.5, 0.25, 0.25, 0.5, },
		listButtonBackdropBorderColor = { 0.0, 0.0, 0.0, 0.0, },
		listButtonHighlightColor = { 0.5, 0.5, 0.75, 0.25, },
		listButtonSelectedColor = { 0.5, 0.5, 0.5, 0.25, },

		frameFont = SystemFont_Shadow_Med1:GetFont(),	--	"Fonts\ARKai_T.ttf"
		frameFontSize = min(select(2, SystemFont_Shadow_Med1:GetFont()) + 1, 15),
		frameFontOutline = "NORMAL",

		tabSize = 24,
		tabInterval = 2,

		explorerWidth = 360,
		explorerHeight = 480,

		charListButtonHeight = 20,
	};
	local BIG_NUMBER = 4294967295;
	local ICON_FOR_NO_CID = 135913;
	local PERIODIC_UPDATE_PERIOD = 1.0;
	local MAXIMUM_VAR_UPDATE_PERIOD = 4.0;
	--[[
		alaTradeSkillSV = {
			var = {
				[GUID] = {
					[pid] = {
						{ sid, },			--	list
						{ [sid] = index, },	--	hash
						{ [sid] = cd, },	--	cd
						update = bool,
						max_rank = number,
						cur_rank = number,
					},
					realm_id = number,
					realm_name = string,
				},
			},
			set = {
				[pid] = { 
					shown = true,
					showSet = false,
					showProfit = false,
					--
					showKnown = true,
					showUnkown = true,
					showHighRank = false,
					showItemInsteadOfSpell = false,
					showRank = true,
					haveMaterials = false,
					phase = curPhase,
					--
					searchText = "",
					--
					costOnly = false,
					--
				 },
				board = {
					shown = true,
					locked = true,
					pos = { board:GetPoint() },
				},
				explorer = {
					showSet = true,
					showProfit = false,
					--
					showKnown = true,
					showUnkown = false,
					showHighRank = false,
					showItemInsteadOfSpell = false,
					showRank = true,
					phase = curPhase,
					--
					filter = {
						-- realm = nil,
						skill = nil,
						type = nil,
						subType = nil,
						eqLoc = nil,
					},
					searchText = "",
					--
					costOnly = false,
				},
				expand = false,
				blz_style = false,
				bg_color = { 0.0, 0.0, 0.0, 0.5, },
				show_tradeskill_frame_price_info = true,
				show_tradeskill_frame_rank_info = true,
				show_tradeskill_tip_craft_item_price = true,
				show_tradeskill_tip_craft_spell_price = true,
				show_tradeskill_tip_recipe_price = true,
				show_tradeskill_tip_recipe_account_learned = true,
				default_skill_button_tip = true,
				colored_rank_for_unknown = false,
				regular_exp = false,
				char_list = {  },
				show_call = true,
				show_tab = true,
				portrait_button = true,
				show_board = true,
				lock_board = false,
				board_pos = { "TOP", 0, -20, },
				hide_mtsl = false,
			},
			fav = {
				[sid] = 1,
			},
			_version = number,
		}
	]]
----------------------------------------------------------------------------------------------------
local LOCALE = GetLocale();
local L = {  };
do	--	LOCALE
	L.extra_skill_name = {  };
	if LOCALE == "koKR" then
		L.extra_skill_name[3] = "가죽 세공";
	end
	--
	if LOCALE == "zhCN" or LOCALE == "zhTW" then
		L["OK"] = "确定";
		L["Search"] = "搜索";
		L["Open"] = "打开搜索";
		L["Close"] = "关闭搜索";
		L["add_fav"] = "添加收藏";
		L["sub_fav"] = "取消收藏";
		L["query_who_can_craft_it"] = "谁会做它？";
		L["showKnown"] = "已学";
		L["showUnkown"] = "未学";
		L["showHighRank"] = "高等级";
		L["showItemInsteadOfSpell"] = "物品";
		L["showRank"] = "等级";
		L["haveMaterials"] = "材料足够";
		L["costOnly"] = "只显示成本";
		--
		L["LABEL_RANK_LEVEL"] = "\124cffff7f00技能等级: \124r";
		L["LABEL_GET_FROM"] = "\124cffff7f00来源: \124r";
		L["quest"] = "任务";
		L["item"] = "物品";
		L["object"] = "物品";
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
		L["LABEL_ACCOUT_RECIPE_LEARNED"] = "\124cffff7f00帐号角色状态: \124r";
		L["LABEL_USED_AS_MATERIAL_IN"] = "\124cffff7f00用于制造: \124r";
		L["RECIPE_LEARNED"] = "\124cff00ff00已学\124r";
		L["RECIPE_NOT_LEARNED"] = "\124cffff0000未学\124r";

		L["PRINT_MATERIALS: "] = "材料: ";
		L["PRICE_UNK"] = "未知";
		L["AH_PRICE"] = "\124cff00ff00价格\124r";
		L["VENDOR_RPICE"] = "\124cffffaf00商人\124r";
		L["COST_PRICE"] = "\124cffff7f00成本\124r";
		L["COST_PRICE_KNOWN"] = "\124cffff0000已缓存成本\124r";
		L["UNKOWN_PRICE"] = "\124cffff0000未知价格\124r";
		L["BOP"] = "\124cffff7f7f拾取绑定\124r";
		L["PRICE_DIFF+"] = "\124cff00ff00差价\124r";
		L["PRICE_DIFF-"] = "\124cffff0000差价\124r";
		L["PRICE_DIFF0"] = "持平";
		L["PRICE_DIFF_INFO+"] = "\124cff00ff00利润\124r";
		L["PRICE_DIFF_INFO-"] = "\124cffff0000亏损\124r";
		L["CRAFT_INFO"] = "\124cffff7f00商业技能制造信息: \124r";
		L["ITEMS_UNK"] = "项未知";
		L["NEED_UPDATE"] = "\124cffff0000!!需要刷新!!\124r";
		--
		L["TIP_PROFIT_FRAME_CALL_INFO"] = "\124cffffffff我想赚点零花钱! \124r";
		L["TIP_SEARCH_NAME_ONLY_INFO"] = "\124cffffffff只搜索名字，而不是物品链接\124r";
		--
		L["BOARD_LOCK"] = "锁定";
		L["BOARD_CLOSE"] = "关闭";
		L["BOARD_TIP"] = "显示帐号下角色的商业技能冷却时间，鼠标右击锁定或关闭";
		L["COLORED_FORMATTED_TIME_LEN"] = {
			"\124cff%.2x%.2x00%d天%02d时%02d分%02d秒\124r",
			"\124cff%.2x%.2x00%d时%02d分%02d秒\124r",
			"\124cff%.2x%.2x00%d分%02d秒\124r",
			"\124cff%.2x%.2x00%d秒\124r",
		};
		L["COOLDOWN_EXPIRED"] = "\124cff00ff00冷却结束\124r";
		--
		L["EXPLORER_TITLE"] = "ALA @ 网易有爱 \124cff00ff00wowui.w.163.com\124r";
		L.EXPLORER_SET = {
			skill = "技能",
			type = "物品类型",
			subType = "子类型",
			eqLoc = "装备部位",
		};
		L.TRADESKILL_NAME = {
			[1] = "急救",
			[2] = "锻造",
			[3] = "制皮",
			[4] = "炼金术",
			[5] = "草药学",
			[6] = "烹饪",
			[7] = "采矿",
			[8] = "裁缝",
			[9] = "工程学",
			[10] = "附魔",
			[11] = "钓鱼",
			[12] = "剥皮",
			[13] = "毒药（盗贼）",
		};
		L.ITEM_TYPE_LIST = {
			[LE_ITEM_CLASS_CONSUMABLE] = "消耗品",				--	0	Consumable
			[LE_ITEM_CLASS_CONTAINER] = "容器",					--	1	Container
			[LE_ITEM_CLASS_WEAPON] = "武器",					--	2	Weapon
			[LE_ITEM_CLASS_GEM] = "宝石",						--	3	Gem
			[LE_ITEM_CLASS_ARMOR] = "护甲",						--	4	Armor
			[LE_ITEM_CLASS_REAGENT] = "材料",					--	5	Reagent Obsolete
			[LE_ITEM_CLASS_PROJECTILE] = "弹药",				--	6	Projectile Obsolete
			[LE_ITEM_CLASS_TRADEGOODS] = "商品",				--	7	Tradeskill
			[LE_ITEM_CLASS_ITEM_ENHANCEMENT] = "Item Enhancement",	--	8	Item Enhancement
			[LE_ITEM_CLASS_RECIPE] = "配方",					--	9	Recipe
			[10] = "Money",										--	10	Money(OBSOLETE)
			[LE_ITEM_CLASS_QUIVER] = "箭袋",					--	11	Quiver Obsolete
			[LE_ITEM_CLASS_QUESTITEM] = "任务",					--	12	Quest
			[LE_ITEM_CLASS_KEY] = "钥匙",						--	13	Key Obsolete
			[14] = "Permanent",									--	14	Permanent(OBSOLETE)
			[LE_ITEM_CLASS_MISCELLANEOUS] = "其它",				--	15	Miscellaneous
			[LE_ITEM_CLASS_GLYPH] = "Glyph",					--	16	Glyph
			[LE_ITEM_CLASS_BATTLEPET] = "战斗宠物",				--	17	Battle Pets
			[LE_ITEM_CLASS_WOW_TOKEN] = "WoW Token",			--	18	WoW Token
		};
		L.ITEM_SUB_TYPE_LIST = {
			[LE_ITEM_CLASS_CONSUMABLE] = {			--	0	Consumable
				[0] = "消耗品",				--	Explosives and Devices
				[1] = "药水",				--	Potion
				[2] = "药剂",				--	Elixir
				[3] = "合剂",				--	Flask
				[4] = "卷轴",				--	Scroll (OBSOLETE)
				[5] = "食物和饮料",			--	Food & Drink
				[6] = "物品附魔",			--	Item Enhancement (OBSOLETE)
				[7] = "绷带",				--	Bandage
				[8] = "其它",				--	Other
				[9] = "凡图斯符文",			--	Vantus Runes
			},
			[LE_ITEM_CLASS_CONTAINER] = {			--	1	Container
				[0] = "容器",		--	Bag
				[1] = "灵魂包",		--	Soul Bag
				[2] = "草药包",		--	Herb Bag
				[3] = "附魔包",		--	Enchanting Bag
				[4] = "工程包",		--	Engineering Bag
				[5] = "宝石包",		--	Gem Bag
				[6] = "矿石包",		--	Mining Bag
				[7] = "制皮包",		--	Leatherworking Bag
				[8] = "铭文包",		--	Inscription Bag
				[9] = "渔具包",		--	Tackle Box
				[10] = "烹饪包",	--	Cooking Bag
			},
			[LE_ITEM_CLASS_WEAPON] = {				--	2	Weapon
				[LE_ITEM_WEAPON_AXE1H] = "单手斧",			--	0	--	One-Handed Axes
				[LE_ITEM_WEAPON_AXE2H] = "双手斧",			--	1	--	Two-Handed Axes
				[LE_ITEM_WEAPON_BOWS] = "弓",				--	2	--	Bows
				[LE_ITEM_WEAPON_GUNS] = "枪",				--	3	--	Guns
				[LE_ITEM_WEAPON_MACE1H] = "单手锤",			--	4	--	One-Handed Maces
				[LE_ITEM_WEAPON_MACE2H] = "双手锤",			--	5	--	Two-Handed Maces
				[LE_ITEM_WEAPON_POLEARM] = "长柄武器",		--	6	--	Polearms
				[LE_ITEM_WEAPON_SWORD1H] = "单手剑",		--	7	--	One-Handed Swords
				[LE_ITEM_WEAPON_SWORD2H] = "双手剑",		--	8	--	Two-Handed Swords
				[LE_ITEM_WEAPON_WARGLAIVE] = "战刃",		--	9	--	Warglaives
				[LE_ITEM_WEAPON_STAFF] = "法杖",			--	10	--	Staves
				[LE_ITEM_WEAPON_EXOTIC1H] = "Bear Claws",	--	11	--	LE_ITEM_WEAPON_BEARCLAW	--	Bear Claws
				[LE_ITEM_WEAPON_EXOTIC2H] = "CatClaws",		--	12	--	LE_ITEM_WEAPON_CATCLAW	--	CatClaws
				[LE_ITEM_WEAPON_UNARMED] = "拳套",			--	13	--	Fist Weapons
				[LE_ITEM_WEAPON_GENERIC] = "其它",			--	14	--	Miscellaneous
				[LE_ITEM_WEAPON_DAGGER] = "匕首",			--	15	--	Daggers
				[LE_ITEM_WEAPON_THROWN] = "投掷武器",		--	16	--	Thrown
				[LE_ITEM_WEAPON_SPEAR] = "Spears",			--	17	--	Spears
				[LE_ITEM_WEAPON_CROSSBOW] = "弩",			--	18	--	Crossbows
				[LE_ITEM_WEAPON_WAND] = "魔杖",				--	19	--	Wands
				[LE_ITEM_WEAPON_FISHINGPOLE] = "钓鱼竿",	--	20	--	Fishing Poles
			},
			[LE_ITEM_CLASS_GEM] = {					--	3	Gem
				[LE_ITEM_GEM_RED] = "红色宝石",					--	0	--	Intellect
				[LE_ITEM_GEM_BLUE] = "蓝色宝石",				--	1	--	Agility
				[LE_ITEM_GEM_YELLOW] = "黄色宝石",				--	2	--	Strength
				[LE_ITEM_GEM_PURPLE] = "紫色宝石",				--	3	--	Stamina
				[LE_ITEM_GEM_GREEN] = "绿色宝石",				--	4	--	Spirit
				[LE_ITEM_GEM_ORANGE] = "橙色宝石",				--	5	--	Critical Strike
				[LE_ITEM_GEM_META] = "多彩宝石",				--	6	--	Mastery
				[LE_ITEM_GEM_SIMPLE] = "简单宝石",				--	7	--	Haste
				[LE_ITEM_GEM_PRISMATIC] = "棱彩宝石",			--	8	--	Versatility
			},
			[LE_ITEM_CLASS_ARMOR] = {				--	4	Armor
				[LE_ITEM_ARMOR_GENERIC] = "其它",		--	0	--	Miscellaneous	Includes Spellstones, Firestones, Trinkets, Rings and Necks
				[LE_ITEM_ARMOR_CLOTH] = "布甲",			--	1	--	Cloth
				[LE_ITEM_ARMOR_LEATHER] = "皮甲",		--	2	--	Leather
				[LE_ITEM_ARMOR_MAIL] = "锁甲",			--	3	--	Mail
				[LE_ITEM_ARMOR_PLATE] = "板甲",			--	4	--	Plate
				[LE_ITEM_ARMOR_COSMETIC] = "Cosmetic",	--	5	--	Cosmetic
				[LE_ITEM_ARMOR_SHIELD] = "盾牌",		--	6	--	Shields
				[LE_ITEM_ARMOR_LIBRAM] = "圣契",		--	7	--	Librams
				[LE_ITEM_ARMOR_IDOL] = "神像",			--	8	--	Idols
				[LE_ITEM_ARMOR_TOTEM] = "图腾",			--	9	--	Totems
				[LE_ITEM_ARMOR_SIGIL] = "魔印",			--	10	--	Sigils
				[LE_ITEM_ARMOR_RELIC] = "Relic",		--	11	--	Relic
			},
			[LE_ITEM_CLASS_REAGENT] = {				--	5	Reagent Obsolete
				[0] = "材料",		--	Reagent
				[1] = "Keystone",	--	Keystone
			},
			[LE_ITEM_CLASS_PROJECTILE] = {			--	6	Projectile Obsolete
				[0] = "Wand",		--	Wand(OBSOLETE)
				[1] = "Bolt",		--	Bolt(OBSOLETE)
				[2] = "箭",		--	Arrow
				[3] = "子弹",		--	Bullet
				[4] = "投掷武器",	--	Thrown(OBSOLETE)
			},
			[LE_ITEM_CLASS_TRADEGOODS] = {			--	7	Tradeskill
				[0] = "商品",						--	Trade Goods (OBSOLETE)
				[1] = "零件",						--	Parts
				[2] = "爆炸物",						--	Explosives (OBSOLETE)
				[3] = "装置",						--	Devices (OBSOLETE)
				[4] = "Jewelcrafting",				--	Jewelcrafting
				[5] = "Cloth",						--	Cloth
				[6] = "Leather",					--	Leather
				[7] = "Metal & Stone",				--	Metal & Stone
				[8] = "Cooking",					--	Cooking
				[9] = "Herb",						--	Herb
				[10] = "Elemental",					--	Elemental
				[11] = "Other",						--	Other
				[12] = "Enchanting",				--	Enchanting
				[13] = "Materials",					--	Materials (OBSOLETE)
				[14] = "Item Enchantment",			--	Item Enchantment (OBSOLETE)
				[15] = "Weapon Enchantment",		--	Weapon Enchantment - Obsolete
				[16] = "Inscription",				--	Inscription
				[17] = "Explosives and Devices",	--	Explosives and Devices (OBSOLETE)
			},
			[LE_ITEM_CLASS_ITEM_ENHANCEMENT] = {	--	8	Item Enhancement
				[0] = "头部",			--	Head
				[1] = "颈部",			--	Neck
				[2] = "肩部",			--	Shoulder
				[3] = "背部",			--	Cloak
				[4] = "胸部",			--	Chest
				[5] = "手腕",			--	Wrist
				[6] = "手",				--	Hands
				[7] = "腰部",			--	Waist
				[8] = "腿部",			--	Legs
				[9] = "脚",				--	Feet
				[10] = "手指",			--	Finger
				[11] = "武器",			--	Weapon	One-handed weapons
				[12] = "双手武器",		--	Two-Handed Weapon
				[13] = "盾牌/副手",		--	Shield/Off-hand
				[14] = "Misc",			--	Misc
			},
			[LE_ITEM_CLASS_RECIPE] = {				--	9	Recipe
				[LE_ITEM_RECIPE_BOOK] = "书籍",					--	0	--	Book
				[LE_ITEM_RECIPE_LEATHERWORKING] = "制皮",		--	1	--	Leatherworking
				[LE_ITEM_RECIPE_TAILORING] = "裁缝",			--	2	--	Tailoring
				[LE_ITEM_RECIPE_ENGINEERING] = "工程学",		--	3	--	Engineering
				[LE_ITEM_RECIPE_BLACKSMITHING] = "锻造",		--	4	--	Blacksmithing
				[LE_ITEM_RECIPE_COOKING] = "烹饪",				--	5	--	Cooking
				[LE_ITEM_RECIPE_ALCHEMY] = "炼金术",			--	6	--	Alchemy
				[LE_ITEM_RECIPE_FIRST_AID] = "急救",			--	7	--	First Aid
				[LE_ITEM_RECIPE_ENCHANTING] = "附魔",			--	8	--	Enchanting
				[LE_ITEM_RECIPE_FISHING] = "钓鱼",				--	9	--	Fishing
				[LE_ITEM_RECIPE_JEWELCRAFTING] = "珠宝加工",	--	10	--	Jewelcrafting
				[LE_ITEM_RECIPE_INSCRIPTION] = "铭文",			--	11	--	Inscription
			},
			[10] = {								--	10	Money(OBSOLETE)
				[0] = "Money",	--	Money(OBSOLETE)
			},
			[LE_ITEM_CLASS_QUIVER] = {				--	11	Quiver Obsolete
				[0] = "Quiver(OBSOLETE)",	--	Quiver(OBSOLETE)
				[1] = "Bolt(OBSOLETE)",		--	Bolt(OBSOLETE)
				[2] = "箭袋",				--	Quiver
				[3] = "弹药袋",				--	Ammo Pouch
			},
			[LE_ITEM_CLASS_QUESTITEM] = {			--	12	Quest
				[0] = "任务",			--	Quest
			},
			[LE_ITEM_CLASS_KEY] = {					--	13	Key Obsolete
				[0] = "钥匙",			--	Key
				[1] = "Lockpick",		--	Lockpick
			},
			[14] = {								--	14	Permanent(OBSOLETE)
				[0] = "Permanent",		--	Permanent
			},
			[LE_ITEM_CLASS_MISCELLANEOUS] = {		--	15	Miscellaneous
				[LE_ITEM_MISCELLANEOUS_JUNK] = "垃圾",							--	0	--	Junk
				[LE_ITEM_MISCELLANEOUS_REAGENT] = "Reagent",					--	1	--	Reagent	Mainly spell reagents. For crafting reagents see 7: Tradeskill.
				[LE_ITEM_MISCELLANEOUS_COMPANION_PET] = "Companion Pets",		--	2	--	Companion Pets
				[LE_ITEM_MISCELLANEOUS_HOLIDAY] = "Holiday",					--	3	--	Holiday
				[LE_ITEM_MISCELLANEOUS_OTHER] = "Other",						--	4	--	Other
				[LE_ITEM_MISCELLANEOUS_MOUNT] = "Mount",						--	5	--	Mount
				-- [LE_ITEM_MISCELLANEOUS_MOUNT_EQUIPMENT] = "Mount Equipment",	--	6	--	Mount Equipment
			},
			[LE_ITEM_CLASS_GLYPH] = {				--	16	Glyph
				[1] = "Warrior",		--	Warrior
				[2] = "Paladin",		--	Paladin
				[3] = "Hunter",			--	Hunter
				[4] = "Rogue",			--	Rogue
				[5] = "Priest",			--	Priest
				[6] = "Death Knight",	--	Death Knight
				[7] = "Shaman",			--	Shaman
				[8] = "Mage",			--	Mage
				[9] = "Warlock",		--	Warlock
				[10] = "Monk",			--	Monk
				[11] = "Druid",			--	Druid
				[12] = "Demon Hunter",	--	Demon Hunter
			},
			[LE_ITEM_CLASS_BATTLEPET] = {			--	17	Battle Pets
				[0] = "Humanoid",		--	Humanoid
				[1] = "Dragonkin",		--	Dragonkin
				[2] = "Flying",			--	Flying
				[3] = "Undead",			--	Undead
				[4] = "Critter",		--	Critter
				[5] = "Magic",			--	Magic
				[6] = "Elemental",		--	Elemental
				[7] = "Beast",			--	Beast
				[8] = "Aquatic",		--	Aquatic
				[9] = "Mechanical",		--	Mechanical
			},
			[LE_ITEM_CLASS_WOW_TOKEN] = {			--	18	WoW Token
				[0] = "WoW Token",		--	WoW Token
			},
		};
		L.ITEM_EQUIP_LOC = {
			[0] = "弹药",
			[1] = "头部",
			[2] = "颈部",
			[3] = "肩部",
			[4] = "衬衣",
			[5] = "胸部",
			[6] = "腰部",
			[7] = "腿部",
			[8] = "脚",
			[8] = "腿部",
			[9] = "手腕",
			[10] = "手",
			[11] = "手指",
			[13] = "饰品",
			[15] = "背部",
			[16] = "主手",
			[17] = "副手",
			[18] = "远程",
			[19] = "战袍",
			[20] = "背包",
			[21] = "单手武器",
			[22] = "双手武器",
		};
		L["EXPLORER_CLEAR_FILTER"] = "\124cff00ff00清除\124r";
		--
		L.SLASH_NOTE = {
			["expand"] = "加宽窗口",
			["blz_style"] = "暴雪风格",
			["bg_color"] = "点击设置背景颜色",
			["show_tradeskill_frame_price_info"] = "在商业技能窗口中显示价格信息",
			["show_tradeskill_frame_rank_info"] = "在商业技能窗口中显示等级信息",
			["show_tradeskill_tip_craft_item_price"] = "在鼠标提示中显示物品制造信息",
			["show_tradeskill_tip_craft_spell_price"] = "在鼠标提示中显示商业技能法术信息",
			["show_tradeskill_tip_recipe_price"] = "在鼠标提示中显示配方信息",
			["show_tradeskill_tip_recipe_account_learned"] = "在配方的鼠标提示中，显示帐号所有角色的学习情况",
			["show_tradeskill_tip_material_craft_info"] = "显示物品作为材料的商业技能信息",
			["default_skill_button_tip"] = "在默认的技能列表上显示鼠标提示",
			["colored_rank_for_unknown"] = "总是将名称按照难度染色，将未学技能底色显示为红色",
			["regular_exp"] = "正则表达式搜索\124cffff0000!!!慎用!!!\124r",
			["show_call"] = "显示界面切换按钮",
			["show_tab"] = "显示切换栏",
			["portrait_button"] = "商业技能头像下拉菜单",
			["show_board"] = "显示冷却面板",
			["lock_board"] = "锁定冷却面板",
			["hide_mtsl"] = "隐藏MTSL界面",
		};
		L.ALPHA = "透明度";
		L.CHAR_LIST = "角色列表";
		L.CHAR_DEL = "删除角色";
		L["INVALID_COMMANDS"] = "无效命令参数，使用\124cff00ff00true、1、on、enable\124r 或者 \124cffff0000false、0、off、disable\124r.";
	elseif LOCALE == "koKR" then
		L["OK"] = "확인";
		L["Search"] = "검색";
		L["Open"] = "열기";
		L["Close"] = "닫기";
		L["add_fav"] = "즐겨찾기";
		L["sub_fav"] = "즐겨찾기 해제";
		L["query_who_can_craft_it"] = "누가 제작 가능?";
		L["showKnown"] = "알려짐";
		L["showUnkown"] = "알 수 없음";
		L["showHighRank"] = "높은 랭크";
		L["showItemInsteadOfSpell"] = "아이템";
		L["showRank"] = "랭크";
		L["haveMaterials"] = "보유 재료";
		L["costOnly"] = "가격만 표시";
		--
		L["LABEL_RANK_LEVEL"] = "\124cffff7f00랭크: \124r";
		L["LABEL_GET_FROM"] = "\124cffff7f00획득: \124r";
		L["quest"] = "퀘스트";
		L["item"] = "아이템";
		L["object"] = "아이템";
		L["trainer"] = "기술 전문가";
		L["quest_reward"] = "퀘스트 보상";
		L["quest_accepted_from"] = "에 의해 주어진 퀘스트";
		L["sold_by"] = "판매";
		L["dropped_by"] = "드랍";
		L["world_drop"] = "월드 드랍";
		L["dropped_by_mod_level"] = "몹 레벨";
		L["tradable"] = "거래 가능";
		L["non_tradable"] = "거래 불가능";
		L["elite"] = "정예";
		L["phase"] = "페이즈";
		L["not_available_for_player's_faction"] = "플레이어 진영에는 사용할 수 없습니다";
		L["available_in_phase_"] = "페이즈에 이용 가능 → ";
		L["LABEL_ACCOUT_RECIPE_LEARNED"] = "\124cffff7f00Status of characters:\124r";
		L["LABEL_USED_AS_MATERIAL_IN"] = "\124cffff7f00Used to craft: \124r";
		L["RECIPE_LEARNED"] = "\124cff00ff00학습\124r";
		L["RECIPE_NOT_LEARNED"] = "\124cffff0000비학습\124r";

		L["PRINT_MATERIALS: "] = "필요: ";
		L["PRICE_UNK"] = "알 수 없음";
		L["AH_PRICE"] = "\124cff00ff00경매 \124r";
		L["VENDOR_RPICE"] = "\124cffffaf00상점 \124r";
		L["COST_PRICE"] = "\124cffff7f00가격 \124r";
		L["COST_PRICE_KNOWN"] = "\124cffff0000알려진 가격 \124r";
		L["UNKOWN_PRICE"] = "\124cffff0000알 수 없는 가격\124r";
		L["BOP"] = "\124cffff7f7f획득시 귀속\124r";
		L["PRICE_DIFF+"] = "\124cff00ff00가격 차이 \124r";
		L["PRICE_DIFF-"] = "\124cffff0000가격 차이 \124r";
		L["PRICE_DIFF0"] = "똑같음";
		L["PRICE_DIFF_INFO+"] = "\124cff00ff00+\124r";
		L["PRICE_DIFF_INFO-"] = "\124cffff0000-\124r";
		L["CRAFT_INFO"] = "\124cffff7f00제작 정보: \124r";
		L["ITEMS_UNK"] = "알 수 없는 아이템";
		L["NEED_UPDATE"] = "\124cffff0000!!새로 고침 필요!\124r";
		--
		L["TIP_PROFIT_FRAME_CALL_INFO"] = "\124cffffffff돈을 버세요!\124r";
		L["TIP_SEARCH_NAME_ONLY_INFO"] = "\124cffffffSearch name instead of hyperlink\124r";
		--
		L["BOARD_LOCK"] = "잠금";
		L["BOARD_CLOSE"] = "닫기";
		L["BOARD_TIP"] = "계정간 스킬 스킬의 재사용 대기 시간을 표시합니다. 마우스 오른쪽 버튼을 클릭하여 전환 또는 잠금";
		L["COLORED_FORMATTED_TIME_LEN"] = {
			"\124cff%.2x%.2x00%d일 %02d시간 %02d분 %02d초\124r",
			"\124cff%.2x%.2x00%d시간 %02d분 %02d초\124r",
			"\124cff%.2x%.2x00%d분 %02d초\124r",
			"\124cff%.2x%.2x00%d초\124r",
		};
		L["COOLDOWN_EXPIRED"] = "\124cff00ff00유효함\124r";
		--
		L["EXPLORER_TITLE"] = "ALA @ 163UI";
		L.EXPLORER_SET = {
			skill = "기술",
			type = "유형",
			subType = "하위유형",
			eqLoc = "장비부위",
		};
		L.TRADESKILL_NAME = {
			[1] = "응급치료",
			[2] = "대장기술",
			[3] = "가죽세공",
			[4] = "연금술",
			[5] = "약초찾기",
			[6] = "요리",
			[7] = "채광",
			[8] = "재봉술",
			[9] = "기계공학",
			[10] = "마법부여",
			[11] = "낚시",
			[12] = "무두질",
			[13] = "독극물",
		};
		L.ITEM_TYPE_LIST = {
			[LE_ITEM_CLASS_CONSUMABLE] = "소모품",				--	0	Consumable
			[LE_ITEM_CLASS_CONTAINER] = "용기",				--	1	Container
			[LE_ITEM_CLASS_WEAPON] = "무기",						--	2	Weapon
			[LE_ITEM_CLASS_GEM] = "보석",							--	3	Gem
			[LE_ITEM_CLASS_ARMOR] = "갑옷",						--	4	Armor
			[LE_ITEM_CLASS_REAGENT] = "재료",					--	5	Reagent Obsolete
			[LE_ITEM_CLASS_PROJECTILE] = "탄약",				--	6	Projectile Obsolete
			[LE_ITEM_CLASS_TRADEGOODS] = "상품",				--	7	Tradeskill
			[LE_ITEM_CLASS_ITEM_ENHANCEMENT] = "아이템 향상",	--	8	Item Enhancement
			[LE_ITEM_CLASS_RECIPE] = "레시피",						--	9	Recipe
			[10] = "돈",											--	10	Money(OBSOLETE)
			[LE_ITEM_CLASS_QUIVER] = "직업가방",						--	11	Quiver Obsolete
			[LE_ITEM_CLASS_QUESTITEM] = "퀘스트",					--	12	Quest
			[LE_ITEM_CLASS_KEY] = "열쇠",							--	13	Key Obsolete
			[14] = "영구적인",										--	14	Permanent(OBSOLETE)
			[LE_ITEM_CLASS_MISCELLANEOUS] = "기타",		--	15	Miscellaneous
			[LE_ITEM_CLASS_GLYPH] = "GLYPH",						--	16	Glyph
			[LE_ITEM_CLASS_BATTLEPET] = "전투 애완 동물",				--	17	Battle Pets
			[LE_ITEM_CLASS_WOW_TOKEN] = "와우 토큰",				--	18	WoW Token
		};
		L.ITEM_SUB_TYPE_LIST = {
			[LE_ITEM_CLASS_CONSUMABLE] = {			--	0	Consumable
				[0] = "소모품", 
				[1] = "물약", 
				[2] = "영약", 
				[3] = "용기", 
				[4] = "두루마리", 
				[5] = "음식 & 음료", 
				[6] = "아이템 향상", 
				[7] = "붕대", 
				[8] = "기타", 
				[9] = "반투스 룬", 
			},
			[LE_ITEM_CLASS_CONTAINER] = {			--	1	Container
				[0] = "가방", 
				[1] = "영혼석 가방", 
				[2] = "약초 가방", 
				[3] = "마법부여 가방", 
				[4] = "기계공학 가방", 
				[5] = "보석 가방", 
				[6] = "채광 가방", 
				[7] = "무두 가방", 
				[8] = "주문각인 가방", 
				[9] = "낚시 도구 상자", 
				[10] = "요리 가방", 
			},
			[LE_ITEM_CLASS_WEAPON] = {								--	2	Weapon
				[LE_ITEM_WEAPON_AXE1H] = "한손 도끼", 		--	0
				[LE_ITEM_WEAPON_AXE2H] = "양손 도끼", 		--	1
				[LE_ITEM_WEAPON_BOWS] = "활", 					--	2
				[LE_ITEM_WEAPON_GUNS] = "총", 					--	3
				[LE_ITEM_WEAPON_MACE1H] = "한손 둔기", 		--	4
				[LE_ITEM_WEAPON_MACE2H] = "양손 둔기", 		--	5
				[LE_ITEM_WEAPON_POLEARM] = "장창", 				--	6
				[LE_ITEM_WEAPON_SWORD1H] = "한손 도검", 	--	7
				[LE_ITEM_WEAPON_SWORD2H] = "양손 도검", 	--	8
				[LE_ITEM_WEAPON_WARGLAIVE] = "전투검", 			--	9
				[LE_ITEM_WEAPON_STAFF] = "자팡이", 					--	10
				[LE_ITEM_WEAPON_EXOTIC1H] = "곰 발톱", 			--	11	--	LE_ITEM_WEAPON_BEARCLAW
				[LE_ITEM_WEAPON_EXOTIC2H] = "고양이 발톱", 				--	12	--	LE_ITEM_WEAPON_CATCLAW
				[LE_ITEM_WEAPON_UNARMED] = "장착 무기", 			--	13
				[LE_ITEM_WEAPON_GENERIC] = "기타", 		--	14
				[LE_ITEM_WEAPON_DAGGER] = "단검", 				--	15
				[LE_ITEM_WEAPON_THROWN] = "투척 무기", 				--	16
				[LE_ITEM_WEAPON_SPEAR] = "SPEAR", 					--	17
				[LE_ITEM_WEAPON_CROSSBOW] = "석궁", 			--	18
				[LE_ITEM_WEAPON_WAND] = "마법봉", 					--	19
				[LE_ITEM_WEAPON_FISHINGPOLE] = "낚시대", 	--	20
			},
			[LE_ITEM_CLASS_GEM] = {					--	3	Gem
				[LE_ITEM_GEM_RED] = "Red Gem",					--	0	--	Intellect
				[LE_ITEM_GEM_BLUE] = "Blue Gem",				--	1	--	Agility
				[LE_ITEM_GEM_YELLOW] = "Yellow Gem",				--	2	--	Strength
				[LE_ITEM_GEM_PURPLE] = "Purple Gem",				--	3	--	Stamina
				[LE_ITEM_GEM_GREEN] = "Green Gem",				--	4	--	Spirit
				[LE_ITEM_GEM_ORANGE] = "Orange Gem",				--	5	--	Critical Strike
				[LE_ITEM_GEM_META] = "Meta Gem",				--	6	--	Mastery
				[LE_ITEM_GEM_SIMPLE] = "Simple Gem",				--	7	--	Haste
				[LE_ITEM_GEM_PRISMATIC] = "Prismatic Gem",			--	8	--	Versatility
			},
			[LE_ITEM_CLASS_ARMOR] = {						--	4	Armor
				[LE_ITEM_ARMOR_GENERIC] = "기타", 	--	0	Includes Spellstones, Firestones, Trinkets, Rings and Necks
				[LE_ITEM_ARMOR_CLOTH] = "천", 			--	1
				[LE_ITEM_ARMOR_LEATHER] = "가죽", 		--	2
				[LE_ITEM_ARMOR_MAIL] = "사슬", 				--	3
				[LE_ITEM_ARMOR_PLATE] = "판금", 			--	4
				[LE_ITEM_ARMOR_COSMETIC] = "Cosmetic", 		--	5
				[LE_ITEM_ARMOR_SHIELD] = "방패", 		--	6
				[LE_ITEM_ARMOR_LIBRAM] = "성서", 		--	7
				[LE_ITEM_ARMOR_IDOL] = "우상", 			--	8
				[LE_ITEM_ARMOR_TOTEM] = "토템", 			--	9
				[LE_ITEM_ARMOR_SIGIL] = "Sigils", 			--	10
				[LE_ITEM_ARMOR_RELIC] = "유물", 			--	11
			},
			[LE_ITEM_CLASS_REAGENT] = {				--	5	Reagent Obsolete
				[0] = "재료", 
				[1] = "쐐기돌", 
			},
			[LE_ITEM_CLASS_PROJECTILE] = {			--	6	Projectile Obsolete
				[0] = "Wand", 
				[1] = "Bolt", 
				[2] = "화살", 
				[3] = "총알", 
				[4] = "투척", 
			},
			[LE_ITEM_CLASS_TRADEGOODS] = {			--	7	Tradeskill
				[0] = "상품", 
				[1] = "부속", 
				[2] = "폭발물", 
				[3] = "장치", 
				[4] = "보석세공", 
				[5] = "천", 
				[6] = "가죽", 
				[7] = "주괴 및 광석", 
				[8] = "요리", 
				[9] = "약초", 
				[10] = "정령", 
				[11] = "기타", 
				[12] = "마법부여", 
				[13] = "재료", 
				[14] = "아이템 마법부여", 
				[15] = "무기 마법부여", 
				[16] = "주문각인", 
				[17] = "폭발물과 장치", 
			},
			[LE_ITEM_CLASS_ITEM_ENHANCEMENT] = {	--	8	Item Enhancement
				[0] = "머리", 
				[1] = "목", 
				[2] = "어깨", 
				[3] = "망토", 
				[4] = "가슴", 
				[5] = "손목", 
				[6] = "손", 
				[7] = "허리", 
				[8] = "다리", 
				[9] = "발", 
				[10] = "손가락", 
				[11] = "한손 무기", 
				[12] = "양손 무기", 
				[13] = "방패/보조장비", 
				[14] = "기타", 
			},
			[LE_ITEM_CLASS_RECIPE] = {				--	9	Recipe
				[LE_ITEM_RECIPE_BOOK] = "책", 					--	0
				[LE_ITEM_RECIPE_LEATHERWORKING] = "가죽세공", --	1
				[LE_ITEM_RECIPE_TAILORING] = "재봉술", 			--	2
				[LE_ITEM_RECIPE_ENGINEERING] = "기계공학", 		--	3
				[LE_ITEM_RECIPE_BLACKSMITHING] = "대장기술", 	--	4
				[LE_ITEM_RECIPE_COOKING] = "요리", 				--	5
				[LE_ITEM_RECIPE_ALCHEMY] = "연금술", 				--	6
				[LE_ITEM_RECIPE_FIRST_AID] = "응급치료", 			--	7
				[LE_ITEM_RECIPE_ENCHANTING] = "마법부여", 		--	8
				[LE_ITEM_RECIPE_FISHING] = "낚시", 				--	9
				[LE_ITEM_RECIPE_JEWELCRAFTING] = "보석세공", 	--	10
				[LE_ITEM_RECIPE_INSCRIPTION] = "주문각인", 		--	11
			},
			[10] = {								--	10	Money(OBSOLETE)
				[0] = "돈",
			},
			[LE_ITEM_CLASS_QUIVER] = {				--	11	Quiver Obsolete
				[0] = "Quiver(OBSOLETE)",
				[1] = "Bolt(OBSOLETE)",
				[2] = "Quiver",
				[3] = "총알 주머니",
			},
			[LE_ITEM_CLASS_QUESTITEM] = {			--	12	Quest
				[0] = "퀘스트",
			},
			[LE_ITEM_CLASS_KEY] = {					--	13	Key Obsolete
				[0] = "열쇠",
				[1] = "자물쇠",
			},
			[14] = {								--	14	Permanent(OBSOLETE)
				[0] = "영구적인",
			},
			[LE_ITEM_CLASS_MISCELLANEOUS] = {		--	15	Miscellaneous
				[LE_ITEM_MISCELLANEOUS_JUNK] = "기타 잡템",							--	0
				[LE_ITEM_MISCELLANEOUS_REAGENT] = "영구적인",					--	17: Tradeskill.
				[LE_ITEM_MISCELLANEOUS_COMPANION_PET] = "반려 동물",		--	2
				[LE_ITEM_MISCELLANEOUS_HOLIDAY] = "휴일",					--	3
				[LE_ITEM_MISCELLANEOUS_OTHER] = "기타",						--	4
				[LE_ITEM_MISCELLANEOUS_MOUNT] = "장착",						--	5
				-- [LE_ITEM_MISCELLANEOUS_MOUNT_EQUIPMENT] = "Mount Equipment",	--	6
			},
			[LE_ITEM_CLASS_GLYPH] = {				--	16	Glyph
				[1] = "전사",
				[2] = "성기사",
				[3] = "사냥꾼",
				[4] = "도적",
				[5] = "사제",
				[6] = "죽음의기사",
				[7] = "주술사",
				[8] = "마법사",
				[9] = "흑마법사",
				[10] = "수도사",
				[11] = "드루이드",
				[12] = "악마사냥꾼",
			},
			[LE_ITEM_CLASS_BATTLEPET] = {			--	17	Battle Pets
				[0] = "Humanoid",
				[1] = "Dragonkin",
				[2] = "Flying",
				[3] = "Undead",
				[4] = "Critter",
				[5] = "Magic",
				[6] = "Elemental",
				[7] = "Beast",
				[8] = "Aquatic",
				[9] = "Mechanical",
			},
			[LE_ITEM_CLASS_WOW_TOKEN] = {			--	18	WoW Token
				[0] = "와우 토큰",
			},
		};
		L.ITEM_EQUIP_LOC = {
			[0] = "탄약",
			[1] = "머리",
			[2] = "목",
			[3] = "어깨",
			[4] = "셔츠",
			[5] = "가슴",
			[6] = "허리",
			[7] = "다리",
			[8] = "발",
			[9] = "손목",
			[10] = "손",
			[11] = "손가락",
			[13] = "장신구",
			[15] = "망토",
			[16] = "주장비",
			[17] = "보조장비",
			[18] = "원거리",
			[19] = "휘장",
			[20] = "용기",
			[21] = "한손 무기",
			[22] = "양손 무기",
		};
		L["EXPLORER_CLEAR_FILTER"] = "\124cff00ff00Clear\124r";
		--
		L.SLASH_NOTE = {
			["expand"] = "Expand frame",
			["blz_style"] = "Blizzar style",
			["bg_color"] = "Click to set Color of Background",
			["show_tradeskill_frame_price_info"] = "전문 기술 프레임에 가격 정보 표시",
			["show_tradeskill_frame_rank_info"] = "전문 기술 프레임에 순위 정보 표시",
			["show_tradeskill_tip_craft_item_price"] = "제작된 아이템의 툴팁에 정보 표시",
			["show_tradeskill_tip_craft_spell_price"] = "전문 기술 주문에 대한 정보를 툴팁에 표시",
			["show_tradeskill_tip_recipe_price"] = "레시피를 위해 툴팁에 정보 표시",
			["show_tradeskill_tip_recipe_account_learned"] = "다른 캐릭터가 레시피를 배웠는지 여부를 표시",
			["show_tradeskill_tip_material_craft_info"] = "Show tradeskill list using tip item",
			["default_skill_button_tip"] = "Show tip on default skill list button",
			["colored_rank_for_unknown"] = "알 수 없는 맞춤법에 대한 순위 별 색상 이름",
			["regular_exp"] = "정규식으로 검색\124cffff0000!!!Caution!!!\124r",
			["show_call"] = "Show UI toggle button",
			["show_tab"] = "Show switch bar",
			["portrait_button"] = "Dropdown menu on portrait of tradeskill frame",
			["show_board"] = "변환 쿨타임 보드 표시",
			["lock_board"] = "변환 쿨타임 보드 잠금",
			["hide_mtsl"] = "MTSL 숨김",
		};
		L.ALPHA = "Alpha";
		L.CHAR_LIST = "캐릭터 목록";
		L.CHAR_DEL = "캐릭터 삭제";
		L["INVALID_COMMANDS"] = "잘못된 명령. 사용 \124cff00ff00true, 1, on, enable\124r or \124cffff0000false, 0, off, disable\124r instead.";
	else
		L["OK"] = "OK";
		L["Search"] = "Search";
		L["Open"] = "Open";
		L["Close"] = "Close";
		L["add_fav"] = "Favorite";
		L["sub_fav"] = "Unfavorite";
		L["query_who_can_craft_it"] = "Who can craft it ?";
		L["showKnown"] = "Known";
		L["showUnkown"] = "Unknown";
		L["showHighRank"] = "High Rank";
		L["showItemInsteadOfSpell"] = "Items";
		L["showRank"] = "Rank";
		L["haveMaterials"] = "haveMaterials";
		L["costOnly"] = "Show cost only";
		--
		L["LABEL_RANK_LEVEL"] = "\124cffff7f00Rank: \124r";
		L["LABEL_GET_FROM"] = "\124cffff7f00Get from: \124r";
		L["quest"] = "Quest";
		L["item"] = "Item";
		L["object"] = "Object";
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
		L["LABEL_ACCOUT_RECIPE_LEARNED"] = "\124cffff7f00Status of characters:\124r";
		L["LABEL_USED_AS_MATERIAL_IN"] = "\124cffff7f00Used to craft: \124r";
		L["RECIPE_LEARNED"] = "\124cff00ff00Learned\124r";
		L["RECIPE_NOT_LEARNED"] = "\124cffff0000Not learned\124r";

		L["PRINT_MATERIALS: "] = "Needs: ";
		L["PRICE_UNK"] = "Unknown";
		L["AH_PRICE"] = "\124cff00ff00AH\124r";
		L["VENDOR_RPICE"] = "\124cffffaf00Vendor\124r";
		L["COST_PRICE"] = "\124cffff7f00Cost\124r";
		L["COST_PRICE_KNOWN"] = "\124cffff0000Known Material\124r";
		L["UNKOWN_PRICE"] = "\124cffff0000Unkown\124r";
		L["BOP"] = "\124cffff7f7fBOP\124r";
		L["PRICE_DIFF+"] = "\124cff00ff00Diff\124r";
		L["PRICE_DIFF-"] = "\124cffff0000Diff\124r";
		L["PRICE_DIFF0"] = "The same";
		L["PRICE_DIFF_INFO+"] = "\124cff00ff00+\124r";
		L["PRICE_DIFF_INFO-"] = "\124cffff0000-\124r";
		L["CRAFT_INFO"] = "\124cffff7f00Craft info: \124r";
		L["ITEMS_UNK"] = "items unk";
		L["NEED_UPDATE"] = "\124cffff0000!!Need refresh!!\124r";
		--
		L["TIP_PROFIT_FRAME_CALL_INFO"] = "\124cffffffffEarn some money! \124r";
		L["TIP_SEARCH_NAME_ONLY_INFO"] = "\124cffffffSearch name instead of hyperlink\124r";
		--
		L["BOARD_LOCK"] = "LOCK";
		L["BOARD_CLOSE"] = "CLOSE";
		L["BOARD_TIP"] = "Show cooldown of tradeskill among account. Right-click to toggle or lock";
		L["COLORED_FORMATTED_TIME_LEN"] = {
			"\124cff%.2x%.2x00%dd %02dh %02dm %02ds\124r",
			"\124cff%.2x%.2x00%dh %02dm %02ds\124r",
			"\124cff%.2x%.2x00%dm %02ds\124r",
			"\124cff%.2x%.2x00%ds\124r",
		};
		L["COOLDOWN_EXPIRED"] = "\124cff00ff00Available\124r";
		--
		L["EXPLORER_TITLE"] = "ALA @ 163UI";
		L.EXPLORER_SET = {
			skill = "Skill",
			type = "Type",
			subType = "SubType",
			eqLoc = "EqLoc",
		};
		L.TRADESKILL_NAME = {
			[1] = "FirstAid",
			[2] = "Blacksmithing",
			[3] = "Leatherworking",
			[4] = "Alchemy",
			[5] = "Herbalism",
			[6] = "Cooking",
			[7] = "Mining",
			[8] = "Tailoring",
			[9] = "Engineering",
			[10] = "Enchanting",
			[11] = "Fishing",
			[12] = "Skinning",
			[13] = "RoguePoisons",
		};
		L.ITEM_TYPE_LIST = {
			[LE_ITEM_CLASS_CONSUMABLE] = "Consumable",				--	0	Consumable
			[LE_ITEM_CLASS_CONTAINER] = "Container",				--	1	Container
			[LE_ITEM_CLASS_WEAPON] = "Weapon",						--	2	Weapon
			[LE_ITEM_CLASS_GEM] = "Gem",							--	3	Gem
			[LE_ITEM_CLASS_ARMOR] = "Armor",						--	4	Armor
			[LE_ITEM_CLASS_REAGENT] = "Reagent",					--	5	Reagent Obsolete
			[LE_ITEM_CLASS_PROJECTILE] = "Projectile",				--	6	Projectile Obsolete
			[LE_ITEM_CLASS_TRADEGOODS] = "Tradeskill",				--	7	Tradeskill
			[LE_ITEM_CLASS_ITEM_ENHANCEMENT] = "Item Enhancement",	--	8	Item Enhancement
			[LE_ITEM_CLASS_RECIPE] = "Recipe",						--	9	Recipe
			[10] = "Money",											--	10	Money(OBSOLETE)
			[LE_ITEM_CLASS_QUIVER] = "Quiver",						--	11	Quiver Obsolete
			[LE_ITEM_CLASS_QUESTITEM] = "Quest",					--	12	Quest
			[LE_ITEM_CLASS_KEY] = "Key",							--	13	Key Obsolete
			[14] = "Permanent",										--	14	Permanent(OBSOLETE)
			[LE_ITEM_CLASS_MISCELLANEOUS] = "Miscellaneous",		--	15	Miscellaneous
			[LE_ITEM_CLASS_GLYPH] = "Glyph",						--	16	Glyph
			[LE_ITEM_CLASS_BATTLEPET] = "Battle Pets",				--	17	Battle Pets
			[LE_ITEM_CLASS_WOW_TOKEN] = "WoW Token",				--	18	WoW Token
		};
		L.ITEM_SUB_TYPE_LIST = {
			[LE_ITEM_CLASS_CONSUMABLE] = {			--	0	Consumable
				[0] = "Consumable", 
				[1] = "Potion", 
				[2] = "Elixir", 
				[3] = "Flask", 
				[4] = "Scroll ", 
				[5] = "Food & Drink", 
				[6] = "Item Enhancement ", 
				[7] = "Bandage", 
				[8] = "Other", 
				[9] = "Vantus Runes", 
			},
			[LE_ITEM_CLASS_CONTAINER] = {			--	1	Container
				[0] = "Bag", 
				[1] = "Soul Bag", 
				[2] = "Herb Bag", 
				[3] = "Enchanting Bag", 
				[4] = "Engineering Bag", 
				[5] = "Gem Bag", 
				[6] = "Mining Bag", 
				[7] = "Leatherworking Bag", 
				[8] = "Inscription Bag", 
				[9] = "Tackle Box", 
				[10] = "Cooking Bag", 
			},
			[LE_ITEM_CLASS_WEAPON] = {								--	2	Weapon
				[LE_ITEM_WEAPON_AXE1H] = "One-Handed Axes", 		--	0
				[LE_ITEM_WEAPON_AXE2H] = "Two-Handed Axes", 		--	1
				[LE_ITEM_WEAPON_BOWS] = "Bows", 					--	2
				[LE_ITEM_WEAPON_GUNS] = "Guns", 					--	3
				[LE_ITEM_WEAPON_MACE1H] = "One-Handed Maces", 		--	4
				[LE_ITEM_WEAPON_MACE2H] = "Two-Handed Maces", 		--	5
				[LE_ITEM_WEAPON_POLEARM] = "Polearms", 				--	6
				[LE_ITEM_WEAPON_SWORD1H] = "One-Handed Swords", 	--	7
				[LE_ITEM_WEAPON_SWORD2H] = "Two-Handed Swords", 	--	8
				[LE_ITEM_WEAPON_WARGLAIVE] = "Warglaives", 			--	9
				[LE_ITEM_WEAPON_STAFF] = "Staves", 					--	10
				[LE_ITEM_WEAPON_EXOTIC1H] = "Bear Claws", 			--	11	--	LE_ITEM_WEAPON_BEARCLAW
				[LE_ITEM_WEAPON_EXOTIC2H] = "CatClaws", 				--	12	--	LE_ITEM_WEAPON_CATCLAW
				[LE_ITEM_WEAPON_UNARMED] = "Fist Weapons", 			--	13
				[LE_ITEM_WEAPON_GENERIC] = "Miscellaneous", 		--	14
				[LE_ITEM_WEAPON_DAGGER] = "Daggers", 				--	15
				[LE_ITEM_WEAPON_THROWN] = "Thrown", 				--	16
				[LE_ITEM_WEAPON_SPEAR] = "Spears", 					--	17
				[LE_ITEM_WEAPON_CROSSBOW] = "Crossbows", 			--	18
				[LE_ITEM_WEAPON_WAND] = "Wands", 					--	19
				[LE_ITEM_WEAPON_FISHINGPOLE] = "Fishing Poles", 	--	20
			},
			[LE_ITEM_CLASS_GEM] = {					--	3	Gem
				[LE_ITEM_GEM_RED] = "Red Gem",					--	0	--	Intellect
				[LE_ITEM_GEM_BLUE] = "Blue Gem",				--	1	--	Agility
				[LE_ITEM_GEM_YELLOW] = "Yellow Gem",				--	2	--	Strength
				[LE_ITEM_GEM_PURPLE] = "Purple Gem",				--	3	--	Stamina
				[LE_ITEM_GEM_GREEN] = "Green Gem",				--	4	--	Spirit
				[LE_ITEM_GEM_ORANGE] = "Orange Gem",				--	5	--	Critical Strike
				[LE_ITEM_GEM_META] = "Meta Gem",				--	6	--	Mastery
				[LE_ITEM_GEM_SIMPLE] = "Simple Gem",				--	7	--	Haste
				[LE_ITEM_GEM_PRISMATIC] = "Prismatic Gem",			--	8	--	Versatility
			},
			[LE_ITEM_CLASS_ARMOR] = {						--	4	Armor
				[LE_ITEM_ARMOR_GENERIC] = "Miscellaneous", 	--	0	Includes Spellstones, Firestones, Trinkets, Rings and Necks
				[LE_ITEM_ARMOR_CLOTH] = "Cloth", 			--	1
				[LE_ITEM_ARMOR_LEATHER] = "Leather", 		--	2
				[LE_ITEM_ARMOR_MAIL] = "Mail", 				--	3
				[LE_ITEM_ARMOR_PLATE] = "Plate", 			--	4
				[LE_ITEM_ARMOR_COSMETIC] = "Cosmetic", 		--	5
				[LE_ITEM_ARMOR_SHIELD] = "Shields", 		--	6
				[LE_ITEM_ARMOR_LIBRAM] = "Librams", 		--	7
				[LE_ITEM_ARMOR_IDOL] = "Idols", 			--	8
				[LE_ITEM_ARMOR_TOTEM] = "Totems", 			--	9
				[LE_ITEM_ARMOR_SIGIL] = "Sigils", 			--	10
				[LE_ITEM_ARMOR_RELIC] = "Relic", 			--	11
			},
			[LE_ITEM_CLASS_REAGENT] = {				--	5	Reagent Obsolete
				[0] = "Reagent", 
				[1] = "Keystone", 
			},
			[LE_ITEM_CLASS_PROJECTILE] = {			--	6	Projectile Obsolete
				[0] = "Wand", 
				[1] = "Bolt", 
				[2] = "Arrow", 
				[3] = "Bullet", 
				[4] = "Thrown", 
			},
			[LE_ITEM_CLASS_TRADEGOODS] = {			--	7	Tradeskill
				[0] = "Trade Goods ", 
				[1] = "Parts", 
				[2] = "Explosives ", 
				[3] = "Devices ", 
				[4] = "Jewelcrafting", 
				[5] = "Cloth", 
				[6] = "Leather", 
				[7] = "Metal & Stone", 
				[8] = "Cooking", 
				[9] = "Herb", 
				[10] = "Elemental", 
				[11] = "Other", 
				[12] = "Enchanting", 
				[13] = "Materials ", 
				[14] = "Item Enchantment ", 
				[15] = "Weapon Enchantment", 
				[16] = "Inscription", 
				[17] = "Explosives and Devices ", 
			},
			[LE_ITEM_CLASS_ITEM_ENHANCEMENT] = {	--	8	Item Enhancement
				[0] = "Head", 
				[1] = "Neck", 
				[2] = "Shoulder", 
				[3] = "Cloak", 
				[4] = "Chest", 
				[5] = "Wrist", 
				[6] = "Hands", 
				[7] = "Waist", 
				[8] = "Legs", 
				[9] = "Feet", 
				[10] = "Finger", 
				[11] = "Weapon	One-handed weapons", 
				[12] = "Two-Handed Weapon", 
				[13] = "Shield/Off-hand", 
				[14] = "Misc", 
			},
			[LE_ITEM_CLASS_RECIPE] = {				--	9	Recipe
				[LE_ITEM_RECIPE_BOOK] = "Book", 					--	0
				[LE_ITEM_RECIPE_LEATHERWORKING] = "Leatherworking", --	1
				[LE_ITEM_RECIPE_TAILORING] = "Tailoring", 			--	2
				[LE_ITEM_RECIPE_ENGINEERING] = "Engineering", 		--	3
				[LE_ITEM_RECIPE_BLACKSMITHING] = "Blacksmithing", 	--	4
				[LE_ITEM_RECIPE_COOKING] = "Cooking", 				--	5
				[LE_ITEM_RECIPE_ALCHEMY] = "Alchemy", 				--	6
				[LE_ITEM_RECIPE_FIRST_AID] = "First Aid", 			--	7
				[LE_ITEM_RECIPE_ENCHANTING] = "Enchanting", 		--	8
				[LE_ITEM_RECIPE_FISHING] = "Fishing", 				--	9
				[LE_ITEM_RECIPE_JEWELCRAFTING] = "Jewelcrafting", 	--	10
				[LE_ITEM_RECIPE_INSCRIPTION] = "Inscription", 		--	11
			},
			[10] = {								--	10	Money(OBSOLETE)
				[0] = "Money",
			},
			[LE_ITEM_CLASS_QUIVER] = {				--	11	Quiver Obsolete
				[0] = "Quiver(OBSOLETE)",
				[1] = "Bolt(OBSOLETE)",
				[2] = "Quiver",
				[3] = "Ammo Pouch",
			},
			[LE_ITEM_CLASS_QUESTITEM] = {			--	12	Quest
				[0] = "Quest",
			},
			[LE_ITEM_CLASS_KEY] = {					--	13	Key Obsolete
				[0] = "Key",
				[1] = "Lockpick",
			},
			[14] = {								--	14	Permanent(OBSOLETE)
				[0] = "Permanent",
			},
			[LE_ITEM_CLASS_MISCELLANEOUS] = {		--	15	Miscellaneous
				[LE_ITEM_MISCELLANEOUS_JUNK] = "Junk",							--	0
				[LE_ITEM_MISCELLANEOUS_REAGENT] = "Reagent",					--	17: Tradeskill.
				[LE_ITEM_MISCELLANEOUS_COMPANION_PET] = "Companion Pets",		--	2
				[LE_ITEM_MISCELLANEOUS_HOLIDAY] = "Holiday",					--	3
				[LE_ITEM_MISCELLANEOUS_OTHER] = "Other",						--	4
				[LE_ITEM_MISCELLANEOUS_MOUNT] = "Mount",						--	5
				-- [LE_ITEM_MISCELLANEOUS_MOUNT_EQUIPMENT] = "Mount Equipment",	--	6
			},
			[LE_ITEM_CLASS_GLYPH] = {				--	16	Glyph
				[1] = "Warrior",
				[2] = "Paladin",
				[3] = "Hunter",
				[4] = "Rogue",
				[5] = "Priest",
				[6] = "Death Knight",
				[7] = "Shaman",
				[8] = "Mage",
				[9] = "Warlock",
				[10] = "Monk",
				[11] = "Druid",
				[12] = "Demon Hunter",
			},
			[LE_ITEM_CLASS_BATTLEPET] = {			--	17	Battle Pets
				[0] = "Humanoid",
				[1] = "Dragonkin",
				[2] = "Flying",
				[3] = "Undead",
				[4] = "Critter",
				[5] = "Magic",
				[6] = "Elemental",
				[7] = "Beast",
				[8] = "Aquatic",
				[9] = "Mechanical",
			},
			[LE_ITEM_CLASS_WOW_TOKEN] = {			--	18	WoW Token
				[0] = "WoW Token",
			},
		};
		L.ITEM_EQUIP_LOC = {
			[0] = "Ammo",
			[1] = "Head",
			[2] = "Neck",
			[3] = "Shoulder",
			[4] = "Shirt",
			[5] = "Chest",
			[6] = "Waist",
			[7] = "Legs",
			[8] = "Feet",
			[9] = "Wrist",
			[10] = "Hands",
			[11] = "Fingers",
			[13] = "Trinkets",
			[15] = "Cloaks",
			[16] = "Main-Hand",
			[17] = "Off-Hand",
			[18] = "Ranged",
			[19] = "Tabard",
			[20] = "Containers",
			[21] = "One-Hand",
			[22] = "Two-Handed",
		};
		L["EXPLORER_CLEAR_FILTER"] = "\124cff00ff00Clear\124r";
		--
		L.SLASH_NOTE = {
			["expand"] = "Expand frame",
			["blz_style"] = "Blizzard style",
			["bg_color"] = "Click to set Color of Background",
			["show_tradeskill_frame_price_info"] = "Show price info in tradeskill frame",
			["show_tradeskill_frame_rank_info"] = "Show rank info in tradeskill frame",
			["show_tradeskill_tip_craft_item_price"] = "Show info in tooltip for crafted item",
			["show_tradeskill_tip_craft_spell_price"] = "Show info in tooltip for tradeskill spell",
			["show_tradeskill_tip_recipe_price"] = "Show info in tooltip for recipe",
			["show_tradeskill_tip_recipe_account_learned"] = "Show whether the other characters learned the recipe",
			["show_tradeskill_tip_material_craft_info"] = "Show tradeskill list using tip item",
			["default_skill_button_tip"] = "Show tip on default skill list button",
			["colored_rank_for_unknown"] = "Color name by rank for unknown spell",
			["regular_exp"] = "Search in the way of Regular Expression\124cffff0000!!!Caution!!!\124r",
			["show_call"] = "Show UI toggle button",
			["show_tab"] = "Show switch bar",
			["portrait_button"] = "Dropdown menu on portrait of tradeskill frame",
			["show_board"] = "Show board",
			["lock_board"] = "Lock board",
			["hide_mtsl"] = "Hide MTSL",
		};
		L.ALPHA = "Alpha";
		L.CHAR_LIST = "Character list";
		L.CHAR_DEL = "Del character";
		L["INVALID_COMMANDS"] = "Invalid commonds. Use \124cff00ff00true, 1, on, enable\124r or \124cffff0000false, 0, off, disable\124r instead.";
	end
	--
	L.ENCHANT_FILTER = {  };
	if LOCALE == "zhCN" then
		L.ENCHANT_FILTER.INVTYPE_CLOAK = "披风";
		L.ENCHANT_FILTER.INVTYPE_CHEST = "胸甲";
		L.ENCHANT_FILTER.INVTYPE_WRIST = "护腕";
		L.ENCHANT_FILTER.INVTYPE_HAND = "手套";
		L.ENCHANT_FILTER.INVTYPE_FEET = "靴子";
		L.ENCHANT_FILTER.INVTYPE_WEAPON = "武器";
		L.ENCHANT_FILTER.INVTYPE_SHIELD = "盾牌";
		L.ENCHANT_FILTER.NONE = "没有匹配的附魔";
	elseif LOCALE == "zhTW" then
		L.ENCHANT_FILTER.INVTYPE_CLOAK = "披風";
		L.ENCHANT_FILTER.INVTYPE_CHEST = "胸甲";
		L.ENCHANT_FILTER.INVTYPE_WRIST = "護腕";
		L.ENCHANT_FILTER.INVTYPE_HAND = "手套";
		L.ENCHANT_FILTER.INVTYPE_FEET = "長靴";
		L.ENCHANT_FILTER.INVTYPE_WEAPON = "武器";
		L.ENCHANT_FILTER.INVTYPE_SHIELD = "盾牌";
		L.ENCHANT_FILTER.NONE = "沒有匹配的附魔";
	elseif LOCALE == "enUS" then
		L.ENCHANT_FILTER.INVTYPE_CLOAK = "Cloak";
		L.ENCHANT_FILTER.INVTYPE_CHEST = "Chest";
		L.ENCHANT_FILTER.INVTYPE_WRIST = "Bracer";
		L.ENCHANT_FILTER.INVTYPE_HAND = "Glove";
		L.ENCHANT_FILTER.INVTYPE_FEET = "Boot";
		L.ENCHANT_FILTER.INVTYPE_WEAPON = "Weapon";
		L.ENCHANT_FILTER.INVTYPE_SHIELD = "Shield";
		L.ENCHANT_FILTER.NONE = "No matched enchating recipe";
	elseif LOCALE == "deDE" then
		L.ENCHANT_FILTER.INVTYPE_CLOAK = "Umhang";
		L.ENCHANT_FILTER.INVTYPE_CHEST = "Brust";
		L.ENCHANT_FILTER.INVTYPE_WRIST = "Armschiene";
		L.ENCHANT_FILTER.INVTYPE_HAND = "Handschuhe";
		L.ENCHANT_FILTER.INVTYPE_FEET = "Stiefel";
		L.ENCHANT_FILTER.INVTYPE_WEAPON = "Waffe";
		L.ENCHANT_FILTER.INVTYPE_SHIELD = "Schild";
		L.ENCHANT_FILTER.NONE = "No matched enchating recipe";
	elseif LOCALE == "esES" or LOCALE == "esMX" then
		L.ENCHANT_FILTER.INVTYPE_CLOAK = "capa";
		L.ENCHANT_FILTER.INVTYPE_CHEST = "pechera";
		L.ENCHANT_FILTER.INVTYPE_WRIST = "brazal";
		L.ENCHANT_FILTER.INVTYPE_HAND = "guantes";
		L.ENCHANT_FILTER.INVTYPE_FEET = "botas";
		L.ENCHANT_FILTER.INVTYPE_WEAPON = "arma";
		L.ENCHANT_FILTER.INVTYPE_SHIELD = "escudo";
		L.ENCHANT_FILTER.NONE = "No matched enchating recipe";
	elseif LOCALE == "frFR" then
		L.ENCHANT_FILTER.INVTYPE_CLOAK = "cape";
		L.ENCHANT_FILTER.INVTYPE_CHEST = "plastron";
		L.ENCHANT_FILTER.INVTYPE_WRIST = "bracelets";
		L.ENCHANT_FILTER.INVTYPE_HAND = "gants";
		L.ENCHANT_FILTER.INVTYPE_FEET = "bottes";
		L.ENCHANT_FILTER.INVTYPE_WEAPON = "d'arme";
		L.ENCHANT_FILTER.INVTYPE_SHIELD = "bouclier";
		L.ENCHANT_FILTER.NONE = "No matched enchating recipe";
	elseif LOCALE == "ptBR" then
		L.ENCHANT_FILTER.INVTYPE_CLOAK = "Manto";
		L.ENCHANT_FILTER.INVTYPE_CHEST = "Torso";
		L.ENCHANT_FILTER.INVTYPE_WRIST = "Braçadeiras";
		L.ENCHANT_FILTER.INVTYPE_HAND = "Luvas";
		L.ENCHANT_FILTER.INVTYPE_FEET = "Botas";
		L.ENCHANT_FILTER.INVTYPE_WEAPON = "Arma";
		L.ENCHANT_FILTER.INVTYPE_SHIELD = "Escudo";
		L.ENCHANT_FILTER.NONE = "No matched enchating recipe";
	elseif LOCALE == "ruRU" then
		L.ENCHANT_FILTER.INVTYPE_CLOAK = "плаща";
		L.ENCHANT_FILTER.INVTYPE_CHEST = "нагрудника";
		L.ENCHANT_FILTER.INVTYPE_WRIST = "браслетов";
		L.ENCHANT_FILTER.INVTYPE_HAND = "перчаток";
		L.ENCHANT_FILTER.INVTYPE_FEET = "обуви";
		L.ENCHANT_FILTER.INVTYPE_WEAPON = "оружия";
		L.ENCHANT_FILTER.INVTYPE_SHIELD = "щита";
		L.ENCHANT_FILTER.NONE = "No matched enchating recipe";
	elseif LOCALE == "koKR" then
		L.ENCHANT_FILTER.INVTYPE_CLOAK = "망토";
		L.ENCHANT_FILTER.INVTYPE_CHEST = "가슴보호구";
		L.ENCHANT_FILTER.INVTYPE_WRIST = "손목보호구";
		L.ENCHANT_FILTER.INVTYPE_HAND = "장갑";
		L.ENCHANT_FILTER.INVTYPE_FEET = "장화";
		L.ENCHANT_FILTER.INVTYPE_WEAPON = "무기";
		L.ENCHANT_FILTER.INVTYPE_SHIELD = "방패";
		L.ENCHANT_FILTER.NONE = "No matched enchating recipe";
	end
	L.ENCHANT_FILTER.INVTYPE_ROBE = L.ENCHANT_FILTER.INVTYPE_CHEST;
	L.ENCHANT_FILTER.INVTYPE_2HWEAPON = L.ENCHANT_FILTER.INVTYPE_WEAPON;
	L.ENCHANT_FILTER.INVTYPE_WEAPONMAINHAND = L.ENCHANT_FILTER.INVTYPE_WEAPON;
	L.ENCHANT_FILTER.INVTYPE_WEAPONOFFHAND = L.ENCHANT_FILTER.INVTYPE_WEAPON;
end

local rank_color = {
	[0] = { 1.0, 0.0, 0.0, 1.0, },
	[1] = { 1.0, 0.5, 0.35, 1.0, },
	[2] = { 1.0, 1.0, 0.25, 1.0, },
	[3] = { 0.25, 1.0, 0.25, 1.0, },
	[4] = { 0.5, 0.5, 0.5, 1.0, },
	[BIG_NUMBER] = { 0.0, 0.0, 0.0, 1.0, },
};
local rank_index = {
	['optimal'] = 1,
	['medium'] = 2,
	['easy'] = 3,
	['trivial'] = 4,
};
---------------------------------------------------------------------------------------------------
local AVAR, VAR, SET, FAV, CMM = nil, nil, nil, nil, nil;
local merc = nil;
local gui = {  };
NS.gui = gui;

local PLAYER_REALM_ID = tonumber(GetRealmID());
local PLAYER_REALM_NAME = GetRealmName();
local PLAYER_GUID = UnitGUID('player');
local PLAYER_NAME = UnitName('player');

do	--	InsertLink
	if not _G.ALA_HOOK_ChatEdit_InsertLink then
		local handlers_name = {  };
		local handlers_link = {  };
		function _G.ALA_INSERT_LINK(link, ...)
			if not link then return; end
			local num = #handlers_link;
			if num > 0 then
				for index = 1, num do
					if handlers_link[index](link, ...) then
						return true;
					end
				end
			end
		end
		function _G.ALA_INSERT_NAME(name, ...)
			if not name then return; end
			local num = #handlers_name;
			if num > 0 then
				for index = 1, num do
					if handlers_name[index](name, ...) then
						return true;
					end
				end
			end
		end
		function _G.ALA_HOOK_ChatEdit_InsertName(func)
			for index = 1, #handlers_name do
				if func == handlers_name[index] then
					return;
				end
			end
			tinsert(handlers_name, func);
		end
		function _G.ALA_UNHOOK_ChatEdit_InsertName(func)
			for index = 1, #handlers_name do
				if func == handlers_name[index] then
					tremove(handlers_name, i);
					return;
				end
			end
		end
		function _G.ALA_HOOK_ChatEdit_InsertLink(func)
			for index = 1, #handlers_link do
				if func == handlers_link[index] then
					return;
				end
			end
			tinsert(handlers_link, func);
		end
		function _G.ALA_UNHOOK_ChatEdit_InsertLink(func)
			for index = 1, #handlers_link do
				if func == handlers_link[index] then
					tremove(handlers_link, index);
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
	local info_lines = self.info_lines;
	if info_lines then
		for index = 1, #info_lines do
			GameTooltip:AddLine(info_lines[index]);
		end
	end
	GameTooltip:Show();
end
local function button_info_OnLeave(self)
	if GameTooltip:IsOwned(self) then
		GameTooltip:Hide();
	end
end

local _EventHandler = CreateFrame("FRAME");
do	--	EventHandler
	local function OnEvent(self, event, ...)
		return NS[event](...);
	end
	function _EventHandler:FireEvent(event, ...)
		local func = NS[event];
		if func then
			return func(...);
		end
	end
	function _EventHandler:RegEvent(event)
		NS[event] = NS[event] or _noop_;
		self:RegisterEvent(event);
		self:SetScript("OnEvent", OnEvent);
	end
	function _EventHandler:UnregEvent(event)
		self:UnregisterEvent(event);
	end
end

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

----	index
	local index_validated = 1;
	local index_phase = 2;
	local index_pid = 3;
	local index_sid = 4;
	local index_cid = 5;
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
	local index_rid = 16;
	local index_quest = 17;
	local index_object = 18;
	--
	-- 1itemName, 2itemLink, 3itemRarity, 4itemLevel, 5itemMinLevel, 6itemType, 7itemSubType, 8itemStackCount,
	-- 9itemEquipLoc, 10itemIcon, 11itemSellPrice, 12itemClassID, 13itemSubClassID, 14bindType, 15expacID, 16itemSetID, 
	-- 17isCraftingReagent = GetItemInfo(itemID or "itemString" or "itemName" or "itemLink") 
	local index_i_name = 1;			--	1
	local index_i_link = 2;			--	2
	local index_i_rarity = 3;		--	3
	local index_i_loc = 4;			--	9
	local index_i_icon = 5;			--	10
	local index_i_sellPrice = 6;	--	11
	local index_i_typeID = 7;		--	12
	local index_i_subTypeID = 8;	--	13
	local index_i_bindType = 9;		--	14	--	0 - none; 1 - on pickup; 2 - on equip; 3 - on use; 4 - quest.
	-- local index_i_ilevel = 4;		--	4
	-- local index_i_plevel = 5;		--	5
	-- local index_i_type = 6;			--	6
	-- local index_i_subType = 7;		--	7
	-- local index_i_stackCount = 7;	--	8
	local index_i_name_lower = 10;
	local index_i_link_lower = 11;
	local index_i_string = 12;
----

local train_price_fix = {
	[1] = {		--	FirstAid		all	[Basic]	nothing wrong
	},
	[2] = {		--	Blacksmithing	[Basic, Armorsmith,]	todo
		[2742] = 200,
		[9987] = 500,
		[9985] = 250,
		[2740] = 200,
		[9986] = 500,
		[2670] = 500,
		[2741] = 200,
		[6517] = 800,
		[9974] = 10000,
		[9954] = 10000,
	},
	[3] = {		--	Leatherworking	[Basic,]	todo
		[7156] = 2400,
		[10499] = 3000,
		[9145] = 500,
		[3760] = 600,
		[3768] = 500,
		[3776] = 1200,
		[19047] = 5000,
		[3761] = 350,
		[22331] = 5000,
		[10507] = 3000,
		[19058] = 5000,
		[3770] = 500,
		[10511] = 3000,
		[3818] = 500,
		[3763] = 300,
		[10556] = 4500,
		[10482] = 2000,
		[9065] = 150,
		[2165] = 250,
		[10487] = 2000,
		[20649] = 1000,
		[9193] = 500,
		[10548] = 4000,
		[9068] = 400,
		[14932] = 3600,
		[10518] = 3500,
		[2166] = 450,
		[9196] = 1500,
		[7135] = 400,
		[7151] = 1200,
		[10552] = 4000,
		[9198] = 2000,
		[3817] = 200,
		[2159] = 250,
		[2167] = 350,
		[9074] = 500,
		[3766] = 400,
		[9201] = 2000,
		[3774] = 1000,
		[20650] = 4000,
		[7147] = 1000,
		[3764] = 500,
		[2168] = 350,
		[9194] = 500,
		[3759] = 200,
		[3780] = 750,
		[6661] = 2000,
		[9206] = 2500,
		[10558] = 4500,
		[14930] = 3600,
	},
	[4] = {		--	Alchemy 		all	[Basic]
		[3452] = 5000,
		[11460] = 5000,
		[11461] = 10000,
		[12609] = 8000,
		[11478] = 14000,
		[7181] = 5000,
		[11448] = 9000,
		[11449] = 6500,
		[11457] = 10000,
		[11465] = 12000,
		[17551] = 15000,
		[11450] = 7500,
		[3448] = 5000,
		[15833] = 10000,
		[22808] = 10000,
		[11451] = 8000,
		[11467] = 12000,
		[3173] = 1500,
	},
	[5] = {		--	Herbalism		--	UNUSED
	},
	[6] = {		--	Cooking			all	[Basic]	nothing wrong
	},
	[7] = {		--	Mining			all	[Basic]	nothing wrong
	},
	[8] = {		--	Tailoring		all	[Basic]
		[2402] = 250,
		[2964] = 100,
		[3840] = 100,
		[2385] = 50,
		[3755] = 100,
		[2393] = 25,
		[3914] = 50,
		[2397] = 200,
		[7623] = 50,
		[8465] = 50,
		[12045] = 50,
		[12046] = 300,
		[3842] = 300,
		[8776] = 50,
		[2386] = 200,
		[7624] = 50,
		[3841] = 200,
		[2392] = 50,
		[2394] = 50,
		[2396] = 200,
		[2395] = 300,
		[8766] = 1000,
		[12074] = 6000,
		[8799] = 3000,
		[3839] = 500,
		[2406] = 200,
		[8770] = 1000,
		[3871] = 500,
		[12079] = 6500,
		[8772] = 1000,
		[8804] = 5000,
		[2399] = 300,
		[12050] = 4000,
		[12053] = 5000,
		[3865] = 1000,
		[6690] = 1000,
		[12088] = 7500,
		[3850] = 500,
		[8467] = 250,
		[3866] = 250,
		[12048] = 4000,
		[8774] = 1000,
		[3843] = 400,
		[12061] = 2500,
		[3859] = 750,
		[2401] = 300,
		[3855] = 750,
		[3757] = 200,
		[6521] = 400,
		[12065] = 5000,
		[8489] = 750,
		[3852] = 750,
		[8758] = 600,
		[3848] = 500,
		[3813] = 800,
		[12067] = 5000,
		[8760] = 600,
		[8483] = 500,
		[3845] = 300,
		[12069] = 5000,
		[8762] = 750,
		[12070] = 5000,
		[12092] = 7500,
		[12049] = 4000,
		[8764] = 900,
		[3861] = 1000,
		[8791] = 2500,
		[12073] = 6000,
		[12077] = 5000,
	},
	[9] = {		--	Engineering		all	[Basic, Goblin, Gnome]
		[15255] = 1500,
		[9271] = 500,
		[3949] = 550,
		[3965] = 1200,
		[3973] = 300,
		[3934] = 400,
		[3942] = 500,
		[3950] = 600,
		[3958] = 800,
		[12584] = 1000,
		[12585] = 1000,
		[12586] = 1000,
		[8334] = 300,
		[12619] = 2400,
		[3967] = 1400,
		[12589] = 1300,
		[3936] = 420,
		[12717] = 1500,
		[12718] = 1500,
		[12908] = 2800,
		[3937] = 450,
		[3945] = 500,
		[12595] = 1600,
		[3961] = 900,
		[12596] = 1700,
		[12754] = 2600,
		[12755] = 2400,
		[3938] = 450,
		[3946] = 500,
		[6458] = 400,
		[3962] = 1000,
		[12758] = 3000,
		[3953] = 600,
		[3941] = 500,
		[12599] = 1800,
		[12760] = 1500,
		[3955] = 750,
		[3963] = 1000,
		[12603] = 1800,
		[12590] = 1000,
		[3947] = 300,
		[3932] = 300,
		[12591] = 1500,
		[12594] = 1600,
		[3956] = 750,
		[12715] = 1000,
		[12716] = 1500,
		[3978] = 475,
		[12618] = 2200,
		[12902] = 1800,
		[12906] = 2400,
		[12895] = 1500,
		[12897] = 1500,
		[12899] = 1500,
		[12903] = 2000,
		[12905] = 2200,
		[12907] = 2600,
		[12759] = 2800,
	},
	[10] = {	--	Enchanting		all	[Basic]
		[13640] = 2700,
	},
	[11] = {	--	Fishing			--	UNUSED
	},
	[12] = {	--	Skinning		--	UNUSED
	},
	[13] = {	--	Poisons			all	[Basic]	nothing wrong		--	Rogue
	},
	[14] = {	--	Beast Training	--	UNUSED	--	Hunter
	},
};

do	--	MAIN
	local GetSpellCooldown = GetSpellCooldown;
	function __ala_meta__.GetSpellModifiedCooldown(sid, formatStr)
		local start, duration, enabled, modRate = GetSpellCooldown(sid);
		if start and start > 0 then
			local now = GetTime();
			if start > now then
				start = start - 4294967.28;
			end
			if formatStr then
				local cd = duration + start - now;
				local d = floor(cd / 86400);
				cd = cd % 86400;
				local h = floor(cd / 3600);
				cd = cd % 3600;
				local m = floor(cd / 60);
				cd = cd % 60;
				if d > 0 then
					formatStr = format("%dd %02dh %02dm %02ds", d, h, m, cd);
				elseif h > 0 then
					formatStr = format("%dh %02dm %02ds", h, m, cd);
				elseif m > 0 then
					formatStr = format("%dm %02ds", m, cd);
				else
					formatStr = format("%ds", cd);
				end
			else
				formatStr = nil;
			end
			return true, start, duration, enabled, modRate, formatStr;
		else
			return false, 0, 0, enabled, modRate, nil;
		end
	end

	do	--	db
		--	skill list
		local tradeskill_id = {
			[1] = 3273,		--	FirstAid
			[2] = 2018,		--	Blacksmithing
			[3] = 2108,		--	Leatherworking
			[4] = 2259,		--	Alchemy
			[5] = 2383,		--	Herbalism		--	UNUSED
			[6] = 2550,		--	Cooking
			[7] = 2575,		--	Mining
			[8] = 3908,		--	Tailoring
			[9] = 4036,		--	Engineering
			[10] = 7411,	--	Enchanting
			[11] = 7620,	--	Fishing			--	UNUSED
			[12] = 8613,	--	Skinning		--	UNUSED
			[13] = 2842,	--	Poisons			--	Rogue
			[14] = 5149,	--	Beast Training	--	UNUSED	--	Hunter
		};
		local tradeskill_name = {  };		--	[pid] = prof_name
		local tradeskill_hash = {  };		--	[prof_name] = pid
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
			[11] = "Interface\\Icons\\trade_fishing",
			[12] = "Interface\\Icons\\inv_misc_pelt_wolf_01",
			[13] = "Interface\\Icons\\trade_brewpoison",
			[14] = 132162,
		};
		local tradeskill_check_id = {		--	[pid] = p_check_sid
			[1] = 3273,		--	FirstAid
			[2] = 2018,		--	Blacksmithing
			[3] = 2108,		--	Leatherworking
			[4] = 2259,		--	Alchemy
			[5] = 2383,		--	Herbalism		--	UNUSED
			[6] = 2550,		--	Cooking
			[7] = 2656,		--	Mining
			[8] = 3908,		--	Tailoring
			[9] = 4036,		--	Engineering
			[10] = 7411,	--	Enchanting
			[11] = 7620,	--	Fishing			--	UNUSED
			[12] = 8613,	--	Skinning		--	UNUSED
			[13] = 2842,	--	Poisons			--	Rogue
			[14] = 5149,	--	Beast Training	--	UNUSED	--	Hunter
		};
		local tradeskill_check_name = {  };	--	[pid] = p_check_sname
		local tradeskill_has_win = {		--	[pid] = bool
			[1] = true,		--	FirstAid
			[2] = true,		--	Blacksmithing
			[3] = true,		--	Leatherworking
			[4] = true,		--	Alchemy
			[5] = false,	--	Herbalism		--	UNUSED
			[6] = true,		--	Cooking
			[7] = true,		--	Mining
			[8] = true,		--	Tailoring
			[9] = true,		--	Engineering
			[10] = true,	--	Enchanting
			[11] = false,	--	Fishing			--	UNUSED
			[12] = false,	--	Skinning		--	UNUSED
			[13] = true,	--	Poisons			--	Rogue
			[14] = true,	--	Beast Training	--	UNUSED	--	Hunter
		};
		--	recipe db
		local recipe_info = {
			[19566] = { true, 1,  3, 19566, 15409, 250, 250, 250, 250,   1,   1, { 8150, }, { 1, }, },
			--
			[3275]  = {  nil, 1,  1,  3275,  1251,   1,  30,  45,  60,   1,   1, { 2589, }, { 1, }, },
			[3276]  = {  nil, 1,  1,  3276,  2581,  40,  50,  75, 100,   1,   1, { 2589, }, { 2, }, { 2326, 2327, 2329, 2798, 3181, 3373, 4211, 4591, 5150, 5759, 5939, 5943, 6094, }, 100, },
			[7934]  = {  nil, 1,  1,  7934,  6452,  80,  80, 115, 150,   3,   3, { 1475, }, { 1, }, { 2326, 2327, 2329, 2798, 3181, 3373, 4211, 4591, 5150, 5759, 5939, 5943, 6094, }, 250, },
			[3277]  = {  nil, 1,  1,  3277,  3530,  80,  80, 115, 150,   1,   1, { 2592, }, { 1, }, { 2326, 2327, 2329, 2798, 3181, 3373, 4211, 4591, 5150, 5759, 5939, 5943, 6094, }, 250, },
			[3278]  = {  nil, 1,  1,  3278,  3531, 115, 115, 150, 185,   1,   1, { 2592, }, { 2, }, { 2326, 2327, 2329, 2798, 3181, 3373, 4211, 4591, 5150, 5759, 5939, 5943, 6094, }, 1000, },
			[7935]  = {  nil, 1,  1,  7935,  6453, 130, 130, 165, 200,   3,   3, { 1288, }, { 1, }, nil, nil, 6454, },
			[7928]  = {  nil, 1,  1,  7928,  6450, 150, 150, 180, 210,   1,   1, { 4306, }, { 1, }, { 2326, 2327, 2329, 2798, 3181, 3373, 4211, 4591, 5150, 5759, 5939, 5943, 6094, }, 5000, },
			[7929]  = {  nil, 1,  1,  7929,  6451, 180, 180, 210, 240,   1,   1, { 4306, }, { 2, }, nil, nil, 16112, },
			[10840] = {  nil, 1,  1, 10840,  8544, 210, 210, 240, 270,   1,   1, { 4338, }, { 1, }, nil, nil, 16113, },
			[10841] = {  nil, 1,  1, 10841,  8545, 240, 240, 270, 300,   1,   1, { 4338, }, { 2, }, { 12920, 12939, }, 0, },
			[18629] = {  nil, 1,  1, 18629, 14529, 260, 260, 290, 320,   1,   1, { 14047, }, { 1, }, { 12920, 12939, }, 0, },
			[18630] = {  nil, 1,  1, 18630, 14530, 290, 290, 320, 350,   1,   1, { 14047, }, { 2, }, { 12920, 12939, }, 0, },
			[30021] = {  nil, 1,  1, 30021, 23684, 300, 300, 330, 360,   4,   4, { 23567, 14047, }, { 1, 10, }, },
			[23787] = {  nil, 3,  1, 23787, 19440, 300, 300, 330, 360,   1,   1, { 19441, }, { 1, }, nil, nil, 19442, },
			[3115]  = {  nil, 1,  2,  3115,  3239,   1,  15,  35,  55,   1,   1, { 2835, 2589, }, { 1, 1, }, },
			[2663]  = {  nil, 1,  2,  2663,  2853,   1,  20,  40,  60,   1,   1, { 2840, }, { 2, }, },
			[2660]  = {  nil, 1,  2,  2660,  2862,   1,  15,  35,  55,   1,   1, { 2835, }, { 1, }, },
			[12260] = {  nil, 1,  2, 12260, 10421,   1,  15,  35,  55,   1,   1, { 2840, }, { 4, }, },
			[2662]  = {  nil, 1,  2,  2662,  2852,   1,  50,  70,  90,   1,   1, { 2840, }, { 4, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 50, },
			[2737]  = {  nil, 1,  2,  2737,  2844,  15,  55,  75,  95,   1,   1, { 2840, 2880, 2589, }, { 6, 1, 2, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 50, },
			[2738]  = {  nil, 1,  2,  2738,  2845,  20,  60,  80, 100,   1,   1, { 2840, 2880, 2589, }, { 6, 1, 2, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 50, },
			[3319]  = {  nil, 1,  2,  3319,  3469,  20,  60,  80, 100,   1,   1, { 2840, }, { 8, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 50, },
			[2739]  = {  nil, 1,  2,  2739,  2847,  25,  65,  85, 105,   1,   1, { 2840, 2880, 2589, }, { 6, 1, 2, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 50, },
			[3320]  = {  nil, 1,  2,  3320,  3470,  25,  45,  65,  85,   1,   1, { 2835, }, { 2, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 100, },
			[8880]  = {  nil, 1,  2,  8880,  7166,  30,  70,  90, 110,   1,   1, { 2840, 2880, 3470, 2318, }, { 6, 1, 1, 1, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 100, },
			[9983]  = {  nil, 1,  2,  9983,  7955,  30,  70,  90, 110,   1,   1, { 2840, 2880, 3470, 2318, }, { 10, 2, 1, 1, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4605, 5511, 6299, 10266, 10266, 10276, 10277, 10278, }, 100, },
			[3293]  = {  nil, 1,  2,  3293,  3488,  35,  75,  95, 115,   1,   1, { 2840, 2880, 774, 3470, 2318, }, { 12, 2, 2, 2, 2, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 250, },
			[2661]  = {  nil, 1,  2,  2661,  2851,  35,  75,  95, 115,   1,   1, { 2840, }, { 6, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 100, },
			[3321]  = {  nil, 1,  2,  3321,  3471,  35,  75,  95, 115,   1,   1, { 2840, 774, 3470, }, { 8, 1, 2, }, nil, nil, 3609, },
			[3323]  = {  nil, 1,  2,  3323,  3472,  40,  80, 100, 120,   1,   1, { 2840, 3470, }, { 8, 2, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 100, },
			[3324]  = {  nil, 1,  2,  3324,  3473,  45,  85, 105, 125,   1,   1, { 2840, 2321, 3470, }, { 8, 2, 3, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 200, },
			[3325]  = {  nil, 1,  2,  3325,  3474,  60, 100, 120, 140,   1,   1, { 2840, 818, 774, }, { 8, 1, 1, }, nil, nil, 3610, },
			[7408]  = {  nil, 1,  2,  7408,  6214,  65, 105, 125, 145,   1,   1, { 2840, 2880, 2318, }, { 12, 2, 2, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 300, },
			[2665]  = {  nil, 1,  2,  2665,  2863,  65,  65,  72,  80,   1,   1, { 2836, }, { 1, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 100, },
			[3116]  = {  nil, 1,  2,  3116,  3240,  65,  65,  72,  80,   1,   1, { 2836, 2592, }, { 1, 1, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 100, },
			[8366]  = {  nil, 1,  2,  8366,  6730,  70, 110, 130, 150,   1,   1, { 2840, 774, 3470, }, { 12, 2, 2, }, },
			[3294]  = {  nil, 1,  2,  3294,  3489,  70, 110, 130, 150,   1,   1, { 2840, 2880, 2842, 3470, 2318, }, { 10, 2, 2, 2, 2, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 500, },
			[2666]  = {  nil, 1,  2,  2666,  2857,  70, 110, 130, 150,   1,   1, { 2840, }, { 10, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 200, },
			[3326]  = {  nil, 1,  2,  3326,  3478,  75,  75,  87, 100,   1,   1, { 2836, }, { 2, }, { 514, 957, 1241, 1383, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4605, 5511, 6299, 10266, 10276, 10277, 10278, }, 250, },
			[2667]  = {  nil, 1,  2,  2667,  2864,  80, 120, 140, 160,   1,   1, { 2840, 1210, 3470, }, { 12, 1, 2, }, nil, nil, 2881, },
			[2664]  = {  nil, 1,  2,  2664,  2854,  90, 115, 127, 140,   1,   1, { 2840, 3470, }, { 10, 3, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 500, },
			[7817]  = {  nil, 1,  2,  7817,  6350,  95, 125, 140, 155,   1,   1, { 2841, 3470, }, { 6, 6, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 200, },
			[3292]  = {  nil, 1,  2,  3292,  3487,  95, 135, 155, 175,   1,   1, { 2840, 2880, 818, 2319, }, { 14, 2, 2, 2, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 500, },
			[19666] = {  nil, 1,  2, 19666, 15869, 100, 100, 110, 120,   2,   2, { 2842, 3470, }, { 1, 1, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 100, },
			[2671]  = {  nil, 1,  2,  2671,  2867, 100, 145, 160, 175,   1,   1, { 2841, }, { 4, }, },
			[3491]  = {  nil, 1,  2,  3491,  3848, 105, 135, 150, 165,   1,   1, { 2841, 2880, 3470, 818, 2319, }, { 6, 4, 2, 1, 1, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 600, },
			[8367]  = {  nil, 1,  2,  8367,  6731, 100, 140, 160, 180,   1,   1, { 2840, 818, 3470, }, { 16, 2, 3, }, nil, nil, 6735, },
			[7818]  = {  nil, 1,  2,  7818,  6338, 100, 105, 107, 110,   1,   1, { 2842, 3470, }, { 1, 2, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 100, },
			[2668]  = {  nil, 1,  2,  2668,  2865, 105, 145, 160, 175,   1,   1, { 2841, }, { 6, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 300, },
			[2670]  = {  nil, 1,  2,  2670,  2866, 105, 145, 160, 175,   1,   1, { 2841, }, { 7, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 450, },
			[2740]  = {  nil, 1,  2,  2740,  2848, 110, 140, 155, 170,   1,   1, { 2841, 2880, 2319, }, { 6, 4, 1, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 180, },
			[3328]  = {  nil, 1,  2,  3328,  3480, 110, 140, 155, 170,   1,   1, { 2841, 1210, 3478, }, { 5, 1, 1, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 500, },
			[2741]  = {  nil, 1,  2,  2741,  2849, 115, 145, 160, 175,   1,   1, { 2841, 2880, 2319, }, { 7, 4, 1, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 180, },
			[6517]  = {  nil, 1,  2,  6517,  5540, 110, 140, 155, 170,   1,   1, { 2841, 3466, 5498, 3478, }, { 6, 1, 2, 2, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 720, },
			[2672]  = {  nil, 1,  2,  2672,  2868, 120, 150, 165, 180,   1,   1, { 2841, 3478, }, { 5, 2, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 500, },
			[2742]  = {  nil, 1,  2,  2742,  2850, 120, 150, 165, 180,   1,   1, { 2841, 2880, 2319, }, { 5, 4, 2, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 180, },
			[9985]  = {  nil, 1,  2,  9985,  7956, 125, 155, 170, 185,   1,   1, { 2841, 3466, 2319, }, { 8, 1, 1, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 225, },
			[2674]  = {  nil, 1,  2,  2674,  2871, 125, 125, 132, 140,   1,   1, { 2838, }, { 1, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 1000, },
			[3330]  = {  nil, 1,  2,  3330,  3481, 125, 155, 170, 185,   1,   1, { 2841, 2842, 3478, }, { 8, 2, 2, }, nil, nil, 2882, },
			[3117]  = {  nil, 1,  2,  3117,  3241, 125, 125, 132, 140,   1,   1, { 2838, 2592, }, { 1, 1, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 1000, },
			[3295]  = {  nil, 1,  2,  3295,  3490, 125, 155, 170, 185,   1,   1, { 2841, 3466, 2459, 1210, 3478, 2319, }, { 4, 1, 1, 2, 2, 2, }, nil, nil, 2883, },
			[3337]  = {  nil, 1,  2,  3337,  3486, 125, 125, 137, 150,   1,   1, { 2838, }, { 3, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 1000, },
			[3331]  = {  nil, 1,  2,  3331,  3482, 130, 160, 175, 190,   1,   1, { 2841, 2842, 3478, }, { 6, 1, 2, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 500, },
			[9986]  = {  nil, 1,  2,  9986,  7957, 130, 160, 175, 190,   1,   1, { 2841, 3466, 2319, }, { 12, 2, 2, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 450, },
			[3296]  = {  nil, 1,  2,  3296,  3491, 130, 160, 175, 190,   1,   1, { 2841, 3466, 1206, 1210, 3478, 2319, }, { 8, 1, 1, 1, 2, 2, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 1000, },
			[2673]  = {  nil, 1,  2,  2673,  2869, 130, 160, 175, 190,   1,   1, { 2841, 2842, 3478, 1705, }, { 10, 2, 2, 1, }, nil, nil, 5578, },
			[9987]  = {  nil, 1,  2,  9987,  7958, 135, 165, 180, 195,   1,   1, { 2841, 3466, 2319, }, { 14, 1, 2, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 450, },
			[3333]  = {  nil, 1,  2,  3333,  3483, 135, 165, 180, 195,   1,   1, { 2841, 2842, 3478, }, { 8, 1, 2, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 1000, },
			[8368]  = {  nil, 1,  2,  8368,  6733, 140, 170, 185, 200,   1,   1, { 2841, 1210, 3478, }, { 8, 3, 4, }, },
			[6518]  = {  nil, 1,  2,  6518,  5541, 140, 170, 185, 200,   1,   1, { 2841, 3466, 5500, 3478, 2319, }, { 10, 1, 1, 2, 2, }, nil, nil, 5543, },
			[3297]  = {  nil, 1,  2,  3297,  3492, 145, 175, 190, 205,   1,   1, { 3575, 3466, 3391, 1705, 3478, 2319, }, { 6, 2, 1, 2, 2, 2, }, nil, nil, 3608, },
			[3334]  = {  nil, 1,  2,  3334,  3484, 145, 175, 190, 205,   1,   1, { 3575, 1705, 3478, 2605, }, { 4, 2, 2, 1, }, nil, nil, 3611, },
			[2675]  = {  nil, 1,  2,  2675,  2870, 145, 175, 190, 205,   1,   1, { 2841, 1206, 1705, 5500, 2842, }, { 20, 2, 2, 2, 4, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 1000, },
			[14379] = {  nil, 1,  2, 14379, 11128, 150, 155, 157, 160,   1,   1, { 3577, 3478, }, { 1, 2, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 250, },
			[8768]  = {  nil, 1,  2,  8768,  7071, 150, 150, 152, 155,   2,   2, { 3575, }, { 1, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 250, },
			[3336]  = {  nil, 1,  2,  3336,  3485, 150, 180, 195, 210,   1,   1, { 3575, 5498, 3478, 2605, }, { 4, 2, 2, 1, }, nil, nil, 3612, },
			[7221]  = {  nil, 1,  2,  7221,  6042, 150, 180, 195, 210,   1,   1, { 3575, 3478, }, { 6, 4, }, nil, nil, 6044, },
			[19667] = {  nil, 1,  2, 19667, 15870, 150, 150, 160, 170,   2,   2, { 3577, 3486, }, { 1, 1, }, { 1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276, }, 250, },
			[3506]  = {  nil, 1,  2,  3506,  3842, 155, 180, 192, 205,   1,   1, { 3575, 3486, 2605, }, { 8, 1, 1, }, { 2836, 3355, 4258, }, 5000, },
			[3494]  = {  nil, 1,  2,  3494,  3851, 155, 180, 192, 205,   1,   1, { 3575, 3466, 3486, 2842, 4234, }, { 8, 2, 1, 4, 2, }, nil, nil, 10858, },
			[12259] = {  nil, 1,  2, 12259, 10423, 155, 180, 192, 205,   1,   1, { 2841, 2842, 3478, }, { 12, 4, 2, }, nil, nil, 10424, },
			[3492]  = {  nil, 1,  2,  3492,  3849, 160, 185, 197, 210,   1,   1, { 3575, 3466, 3486, 1705, 4234, }, { 6, 2, 1, 2, 3, }, nil, nil, 12162, },
			[3504]  = {  nil, 1,  2,  3504,  3840, 160, 185, 197, 210,   1,   1, { 3575, 3486, 2605, }, { 7, 1, 1, }, nil, nil, 3870, },
			[9813]  = {  nil, 1,  2,  9813,  7914, 160, 185, 197, 210,   1,   1, { 3575, 3486, }, { 20, 4, }, nil, nil, 7979, },
			[9811]  = {  nil, 1,  2,  9811,  7913, 160, 185, 197, 210,   1,   1, { 3575, 5635, 1210, 3486, }, { 8, 4, 2, 2, }, nil, nil, 7978, },
			[7222]  = {  nil, 1,  2,  7222,  6043, 165, 190, 202, 215,   1,   1, { 3575, 3478, 1705, }, { 4, 2, 1, }, nil, nil, 6045, },
			[3501]  = {  nil, 1,  2,  3501,  3835, 165, 190, 202, 215,   1,   1, { 3575, 2605, }, { 6, 1, }, { 2836, 3355, 4258, }, 1000, },
			[3495]  = {  nil, 1,  2,  3495,  3852, 170, 195, 207, 220,   1,   1, { 3575, 3577, 1705, 3466, 4234, 3486, }, { 10, 4, 2, 2, 2, 2, }, nil, nil, 3867, },
			[3502]  = {  nil, 1,  2,  3502,  3836, 170, 195, 207, 220,   1,   1, { 3575, 3864, 2605, }, { 12, 1, 1, }, { 2836, 3355, 4258, }, 1250, },
			[3507]  = {  nil, 1,  2,  3507,  3843, 170, 195, 207, 220,   1,   1, { 3575, 3577, 3486, }, { 10, 2, 1, }, nil, nil, 3872, },
			[9814]  = {  nil, 1,  2,  9814,  7915, 175, 200, 212, 225,   1,   1, { 3575, 5637, 5635, }, { 10, 2, 2, }, nil, nil, 7980, },
			[3505]  = {  nil, 1,  2,  3505,  3841, 175, 200, 212, 225,   1,   1, { 3859, 3577, 3486, }, { 6, 2, 1, }, nil, nil, 3871, },
			[3493]  = {  nil, 1,  2,  3493,  3850, 175, 200, 212, 225,   1,   1, { 3575, 3466, 3486, 1529, 4234, }, { 8, 2, 2, 2, 3, }, nil, nil, 3866, },
			[3496]  = {  nil, 1,  2,  3496,  3853, 180, 205, 217, 230,   1,   1, { 3859, 3466, 3486, 1705, 4234, }, { 8, 2, 2, 3, 3, }, nil, nil, 12163, },
			[3508]  = {  nil, 1,  2,  3508,  3844, 180, 205, 217, 230,   1,   1, { 3575, 3486, 1529, 1206, 4255, }, { 20, 4, 2, 2, 1, }, { 2836, 3355, 4258, }, 7500, },
			[15972] = {  nil, 1,  2, 15972, 12259, 180, 205, 217, 230,   1,   1, { 3859, 3466, 1206, 7067, 4234, }, { 10, 2, 1, 1, 1, }, { 2836, 3355, 4258, }, 7500, },
			[9818]  = {  nil, 1,  2,  9818,  7916, 180, 205, 217, 230,   1,   1, { 3575, 5637, 818, 3486, }, { 12, 4, 4, 2, }, nil, nil, 7981, },
			[3498]  = {  nil, 1,  2,  3498,  3855, 185, 210, 222, 235,   1,   1, { 3575, 3466, 3486, 3577, 4234, }, { 14, 2, 2, 4, 2, }, nil, nil, 12164, },
			[9820]  = {  nil, 1,  2,  9820,  7917, 185, 210, 222, 235,   1,   1, { 3575, 3486, 5637, }, { 14, 3, 2, }, nil, nil, 7982, },
			[3513]  = {  nil, 1,  2,  3513,  3846, 185, 210, 222, 235,   1,   1, { 3859, 3864, 1705, 3486, }, { 8, 1, 1, 2, }, nil, nil, 3874, },
			[7223]  = {  nil, 1,  2,  7223,  6040, 185, 210, 222, 235,   1,   1, { 3859, 3486, }, { 5, 2, }, { 2836, 3355, 4258, }, 1000, },
			[7224]  = {  nil, 1,  2,  7224,  6041, 190, 215, 227, 240,   1,   1, { 3859, 3486, 4234, }, { 8, 2, 4, }, nil, nil, 6046, },
			[21913] = {  nil, 1,  2, 21913, 17704, 190, 215, 227, 240,   1,   1, { 3859, 3829, 7070, 7069, 4234, }, { 10, 1, 2, 2, 2, }, nil, nil, 17706, },
			[3503]  = {  nil, 1,  2,  3503,  3837, 190, 215, 227, 240,   1,   1, { 3859, 3577, 3486, }, { 8, 2, 2, }, nil, nil, 6047, },
			[15973] = {  nil, 1,  2, 15973, 12260, 190, 215, 227, 240,   1,   1, { 3859, 3577, 7068, 4234, }, { 10, 4, 2, 2, }, nil, nil, 12261, },
			[3511]  = {  nil, 1,  2,  3511,  3845, 195, 220, 232, 245,   1,   1, { 3859, 3577, 3486, 1529, }, { 12, 2, 4, 2, }, nil, nil, 3873, },
			[9916]  = {  nil, 1,  2,  9916,  7963, 200, 225, 237, 250,   1,   1, { 3859, 3486, }, { 16, 3, }, { 2836, 3355, 4258, }, 2500, },
			[9920]  = {  nil, 1,  2,  9920,  7966, 200, 200, 205, 210,   1,   1, { 7912, }, { 4, }, { 2836, 3355, 4258, }, 2500, },
			[9918]  = {  nil, 1,  2,  9918,  7964, 200, 200, 205, 210,   1,   1, { 7912, }, { 1, }, { 2836, 3355, 4258, }, 2500, },
			[19668] = {  nil, 1,  2, 19668, 15871, 200, 200, 210, 220,   2,   2, { 6037, 7966, }, { 1, 1, }, { 2836, 3355, 4258, }, 2500, },
			[9921]  = {  nil, 1,  2,  9921,  7965, 200, 200, 205, 210,   1,   1, { 7912, 4306, }, { 1, 1, }, { 2836, 3355, 4258, }, 2500, },
			[3497]  = {  nil, 1,  2,  3497,  3854, 200, 225, 237, 250,   1,   1, { 3859, 3466, 3486, 1529, 3829, 4234, }, { 8, 2, 2, 2, 1, 4, }, nil, nil, 3868, },
			[11454] = {  nil, 1,  2, 11454,  9060, 200, 225, 237, 250,   1,   1, { 3860, 3577, 6037, }, { 5, 1, 1, }, nil, nil, 10713, },
			[14380] = {  nil, 1,  2, 14380, 11144, 200, 205, 207, 210,   1,   1, { 6037, 3486, }, { 1, 1, }, { 2836, 3355, 4258, }, 2500, },
			[3500]  = {  nil, 1,  2,  3500,  3856, 200, 225, 237, 250,   1,   1, { 3859, 3466, 3486, 3864, 3824, 4234, }, { 10, 2, 3, 2, 1, 3, }, nil, nil, 3869, },
			[3515]  = {  nil, 1,  2,  3515,  3847, 200, 225, 237, 250,   1,   1, { 3859, 3577, 3486, 3864, }, { 10, 4, 4, 1, }, nil, nil, 3875, },
			[11643] = {  nil, 1,  2, 11643,  9366, 205, 225, 235, 245,   1,   1, { 3859, 3577, 3486, 3864, }, { 10, 4, 4, 1, }, nil, nil, 9367, },
			[9928]  = {  nil, 1,  2,  9928,  7919, 205, 225, 235, 245,   1,   1, { 3860, 4338, }, { 6, 4, }, { 2836, 3355, 4258, }, 5000, },
			[9926]  = {  nil, 1,  2,  9926,  7918, 205, 225, 235, 245,   1,   1, { 3860, 4234, }, { 8, 6, }, { 2836, 3355, 4258, }, 5000, },
			[9931]  = {  nil, 1,  2,  9931,  7920, 210, 230, 240, 250,   1,   1, { 3860, }, { 12, }, { 2836, 3355, 4258, }, 5000, },
			[9933]  = {  nil, 1,  2,  9933,  7921, 210, 230, 240, 250,   1,   1, { 3860, 1705, }, { 10, 2, }, nil, nil, 7975, },
			[9980]  = {  nil, 1,  2,  9980,  7937, 210, 265, 275, 285,   1,   1, { 3860, 6037, 7971, 7966, }, { 16, 2, 1, 1, }, nil, nil, nil, { 2771, }, },
			[9993]  = {  nil, 1,  2,  9993,  7941, 210, 235, 247, 260,   1,   1, { 3860, 3864, 7966, 4234, }, { 12, 2, 1, 4, }, { 2836, 3355, 4258, }, 10000, },
			[9972]  = {  nil, 1,  2,  9972,  7935, 210, 260, 270, 280,   1,   1, { 3860, 6037, 7077, 7966, }, { 16, 6, 1, 1, }, nil, nil, nil, { 2773, }, },
			[9979]  = {  nil, 1,  2,  9979,  7936, 210, 265, 275, 285,   1,   1, { 3860, 6037, 4304, 7966, 7909, }, { 14, 2, 4, 1, 1, }, nil, nil, nil, { 2772, }, },
			[9937]  = {  nil, 1,  2,  9937,  7924, 215, 235, 245, 255,   1,   1, { 3860, 3864, }, { 8, 2, }, nil, nil, 7995, },
			[9935]  = {  nil, 1,  2,  9935,  7922, 215, 235, 245, 255,   1,   1, { 3859, 7966, }, { 14, 1, }, { 2836, 3355, 4258, }, 5000, },
			[9957]  = {  nil, 1,  2,  9957,  7929, 215, 250, 260, 270,   1,   1, { 3860, 7067, }, { 12, 1, }, nil, nil, nil, { 2756, }, },
			[9939]  = {  nil, 1,  2,  9939,  7967, 215, 235, 245, 255,   1,   1, { 3860, 6037, 7966, }, { 4, 2, 4, }, nil, nil, 7976, },
			[9945]  = {  nil, 1,  2,  9945,  7926, 220, 240, 250, 260,   1,   1, { 3860, 6037, 7966, 7909, }, { 12, 1, 1, 1, }, nil, nil, 7983, },
			[9950]  = {  nil, 1,  2,  9950,  7927, 220, 240, 250, 260,   1,   1, { 3860, 4338, 6037, 7966, }, { 10, 6, 1, 1, }, nil, nil, 7984, },
			[9942]  = {  nil, 1,  2,  9942,  7925, 220, 240, 250, 260,   1,   1, { 3860, 4234, 4338, }, { 8, 6, 4, }, },
			[9995]  = {  nil, 1,  2,  9995,  7942, 220, 245, 257, 270,   1,   1, { 3860, 7909, 7966, 4304, }, { 16, 2, 1, 4, }, nil, nil, 7992, },
			[9952]  = {  nil, 1,  2,  9952,  7928, 225, 245, 255, 265,   1,   1, { 3860, 6037, 4304, }, { 12, 1, 6, }, nil, nil, 7985, },
			[9997]  = {  nil, 1,  2,  9997,  7943, 225, 250, 262, 275,   1,   1, { 3860, 6037, 7966, 4304, }, { 14, 4, 1, 2, }, nil, nil, 8029, },
			[9961]  = {  nil, 1,  2,  9961,  7931, 230, 250, 260, 270,   1,   1, { 3860, 4338, }, { 10, 6, }, { 2836, }, 15000, },
			[10001] = {  nil, 1,  2, 10001,  7945, 230, 255, 267, 280,   1,   1, { 3860, 7971, 1210, 7966, 4304, }, { 16, 1, 4, 1, 2, }, { 2836, }, 15000, },
			[9959]  = {  nil, 1,  2,  9959,  7930, 230, 250, 260, 270,   1,   1, { 3860, }, { 16, }, { 2836, }, 15000, },
			[9964]  = {  nil, 1,  2,  9964,  7969, 235, 255, 265, 275,   1,   1, { 3860, 7966, }, { 4, 3, }, nil, nil, 7989, },
			[10003] = {  nil, 1,  2, 10003,  7954, 235, 260, 272, 285,   1,   1, { 3860, 7075, 6037, 3864, 1529, 7966, 4304, }, { 24, 4, 6, 5, 5, 4, 4, }, { 7231, 7232, 11146, 11178, }, 13500, },
			[9968]  = {  nil, 1,  2,  9968,  7933, 235, 255, 265, 275,   1,   1, { 3860, 4304, }, { 14, 4, }, { 2836, }, 20000, },
			[9966]  = {  nil, 1,  2,  9966,  7932, 235, 255, 265, 275,   1,   1, { 3860, 4304, 3864, }, { 14, 4, 4, }, nil, nil, 7991, },
			[10005] = {  nil, 1,  2, 10005,  7944, 240, 265, 277, 290,   1,   1, { 3860, 7909, 1705, 1206, 7966, 4338, }, { 14, 1, 2, 2, 1, 2, }, nil, nil, 7993, },
			[9954]  = {  nil, 1,  2,  9954,  7938, 225, 245, 255, 265,   1,   1, { 3860, 6037, 7909, 3864, 5966, 7966, }, { 10, 8, 3, 3, 1, 2, }, { 5164, 7230, 11177, }, 9000, },
			[10007] = {  nil, 1,  2, 10007,  7961, 245, 270, 282, 295,   1,   1, { 3860, 7081, 6037, 3823, 7909, 7966, 4304, }, { 28, 6, 8, 2, 6, 4, 2, }, { 7231, 7232, 11146, 11178, }, 13500, },
			[9970]  = {  nil, 1,  2,  9970,  7934, 245, 255, 265, 275,   1,   1, { 3860, 7909, }, { 14, 1, }, nil, nil, 7990, },
			[10009] = {  nil, 1,  2, 10009,  7946, 245, 270, 282, 295,   1,   1, { 3860, 7075, 7966, 4304, }, { 18, 2, 1, 4, }, nil, nil, 8028, },
			[9974]  = {  nil, 1,  2,  9974,  7939, 245, 265, 275, 285,   1,   1, { 3860, 6037, 7910, 7971, 7966, }, { 12, 24, 4, 4, 2, }, { 5164, 7230, 11177, }, 9000, },
			[16639] = {  nil, 1,  2, 16639, 12644, 250, 255, 257, 260,   1,   1, { 12365, }, { 4, }, { 2836, }, 10000, },
			[16643] = {  nil, 1,  2, 16643, 12406, 250, 270, 280, 290,   1,   1, { 12359, 11186, }, { 12, 4, }, nil, nil, 12683, },
			[16641] = {  nil, 1,  2, 16641, 12404, 250, 255, 257, 260,   1,   1, { 12365, }, { 1, }, { 2836, }, 10000, },
			[16642] = {  nil, 1,  2, 16642, 12405, 250, 270, 280, 290,   1,   1, { 12359, 12361, 11188, }, { 16, 1, 4, }, nil, nil, 12682, },
			[16640] = {  nil, 1,  2, 16640, 12643, 250, 255, 257, 260,   1,   1, { 12365, 14047, }, { 1, 1, }, { 2836, }, 10000, },
			[10011] = {  nil, 1,  2, 10011,  7959, 250, 275, 287, 300,   1,   1, { 3860, 7972, 6037, 7966, 4304, }, { 28, 10, 10, 6, 6, }, { 7231, 7232, 11146, 11178, }, 13500, },
			[10013] = {  nil, 1,  2, 10013,  7947, 255, 280, 292, 305,   1,   1, { 3860, 6037, 7910, 7966, 4304, }, { 12, 6, 2, 1, 2, }, nil, nil, 8030, },
			[16644] = {  nil, 1,  2, 16644, 12408, 255, 275, 285, 295,   1,   1, { 12359, 11184, }, { 12, 4, }, nil, nil, 12684, },
			[16960] = {  nil, 1,  2, 16960, 12764, 260, 285, 297, 310,   1,   1, { 12359, 12644, 8170, }, { 16, 2, 4, }, },
			[16645] = {  nil, 1,  2, 16645, 12416, 260, 280, 290, 300,   1,   1, { 12359, 7077, }, { 10, 2, }, nil, nil, 12685, },
			[10015] = {  nil, 1,  2, 10015,  7960, 260, 285, 297, 310,   1,   1, { 3860, 6037, 7910, 7081, 7966, 4304, }, { 30, 16, 6, 4, 8, 6, }, { 7231, 7232, 11146, 11178, }, 13500, },
			[15292] = {  nil, 1,  2, 15292, 11608, 265, 285, 295, 305,   1,   1, { 11371, 7077, }, { 18, 4, }, nil, nil, 11610, },
			[16647] = {  nil, 1,  2, 16647, 12424, 265, 285, 295, 305,   1,   1, { 12359, 8170, 7909, }, { 22, 6, 1, }, nil, nil, 12688, },
			[16646] = {  nil, 1,  2, 16646, 12428, 265, 285, 295, 305,   1,   1, { 12359, 8170, 3864, }, { 24, 6, 2, }, nil, nil, 12687, },
			[16648] = {  nil, 1,  2, 16648, 12415, 270, 290, 300, 310,   1,   1, { 12359, 7077, 7910, }, { 18, 2, 1, }, nil, nil, 12689, },
			[16649] = {  nil, 1,  2, 16649, 12425, 270, 290, 300, 310,   1,   1, { 12359, 7910, }, { 20, 1, }, nil, nil, 12690, },
			[16650] = {  nil, 1,  2, 16650, 12624, 270, 290, 300, 310,   1,   1, { 12359, 12655, 12803, 8153, 12364, }, { 40, 2, 4, 4, 1, }, nil, nil, 12691, },
			[16965] = {  nil, 1,  2, 16965, 12769, 270, 295, 307, 320,   1,   1, { 12359, 12803, 8153, 12799, 12644, 8170, }, { 30, 6, 6, 6, 2, 8, }, },
			[15293] = {  nil, 1,  2, 15293, 11606, 270, 290, 300, 310,   1,   1, { 11371, 7077, }, { 10, 2, }, nil, nil, 11614, },
			[16967] = {  nil, 1,  2, 16967, 12772, 270, 295, 307, 320,   1,   1, { 12359, 3577, 6037, 12361, 8170, }, { 30, 4, 2, 2, 4, }, },
			[16970] = {  nil, 1,  2, 16970, 12774, 275, 300, 312, 325,   1,   1, { 12359, 12655, 7910, 12361, 12644, 8170, }, { 30, 4, 4, 4, 2, 4, }, nil, nil, 12821, },
			[16969] = {  nil, 1,  2, 16969, 12773, 275, 300, 312, 325,   1,   1, { 12359, 12799, 12644, 8170, }, { 20, 2, 2, 4, }, nil, nil, 12819, },
			[20201] = {  nil, 1,  2, 20201, 16206, 275, 275, 280, 285,   1,   1, { 12360, 12644, }, { 3, 1, }, { 2836, }, 10000, },
			[16651] = {  nil, 1,  2, 16651, 12645, 275, 295, 305, 315,   1,   1, { 12359, 12644, 7076, }, { 4, 4, 2, }, nil, nil, 12692, },
			[19669] = {  nil, 1,  2, 19669, 15872, 275, 275, 280, 285,   2,   2, { 12360, 12644, }, { 1, 1, }, { 2836, }, 10000, },
			[15294] = {  nil, 1,  2, 15294, 11607, 275, 295, 305, 315,   1,   1, { 11371, 7077, }, { 26, 4, }, nil, nil, 11611, },
			[15295] = {  nil, 1,  2, 15295, 11605, 280, 300, 310, 320,   1,   1, { 11371, 7077, }, { 6, 1, }, nil, nil, 11615, },
			[16973] = {  nil, 1,  2, 16973, 12776, 280, 305, 317, 330,   1,   1, { 12359, 12655, 12364, 12804, 8170, }, { 20, 6, 2, 4, 4, }, nil, nil, 12824, },
			[16653] = {  nil, 1,  2, 16653, 12410, 280, 300, 310, 320,   1,   1, { 12359, 7910, 11188, }, { 24, 1, 4, }, nil, nil, 12694, },
			[16971] = {  nil, 1,  2, 16971, 12775, 280, 305, 317, 330,   1,   1, { 12359, 12644, 8170, }, { 40, 6, 6, }, nil, nil, 12823, },
			[16978] = {  nil, 1,  2, 16978, 12777, 280, 305, 317, 330,   1,   1, { 12655, 7078, 7077, 12800, 12644, }, { 10, 4, 4, 2, 2, }, nil, nil, 12825, },
			[16652] = {  nil, 1,  2, 16652, 12409, 280, 300, 310, 320,   1,   1, { 12359, 8170, 11185, }, { 20, 8, 4, }, nil, nil, 12693, },
			[16980] = {  nil, 1,  2, 16980, 12779, 285, 310, 322, 335,   1,   1, { 12359, 12799, 12644, 8170, }, { 30, 2, 2, 4, }, },
			[15296] = {  nil, 1,  2, 15296, 11604, 285, 305, 315, 325,   1,   1, { 11371, 7077, }, { 20, 8, }, nil, nil, 11612, },
			[16667] = {  nil, 1,  2, 16667, 12628, 285, 305, 315, 325,   1,   1, { 12359, 12662, 12361, 7910, }, { 40, 10, 4, 4, }, nil, nil, 12696, },
			[16983] = {  nil, 1,  2, 16983, 12781, 285, 310, 322, 335,   1,   1, { 12655, 12360, 12804, 12799, 12361, 12364, }, { 6, 2, 4, 2, 2, 1, }, nil, nil, 12827, },
			[16654] = {  nil, 1,  2, 16654, 12418, 285, 305, 315, 325,   1,   1, { 12359, 7077, }, { 18, 4, }, nil, nil, 12695, },
			[16660] = {  nil, 1,  2, 16660, 12625, 290, 310, 320, 330,   1,   1, { 12359, 12360, 12364, 7080, }, { 20, 4, 2, 2, }, nil, nil, 12698, },
			[23632] = {  nil, 3,  2, 23632, 19051, 290, 310, 320, 330,   1,   1, { 12359, 6037, 12811, }, { 8, 6, 1, }, nil, nil, 19203, },
			[16984] = {  nil, 1,  2, 16984, 12792, 290, 315, 327, 340,   1,   1, { 12359, 7077, 7910, 8170, }, { 30, 4, 4, 4, }, nil, nil, 12828, },
			[16656] = {  nil, 1,  2, 16656, 12419, 290, 310, 320, 330,   1,   1, { 12359, 7077, }, { 14, 4, }, nil, nil, 12697, },
			[16655] = {  nil, 1,  2, 16655, 12631, 290, 310, 320, 330,   1,   1, { 12359, 12655, 7078, 7910, }, { 20, 6, 2, 4, }, nil, nil, 12699, },
			[23628] = {  nil, 3,  2, 23628, 19043, 290, 310, 320, 330,   1,   1, { 12359, 7076, 12803, }, { 12, 3, 3, }, nil, nil, 19202, },
			[16985] = {  nil, 1,  2, 16985, 12782, 290, 315, 327, 340,   1,   1, { 12359, 12360, 12662, 12808, 12361, 12644, 8170, }, { 40, 2, 16, 8, 2, 2, 4, }, nil, nil, 12830, },
			[16658] = {  nil, 1,  2, 16658, 12427, 295, 315, 325, 335,   1,   1, { 12359, 7910, }, { 34, 2, }, nil, nil, 12701, },
			[16659] = {  nil, 1,  2, 16659, 12417, 295, 315, 325, 335,   1,   1, { 12359, 7077, }, { 18, 4, }, nil, nil, 12702, },
			[16661] = {  nil, 1,  2, 16661, 12632, 295, 315, 325, 335,   1,   1, { 12359, 12655, 7080, 12361, }, { 20, 4, 4, 4, }, nil, nil, 12703, },
			[20874] = {  nil, 1,  2, 20874, 17014, 295, 315, 325, 335,   1,   1, { 11371, 17010, 17011, }, { 4, 2, 2, }, nil, nil, 17051, },
			[20872] = {  nil, 1,  2, 20872, 16989, 295, 315, 325, 335,   1,   1, { 11371, 17010, 17011, }, { 6, 3, 3, }, nil, nil, 17049, },
			[16657] = {  nil, 1,  2, 16657, 12426, 295, 315, 325, 335,   1,   1, { 12359, 7910, 7909, }, { 34, 1, 1, }, nil, nil, 12700, },
			[28461] = {  nil, 6,  2, 28461, 22762, 300, 320, 330, 340,   1,   1, { 12655, 19726, 12360, 12803, }, { 12, 2, 2, 2, }, nil, nil, 22766, },
			[23652] = {  nil, 3,  2, 23652, 19168, 300, 320, 330, 340,   1,   1, { 17011, 17010, 12360, 11371, 12809, }, { 6, 6, 10, 6, 12, }, nil, nil, 19211, },
			[23650] = {  nil, 3,  2, 23650, 19170, 300, 320, 330, 340,   1,   1, { 17011, 17010, 12360, 11371, 12800, }, { 4, 7, 12, 8, 4, }, nil, nil, 19210, },
			[28463] = {  nil, 6,  2, 28463, 22764, 300, 320, 330, 340,   1,   1, { 12655, 12803, }, { 6, 2, }, nil, nil, 22768, },
			[16993] = {  nil, 1,  2, 16993, 12794, 300, 320, 330, 340,   1,   1, { 12655, 12364, 12799, 7076, 12810, }, { 20, 8, 8, 6, 4, }, nil, nil, 12837, },
			[22757] = {  nil, 1,  2, 22757, 18262, 300, 300, 310, 320,   1,   1, { 7067, 12365, }, { 2, 3, }, nil, nil, 18264, },
			[16988] = {  nil, 1,  2, 16988, 12796, 300, 320, 330, 340,   1,   1, { 12359, 12360, 12809, 12810, 7076, }, { 50, 15, 4, 6, 10, }, nil, nil, 12833, },
			[28244] = {  nil, 6,  2, 28244, 22671, 300, 320, 330, 340,   1,   1, { 22682, 12359, 12360, 7080, }, { 4, 12, 2, 2, }, { 16365, }, 0, nil, { 9233, }, },
			[16742] = {  nil, 2,  2, 16742, 12620, 300, 320, 330, 340,   1,   1, { 12360, 12655, 7076, 12799, 12800, }, { 6, 16, 6, 2, 1, }, nil, nil, 12725, },
			[27585] = {  nil, 5,  2, 27585, 22197, 300, 320, 330, 340,   1,   1, { 22202, 12655, 7076, }, { 14, 4, 2, }, nil, nil, 22209, },
			[27830] = {  nil, 5,  2, 27830, 22384, 300, 320, 330, 340,   1,   1, { 12360, 11371, 12808, 20520, 15417, 12753, }, { 15, 10, 20, 20, 10, 2, }, nil, nil, 22390, },
			[16732] = {  nil, 1,  2, 16732, 12614, 300, 320, 330, 340,   1,   1, { 12359, 12360, 7910, }, { 40, 2, 1, }, nil, nil, 12719, },
			[27832] = {  nil, 5,  2, 27832, 22383, 300, 320, 330, 340,   1,   1, { 12360, 20725, 13512, 12810, }, { 12, 2, 2, 4, }, nil, nil, 22389, },
			[16741] = {  nil, 1,  2, 16741, 12639, 300, 320, 330, 340,   1,   1, { 12360, 12655, 7076, 12361, 12799, }, { 15, 20, 10, 4, 4, }, nil, nil, 12720, },
			[16744] = {  nil, 2,  2, 16744, 12619, 300, 320, 330, 340,   1,   1, { 12360, 12655, 7080, 12361, 12364, }, { 10, 20, 6, 2, 1, }, nil, nil, 12726, },
			[27587] = {  nil, 5,  2, 27587, 22196, 300, 320, 330, 340,   1,   1, { 22203, 22202, 12655, 7076, 12364, }, { 18, 40, 12, 10, 4, }, nil, nil, 22222, },
			[16987] = {  nil, 1,  2, 16987, 12802, 300, 325, 337, 350,   1,   1, { 12655, 12804, 12364, 12800, 12644, }, { 20, 20, 2, 2, 2, }, },
			[27588] = {  nil, 5,  2, 27588, 22195, 300, 320, 330, 340,   1,   1, { 22202, 12810, }, { 14, 4, }, nil, nil, 22214, },
			[16731] = {  nil, 1,  2, 16731, 12613, 300, 320, 330, 340,   1,   1, { 12359, 12360, 7910, }, { 40, 2, 1, }, nil, nil, 12718, },
			[16995] = {  nil, 1,  2, 16995, 12783, 300, 320, 330, 340,   1,   1, { 12360, 12655, 12810, 7910, 12800, 12799, 12644, }, { 10, 10, 2, 6, 6, 6, 4, }, nil, nil, 12839, },
			[20890] = {  nil, 1,  2, 20890, 17015, 300, 320, 330, 340,   1,   1, { 11371, 17010, 11382, 12810, }, { 16, 12, 2, 2, }, nil, nil, 17059, },
			[16729] = {  nil, 1,  2, 16729, 12640, 300, 320, 330, 340,   1,   1, { 12359, 12360, 8146, 12361, 12800, }, { 80, 12, 40, 10, 4, }, nil, nil, 12717, },
			[27829] = {  nil, 5,  2, 27829, 22385, 300, 320, 330, 340,   1,   1, { 12360, 12655, 7076, 13510, }, { 12, 20, 10, 2, }, nil, nil, 22388, },
			[16746] = {  nil, 1,  2, 16746, 12641, 300, 320, 330, 340,   1,   1, { 12360, 12655, 12364, 12800, }, { 30, 30, 6, 6, }, nil, nil, 12728, },
			[20876] = {  nil, 1,  2, 20876, 17013, 300, 320, 330, 340,   1,   1, { 11371, 17010, 17011, }, { 16, 4, 6, }, nil, nil, 17052, },
			[23633] = {  nil, 3,  2, 23633, 19057, 300, 320, 330, 340,   1,   1, { 12360, 6037, 12811, }, { 2, 10, 1, }, nil, nil, 19205, },
			[23629] = {  nil, 3,  2, 23629, 19048, 300, 320, 330, 340,   1,   1, { 12360, 7076, 12803, }, { 4, 6, 6, }, nil, nil, 19204, },
			[16986] = {  nil, 1,  2, 16986, 12795, 300, 325, 337, 350,   1,   1, { 12655, 12360, 12662, 7910, 12644, }, { 10, 10, 8, 10, 2, }, },
			[20897] = {  nil, 1,  2, 20897, 17016, 300, 320, 330, 340,   1,   1, { 11371, 17011, 11382, 12810, }, { 18, 12, 2, 2, }, nil, nil, 17060, },
			[16664] = {  nil, 1,  2, 16664, 12610, 300, 320, 330, 340,   1,   1, { 12359, 12360, 3577, }, { 20, 2, 6, }, nil, nil, 12706, },
			[24136] = {  nil, 4,  2, 24136, 19690, 300, 320, 330, 340,   1,   1, { 12359, 19774, 19726, 7910, }, { 20, 10, 2, 2, }, nil, nil, 19776, },
			[23636] = {  nil, 3,  2, 23636, 19148, 300, 320, 330, 340,   1,   1, { 17011, 17010, 11371, }, { 4, 2, 4, }, nil, nil, 19206, },
			[20873] = {  nil, 1,  2, 20873, 16988, 300, 320, 330, 340,   1,   1, { 11371, 17010, 17011, }, { 16, 4, 5, }, nil, nil, 17053, },
			[21161] = {  nil, 1,  2, 21161, 17193, 300, 325, 337, 350,   1,   1, { 17203, 11371, 12360, 7078, 11382, 17011, 17010, }, { 8, 20, 50, 25, 10, 10, 10, }, nil, nil, 18592, },
			[23637] = {  nil, 3,  2, 23637, 19164, 300, 320, 330, 340,   1,   1, { 17011, 17010, 17012, 11371, 11382, }, { 3, 5, 4, 4, 2, }, nil, nil, 19207, },
			[24141] = {  nil, 4,  2, 24141, 19695, 300, 320, 330, 340,   1,   1, { 12359, 19774, 12799, }, { 16, 10, 1, }, nil, nil, 19781, },
			[23653] = {  nil, 3,  2, 23653, 19169, 300, 320, 330, 340,   1,   1, { 17011, 17010, 12360, 11371, 12364, }, { 8, 5, 10, 12, 4, }, nil, nil, 19212, },
			[16745] = {  nil, 2,  2, 16745, 12618, 300, 320, 330, 340,   1,   1, { 12360, 12655, 7076, 7080, 12364, 12800, }, { 8, 24, 4, 4, 2, 2, }, nil, nil, 12727, },
			[16994] = {  nil, 1,  2, 16994, 12784, 300, 320, 330, 340,   1,   1, { 12360, 12810, 12644, }, { 20, 6, 2, }, nil, nil, 12838, },
			[16728] = {  nil, 1,  2, 16728, 12636, 300, 320, 330, 340,   1,   1, { 12359, 12655, 8168, 12799, 12364, }, { 40, 4, 60, 6, 2, }, nil, nil, 12716, },
			[16726] = {  nil, 1,  2, 16726, 12612, 300, 320, 330, 340,   1,   1, { 12359, 12360, 6037, 12364, }, { 30, 2, 2, 1, }, nil, nil, 12714, },
			[16725] = {  nil, 1,  2, 16725, 12420, 300, 320, 330, 340,   1,   1, { 12359, 7077, }, { 20, 4, }, nil, nil, 12713, },
			[16724] = {  nil, 1,  2, 16724, 12633, 300, 320, 330, 340,   1,   1, { 12359, 12655, 6037, 3577, 12800, }, { 20, 4, 6, 6, 2, }, nil, nil, 12711, },
			[16991] = {  nil, 1,  2, 16991, 12798, 300, 320, 330, 340,   1,   1, { 12359, 12360, 12808, 12364, 12644, 12810, }, { 40, 12, 10, 8, 2, 4, }, nil, nil, 12835, },
			[16662] = {  nil, 1,  2, 16662, 12414, 300, 320, 330, 340,   1,   1, { 12359, 11186, }, { 26, 4, }, nil, nil, 12704, },
			[16663] = {  nil, 1,  2, 16663, 12422, 300, 320, 330, 340,   1,   1, { 12359, 7910, }, { 40, 2, }, nil, nil, 12705, },
			[16990] = {  nil, 1,  2, 16990, 12790, 300, 320, 330, 340,   1,   1, { 12360, 12800, 12811, 12799, 12810, 12644, }, { 15, 8, 1, 4, 8, 2, }, nil, nil, 12834, },
			[16992] = {  nil, 1,  2, 16992, 12797, 300, 320, 330, 340,   1,   1, { 12360, 12361, 12800, 7080, 12644, 12810, }, { 18, 8, 8, 4, 2, 4, }, nil, nil, 12836, },
			[28243] = {  nil, 6,  2, 28243, 22670, 300, 320, 330, 340,   1,   1, { 22682, 12359, 12360, 7080, }, { 5, 12, 2, 2, }, { 16365, }, 0, nil, { 9233, }, },
			[24139] = {  nil, 4,  2, 24139, 19693, 300, 320, 330, 340,   1,   1, { 12359, 19774, 12799, }, { 20, 14, 2, }, nil, nil, 19779, },
			[28462] = {  nil, 6,  2, 28462, 22763, 300, 320, 330, 340,   1,   1, { 12655, 19726, 12803, }, { 8, 1, 2, }, nil, nil, 22767, },
			[24914] = {  nil, 4,  2, 24914, 20550, 300, 320, 330, 340,   1,   1, { 12359, 20520, 6037, }, { 20, 10, 10, }, nil, nil, 20554, },
			[24137] = {  nil, 4,  2, 24137, 19691, 300, 320, 330, 340,   1,   1, { 12359, 19774, 19726, 7910, }, { 16, 8, 2, 1, }, nil, nil, 19777, },
			[16730] = {  nil, 1,  2, 16730, 12429, 300, 320, 330, 340,   1,   1, { 12359, 7910, }, { 44, 2, }, nil, nil, 12715, },
			[24138] = {  nil, 4,  2, 24138, 19692, 300, 320, 330, 340,   1,   1, { 12359, 19774, 19726, 12810, }, { 12, 6, 2, 4, }, nil, nil, 19778, },
			[23638] = {  nil, 3,  2, 23638, 19166, 300, 320, 330, 340,   1,   1, { 17011, 17010, 12360, 11382, 11371, }, { 3, 6, 12, 1, 4, }, nil, nil, 19208, },
			[27586] = {  nil, 5,  2, 27586, 22198, 300, 320, 330, 340,   1,   1, { 22203, 22202, 12655, 7076, }, { 8, 24, 8, 4, }, nil, nil, 22219, },
			[27589] = {  nil, 5,  2, 27589, 22194, 300, 320, 330, 340,   1,   1, { 22203, 22202, 12810, 13512, }, { 8, 24, 8, 1, }, nil, nil, 22220, },
			[24140] = {  nil, 4,  2, 24140, 19694, 300, 320, 330, 340,   1,   1, { 12359, 19774, 12799, }, { 18, 12, 2, }, nil, nil, 19780, },
			[24913] = {  nil, 4,  2, 24913, 20551, 300, 320, 330, 340,   1,   1, { 12359, 20520, 6037, 11754, }, { 16, 8, 8, 1, }, nil, nil, 20555, },
			[28242] = {  nil, 6,  2, 28242, 22669, 300, 320, 330, 340,   1,   1, { 22682, 12359, 12360, 7080, }, { 7, 16, 2, 4, }, { 16365, }, 0, nil, { 9233, }, },
			[16665] = {  nil, 1,  2, 16665, 12611, 300, 320, 330, 340,   1,   1, { 12359, 12360, 2842, }, { 20, 2, 10, }, nil, nil, 12707, },
			[24912] = {  nil, 4,  2, 24912, 20549, 300, 320, 330, 340,   1,   1, { 12359, 20520, 6037, 12810, }, { 12, 6, 6, 2, }, nil, nil, 20553, },
			[24399] = {  nil, 3,  2, 24399, 20039, 300, 320, 330, 340,   1,   1, { 17011, 17010, 17012, 11371, }, { 3, 3, 4, 6, }, nil, nil, 20040, },
			[23639] = {  nil, 3,  2, 23639, 19167, 300, 320, 330, 340,   1,   1, { 17011, 17010, 12360, 11371, }, { 5, 2, 16, 6, }, nil, nil, 19209, },
			[27590] = {  nil, 5,  2, 27590, 22191, 300, 320, 330, 340,   1,   1, { 22203, 22202, 12810, 12809, 12800, }, { 15, 36, 12, 10, 4, }, nil, nil, 22221, },
			[2881]  = {  nil, 1,  3,  2881,  2318,   1,  20,  30,  40,   1,   1, { 2934, }, { 3, }, },
			[7126]  = {  nil, 1,  3,  7126,  5957,   1,  40,  55,  70,   1,   1, { 2318, 2320, }, { 3, 1, }, },
			[9058]  = {  nil, 1,  3,  9058,  7276,   1,  40,  55,  70,   1,   1, { 2318, 2320, }, { 2, 1, }, },
			[9059]  = {  nil, 1,  3,  9059,  7277,   1,  40,  55,  70,   1,   1, { 2318, 2320, }, { 2, 3, }, },
			[2152]  = {  nil, 1,  3,  2152,  2304,   1,  30,  45,  60,   1,   1, { 2318, }, { 1, }, },
			[2149]  = {  nil, 1,  3,  2149,  2302,   1,  40,  55,  70,   1,   1, { 2318, 2320, }, { 2, 1, }, },
			[2153]  = {  nil, 1,  3,  2153,  2303,  15,  45,  60,  75,   1,   1, { 2318, 2320, }, { 4, 1, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 7866, 7867, 7868, 7869, 11083, 11096, }, 50, },
			[3753]  = {  nil, 1,  3,  3753,  4237,  25,  55,  70,  85,   1,   1, { 2318, 2320, }, { 6, 1, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 7866, 7867, 7868, 7869, 11083, 11096, }, 75, },
			[9060]  = {  nil, 1,  3,  9060,  7278,  30,  60,  75,  90,   1,   1, { 2318, 2320, }, { 4, 2, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 7866, 7867, 7868, 7869, 11083, 11096, }, 100, },
			[9062]  = {  nil, 1,  3,  9062,  7279,  30,  60,  75,  90,   1,   1, { 2318, 2320, }, { 3, 4, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 11083, 11096, }, 100, },
			[9064]  = {  nil, 1,  3,  9064,  7280,  35,  65,  80,  95,   1,   1, { 2318, 2320, }, { 5, 5, }, nil, nil, 7288, },
			[3816]  = {  nil, 1,  3,  3816,  4231,  35,  55,  65,  75,   1,   1, { 783, 4289, }, { 1, 1, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 7866, 7867, 7868, 7869, 11083, 11096, }, 50, },
			[2160]  = {  nil, 1,  3,  2160,  2300,  40,  70,  85, 100,   1,   1, { 2318, 2320, }, { 8, 4, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 7866, 7867, 7868, 7869, 11083, 11096, }, 100, },
			[5244]  = {  nil, 1,  3,  5244,  5081,  40,  70,  85, 100,   1,   1, { 5082, 2318, 2320, }, { 3, 4, 1, }, nil, nil, 5083, },
			[2161]  = {  nil, 1,  3,  2161,  2309,  55,  85, 100, 115,   1,   1, { 2318, 2320, }, { 8, 5, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 7866, 7867, 7868, 7869, 11083, 11096, }, 100, },
			[3756]  = {  nil, 1,  3,  3756,  4239,  55,  85, 100, 115,   1,   1, { 2318, 2320, }, { 3, 2, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 11083, 11096, }, 150, },
			[2163]  = {  nil, 1,  3,  2163,  2311,  60,  90, 105, 120,   1,   1, { 2318, 2320, 2324, }, { 8, 2, 1, }, nil, nil, 2407, },
			[2162]  = {  nil, 1,  3,  2162,  2310,  60,  90, 105, 120,   1,   1, { 2318, 2320, }, { 5, 2, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 11083, 11096, }, 100, },
			[9065]  = {  nil, 1,  3,  9065,  7281,  70, 100, 115, 130,   1,   1, { 2318, 2320, }, { 6, 4, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 7866, 7867, 7868, 7869, 8153, 11081, 11084, }, 450, },
			[3759]  = {  nil, 1,  3,  3759,  4242,  75, 105, 120, 135,   1,   1, { 4231, 2318, 2320, }, { 1, 6, 2, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 8153, 11081, 11084, }, 500, },
			[2164]  = {  nil, 1,  3,  2164,  2312,  75, 105, 120, 135,   1,   1, { 4231, 2318, 2320, }, { 1, 4, 2, }, nil, nil, 2408, },
			[3763]  = {  nil, 1,  3,  3763,  4246,  80, 110, 125, 140,   1,   1, { 2318, 2320, }, { 6, 2, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 8153, 11081, 11084, }, 500, },
			[2159]  = {  nil, 1,  3,  2159,  2308,  85, 105, 120, 135,   1,   1, { 2318, 2321, }, { 10, 2, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 7866, 7867, 7868, 7869, 8153, 11081, 11084, }, 550, },
			[3761]  = {  nil, 1,  3,  3761,  4243,  85, 115, 130, 145,   1,   1, { 4231, 2318, 2320, }, { 3, 6, 4, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 8153, 11081, 11084, }, 550, },
			[8322]  = {  nil, 1,  3,  8322,  6709,  90, 115, 130, 145,   1,   1, { 2318, 4231, 2320, 5498, }, { 6, 1, 4, 1, }, nil, nil, 6710, },
			[2158]  = {  nil, 1,  3,  2158,  2307,  90, 120, 135, 150,   1,   1, { 2318, 2320, }, { 7, 2, }, nil, nil, 2406, },
			[7953]  = {  nil, 1,  3,  7953,  6466,  90, 120, 135, 150,   1,   1, { 6470, 4231, 2321, }, { 8, 1, 1, }, nil, nil, 6474, },
			[6702]  = {  nil, 1,  3,  6702,  5780,  90, 120, 135, 150,   1,   1, { 5784, 2318, 2321, }, { 8, 6, 1, }, nil, nil, 5786, },
			[6703]  = {  nil, 1,  3,  6703,  5781,  95, 125, 140, 155,   1,   1, { 5784, 4231, 2318, 2321, }, { 12, 1, 8, 1, }, nil, nil, 5787, },
			[9068]  = {  nil, 1,  3,  9068,  7282,  95, 125, 140, 155,   1,   1, { 2318, 4231, 2321, }, { 10, 1, 1, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 7866, 7867, 7868, 7869, 8153, 11081, 11084, }, 600, },
			[2167]  = {  nil, 1,  3,  2167,  2315, 100, 125, 137, 150,   1,   1, { 2319, 2321, 4340, }, { 4, 2, 1, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 7866, 7867, 7868, 7869, 8153, 11081, 11084, }, 650, },
			[3762]  = {  nil, 1,  3,  3762,  4244, 100, 125, 137, 150,   1,   1, { 4243, 4231, 2320, }, { 1, 2, 2, }, nil, nil, 4293, },
			[2169]  = {  nil, 1,  3,  2169,  2317, 100, 125, 137, 150,   1,   1, { 2319, 2321, 4340, }, { 6, 1, 1, }, nil, nil, 2409, },
			[20648] = {  nil, 1,  3, 20648,  2319, 100, 100, 105, 110,   1,   1, { 2318, }, { 4, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 8153, 11081, 11084, }, 500, },
			[9070]  = {  nil, 1,  3,  9070,  7283, 100, 125, 137, 150,   1,   1, { 7286, 2319, 2321, }, { 12, 4, 1, }, nil, nil, 7289, },
			[3817]  = {  nil, 1,  3,  3817,  4233, 100, 115, 122, 130,   1,   1, { 4232, 4289, }, { 1, 1, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 8153, 11081, 11084, }, 650, },
			[24940] = {  nil, 1,  3, 24940, 20575, 100, 125, 137, 150,   1,   1, { 2319, 7286, 4231, 2321, }, { 8, 8, 1, 2, }, nil, nil, 20576, },
			[2165]  = {  nil, 1,  3,  2165,  2313, 100, 115, 122, 130,   1,   1, { 2319, 2320, }, { 4, 1, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 8153, 11081, 11084, }, 650, },
			[7133]  = {  nil, 1,  3,  7133,  5958, 105, 130, 142, 155,   1,   1, { 2319, 2997, 2321, }, { 8, 1, 1, }, nil, nil, 5972, },
			[7954]  = {  nil, 1,  3,  7954,  6467, 105, 130, 142, 155,   1,   1, { 6471, 6470, 2321, }, { 2, 6, 2, }, nil, nil, 6475, },
			[2168]  = {  nil, 1,  3,  2168,  2316, 110, 135, 147, 160,   1,   1, { 2319, 2321, 4340, }, { 8, 1, 1, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 8153, 11081, 11084, }, 1000, },
			[7135]  = {  nil, 1,  3,  7135,  5961, 115, 140, 152, 165,   1,   1, { 2319, 4340, 2321, }, { 12, 1, 1, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 8153, 11081, 11084, }, 1000, },
			[7955]  = {  nil, 1,  3,  7955,  6468, 115, 140, 152, 165,   1,   1, { 6471, 6470, 2321, }, { 10, 10, 2, }, nil, nil, 6476, },
			[3765]  = {  nil, 1,  3,  3765,  4248, 120, 155, 167, 180,   1,   1, { 2312, 4233, 2321, 4340, }, { 1, 1, 1, 1, }, nil, nil, 7360, },
			[2166]  = {  nil, 1,  3,  2166,  2314, 120, 145, 157, 170,   1,   1, { 2319, 4231, 2321, }, { 10, 2, 2, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 7866, 7867, 7868, 7869, 8153, 11081, 11084, }, 1400, },
			[9074]  = {  nil, 1,  3,  9074,  7285, 120, 145, 157, 170,   1,   1, { 2457, 2319, 2321, }, { 1, 6, 1, }, { 1385, 3365, 3703, 3967, 4588, 5127, 5564, 8153, 11081, 11084, }, 1400, },
			[3767]  = {  nil, 1,  3,  3767,  4250, 120, 145, 157, 170,   1,   1, { 2319, 3383, 2321, }, { 8, 1, 2, }, nil, nil, 4294, },
			[9072]  = {  nil, 1,  3,  9072,  7284, 120, 145, 157, 170,   1,   1, { 7287, 2319, 2321, }, { 6, 4, 1, }, nil, nil, 7290, },
			[9145]  = {  nil, 1,  3,  9145,  7348, 125, 150, 162, 175,   1,   1, { 2319, 5116, 2321, }, { 8, 4, 2, }, { 3007, 4212, }, 1500, },
			[3766]  = {  nil, 1,  3,  3766,  4249, 125, 150, 162, 175,   1,   1, { 4246, 4233, 2321, 4340, }, { 1, 1, 2, 1, }, { 3007, 4212, }, 1500, },
			[3768]  = {  nil, 1,  3,  3768,  4251, 130, 155, 167, 180,   1,   1, { 4233, 2319, 2321, }, { 1, 4, 1, }, { 3007, 4212, }, 1200, },
			[3770]  = {  nil, 1,  3,  3770,  4253, 135, 160, 172, 185,   1,   1, { 2319, 4233, 3389, 3182, 2321, }, { 4, 2, 2, 2, 2, }, { 3007, 4212, }, 1500, },
			[9146]  = {  nil, 1,  3,  9146,  7349, 135, 160, 172, 185,   1,   1, { 2319, 3356, 2321, }, { 8, 4, 2, }, nil, nil, 7361, },
			[9147]  = {  nil, 1,  3,  9147,  7352, 135, 160, 172, 185,   1,   1, { 2319, 7067, 2321, }, { 6, 1, 2, }, nil, nil, 7362, },
			[3769]  = {  nil, 1,  3,  3769,  4252, 140, 165, 177, 190,   1,   1, { 2319, 3390, 4340, 2321, }, { 12, 1, 1, 2, }, nil, nil, 4296, },
			[9148]  = {  nil, 1,  3,  9148,  7358, 140, 165, 177, 190,   1,   1, { 2319, 5373, 2321, }, { 10, 2, 2, }, nil, nil, 7363, },
			[3764]  = {  nil, 1,  3,  3764,  4247, 145, 170, 182, 195,   1,   1, { 2319, 2321, }, { 14, 4, }, { 3007, 4212, }, 1800, },
			[9149]  = {  nil, 1,  3,  9149,  7359, 145, 170, 182, 195,   1,   1, { 2319, 7067, 2997, 2321, }, { 12, 2, 2, 2, }, nil, nil, 7364, },
			[9194]  = {  nil, 1,  3,  9194,  7372, 150, 170, 180, 190,   1,   1, { 4234, 2321, }, { 8, 2, }, { 3007, 4212, }, 2000, },
			[20649] = {  nil, 1,  3, 20649,  4234, 150, 150, 155, 160,   1,   1, { 2319, }, { 5, }, { 3007, 4212, }, 1800, },
			[23190] = {  nil, 2,  3, 23190, 18662, 150, 150, 155, 160,   1,   1, { 4234, 2321, }, { 2, 1, }, nil, nil, 18731, },
			[3771]  = {  nil, 1,  3,  3771,  4254, 150, 170, 180, 190,   1,   1, { 4234, 5637, 2321, }, { 6, 2, 1, }, nil, nil, 4297, },
			[3818]  = {  nil, 1,  3,  3818,  4236, 150, 160, 165, 170,   1,   1, { 4235, 4289, }, { 1, 3, }, { 3007, 4212, }, 1800, },
			[3760]  = {  nil, 1,  3,  3760,  3719, 150, 170, 180, 190,   1,   1, { 4234, 2321, }, { 5, 2, }, { 3007, 4212, }, 2000, },
			[9193]  = {  nil, 1,  3,  9193,  7371, 150, 170, 180, 190,   1,   1, { 4234, 2321, }, { 8, 2, }, { 3007, 4212, }, 2000, },
			[3780]  = {  nil, 1,  3,  3780,  4265, 150, 170, 180, 190,   1,   1, { 4234, 2321, }, { 5, 1, }, { 3007, 4212, }, 2000, },
			[23399] = {  nil, 1,  3, 23399, 18948, 155, 175, 185, 195,   1,   1, { 4234, 4236, 5498, 4461, 5637, }, { 8, 2, 4, 1, 4, }, nil, nil, 18949, },
			[3772]  = {  nil, 1,  3,  3772,  4255, 155, 175, 185, 195,   1,   1, { 4234, 2605, 2321, }, { 9, 2, 4, }, nil, nil, 7613, },
			[7147]  = {  nil, 1,  3,  7147,  5962, 160, 180, 190, 200,   1,   1, { 4234, 4305, 2321, }, { 12, 2, 2, }, { 3007, 4212, }, 2500, },
			[3774]  = {  nil, 1,  3,  3774,  4257, 160, 180, 190, 200,   1,   1, { 4236, 4234, 2321, 2605, 7071, }, { 1, 5, 1, 1, 1, }, { 3007, 4212, }, 2500, },
			[4096]  = {  nil, 1,  3,  4096,  4455, 165, 185, 195, 205,   1,   1, { 4461, 4234, 2321, }, { 6, 4, 2, }, nil, nil, 13287, },
			[9195]  = {  nil, 1,  3,  9195,  7373, 165, 185, 195, 205,   1,   1, { 4234, 2325, 2321, }, { 10, 1, 2, }, nil, nil, 7449, },
			[4097]  = {  nil, 1,  3,  4097,  4456, 165, 185, 195, 205,   1,   1, { 4461, 4234, 2321, }, { 4, 4, 2, }, nil, nil, 13288, },
			[6704]  = {  nil, 1,  3,  6704,  5782, 170, 190, 200, 210,   1,   1, { 5785, 4236, 4234, 2321, }, { 12, 1, 10, 3, }, nil, nil, 5788, },
			[7149]  = {  nil, 1,  3,  7149,  5963, 170, 190, 200, 210,   1,   1, { 4234, 2321, 1206, }, { 10, 2, 1, }, nil, nil, 5973, },
			[3775]  = {  nil, 1,  3,  3775,  4258, 170, 190, 200, 210,   1,   1, { 4236, 4234, 2321, 7071, }, { 2, 4, 1, 1, }, nil, nil, 4298, },
			[7151]  = {  nil, 1,  3,  7151,  5964, 175, 195, 205, 215,   1,   1, { 4234, 4236, 2321, }, { 8, 1, 2, }, { 3007, 4212, }, 2500, },
			[9196]  = {  nil, 1,  3,  9196,  7374, 175, 195, 205, 215,   1,   1, { 4234, 3824, 2321, }, { 10, 1, 2, }, { 3007, 4212, }, 2500, },
			[9197]  = {  nil, 1,  3,  9197,  7375, 175, 195, 205, 215,   1,   1, { 7392, 4234, 2321, }, { 4, 10, 2, }, nil, nil, 7450, },
			[3773]  = {  nil, 1,  3,  3773,  4256, 175, 195, 205, 215,   1,   1, { 4236, 4234, 3824, 2321, }, { 2, 12, 1, 2, }, nil, nil, 4299, },
			[3776]  = {  nil, 1,  3,  3776,  4259, 180, 200, 210, 220,   1,   1, { 4236, 4234, 2605, 2321, }, { 2, 6, 1, 1, }, { 3007, 4212, }, 2800, },
			[9198]  = {  nil, 1,  3,  9198,  7377, 180, 200, 210, 220,   1,   1, { 4234, 7067, 7070, 2321, }, { 6, 2, 2, 2, }, { 3007, 4212, }, 2800, },
			[3778]  = {  nil, 1,  3,  3778,  4262, 185, 205, 215, 225,   1,   1, { 4236, 5500, 1529, 3864, 2321, }, { 4, 2, 2, 1, 1, }, nil, nil, 14635, },
			[9201]  = {  nil, 1,  3,  9201,  7378, 185, 205, 215, 225,   1,   1, { 4234, 2325, 4291, }, { 16, 1, 2, }, { 3007, 4212, }, 2800, },
			[7153]  = {  nil, 1,  3,  7153,  5965, 185, 205, 215, 225,   1,   1, { 4234, 4305, 4291, }, { 14, 2, 2, }, nil, nil, 5974, },
			[6661]  = {  nil, 1,  3,  6661,  5739, 190, 210, 220, 230,   1,   1, { 4234, 2321, 7071, }, { 14, 2, 1, }, { 3007, 4212, }, 2800, },
			[21943] = {  nil, 1,  3, 21943, 17721, 190, 210, 220, 230,   1,   1, { 4234, 7067, 4291, }, { 8, 4, 1, }, nil, nil, 17722, },
			[6705]  = {  nil, 1,  3,  6705,  5783, 190, 210, 220, 230,   1,   1, { 5785, 4236, 4234, 4291, }, { 16, 1, 14, 1, }, nil, nil, 5789, },
			[9202]  = {  nil, 1,  3,  9202,  7386, 190, 210, 220, 230,   1,   1, { 7392, 4234, 4291, }, { 6, 8, 2, }, nil, nil, 7451, },
			[7156]  = {  nil, 1,  3,  7156,  5966, 190, 210, 220, 230,   1,   1, { 4234, 4236, 4291, }, { 4, 1, 1, }, { 3007, 4212, }, 2800, },
			[3777]  = {  nil, 1,  3,  3777,  4260, 195, 215, 225, 235,   1,   1, { 4234, 4236, 4291, }, { 6, 2, 1, }, nil, nil, 4300, },
			[9206]  = {  nil, 1,  3,  9206,  7387, 195, 215, 225, 235,   1,   1, { 4234, 4305, 2325, 7071, }, { 10, 2, 2, 1, }, { 3007, 4212, }, 2800, },
			[3779]  = {  nil, 1,  3,  3779,  4264, 200, 220, 230, 240,   1,   1, { 4234, 4236, 4096, 5633, 4291, 7071, }, { 6, 2, 2, 1, 1, 1, }, nil, nil, 4301, },
			[10490] = {  nil, 1,  3, 10490,  8174, 200, 220, 230, 240,   1,   1, { 4234, 4236, 4291, }, { 12, 2, 2, }, nil, nil, 8384, },
			[22711] = {  nil, 2,  3, 22711, 18238, 200, 210, 220, 230,   1,   1, { 4304, 7428, 7971, 4236, 1210, 8343, }, { 6, 8, 2, 2, 4, 1, }, nil, nil, 18239, },
			[10487] = {  nil, 1,  3, 10487,  8173, 200, 220, 230, 240,   1,   1, { 4304, 4291, }, { 5, 1, }, { 3007, 4212, }, 3500, },
			[9208]  = {  nil, 1,  3,  9208,  7391, 200, 220, 230, 240,   1,   1, { 4234, 2459, 4337, 4291, }, { 10, 2, 2, 1, }, nil, nil, 7453, },
			[9207]  = {  nil, 1,  3,  9207,  7390, 200, 220, 230, 240,   1,   1, { 4234, 7428, 3824, 4291, }, { 8, 2, 1, 2, }, nil, nil, 7452, },
			[10482] = {  nil, 1,  3, 10482,  8172, 200, 200, 200, 200,   1,   1, { 8169, 8150, }, { 1, 1, }, { 3007, 4212, }, 2800, },
			[20650] = {  nil, 1,  3, 20650,  4304, 200, 200, 202, 205,   1,   1, { 4234, }, { 6, }, { 3007, 4212, }, 2800, },
			[10499] = {  nil, 1,  3, 10499,  8175, 205, 225, 235, 245,   1,   1, { 4304, 4291, }, { 7, 2, }, { 11097, 11098, }, 3500, },
			[10509] = {  nil, 1,  3, 10509,  8187, 205, 225, 235, 245,   1,   1, { 4304, 8167, 8343, }, { 6, 8, 1, }, nil, nil, 8385, },
			[10507] = {  nil, 1,  3, 10507,  8176, 205, 225, 235, 245,   1,   1, { 4304, 4291, }, { 5, 2, }, { 11097, 11098, }, 3500, },
			[10518] = {  nil, 1,  3, 10518,  8198, 210, 230, 240, 250,   1,   1, { 4304, 8167, 8343, }, { 8, 12, 1, }, { 7870, 11097, 11098, }, 4000, },
			[10516] = {  nil, 1,  3, 10516,  8192, 210, 230, 240, 250,   1,   1, { 4304, 4338, 4291, }, { 8, 6, 3, }, nil, nil, 8409, },
			[10511] = {  nil, 1,  3, 10511,  8189, 210, 230, 240, 250,   1,   1, { 4304, 8167, 8343, }, { 6, 12, 1, }, { 7870, 11097, 11098, }, 4000, },
			[10520] = {  nil, 1,  3, 10520,  8200, 215, 235, 245, 255,   1,   1, { 4304, 8151, 8343, }, { 10, 4, 1, }, nil, nil, 8386, },
			[10529] = {  nil, 1,  3, 10529,  8210, 220, 240, 250, 260,   1,   1, { 4304, 8153, 8172, }, { 10, 1, 1, }, nil, nil, 8403, },
			[10533] = {  nil, 1,  3, 10533,  8205, 220, 240, 250, 260,   1,   1, { 4304, 8154, 4291, }, { 10, 4, 2, }, nil, nil, 8397, },
			[10525] = {  nil, 1,  3, 10525,  8203, 220, 240, 250, 260,   1,   1, { 4304, 8154, 4291, }, { 12, 12, 4, }, nil, nil, 8395, },
			[10531] = {  nil, 1,  3, 10531,  8201, 220, 240, 250, 260,   1,   1, { 4304, 8151, 8343, }, { 8, 6, 1, }, nil, nil, 8387, },
			[14930] = {  nil, 1,  3, 14930,  8217, 225, 245, 255, 265,   1,   1, { 4304, 8172, 8949, 4291, }, { 12, 1, 1, 4, }, { 7870, 11097, 11098, }, 4000, },
			[10542] = {  nil, 1,  3, 10542,  8204, 225, 245, 255, 265,   1,   1, { 4304, 8154, 4291, }, { 6, 8, 2, }, nil, nil, 8398, },
			[10621] = {  nil, 1,  3, 10621,  8345, 225, 245, 255, 265,   1,   1, { 4304, 8368, 8146, 8343, 8172, }, { 18, 2, 8, 4, 2, }, { 7870, 7871, }, 9000, },
			[10544] = {  nil, 1,  3, 10544,  8211, 225, 245, 255, 265,   1,   1, { 4304, 8153, 8172, }, { 12, 2, 1, }, nil, nil, 8404, },
			[10619] = {  nil, 1,  3, 10619,  8347, 225, 245, 255, 265,   1,   1, { 4304, 8165, 8343, 8172, }, { 24, 12, 4, 2, }, { 7866, 7867, }, 9000, },
			[10546] = {  nil, 1,  3, 10546,  8214, 225, 245, 255, 265,   1,   1, { 4304, 8153, 8172, }, { 10, 2, 1, }, nil, nil, 8405, },
			[14932] = {  nil, 1,  3, 14932,  8218, 225, 245, 255, 265,   1,   1, { 4304, 8172, 8951, 4291, }, { 10, 1, 1, 6, }, { 7870, 11097, 11098, }, 4000, },
			[10630] = {  nil, 1,  3, 10630,  8346, 230, 250, 260, 270,   1,   1, { 4304, 7079, 7075, 8172, 8343, }, { 20, 8, 2, 1, 4, }, { 7868, 7869, }, 9000, },
			-- [10550] = {  nil, 1,  3, 10550,  8195, 230, 250, 260, 270,   1,   1, { 4304, 4291, }, { 12, 4, }, { 223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 7866, 7867, 7868, 7869, 7870, 11083, 11096, }, 0,  },
			[10552] = {  nil, 1,  3, 10552,  8191, 230, 250, 260, 270,   1,   1, { 4304, 8167, 8343, }, { 14, 24, 1, }, { 7870, 11097, 11098, }, 4300, },
			[10558] = {  nil, 1,  3, 10558,  8197, 235, 255, 265, 275,   1,   1, { 4304, 8343, }, { 16, 2, }, { 7870, 11097, 11098, }, 4600, },
			[10554] = {  nil, 1,  3, 10554,  8209, 235, 255, 265, 275,   1,   1, { 4304, 8154, 4291, }, { 12, 12, 6, }, nil, nil, 8399, },
			[10548] = {  nil, 1,  3, 10548,  8193, 230, 250, 260, 270,   1,   1, { 4304, 4291, }, { 14, 4, }, { 7870, 11097, 11098, }, 4600, },
			[10556] = {  nil, 1,  3, 10556,  8185, 235, 255, 265, 275,   1,   1, { 4304, 8167, 8343, }, { 14, 28, 1, }, { 7870, 11097, 11098, }, 4600, },
			[10564] = {  nil, 1,  3, 10564,  8207, 240, 260, 270, 280,   1,   1, { 4304, 8154, 8343, }, { 12, 16, 2, }, nil, nil, 8400, },
			[10560] = {  nil, 1,  3, 10560,  8202, 240, 260, 270, 280,   1,   1, { 4304, 8152, 8343, }, { 10, 6, 2, }, nil, nil, 8389, },
			[10562] = {  nil, 1,  3, 10562,  8216, 240, 260, 270, 280,   1,   1, { 4304, 8152, 8343, }, { 14, 4, 2, }, nil, nil, 8390, },
			[10566] = {  nil, 1,  3, 10566,  8213, 245, 265, 275, 285,   1,   1, { 4304, 8153, 8172, }, { 14, 4, 2, }, nil, nil, 8406, },
			[10568] = {  nil, 1,  3, 10568,  8206, 245, 265, 275, 285,   1,   1, { 4304, 8154, 8343, }, { 14, 8, 2, }, nil, nil, 8401, },
			[10572] = {  nil, 1,  3, 10572,  8212, 250, 270, 280, 290,   1,   1, { 4304, 8153, 8172, }, { 16, 6, 2, }, nil, nil, 8407, },
			[10632] = {  nil, 1,  3, 10632,  8348, 250, 270, 280, 290,   1,   1, { 4304, 7077, 7075, 8172, 8343, }, { 40, 8, 4, 2, 4, }, { 7868, 7869, }, 0, },
			[10570] = {  nil, 1,  3, 10570,  8208, 250, 270, 280, 290,   1,   1, { 4304, 8154, 8343, }, { 10, 20, 2, }, nil, nil, 8402, },
			[10647] = {  nil, 1,  3, 10647,  8349, 250, 270, 280, 290,   1,   1, { 4304, 8168, 7971, 8172, 8343, }, { 40, 40, 2, 4, 4, }, { 7870, 7871, 11097, 11098, }, 5500, },
			[19047] = {  nil, 1,  3, 19047, 15407, 250, 250, 255, 260,   1,   1, { 8171, 15409, }, { 1, 1, }, { 7870, 11097, 11098, }, 4300, },
			[10574] = {  nil, 1,  3, 10574,  8215, 250, 270, 280, 290,   1,   1, { 4304, 8153, 8172, }, { 16, 6, 2, }, nil, nil, 8408, },
			[19058] = {  nil, 1,  3, 19058, 15564, 250, 250, 260, 270,   1,   1, { 8170, }, { 5, }, { 7870, 11097, 11098, }, 4300, },
			[22331] = {  nil, 1,  3, 22331,  8170, 250, 250, 250, 250,   1,   1, { 4304, }, { 6, }, { 11097, 11098, }, 4300, },
			[19048] = {  nil, 1,  3, 19048, 15077, 255, 275, 285, 295,   1,   1, { 8170, 15408, 14341, }, { 4, 4, 1, }, nil, nil, 15724, },
			[10650] = {  nil, 1,  3, 10650,  8367, 255, 275, 285, 295,   1,   1, { 4304, 8165, 8343, 8172, }, { 40, 30, 4, 4, }, { 7866, 7867, }, 0, },
			[19050] = {  nil, 1,  3, 19050, 15045, 260, 280, 290, 300,   1,   1, { 8170, 15412, 14341, }, { 20, 25, 2, }, nil, nil, 15726, },
			[19049] = {  nil, 1,  3, 19049, 15083, 260, 280, 290, 300,   1,   1, { 8170, 2325, 14341, }, { 8, 1, 1, }, nil, nil, 15725, },
			[19053] = {  nil, 1,  3, 19053, 15074, 265, 285, 295, 305,   1,   1, { 8170, 15423, 14341, }, { 6, 6, 1, }, nil, nil, 15729, },
			[19051] = {  nil, 1,  3, 19051, 15076, 265, 285, 295, 305,   1,   1, { 8170, 15408, 14341, }, { 6, 6, 1, }, nil, nil, 15727, },
			[19052] = {  nil, 1,  3, 19052, 15084, 265, 285, 295, 305,   1,   1, { 8170, 2325, 14341, }, { 8, 1, 1, }, nil, nil, 15728, },
			[19055] = {  nil, 1,  3, 19055, 15091, 270, 290, 300, 310,   1,   1, { 8170, 14047, 14341, }, { 10, 6, 1, }, nil, nil, 15731, },
			[19062] = {  nil, 1,  3, 19062, 15067, 270, 290, 300, 310,   1,   1, { 8170, 15420, 1529, 14341, }, { 24, 80, 2, 1, }, nil, nil, 15735, },
			[19060] = {  nil, 1,  3, 19060, 15046, 270, 290, 300, 310,   1,   1, { 8170, 15412, 14341, }, { 20, 25, 1, }, nil, nil, 15733, },
			[19059] = {  nil, 1,  3, 19059, 15054, 270, 290, 300, 310,   1,   1, { 8170, 7078, 7075, 14341, }, { 6, 1, 1, 1, }, nil, nil, 15732, },
			[19061] = {  nil, 1,  3, 19061, 15061, 270, 290, 300, 310,   1,   1, { 8170, 12803, 14341, }, { 12, 4, 1, }, nil, nil, 15734, },
			[19067] = {  nil, 1,  3, 19067, 15057, 275, 295, 305, 315,   1,   1, { 8170, 7080, 7082, 14341, }, { 16, 2, 2, 1, }, nil, nil, 15741, },
			[19064] = {  nil, 1,  3, 19064, 15078, 275, 295, 305, 315,   1,   1, { 8170, 15408, 14341, }, { 6, 8, 1, }, nil, nil, 15738, },
			[19065] = {  nil, 1,  3, 19065, 15092, 275, 295, 305, 315,   1,   1, { 8170, 7971, 14047, 14341, }, { 6, 1, 6, 1, }, nil, nil, 15739, },
			[19063] = {  nil, 1,  3, 19063, 15073, 275, 295, 305, 315,   1,   1, { 8170, 15423, 14341, }, { 4, 8, 1, }, nil, nil, 15737, },
			[19066] = {  nil, 1,  3, 19066, 15071, 275, 295, 305, 315,   1,   1, { 8170, 15422, 14341, }, { 4, 6, 1, }, nil, nil, 15740, },
			[19068] = {  nil, 1,  3, 19068, 15064, 275, 295, 305, 315,   1,   1, { 8170, 15419, 14341, }, { 28, 12, 1, }, nil, nil, 20253, },
			[19073] = {  nil, 1,  3, 19073, 15072, 280, 300, 310, 320,   1,   1, { 8170, 15423, 14341, }, { 8, 8, 1, }, nil, nil, 15746, },
			[19072] = {  nil, 1,  3, 19072, 15093, 280, 300, 310, 320,   1,   1, { 8170, 14047, 14341, }, { 12, 10, 1, }, nil, nil, 15745, },
			[19071] = {  nil, 1,  3, 19071, 15086, 280, 300, 310, 320,   1,   1, { 8170, 2325, 14341, }, { 12, 1, 1, }, nil, nil, 15744, },
			[19070] = {  nil, 1,  3, 19070, 15082, 280, 300, 310, 320,   1,   1, { 8170, 15408, 14341, }, { 6, 8, 1, }, nil, nil, 15743, },
			[24655] = {  nil, 1,  3, 24655, 20296, 280, 300, 310, 320,   1,   1, { 8170, 15412, 15407, 14341, }, { 20, 30, 1, 2, }, { 7866, 7867, }, 0, },
			[19080] = {  nil, 1,  3, 19080, 15065, 285, 305, 315, 325,   1,   1, { 8170, 15419, 14341, }, { 24, 14, 1, }, nil, nil, 20254, },
			[19074] = {  nil, 1,  3, 19074, 15069, 285, 305, 315, 325,   1,   1, { 8170, 15422, 14341, }, { 6, 8, 1, }, nil, nil, 15747, },
			[19078] = {  nil, 1,  3, 19078, 15060, 285, 305, 315, 325,   1,   1, { 8170, 12803, 15407, 14341, }, { 16, 6, 1, 1, }, nil, nil, 15752, },
			[19079] = {  nil, 1,  3, 19079, 15056, 285, 305, 315, 325,   1,   1, { 8170, 7080, 7082, 15407, 14341, }, { 16, 3, 3, 1, 1, }, nil, nil, 15753, },
			[22815] = {  nil, 1,  3, 22815, 18258, 285, 285, 290, 295,   1,   1, { 8170, 14048, 18240, 14341, }, { 4, 2, 1, 1, }, nil, nil, nil, { 5518, }, },
			[19076] = {  nil, 1,  3, 19076, 15053, 285, 305, 315, 325,   1,   1, { 8170, 7078, 7076, 14341, }, { 8, 1, 1, 1, }, nil, nil, 15749, },
			[19077] = {  nil, 1,  3, 19077, 15048, 285, 305, 315, 325,   1,   1, { 8170, 15415, 15407, 14341, }, { 28, 30, 1, 1, }, nil, nil, 15751, },
			[19075] = {  nil, 1,  3, 19075, 15079, 285, 305, 315, 325,   1,   1, { 8170, 15408, 14341, }, { 8, 12, 1, }, nil, nil, 15748, },
			[19086] = {  nil, 1,  3, 19086, 15066, 290, 310, 320, 330,   1,   1, { 8170, 15420, 1529, 15407, 14341, }, { 40, 120, 1, 1, 1, }, nil, nil, 15760, },
			[19084] = {  nil, 1,  3, 19084, 15063, 290, 310, 320, 330,   1,   1, { 8170, 15417, 14341, }, { 30, 8, 1, }, nil, nil, 15758, },
			[19081] = {  nil, 1,  3, 19081, 15075, 290, 310, 320, 330,   1,   1, { 8170, 15423, 14341, }, { 10, 10, 1, }, nil, nil, 15755, },
			[23703] = {  nil, 3,  3, 23703, 19044, 290, 310, 320, 330,   1,   1, { 8170, 12804, 12803, 15407, 14341, }, { 30, 2, 4, 2, 2, }, nil, nil, 19326, },
			[23705] = {  nil, 3,  3, 23705, 19052, 290, 310, 320, 330,   1,   1, { 8170, 12809, 7080, 15407, 14341, }, { 30, 2, 4, 2, 2, }, nil, nil, 19328, },
			[19082] = {  nil, 1,  3, 19082, 15094, 290, 310, 320, 330,   1,   1, { 8170, 14047, 14341, }, { 14, 10, 1, }, nil, nil, 15756, },
			[19085] = {  nil, 1,  3, 19085, 15050, 290, 310, 320, 330,   1,   1, { 8170, 15416, 15407, 14341, }, { 40, 60, 1, 2, }, nil, nil, 15759, },
			[19083] = {  nil, 1,  3, 19083, 15087, 290, 310, 320, 330,   1,   1, { 8170, 15407, 2325, 14341, }, { 16, 1, 3, 1, }, nil, nil, 15757, },
			[20853] = {  nil, 1,  3, 20853, 16982, 295, 315, 325, 335,   1,   1, { 17012, 17010, 17011, 14341, }, { 20, 6, 2, 2, }, nil, nil, 17022, },
			[19088] = {  nil, 1,  3, 19088, 15080, 295, 315, 325, 335,   1,   1, { 8170, 15408, 15407, 14341, }, { 8, 12, 1, 1, }, nil, nil, 15762, },
			[19089] = {  nil, 1,  3, 19089, 15049, 295, 315, 325, 335,   1,   1, { 8170, 15415, 12810, 15407, 14341, }, { 28, 30, 2, 1, 1, }, nil, nil, 15763, },
			[19090] = {  nil, 1,  3, 19090, 15058, 295, 315, 325, 335,   1,   1, { 8170, 7080, 7082, 12810, 14341, }, { 12, 3, 3, 2, 1, }, nil, nil, 15764, },
			[19087] = {  nil, 1,  3, 19087, 15070, 295, 315, 325, 335,   1,   1, { 8170, 15422, 14341, }, { 6, 10, 1, }, nil, nil, 15761, },
			[24846] = {  nil, 5,  3, 24846, 20481, 300, 320, 330, 340,   1,   1, { 20500, 20498, 7078, }, { 1, 20, 2, }, nil, nil, 20506, },
			[19094] = {  nil, 1,  3, 19094, 15051, 300, 320, 330, 340,   1,   1, { 8170, 15416, 12810, 15407, 14341, }, { 44, 45, 2, 1, 1, }, nil, nil, 15770, },
			[24121] = {  nil, 4,  3, 24121, 19685, 300, 320, 330, 340,   1,   1, { 19767, 15407, 12803, 14341, }, { 14, 5, 4, 4, }, nil, nil, 19769, },
			[19092] = {  nil, 1,  3, 19092, 15088, 300, 320, 330, 340,   1,   1, { 8170, 2325, 14341, }, { 14, 2, 2, }, nil, nil, 15768, },
			[19100] = {  nil, 1,  3, 19100, 15081, 300, 320, 330, 340,   1,   1, { 8170, 15408, 15407, 14341, }, { 14, 14, 1, 2, }, nil, nil, 15774, },
			[23708] = {  nil, 3,  3, 23708, 19157, 300, 320, 330, 340,   1,   1, { 17010, 17011, 17012, 12607, 15407, 14227, }, { 5, 2, 4, 4, 4, 4, }, nil, nil, 19331, },
			[23706] = {  nil, 3,  3, 23706, 19058, 300, 320, 330, 340,   1,   1, { 12810, 12803, 12809, 15407, 14341, }, { 8, 4, 4, 2, 2, }, nil, nil, 19329, },
			[24850] = {  nil, 5,  3, 24850, 20477, 300, 320, 330, 340,   1,   1, { 20501, 20498, 18512, 15407, }, { 2, 30, 2, 1, }, nil, nil, 20510, },
			[19091] = {  nil, 1,  3, 19091, 15095, 300, 320, 330, 340,   1,   1, { 8170, 14047, 12810, 14341, }, { 18, 12, 2, 1, }, nil, nil, 15765, },
			[28219] = {  nil, 6,  3, 28219, 22661, 300, 320, 330, 340,   1,   1, { 22682, 12810, 7080, 15407, 14227, }, { 7, 16, 2, 4, 4, }, { 16365, }, 0, nil, { 9233, }, },
			[19098] = {  nil, 1,  3, 19098, 15085, 300, 320, 330, 340,   1,   1, { 8170, 15407, 14256, 2325, 14341, }, { 20, 2, 6, 4, 2, }, nil, nil, 15773, },
			[24848] = {  nil, 5,  3, 24848, 20479, 300, 320, 330, 340,   1,   1, { 20500, 20498, 7078, 15407, }, { 3, 40, 2, 2, }, nil, nil, 20508, },
			[24849] = {  nil, 5,  3, 24849, 20476, 300, 320, 330, 340,   1,   1, { 20501, 20498, 18512, }, { 1, 20, 2, }, nil, nil, 20509, },
			[24851] = {  nil, 5,  3, 24851, 20478, 300, 320, 330, 340,   1,   1, { 20501, 20498, 18512, 15407, }, { 3, 40, 2, 2, }, nil, nil, 20511, },
			[28220] = {  nil, 6,  3, 28220, 22662, 300, 320, 330, 340,   1,   1, { 22682, 12810, 7080, 15407, 14227, }, { 5, 12, 2, 3, 4, }, { 16365, }, 0, nil, { 9233, }, },
			[28224] = {  nil, 6,  3, 28224, 22665, 300, 320, 330, 340,   1,   1, { 22682, 15408, 7080, 15407, 14227, }, { 4, 16, 2, 2, 4, }, { 16365, }, 0, nil, { 9233, }, },
			[28472] = {  nil, 6,  3, 28472, 22759, 300, 320, 330, 340,   1,   1, { 12810, 19726, 12803, 15407, }, { 12, 2, 2, 2, }, nil, nil, 22771, },
			[28221] = {  nil, 6,  3, 28221, 22663, 300, 320, 330, 340,   1,   1, { 22682, 12810, 7080, 15407, 14227, }, { 4, 12, 2, 2, 4, }, { 16365, }, 0, nil, { 9233, }, },
			[28223] = {  nil, 6,  3, 28223, 22666, 300, 320, 330, 340,   1,   1, { 22682, 15408, 7080, 15407, 14227, }, { 5, 16, 2, 3, 4, }, { 16365, }, 0, nil, { 9233, }, },
			[28473] = {  nil, 6,  3, 28473, 22760, 300, 320, 330, 340,   1,   1, { 12810, 18512, 12803, 15407, }, { 6, 2, 2, 2, }, nil, nil, 22770, },
			[28222] = {  nil, 6,  3, 28222, 22664, 300, 320, 330, 340,   1,   1, { 22682, 15408, 7080, 15407, 14227, }, { 7, 24, 2, 4, 4, }, { 16365, }, 0, nil, { 9233, }, },
			[23704] = {  nil, 3,  3, 23704, 19049, 300, 320, 330, 340,   1,   1, { 12810, 12804, 12803, 15407, 14227, }, { 8, 6, 6, 2, 2, }, nil, nil, 19327, },
			[24703] = {  nil, 5,  3, 24703, 20380, 300, 320, 330, 340,   1,   1, { 12810, 20381, 12803, 15407, 14227, }, { 12, 6, 4, 4, 6, }, nil, nil, 20382, },
			[24123] = {  nil, 4,  3, 24123, 19687, 300, 320, 330, 340,   1,   1, { 19767, 15407, 12803, 14341, }, { 8, 3, 4, 3, }, nil, nil, 19771, },
			[22727] = {  nil, 1,  3, 22727, 18251, 300, 320, 330, 340,   1,   1, { 17012, 14341, }, { 3, 2, }, nil, nil, 18252, },
			[23707] = {  nil, 3,  3, 23707, 19149, 300, 320, 330, 340,   1,   1, { 17011, 15407, 14227, }, { 5, 4, 4, }, nil, nil, 19330, },
			[20855] = {  nil, 1,  3, 20855, 16984, 300, 320, 330, 340,   1,   1, { 12810, 15416, 17010, 17011, 14341, }, { 6, 30, 4, 3, 2, }, nil, nil, 17025, },
			[22928] = {  nil, 2,  3, 22928, 18511, 300, 320, 330, 340,   1,   1, { 8170, 7082, 12753, 12809, 15407, 14341, }, { 30, 12, 4, 8, 4, 8, }, nil, nil, 18519, },
			[20854] = {  nil, 1,  3, 20854, 16983, 300, 320, 330, 340,   1,   1, { 17012, 17010, 17011, 14341, }, { 15, 3, 6, 2, }, nil, nil, 17023, },
			[22926] = {  nil, 2,  3, 22926, 18509, 300, 320, 330, 340,   1,   1, { 8170, 12607, 15416, 15414, 15407, 14341, }, { 30, 12, 30, 30, 5, 8, }, nil, nil, 18517, },
			[26279] = {  nil, 5,  3, 26279, 21278, 300, 320, 330, 340,   1,   1, { 12810, 7080, 7082, 15407, 14227, }, { 6, 4, 4, 2, 2, }, nil, nil, 21548, },
			[22923] = {  nil, 2,  3, 22923, 18508, 300, 320, 330, 340,   1,   1, { 8170, 18512, 15420, 15407, 14341, }, { 12, 8, 60, 4, 4, }, nil, nil, 18516, },
			[22922] = {  nil, 2,  3, 22922, 18506, 300, 320, 330, 340,   1,   1, { 8170, 7082, 11754, 15407, 14341, }, { 12, 6, 4, 2, 4, }, nil, nil, 18515, },
			[24124] = {  nil, 4,  3, 24124, 19688, 300, 320, 330, 340,   1,   1, { 19768, 19726, 15407, 14341, }, { 35, 2, 3, 3, }, nil, nil, 19772, },
			[24847] = {  nil, 5,  3, 24847, 20480, 300, 320, 330, 340,   1,   1, { 20500, 20498, 7078, 15407, }, { 2, 30, 2, 1, }, nil, nil, 20507, },
			[24125] = {  nil, 4,  3, 24125, 19689, 300, 320, 330, 340,   1,   1, { 19768, 19726, 15407, 14341, }, { 25, 2, 3, 3, }, nil, nil, 19773, },
			[22921] = {  nil, 2,  3, 22921, 18504, 300, 320, 330, 340,   1,   1, { 8170, 12804, 15407, 14341, }, { 12, 12, 2, 4, }, nil, nil, 18514, },
			[24122] = {  nil, 4,  3, 24122, 19686, 300, 320, 330, 340,   1,   1, { 19767, 15407, 12803, 14341, }, { 10, 4, 4, 3, }, nil, nil, 19770, },
			[28474] = {  nil, 5,  3, 28474, 22761, 300, 320, 330, 340,   1,   1, { 12810, 12803, 15407, }, { 4, 2, 1, }, nil, nil, 22769, },
			[19102] = {  nil, 1,  3, 19102, 15090, 300, 320, 330, 340,   1,   1, { 8170, 12810, 14047, 15407, 14341, }, { 22, 4, 16, 1, 2, }, nil, nil, 15776, },
			[19101] = {  nil, 1,  3, 19101, 15055, 300, 320, 330, 340,   1,   1, { 8170, 7078, 7076, 14341, }, { 10, 1, 1, 2, }, nil, nil, 15775, },
			[22927] = {  nil, 2,  3, 22927, 18510, 300, 320, 330, 340,   1,   1, { 8170, 12803, 7080, 18512, 15407, 14341, }, { 30, 12, 10, 8, 3, 8, }, nil, nil, 18518, },
			[19093] = {  nil, 1,  3, 19093, 15138, 300, 320, 330, 340,   1,   1, { 15410, 14044, 14341, }, { 1, 1, 1, }, nil, nil, nil, { 7493, 7497, }, },
			[19104] = {  nil, 1,  3, 19104, 15068, 300, 320, 330, 340,   1,   1, { 8170, 15422, 15407, 14341, }, { 12, 12, 1, 2, }, nil, nil, 15779, },
			[19097] = {  nil, 1,  3, 19097, 15062, 300, 320, 330, 340,   1,   1, { 8170, 15417, 15407, 14341, }, { 30, 14, 1, 1, }, nil, nil, 15772, },
			[19107] = {  nil, 1,  3, 19107, 15052, 300, 320, 330, 340,   1,   1, { 8170, 15416, 12810, 15407, 14341, }, { 40, 60, 4, 1, 2, }, nil, nil, 15781, },
			[23710] = {  nil, 3,  3, 23710, 19163, 300, 320, 330, 340,   1,   1, { 17010, 17011, 7076, 15407, 14227, }, { 2, 7, 6, 4, 4, }, nil, nil, 19333, },
			[19103] = {  nil, 1,  3, 19103, 15096, 300, 320, 330, 340,   1,   1, { 8170, 12810, 14047, 15407, 14341, }, { 16, 4, 18, 1, 2, }, nil, nil, 15777, },
			[19095] = {  nil, 1,  3, 19095, 15059, 300, 320, 330, 340,   1,   1, { 8170, 12803, 14342, 15407, 14341, }, { 16, 8, 2, 1, 2, }, nil, nil, 15771, },
			[23709] = {  nil, 3,  3, 23709, 19162, 300, 320, 330, 340,   1,   1, { 17010, 17012, 12810, 15407, 14227, }, { 8, 12, 10, 4, 4, }, nil, nil, 19332, },
			[19054] = {  nil, 1,  3, 19054, 15047, 300, 320, 330, 340,   1,   1, { 8170, 15414, 14341, }, { 40, 30, 1, }, nil, nil, 15730, },
			[24654] = {  nil, 1,  3, 24654, 20295, 300, 320, 330, 340,   1,   1, { 8170, 15415, 15407, 14341, }, { 28, 36, 2, 2, }, { 7866, 7867, }, 0, },
			[19106] = {  nil, 1,  3, 19106, 15141, 300, 320, 330, 340,   1,   1, { 8170, 15410, 15416, 14341, }, { 40, 12, 60, 2, }, },
			[11447] = {  nil, 1,  4, 11447,  8827,   1, 190, 210, 230,   1,   1, { 6370, 3357, 3372, }, { 1, 1, 1, }, },
			[22430] = {  nil, 1,  4, 22430, 17967,   1, 315, 322, 330,   1,   1, { 15410, }, { 1, }, },
			[7183]  = {  nil, 1,  4,  7183,  5997,   1,  55,  75,  95,   1,   1, { 765, 3371, }, { 2, 1, }, },
			[2330]  = {  nil, 1,  4,  2330,   118,   1,  55,  75,  95,   1,   1, { 2447, 765, 3371, }, { 1, 1, 1, }, },
			[2329]  = {  nil, 1,  4,  2329,  2454,   1,  55,  75,  95,   1,   1, { 2449, 765, 3371, }, { 1, 1, 1, }, },
			[3170]  = {  nil, 1,  4,  3170,  3382,  15,  60,  80, 100,   1,   1, { 2447, 2449, 3371, }, { 1, 2, 1, }, { 1215, 1246, 1386, 1470, 2132, 2391, 2837, 3184, 3347, 3603, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 5500, 7948, 11041, 11042, 11044, 11046, 11047, }, 50, },
			[2331]  = {  nil, 1,  4,  2331,  2455,  25,  65,  85, 105,   1,   1, { 785, 765, 3371, }, { 1, 1, 1, }, { 1215, 1246, 1386, 1470, 2132, 2391, 2837, 3184, 3347, 3603, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 5500, 7948, 11041, 11042, 11044, 11046, 11047, }, 100, },
			[2332]  = {  nil, 1,  4,  2332,  2456,  40,  70,  90, 110,   1,   1, { 785, 2447, 3371, }, { 2, 1, 1, }, { 1215, 1246, 1386, 1470, 2132, 2391, 2837, 3184, 3347, 3603, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 5500, 7948, 11041, 11042, 11044, 11046, 11047, }, 150, },
			[4508]  = {  nil, 1,  4,  4508,  4596,  50,  80, 100, 120,   1,   1, { 3164, 2447, 3371, }, { 1, 1, 1, }, nil, nil, 4597, },
			[2334]  = {  nil, 1,  4,  2334,  2458,  50,  80, 100, 120,   1,   1, { 2449, 2447, 3371, }, { 2, 1, 1, }, { 1215, 1246, 1386, 1470, 2132, 2391, 2837, 3184, 3347, 3603, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 5500, 7948, 11041, 11042, 11044, 11046, 11047, }, 250, },
			[3230]  = {  nil, 1,  4,  3230,  2457,  50,  80, 100, 120,   1,   1, { 2452, 765, 3371, }, { 1, 1, 1, }, nil, nil, 2553, },
			[2337]  = {  nil, 1,  4,  2337,   858,  55,  85, 105, 125,   1,   1, { 118, 2450, }, { 1, 1, }, { 1215, 1246, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 3603, 3964, 4609, 4900, 5177, 5499, 5500, 11041, 11042, 11044, 11046, 11047, }, 1000, },
			[6617]  = {  nil, 1,  4,  6617,  5631,  60,  90, 110, 130,   1,   1, { 5635, 2450, 3371, }, { 1, 1, 1, }, nil, nil, 5640, },
			[2335]  = {  nil, 1,  4,  2335,  2459,  60,  90, 110, 130,   1,   1, { 2452, 2450, 3371, }, { 1, 1, 1, }, nil, nil, 2555, },
			[2336]  = {  nil, 1,  4,  2336,  2460,  70, 100, 120, 140,   1,   1, { 2449, 785, 3371, }, { 2, 2, 1, }, },
			[7836]  = {  nil, 1,  4,  7836,  6370,  80,  80,  90, 100,   1,   1, { 6358, 3371, }, { 2, 1, }, { 1386, 2391, 2837, 3009, 3347, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 7948, 11042, }, 250, },
			[8240]  = {  nil, 1,  4,  8240,  6662,  90, 120, 140, 160,   1,   1, { 6522, 2449, 3371, }, { 1, 1, 1, }, nil, nil, 6663, },
			[3171]  = {  nil, 1,  4,  3171,  3383,  90, 120, 140, 160,   1,   1, { 785, 2450, 3371, }, { 1, 2, 1, }, { 1386, 2391, 2837, 3009, 3347, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 7948, 11042, }, 500, },
			[7179]  = {  nil, 1,  4,  7179,  5996,  90, 120, 140, 160,   1,   1, { 3820, 6370, 3371, }, { 1, 2, 1, }, { 1386, 2391, 2837, 3009, 3347, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 7948, 11042, }, 450, },
			[7255]  = {  nil, 1,  4,  7255,  6051, 100, 130, 150, 170,   1,   1, { 2453, 2452, 3371, }, { 1, 1, 1, }, nil, nil, 6053, },
			[7841]  = {  nil, 1,  4,  7841,  6372, 100, 130, 150, 170,   1,   1, { 2452, 6370, 3371, }, { 1, 1, 1, }, { 1386, 2391, 2837, 3009, 3347, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 7948, 11042, }, 1000, },
			[3172]  = {  nil, 1,  4,  3172,  3384, 110, 135, 155, 175,   1,   1, { 785, 3355, 3371, }, { 3, 1, 1, }, nil, nil, 3393, },
			[3447]  = {  nil, 1,  4,  3447,   929, 110, 135, 155, 175,   1,   1, { 2453, 2450, 3372, }, { 1, 1, 1, }, { 1386, 2391, 2837, 3009, 3347, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 7948, 11042, }, 4000, },
			[3173]  = {  nil, 1,  4,  3173,  3385, 120, 145, 165, 185,   1,   1, { 785, 3820, 3371, }, { 1, 1, 1, }, { 1386, 2391, 2837, 3009, 3347, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 7948, 11042, }, 150, },
			[3174]  = {  nil, 1,  4,  3174,  3386, 120, 145, 165, 185,   1,   1, { 1288, 2453, 3372, }, { 1, 1, 1, }, nil, nil, 3394, },
			[3176]  = {  nil, 1,  4,  3176,  3388, 125, 150, 170, 190,   1,   1, { 2453, 2450, 3372, }, { 2, 2, 1, }, { 1386, 2391, 2837, 3009, 3347, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 7948, 11042, }, 1500, },
			[6619]  = {  nil, 1,  4,  6619,  5632, 125, 150, 170, 190,   1,   1, { 5636, 3356, 3372, }, { 1, 1, 1, }, },
			[7837]  = {  nil, 1,  4,  7837,  6371, 130, 150, 160, 170,   1,   1, { 6359, 3371, }, { 2, 1, }, { 1386, 2391, 2837, 3009, 3347, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 7948, 11042, }, 1000, },
			[3177]  = {  nil, 1,  4,  3177,  3389, 130, 155, 175, 195,   1,   1, { 3355, 3820, 3372, }, { 1, 1, 1, }, { 1386, 2391, 2837, 3009, 3347, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 7948, 11042, }, 2000, },
			[7256]  = {  nil, 1,  4,  7256,  6048, 135, 160, 180, 200,   1,   1, { 3369, 3356, 3372, }, { 1, 1, 1, }, nil, nil, 6054, },
			[2333]  = {  nil, 1,  4,  2333,  3390, 140, 165, 185, 205,   1,   1, { 3355, 2452, 3372, }, { 1, 1, 1, }, nil, nil, 3396, },
			[7845]  = {  nil, 1,  4,  7845,  6373, 140, 165, 185, 205,   1,   1, { 6371, 3356, 3372, }, { 2, 1, 1, }, { 1386, 2391, 2837, 3009, 3347, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 7948, 11042, }, 3000, },
			[3188]  = {  nil, 1,  4,  3188,  3391, 150, 175, 195, 215,   1,   1, { 2449, 3356, 3372, }, { 1, 1, 1, }, nil, nil, 6211, },
			[6624]  = {  nil, 1,  4,  6624,  5634, 150, 175, 195, 215,   1,   1, { 6370, 3820, 3372, }, { 2, 1, 1, }, nil, nil, 5642, },
			[7181]  = {  nil, 1,  4,  7181,  1710, 155, 175, 195, 215,   1,   1, { 3357, 3356, 3372, }, { 1, 1, 1, }, { 1386, 4160, 4611, 7948, }, 4500, },
			[3452]  = {  nil, 1,  4,  3452,  3827, 160, 180, 200, 220,   1,   1, { 3820, 3356, 3372, }, { 1, 1, 1, }, { 1386, 4160, 4611, 7948, }, 4500, },
			[7257]  = {  nil, 1,  4,  7257,  6049, 165, 210, 230, 250,   1,   1, { 4402, 6371, 3372, }, { 1, 1, 1, }, nil, nil, 6055, },
			[3448]  = {  nil, 1,  4,  3448,  3823, 165, 185, 205, 225,   1,   1, { 3818, 3355, 3372, }, { 1, 1, 1, }, { 1386, 4160, 4611, 7948, }, 4500, },
			[3449]  = {  nil, 1,  4,  3449,  3824, 165, 190, 210, 230,   1,   1, { 3818, 3369, 3372, }, { 4, 4, 1, }, nil, nil, 6068, },
			[6618]  = {  nil, 1,  4,  6618,  5633, 175, 195, 215, 235,   1,   1, { 5637, 3356, 3372, }, { 1, 1, 1, }, nil, nil, 5643, },
			[3450]  = {  nil, 1,  4,  3450,  3825, 175, 195, 215, 235,   1,   1, { 3355, 3821, 3372, }, { 1, 1, 1, }, { 1386, 4160, 4611, 7948, }, 6000, 3830, },
			[3451]  = {  nil, 1,  4,  3451,  3826, 180, 200, 220, 240,   1,   1, { 3357, 2453, 3372, }, { 1, 1, 1, }, nil, nil, 3831, },
			[11449] = {  nil, 1,  4, 11449,  8949, 185, 205, 225, 245,   1,   1, { 3820, 3821, 3372, }, { 1, 1, 1, }, { 1386, 4160, 4611, 7948, }, 5850, },
			[21923] = {  nil, 1,  4, 21923, 17708, 190, 210, 230, 250,   1,   1, { 3819, 3358, 3372, }, { 2, 1, 1, }, nil, nil, 17709, },
			[7258]  = {  nil, 1,  4,  7258,  6050, 190, 205, 225, 245,   1,   1, { 3819, 3821, 3372, }, { 1, 1, 1, }, nil, nil, 6056, },
			[7259]  = {  nil, 1,  4,  7259,  6052, 190, 210, 230, 250,   1,   1, { 3357, 3820, 3372, }, { 1, 1, 1, }, nil, nil, 6057, },
			[3453]  = {  nil, 1,  4,  3453,  3828, 195, 215, 235, 255,   1,   1, { 3358, 3818, 3372, }, { 1, 1, 1, }, nil, nil, 3832, },
			[11450] = {  nil, 1,  4, 11450,  8951, 195, 215, 235, 255,   1,   1, { 3355, 3821, 3372, }, { 1, 1, 1, }, { 1386, 4160, 4611, 7948, }, 6750, },
			[3454]  = {  nil, 1,  4,  3454,  3829, 200, 220, 240, 260,   1,   1, { 3358, 3819, 3372, }, { 4, 2, 1, }, nil, nil, 14634, },
			[12609] = {  nil, 1,  4, 12609, 10592, 200, 220, 240, 260,   1,   1, { 3821, 3818, 3372, }, { 1, 1, 1, }, { 1386, 4160, 4611, 7948, }, 7200, },
			[11448] = {  nil, 1,  4, 11448,  6149, 205, 220, 240, 260,   1,   1, { 3358, 3821, 3372, }, { 1, 1, 1, }, { 1386, 4160, 4611, 7948, }, 8100, },
			[11451] = {  nil, 1,  4, 11451,  8956, 205, 220, 240, 260,   1,   1, { 4625, 3821, 8925, }, { 1, 1, 1, }, { 1386, 4160, 4611, 7948, }, 7200, },
			[11452] = {  nil, 1,  4, 11452,  9030, 210, 225, 245, 265,   1,   1, { 7067, 3821, 8925, }, { 1, 1, 1, }, nil, nil, nil, { 2203, 2501, }, },
			[11453] = {  nil, 1,  4, 11453,  9036, 210, 225, 245, 265,   1,   1, { 3358, 8831, 8925, }, { 1, 1, 1, }, nil, nil, 9293, },
			[11456] = {  nil, 1,  4, 11456,  9061, 210, 225, 245, 265,   1,   1, { 4625, 9260, 3372, }, { 1, 1, 1, }, nil, nil, 10644, },
			[4942]  = {  nil, 1,  4,  4942,  4623, 215, 230, 250, 270,   1,   1, { 3858, 3821, 3372, }, { 1, 1, 1, }, nil, nil, 4624, },
			[22808] = {  nil, 1,  4, 22808, 18294, 215, 230, 250, 270,   1,   1, { 7972, 8831, 8925, }, { 1, 2, 1, }, { 1386, 4160, 4611, 7948, }, 9000, },
			[11457] = {  nil, 1,  4, 11457,  3928, 215, 230, 250, 270,   1,   1, { 8838, 3358, 8925, }, { 1, 1, 1, }, { 1386, 4160, 4611, 7948, }, 9000, },
			[11459] = {  nil, 1,  4, 11459,  9149, 225, 240, 260, 280,   1,   1, { 3575, 9262, 8831, 4625, }, { 4, 1, 4, 4, }, nil, nil, 9303, },
			[11480] = {  nil, 1,  4, 11480,  6037, 225, 240, 260, 280,   1,   1, { 3860, }, { 1, }, nil, nil, 9305, },
			[11479] = {  nil, 1,  4, 11479,  3577, 225, 240, 260, 280,   1,   1, { 3575, }, { 1, }, nil, nil, 9304, },
			[11458] = {  nil, 1,  4, 11458,  9144, 225, 240, 260, 280,   1,   1, { 8153, 8831, 8925, }, { 1, 1, 1, }, nil, nil, 9294, },
			[11460] = {  nil, 1,  4, 11460,  9154, 230, 245, 265, 285,   1,   1, { 8836, 8925, }, { 1, 1, }, { 1386, 7948, }, 4500, },
			[15833] = {  nil, 1,  4, 15833, 12190, 230, 245, 265, 285,   1,   1, { 8831, 8925, }, { 3, 1, }, { 1386, 7948, }, 9000, },
			[11464] = {  nil, 1,  4, 11464,  9172, 235, 250, 270, 290,   1,   1, { 8845, 8838, 8925, }, { 1, 1, 1, }, nil, nil, 9295, },
			[11465] = {  nil, 1,  4, 11465,  9179, 235, 250, 270, 290,   1,   1, { 8839, 3358, 8925, }, { 1, 1, 1, }, { 1386, 7948, }, 10800, },
			[11461] = {  nil, 1,  4, 11461,  9155, 235, 250, 270, 290,   1,   1, { 8839, 3821, 8925, }, { 1, 1, 1, }, { 1386, 7948, }, 9000, },
			[11466] = {  nil, 1,  4, 11466,  9088, 240, 255, 275, 295,   1,   1, { 8836, 8839, 8925, }, { 1, 1, 1, }, nil, nil, 9296, },
			[11468] = {  nil, 1,  4, 11468,  9197, 240, 255, 275, 295,   1,   1, { 8831, 8925, }, { 3, 1, }, nil, nil, 9297, },
			[11467] = {  nil, 1,  4, 11467,  9187, 240, 255, 275, 295,   1,   1, { 8838, 3821, 8925, }, { 1, 1, 1, }, { 1386, 7948, }, 10800, },
			[11473] = {  nil, 1,  4, 11473,  9210, 245, 260, 280, 300,   1,   1, { 8845, 4342, 8925, }, { 2, 1, 1, }, nil, nil, 9302, },
			[11472] = {  nil, 1,  4, 11472,  9206, 245, 260, 280, 300,   1,   1, { 8838, 8846, 8925, }, { 1, 1, 1, }, nil, nil, 9298, },
			[11478] = {  nil, 1,  4, 11478,  9233, 250, 265, 285, 305,   1,   1, { 8846, 8925, }, { 2, 1, }, { 1386, 7948, }, 12600, },
			[3175]  = {  nil, 1,  4,  3175,  3387, 250, 275, 295, 315,   1,   1, { 8839, 8845, 8925, }, { 2, 1, 1, }, nil, nil, 3395, },
			[11477] = {  nil, 1,  4, 11477,  9224, 250, 265, 285, 305,   1,   1, { 8846, 8845, 8925, }, { 1, 1, 1, }, nil, nil, 9300, },
			[11476] = {  nil, 1,  4, 11476,  9264, 250, 265, 285, 305,   1,   1, { 8845, 8925, }, { 3, 1, }, nil, nil, 9301, },
			[26277] = {  nil, 5,  4, 26277, 21546, 250, 265, 285, 305,   1,   1, { 6371, 4625, 8925, }, { 3, 3, 1, }, nil, nil, 21547, },
			[17551] = {  nil, 1,  4, 17551, 13423, 250, 250, 255, 260,   1,   1, { 13422, 3372, }, { 1, 1, }, { 1386, 7948, }, 13500, },
			[17552] = {  nil, 1,  4, 17552, 13442, 255, 270, 290, 310,   1,   1, { 8846, 8925, }, { 3, 1, }, nil, nil, 13476, },
			[17553] = {  nil, 1,  4, 17553, 13443, 260, 275, 295, 315,   1,   1, { 8838, 8839, 8925, }, { 2, 2, 1, }, nil, nil, 13477, },
			[17554] = {  nil, 1,  4, 17554, 13445, 265, 280, 300, 320,   1,   1, { 13423, 8838, 8925, }, { 2, 1, 1, }, nil, nil, 13478, },
			[17555] = {  nil, 1,  4, 17555, 13447, 270, 285, 305, 325,   1,   1, { 13463, 13466, 8925, }, { 1, 2, 1, }, nil, nil, 13479, },
			[17556] = {  nil, 1,  4, 17556, 13446, 275, 290, 310, 330,   1,   1, { 13464, 13465, 8925, }, { 2, 1, 1, }, nil, nil, 13480, },
			[17557] = {  nil, 1,  4, 17557, 13453, 275, 290, 310, 330,   1,   1, { 8846, 13466, 8925, }, { 2, 2, 1, }, nil, nil, 13481, },
			[17559] = {  nil, 1,  4, 17559,  7078, 275, 275, 282, 290,   1,   1, { 7082, }, { 1, }, nil, nil, 13482, },
			[17560] = {  nil, 1,  4, 17560,  7076, 275, 275, 282, 290,   1,   1, { 7078, }, { 1, }, nil, nil, 13483, },
			[17561] = {  nil, 1,  4, 17561,  7080, 275, 275, 282, 290,   1,   1, { 7076, }, { 1, }, nil, nil, 13484, },
			[17562] = {  nil, 1,  4, 17562,  7082, 275, 275, 282, 290,   1,   1, { 7080, }, { 1, }, nil, nil, 13485, },
			[17563] = {  nil, 1,  4, 17563,  7080, 275, 275, 282, 290,   1,   1, { 12808, }, { 1, }, nil, nil, 13486, },
			[17564] = {  nil, 1,  4, 17564, 12808, 275, 275, 282, 290,   1,   1, { 7080, }, { 1, }, nil, nil, 13487, },
			[17565] = {  nil, 1,  4, 17565,  7076, 275, 275, 282, 290,   1,   1, { 12803, }, { 1, }, nil, nil, 13488, },
			[17566] = {  nil, 1,  4, 17566, 12803, 275, 275, 282, 290,   1,   1, { 7076, }, { 1, }, nil, nil, 13489, },
			[17187] = {  nil, 1,  4, 17187, 12360, 275, 275, 282, 290,   1,   1, { 12359, 12363, }, { 1, 1, }, nil, nil, 12958, },
			[24365] = {  nil, 4,  4, 24365, 20007, 275, 290, 310, 330,   1,   1, { 13463, 13466, 8925, }, { 1, 2, 1, }, nil, nil, 20011, },
			[24366] = {  nil, 4,  4, 24366, 20002, 275, 290, 310, 330,   1,   1, { 13463, 13464, 8925, }, { 2, 1, 1, }, nil, nil, 20012, },
			[17571] = {  nil, 1,  4, 17571, 13452, 280, 295, 315, 335,   1,   1, { 13465, 13466, 8925, }, { 2, 2, 1, }, nil, nil, 13491, },
			[17570] = {  nil, 1,  4, 17570, 13455, 280, 295, 315, 335,   1,   1, { 13423, 10620, 8925, }, { 3, 1, 1, }, nil, nil, 13490, },
			[24367] = {  nil, 4,  4, 24367, 20008, 285, 300, 320, 340,   1,   1, { 13467, 13465, 10286, 8925, }, { 2, 2, 2, 1, }, nil, nil, 20013, },
			[17572] = {  nil, 1,  4, 17572, 13462, 285, 300, 320, 340,   1,   1, { 13467, 13466, 8925, }, { 2, 2, 1, }, nil, nil, 13492, },
			[17573] = {  nil, 1,  4, 17573, 13454, 285, 300, 320, 340,   1,   1, { 13463, 13465, 8925, }, { 3, 1, 1, }, nil, nil, 13493, },
			[17575] = {  nil, 1,  4, 17575, 13456, 290, 305, 325, 345,   1,   1, { 7070, 13463, 8925, }, { 1, 1, 1, }, nil, nil, 13495, },
			[17577] = {  nil, 1,  4, 17577, 13461, 290, 305, 325, 345,   1,   1, { 11176, 13463, 8925, }, { 1, 1, 1, }, nil, nil, 13497, },
			[17578] = {  nil, 1,  4, 17578, 13459, 290, 305, 325, 345,   1,   1, { 3824, 13463, 8925, }, { 1, 1, 1, }, nil, nil, 13499, },
			[17574] = {  nil, 1,  4, 17574, 13457, 290, 305, 325, 345,   1,   1, { 7068, 13463, 8925, }, { 1, 1, 1, }, nil, nil, 13494, },
			[24368] = {  nil, 4,  4, 24368, 20004, 290, 305, 325, 345,   1,   1, { 8846, 13466, 8925, }, { 1, 2, 1, }, nil, nil, 20014, },
			[17576] = {  nil, 1,  4, 17576, 13458, 290, 305, 325, 345,   1,   1, { 7067, 13463, 8925, }, { 1, 1, 1, }, nil, nil, 13496, },
			[17579] = {  nil, 1,  4, 17579, 13460, 290, 305, 325, 345,   1,   1, { 7069, 13463, 8925, }, { 1, 1, 1, }, },
			[17580] = {  nil, 1,  4, 17580, 13444, 295, 310, 330, 350,   1,   1, { 13463, 13467, 8925, }, { 3, 2, 1, }, nil, nil, 13501, },
			[17634] = {  nil, 1,  4, 17634, 13506, 300, 315, 322, 330,   1,   1, { 13423, 13465, 13468, 8925, }, { 30, 10, 1, 1, }, nil, nil, 13518, },
			[17635] = {  nil, 1,  4, 17635, 13510, 300, 315, 322, 330,   1,   1, { 8846, 13423, 13468, 8925, }, { 30, 10, 1, 1, }, nil, nil, 13519, },
			[22732] = {  nil, 1,  4, 22732, 18253, 300, 310, 320, 330,   1,   1, { 10286, 13464, 13463, 18256, }, { 1, 4, 4, 1, }, nil, nil, 18257, },
			[17637] = {  nil, 1,  4, 17637, 13512, 300, 315, 322, 330,   1,   1, { 13463, 13465, 13468, 8925, }, { 30, 10, 1, 1, }, nil, nil, 13521, },
			[17636] = {  nil, 1,  4, 17636, 13511, 300, 315, 322, 330,   1,   1, { 13463, 13467, 13468, 8925, }, { 30, 10, 1, 1, }, nil, nil, 13520, },
			[17632] = {  nil, 1,  4, 17632, 13503, 300, 315, 322, 330,   1,   1, { 7078, 7076, 7082, 7080, 12803, 9262, 13468, }, { 8, 8, 8, 8, 8, 2, 4, }, },
			[25146] = {  nil, 5,  4, 25146,  7068, 300, 301, 305, 310,   3,   3, { 7077, }, { 1, }, nil, nil, 20761, },
			[24266] = {  nil, 4,  4, 24266, 19931, 300, 315, 322, 330,   3,   3, { 12938, 19943, 12804, 13468, }, { 1, 1, 6, 1, }, nil, nil, nil, nil, 180368, },
			[17638] = {  nil, 1,  4, 17638, 13513, 300, 315, 322, 330,   1,   1, { 13467, 13465, 13468, 8925, }, { 30, 10, 1, 1, }, nil, nil, 13522, },
			[2540]  = {  nil, 1,  6,  2540,  2681,   1,  45,  65,  85,   1,   1, { 769, }, { 1, }, },
			[7752]  = {  nil, 1,  6,  7752,   787,   1,  45,  65,  85,   1,   1, { 6303, }, { 1, }, nil, nil, 6326, },
			[7751]  = {  nil, 1,  6,  7751,  6290,   1,  45,  65,  85,   1,   1, { 6291, }, { 1, }, nil, nil, 6325, },
			[15935] = {  nil, 1,  6, 15935, 12224,   1,  45,  65,  85,   1,   1, { 12223, 2678, }, { 1, 1, }, nil, nil, 12226, },
			[21143] = {  nil, 1,  6, 21143, 17197,   1,  45,  65,  85,   1,   1, { 6889, 17194, }, { 1, 1, }, nil, nil, 17200, },
			[2538]  = {  nil, 1,  6,  2538,  2679,   1,  45,  65,  85,   1,   1, { 2672, }, { 1, }, },
			[8604]  = {  nil, 1,  6,  8604,  6888,   1,  45,  65,  85,   1,   1, { 6889, 2678, }, { 1, 1, }, },
			[2539]  = {  nil, 1,  6,  2539,  2680,  10,  50,  70,  90,   1,   1, { 2672, 2678, }, { 1, 1, }, { 1355, 1382, 1430, 1699, 3026, 3067, 3087, 3399, 4210, 4552, 5159, 5482, 6286, 8306, }, 50, },
			[6412]  = {  nil, 1,  6,  6412,  5472,  10,  50,  70,  90,   1,   1, { 5465, }, { 1, }, nil, nil, 5482, },
			[6413]  = {  nil, 1,  6,  6413,  5473,  20,  60,  80, 100,   1,   1, { 5466, }, { 1, }, nil, nil, 5483, },
			[2795]  = {  nil, 1,  6,  2795,  2888,  25,  60,  80, 100,   1,   1, { 2886, 2894, }, { 1, 1, }, nil, nil, 2889, },
			[6414]  = {  nil, 1,  6,  6414,  5474,  35,  75,  95, 115,   2,   2, { 5467, 2678, }, { 1, 1, }, nil, nil, 5484, },
			[21144] = {  nil, 1,  6, 21144, 17198,  35,  75,  95, 115,   1,   1, { 6889, 1179, 17196, 17194, }, { 1, 1, 1, 1, }, nil, nil, 17201, },
			[8607]  = {  nil, 1,  6,  8607,  6890,  40,  80, 100, 120,   1,   1, { 3173, }, { 1, }, nil, nil, 6892, },
			[2541]  = {  nil, 1,  6,  2541,  2684,  50,  90, 110, 130,   1,   1, { 2673, }, { 1, }, { 1355, 1382, 1430, 1699, 3026, 3067, 3087, 3399, 4210, 4552, 5159, 5482, 6286, 8306, }, 100, },
			[7754]  = {  nil, 1,  6,  7754,  6316,  50,  90, 110, 130,   1,   1, { 6317, 2678, }, { 1, 1, }, nil, nil, 6329, },
			[6416]  = {  nil, 1,  6,  6416,  5477,  50,  90, 110, 130,   2,   2, { 5469, 4536, }, { 1, 1, }, nil, nil, 5486, },
			[6415]  = {  nil, 1,  6,  6415,  5476,  50,  90, 110, 130,   2,   2, { 5468, 2678, }, { 1, 1, }, nil, nil, 5485, },
			[7753]  = {  nil, 1,  6,  7753,  4592,  50,  90, 110, 130,   1,   1, { 6289, }, { 1, }, nil, nil, 6328, },
			[7827]  = {  nil, 1,  6,  7827,  5095,  50,  90, 110, 130,   1,   1, { 6361, }, { 1, }, nil, nil, 6368, },
			[2542]  = {  nil, 1,  6,  2542,   724,  50,  90, 110, 130,   1,   1, { 723, 2678, }, { 1, 1, }, nil, nil, 2697, },
			[6499]  = {  nil, 1,  6,  6499,  5525,  50,  90, 110, 130,   1,   1, { 5503, 159, }, { 1, 1, }, { 1355, 1382, 1430, 1699, 3026, 3067, 3087, 3399, 4210, 4552, 5159, 5482, 6286, 8306, }, 100, },
			[9513]  = {  nil, 1,  6,  9513,  7676,  60, 100, 120, 140,   1,   1, { 2452, 159, }, { 1, 1, }, nil, nil, 18160, },
			[3371]  = {  nil, 1,  6,  3371,  3220,  60, 100, 120, 140,   2,   2, { 3173, 3172, 3174, }, { 1, 1, 1, }, nil, nil, 3679, },
			[2543]  = {  nil, 1,  6,  2543,   733,  75, 115, 135, 155,   1,   1, { 729, 730, 731, }, { 1, 1, 1, }, nil, nil, 728, },
			[2544]  = {  nil, 1,  6,  2544,  2683,  75, 115, 135, 155,   1,   1, { 2674, 2678, }, { 1, 1, }, { 1355, 1382, 1430, 1699, 3026, 3067, 3087, 3399, 4210, 4552, 5159, 5482, 6286, 8306, }, 200, },
			[25704] = {  nil, 1,  6, 25704, 21072,  80, 120, 140, 160,   1,   1, { 21071, 2678, }, { 1, 1, }, nil, nil, 21099, },
			[3370]  = {  nil, 1,  6,  3370,  3662,  80, 120, 140, 160,   1,   1, { 2924, 2678, }, { 1, 1, }, nil, nil, 3678, },
			[2546]  = {  nil, 1,  6,  2546,  2687,  80, 120, 140, 160,   1,   1, { 2677, 2678, }, { 1, 1, }, { 1355, 1382, 1430, 1699, 3026, 3067, 3087, 3399, 4210, 4552, 5159, 5482, 6286, 8306, }, 150, },
			[8238]  = {  nil, 1,  6,  8238,  6657,  85, 125, 145, 165,   1,   1, { 6522, 2678, }, { 1, 1, }, nil, nil, 6661, },
			[2545]  = {  nil, 1,  6,  2545,  2682,  85, 125, 145, 165,   1,   1, { 2675, 2678, }, { 1, 1, }, nil, nil, 2698, },
			[3372]  = {  nil, 1,  6,  3372,  3663,  90, 130, 150, 170,   1,   1, { 1468, 2692, }, { 2, 1, }, nil, nil, 3680, },
			[6417]  = {  nil, 1,  6,  6417,  5478,  90, 130, 150, 170,   2,   2, { 5051, }, { 1, }, nil, nil, 5487, },
			[6501]  = {  nil, 1,  6,  6501,  5526,  90, 130, 150, 170,   1,   1, { 5503, 1179, 2678, }, { 1, 1, 1, }, nil, nil, 5528, },
			[2547]  = {  nil, 1,  6,  2547,  1082, 100, 135, 155, 175,   1,   1, { 1081, 1080, }, { 1, 1, }, nil, nil, 2699, },
			[7755]  = {  nil, 1,  6,  7755,  4593, 100, 140, 160, 180,   1,   1, { 6308, }, { 1, }, nil, nil, 6330, },
			[2549]  = {  nil, 1,  6,  2549,  1017, 100, 140, 160, 180,   3,   3, { 1015, 2665, }, { 2, 1, }, nil, nil, 2701, },
			[6418]  = {  nil, 1,  6,  6418,  5479, 100, 140, 160, 180,   2,   2, { 5470, 2692, }, { 1, 1, }, nil, nil, 5488, },
			[3397]  = {  nil, 1,  6,  3397,  3726, 110, 150, 170, 190,   1,   1, { 3730, 2692, }, { 1, 1, }, nil, nil, 3734, },
			[3377]  = {  nil, 1,  6,  3377,  3666, 110, 150, 170, 190,   1,   1, { 2251, 2692, }, { 2, 1, }, nil, nil, 3683, },
			[2548]  = {  nil, 1,  6,  2548,  2685, 110, 130, 150, 170,   1,   1, { 2677, 2692, }, { 2, 1, }, nil, nil, 2700, },
			[6419]  = {  nil, 1,  6,  6419,  5480, 110, 150, 170, 190,   2,   2, { 5471, 2678, }, { 1, 4, }, nil, nil, 5489, },
			[3373]  = {  nil, 1,  6,  3373,  3664, 120, 160, 180, 200,   1,   1, { 3667, 2692, }, { 1, 1, }, nil, nil, 3681, },
			[15853] = {  nil, 1,  6, 15853, 12209, 125, 165, 185, 205,   1,   1, { 1015, 2678, }, { 1, 1, }, nil, nil, 12227, },
			[13028] = {  nil, 1,  6, 13028, 10841, 125, 215, 235, 255,   4,   4, { 3821, 159, }, { 1, 1, }, { 8696, }, 0, },
			[3398]  = {  nil, 1,  6,  3398,  3727, 125, 175, 195, 215,   1,   1, { 3731, 2692, }, { 1, 1, }, nil, nil, 3735, },
			[6500]  = {  nil, 1,  6,  6500,  5527, 125, 165, 185, 205,   1,   1, { 5504, 2692, }, { 1, 1, }, { 1355, 1382, 1430, 1699, 3026, 3067, 3087, 3399, 4210, 4552, 5159, 5482, 6286, 8306, }, 300, },
			[3376]  = {  nil, 1,  6,  3376,  3665, 130, 170, 190, 210,   1,   1, { 3685, 2692, }, { 1, 1, }, nil, nil, 3682, },
			[24418] = {  nil, 1,  6, 24418, 20074, 150, 160, 180, 200,   1,   1, { 3667, 3713, }, { 2, 1, }, nil, nil, 20075, },
			[3399]  = {  nil, 1,  6,  3399,  3728, 150, 190, 210, 230,   1,   1, { 3731, 3713, }, { 2, 1, }, nil, nil, 3736, },
			[15865] = {  nil, 1,  6, 15865, 12214, 175, 215, 235, 255,   1,   1, { 12037, 2596, }, { 1, 1, }, nil, nil, 12233, },
			[15863] = {  nil, 1,  6, 15863, 12213, 175, 215, 235, 255,   1,   1, { 12037, 2692, }, { 1, 1, }, nil, nil, 12232, },
			[25954] = {  nil, 1,  6, 25954, 21217, 175, 215, 235, 255,   1,   1, { 21153, 2692, }, { 1, 1, }, nil, nil, 21219, },
			[4094]  = {  nil, 1,  6,  4094,  4457, 175, 215, 235, 255,   1,   1, { 3404, 2692, }, { 1, 1, }, nil, nil, 4609, },
			[20916] = {  nil, 1,  6, 20916,  8364, 175, 215, 235, 255,   1,   1, { 8365, }, { 1, }, nil, nil, 17062, },
			[3400]  = {  nil, 1,  6,  3400,  3729, 175, 215, 235, 255,   1,   1, { 3712, 3713, }, { 1, 1, }, nil, nil, 3737, },
			[7213]  = {  nil, 1,  6,  7213,  6038, 175, 215, 235, 255,   1,   1, { 4655, 2692, }, { 1, 1, }, nil, nil, 6039, },
			[7828]  = {  nil, 1,  6,  7828,  4594, 175, 190, 210, 230,   1,   1, { 6362, }, { 1, }, nil, nil, 6369, },
			[15855] = {  nil, 1,  6, 15855, 12210, 175, 215, 235, 255,   1,   1, { 12184, 2692, }, { 1, 1, }, nil, nil, 12228, },
			[15861] = {  nil, 1,  6, 15861, 12212, 175, 215, 235, 255,   2,   2, { 12202, 159, 4536, }, { 1, 1, 2, }, nil, nil, 12231, },
			[15856] = {  nil, 1,  6, 15856, 13851, 175, 215, 235, 255,   1,   1, { 12203, 2692, }, { 1, 1, }, nil, nil, 12229, },
			[21175] = {  nil, 1,  6, 21175, 17222, 200, 240, 260, 280,   1,   1, { 12205, }, { 2, }, { 1355, 1382, 1430, 1699, 3026, 3067, 3087, 3399, 4210, 4552, 5159, 5482, 6286, 8306, }, 4000, },
			[15910] = {  nil, 1,  6, 15910, 12215, 200, 240, 260, 280,   2,   2, { 12204, 3713, 159, }, { 2, 1, 1, }, nil, nil, 12240, },
			[15906] = {  nil, 1,  6, 15906, 12217, 200, 240, 260, 280,   1,   1, { 12037, 4402, 2692, }, { 1, 1, 1, }, nil, nil, 12239, },
			[15933] = {  nil, 1,  6, 15933, 12218, 225, 265, 285, 305,   1,   1, { 12207, 3713, }, { 1, 2, }, nil, nil, 16110, },
			[18241] = {  nil, 1,  6, 18241, 13930, 225, 265, 285, 305,   1,   1, { 13758, }, { 1, }, nil, nil, 13941, },
			[18238] = {  nil, 1,  6, 18238,  6887, 225, 265, 285, 305,   1,   1, { 4603, }, { 1, }, nil, nil, 13939, },
			[15915] = {  nil, 1,  6, 15915, 12216, 225, 265, 285, 305,   1,   1, { 12206, 2692, }, { 1, 2, }, nil, nil, 16111, },
			[22480] = {  nil, 1,  6, 22480, 18045, 225, 265, 285, 305,   1,   1, { 12208, 3713, }, { 1, 1, }, nil, nil, 18046, },
			[20626] = {  nil, 1,  6, 20626, 16766, 225, 265, 285, 305,   2,   2, { 7974, 2692, 1179, }, { 2, 1, 1, }, nil, nil, 16767, },
			[18239] = {  nil, 1,  6, 18239, 13927, 225, 265, 285, 305,   1,   1, { 13754, 3713, }, { 1, 1, }, nil, nil, 13940, },
			[18240] = {  nil, 1,  6, 18240, 13928, 240, 280, 300, 320,   1,   1, { 13755, 3713, }, { 1, 1, }, nil, nil, 13942, },
			[18242] = {  nil, 1,  6, 18242, 13929, 240, 280, 300, 320,   1,   1, { 13756, 2692, }, { 1, 2, }, nil, nil, 13943, },
			[18244] = {  nil, 1,  6, 18244, 13932, 250, 290, 310, 330,   1,   1, { 13760, }, { 1, }, nil, nil, 13946, },
			[18243] = {  nil, 1,  6, 18243, 13931, 250, 290, 310, 330,   1,   1, { 13759, 159, }, { 1, 1, }, nil, nil, 13945, },
			[18245] = {  nil, 1,  6, 18245, 13933, 275, 315, 335, 355,   1,   1, { 13888, 159, }, { 1, 1, }, nil, nil, 13947, },
			[22761] = {  nil, 2,  6, 22761, 18254, 275, 315, 335, 355,   1,   1, { 18255, 3713, }, { 1, 1, }, nil, nil, 18267, },
			[18247] = {  nil, 1,  6, 18247, 13935, 275, 315, 335, 355,   1,   1, { 13889, 3713, }, { 1, 1, }, nil, nil, 13949, },
			[18246] = {  nil, 1,  6, 18246, 13934, 275, 315, 335, 355,   1,   1, { 13893, 2692, 3713, }, { 1, 1, 1, }, nil, nil, 13948, },
			[24801] = {  nil, 4,  6, 24801, 20452, 285, 325, 345, 365,   1,   1, { 20424, 3713, }, { 1, 1, }, nil, nil, nil, { 8313, }, },
			[25659] = {  nil, 5,  6, 25659, 21023, 300, 325, 345, 365,   5,   5, { 2692, 9061, 8150, 21024, }, { 1, 1, 1, 1, }, nil, nil, 21025, },
			[30047] = {  nil, 1,  6, 30047, 23683, 300, 325, 345, 365,   2,   2, { 23567, 8150, }, { 1, 1, }, },
			[2657]  = {  nil, 1,  7,  2657,  2840,   1,  25,  47,  70,   1,   1, { 2770, }, { 1, }, },
			[2659]  = {  nil, 1,  7,  2659,  2841,  65,  65,  90, 115,   2,   2, { 2840, 3576, }, { 1, 1, }, { 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 6297, 8128, }, 200, },
			[3304]  = {  nil, 1,  7,  3304,  3576,  65,  65,  62,  75,   1,   1, { 2771, }, { 1, }, { 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 6297, 8128, }, 50, },
			[2658]  = {  nil, 1,  7,  2658,  2842,  75, 100, 112, 125,   1,   1, { 2775, }, { 1, }, { 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 6297, 8128, }, 200, },
			[3307]  = {  nil, 1,  7,  3307,  3575, 125, 130, 135, 140,   1,   1, { 2772, }, { 1, }, { 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 6297, 8128, }, 500, },
			[3308]  = {  nil, 1,  7,  3308,  3577, 155, 170, 177, 185,   1,   1, { 2776, }, { 1, }, { 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 6297, 8128, }, 2500, },
			[3569]  = {  nil, 1,  7,  3569,  3859, 165, 165, 165, 165,   1,   1, { 3575, 3857, }, { 1, 1, }, { 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 6297, 8128, }, 2500, },
			[10097] = {  nil, 1,  7, 10097,  3860, 175, 175, 175, 175,   1,   1, { 3858, }, { 1, }, { 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 6297, 8128, }, 5000, },
			[10098] = {  nil, 1,  7, 10098,  6037, 230, 230, 230, 230,   1,   1, { 7911, }, { 1, }, { 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 6297, 8128, }, 10000, },
			[14891] = {  nil, 1,  7, 14891, 11371, 230, 230, 230, 230,   1,   1, { 11370, }, { 8, }, nil, nil, nil, { 4083, }, },
			[16153] = {  nil, 1,  7, 16153, 12359, 250, 250, 250, 250,   1,   1, { 10620, }, { 1, }, { 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 6297, 8128, }, 20000, },
			[22967] = {  nil, 3,  7, 22967, 17771, 300, 310, 315, 320,   1,   1, { 18562, 12360, 17010, 18567, }, { 1, 10, 1, 3, }, { 14401, }, 0, },
			[2387]  = {  nil, 1,  8,  2387,  2570,   1,  35,  47,  60,   1,   1, { 2996, 2320, }, { 1, 1, }, },
			[2393]  = {  nil, 1,  8,  2393,  2576,   1,  35,  47,  60,   1,   1, { 2996, 2320, 2324, }, { 1, 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 22, },
			[2963]  = {  nil, 1,  8,  2963,  2996,   1,  25,  37,  50,   1,   1, { 2589, }, { 2, }, },
			[12044] = {  nil, 1,  8, 12044, 10045,   1,  35,  47,  60,   1,   1, { 2996, 2320, }, { 1, 1, }, },
			[3915]  = {  nil, 1,  8,  3915,  4344,   1,  35,  47,  60,   1,   1, { 2996, 2320, }, { 1, 1, }, },
			[2385]  = {  nil, 1,  8,  2385,  2568,  10,  45,  57,  70,   1,   1, { 2996, 2320, }, { 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 45, },
			[8776]  = {  nil, 1,  8,  8776,  7026,  15,  50,  67,  85,   1,   1, { 2996, 2320, }, { 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 45, },
			[12045] = {  nil, 1,  8, 12045, 10046,  20,  50,  67,  85,   1,   1, { 2996, 2318, 2320, }, { 2, 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 45, },
			[7624]  = {  nil, 1,  8,  7624,  6241,  30,  55,  72,  90,   1,   1, { 2996, 2320, 2324, }, { 3, 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 45, },
			[7623]  = {  nil, 1,  8,  7623,  6238,  30,  55,  72,  90,   1,   1, { 2996, 2320, }, { 3, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 45, },
			[3914]  = {  nil, 1,  8,  3914,  4343,  30,  55,  72,  90,   1,   1, { 2996, 2320, }, { 2, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 45, },
			[3840]  = {  nil, 1,  8,  3840,  4307,  35,  60,  77,  95,   1,   1, { 2996, 2320, }, { 2, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 90, },
			[2392]  = {  nil, 1,  8,  2392,  2575,  40,  65,  82, 100,   1,   1, { 2996, 2320, 2604, }, { 2, 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 45, },
			[2394]  = {  nil, 1,  8,  2394,  2577,  40,  65,  82, 100,   1,   1, { 2996, 2320, 6260, }, { 2, 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 45, },
			[8465]  = {  nil, 1,  8,  8465,  6786,  40,  65,  82, 100,   1,   1, { 2996, 2320, 6260, 2324, }, { 2, 1, 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 45, },
			[2389]  = {  nil, 1,  8,  2389,  2572,  40,  65,  82, 100,   1,   1, { 2996, 2320, 2604, }, { 3, 2, 2, }, nil, nil, 2598, },
			[3755]  = {  nil, 1,  8,  3755,  4238,  45,  70,  87, 105,   1,   1, { 2996, 2320, }, { 3, 3, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 90, },
			[7629]  = {  nil, 1,  8,  7629,  6239,  55,  80,  97, 115,   1,   1, { 2996, 2320, 2604, }, { 3, 1, 1, }, nil, nil, 6271, },
			[7630]  = {  nil, 1,  8,  7630,  6240,  55,  80,  97, 115,   1,   1, { 2996, 2320, 6260, }, { 3, 1, 1, }, nil, nil, 6270, },
			[2397]  = {  nil, 1,  8,  2397,  2580,  60,  85, 102, 120,   1,   1, { 2996, 2320, }, { 2, 3, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 180, },
			[3841]  = {  nil, 1,  8,  3841,  4308,  60,  85, 102, 120,   1,   1, { 2996, 2320, 2605, }, { 3, 2, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 180, },
			[2386]  = {  nil, 1,  8,  2386,  2569,  65,  90, 107, 125,   1,   1, { 2996, 2320, 2318, }, { 3, 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 180, },
			[7633]  = {  nil, 1,  8,  7633,  6242,  70,  95, 112, 130,   1,   1, { 2996, 2320, 6260, }, { 4, 2, 2, }, nil, nil, 6272, },
			[2396]  = {  nil, 1,  8,  2396,  2579,  70,  95, 112, 130,   1,   1, { 2996, 2321, 2605, }, { 3, 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 180, },
			[3842]  = {  nil, 1,  8,  3842,  4309,  70,  95, 112, 130,   1,   1, { 2996, 2321, }, { 4, 2, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 270, },
			[2395]  = {  nil, 1,  8,  2395,  2578,  70,  95, 112, 130,   1,   1, { 2996, 2318, 2321, }, { 4, 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 270, },
			[6686]  = {  nil, 1,  8,  6686,  5762,  70,  95, 112, 130,   1,   1, { 2996, 2321, 2604, }, { 4, 1, 1, }, nil, nil, 5771, },
			[2964]  = {  nil, 1,  8,  2964,  2997,  75,  90,  97, 105,   1,   1, { 2592, }, { 3, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 90, },
			[2402]  = {  nil, 1,  8,  2402,  2584,  75, 100, 117, 135,   1,   1, { 2997, 2321, }, { 1, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 225, },
			[12046] = {  nil, 1,  8, 12046, 10047,  75, 100, 117, 135,   1,   1, { 2996, 2321, }, { 4, 1, }, { 1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 3704, 4159, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557, }, 270, },
			[3845]  = {  nil, 1,  8,  3845,  4312,  80, 105, 122, 140,   1,   1, { 2996, 2318, 2321, }, { 5, 2, 1, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 270, },
			[3757]  = {  nil, 1,  8,  3757,  4240,  80, 105, 122, 140,   1,   1, { 2997, 2321, }, { 3, 1, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 180, },
			[2399]  = {  nil, 1,  8,  2399,  2582,  85, 110, 127, 145,   1,   1, { 2997, 2321, 2605, }, { 2, 2, 1, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 270, },
			[3843]  = {  nil, 1,  8,  3843,  4310,  85, 110, 127, 145,   1,   1, { 2997, 2321, }, { 3, 1, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 360, },
			[7636]  = {  nil, 1,  8,  7636,  6243,  90, 115, 132, 150,   1,   1, { 2997, 2321, 2605, }, { 3, 2, 1, }, },
			[6521]  = {  nil, 1,  8,  6521,  5542,  90, 115, 132, 150,   1,   1, { 2997, 2321, 5498, }, { 3, 2, 1, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 360, },
			[3758]  = {  nil, 1,  8,  3758,  4241,  95, 120, 137, 155,   1,   1, { 2997, 2605, 2321, }, { 4, 1, 1, }, nil, nil, 4292, },
			[2401]  = {  nil, 1,  8,  2401,  2583,  95, 120, 137, 155,   1,   1, { 2997, 2321, 2318, }, { 4, 2, 2, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 270, },
			[3847]  = {  nil, 1,  8,  3847,  4313,  95, 120, 137, 155,   1,   1, { 2997, 2318, 2321, 2604, }, { 4, 2, 1, 2, }, nil, nil, 4345, },
			[3844]  = {  nil, 1,  8,  3844,  4311, 100, 125, 142, 160,   1,   1, { 2997, 2321, 5498, }, { 3, 2, 2, }, nil, nil, 4346, },
			[7639]  = {  nil, 1,  8,  7639,  6263, 100, 125, 142, 160,   1,   1, { 2997, 2321, 6260, }, { 4, 2, 2, }, nil, nil, 6274, },
			[2406]  = {  nil, 1,  8,  2406,  2587, 100, 110, 120, 130,   1,   1, { 2997, 2321, 4340, }, { 2, 1, 1, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 180, },
			[2403]  = {  nil, 1,  8,  2403,  2585, 105, 130, 147, 165,   1,   1, { 2997, 2321, 4340, }, { 4, 3, 1, }, nil, nil, 2601, },
			[3850]  = {  nil, 1,  8,  3850,  4316, 110, 135, 152, 170,   1,   1, { 2997, 2321, }, { 5, 4, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 450, },
			[3866]  = {  nil, 1,  8,  3866,  4330, 110, 135, 152, 170,   1,   1, { 2997, 2604, 2321, }, { 3, 2, 1, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 225, },
			[3848]  = {  nil, 1,  8,  3848,  4314, 110, 135, 152, 170,   1,   1, { 2997, 2321, }, { 3, 2, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 450, },
			[8467]  = {  nil, 1,  8,  8467,  6787, 110, 135, 152, 170,   1,   1, { 2997, 2324, 2321, }, { 3, 4, 1, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 225, },
			[7643]  = {  nil, 1,  8,  7643,  6264, 115, 140, 157, 175,   1,   1, { 2997, 2321, 2604, }, { 5, 3, 3, }, nil, nil, 6275, },
			[6688]  = {  nil, 1,  8,  6688,  5763, 115, 140, 157, 175,   1,   1, { 2997, 2604, 2321, }, { 4, 1, 1, }, nil, nil, 5772, },
			[12047] = {  nil, 1,  8, 12047, 10048, 120, 145, 162, 180,   1,   1, { 2997, 2604, 2321, }, { 5, 3, 1, }, nil, nil, 10316, },
			[3849]  = {  nil, 1,  8,  3849,  4315, 120, 145, 162, 180,   1,   1, { 2997, 2319, 2321, }, { 6, 2, 2, }, nil, nil, 4347, },
			[7892]  = {  nil, 1,  8,  7892,  6384, 120, 145, 162, 180,   1,   1, { 2997, 6260, 4340, 2321, }, { 4, 2, 1, 1, }, nil, nil, 6390, },
			[7893]  = {  nil, 1,  8,  7893,  6385, 120, 145, 162, 180,   1,   1, { 2997, 2605, 4340, 2321, }, { 4, 2, 1, 1, }, nil, nil, 6391, },
			[3851]  = {  nil, 1,  8,  3851,  4317, 125, 150, 167, 185,   1,   1, { 2997, 5500, 2321, }, { 6, 1, 3, }, nil, nil, 4349, },
			[3839]  = {  nil, 1,  8,  3839,  4305, 125, 135, 140, 145,   1,   1, { 4306, }, { 4, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 450, },
			[3868]  = {  nil, 1,  8,  3868,  4331, 125, 150, 167, 185,   1,   1, { 2997, 5500, 2321, 2324, }, { 4, 1, 4, 2, }, nil, nil, 4348, },
			[3855]  = {  nil, 1,  8,  3855,  4320, 125, 150, 167, 185,   1,   1, { 4305, 2319, 3182, 5500, }, { 2, 4, 4, 2, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 675, },
			[3852]  = {  nil, 1,  8,  3852,  4318, 130, 150, 165, 180,   1,   1, { 2997, 2321, 3383, }, { 4, 3, 1, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 675, },
			[3869]  = {  nil, 1,  8,  3869,  4332, 135, 145, 150, 155,   1,   1, { 4305, 4341, 2321, }, { 1, 1, 1, }, nil, nil, 14627, },
			[6690]  = {  nil, 1,  8,  6690,  5766, 135, 155, 170, 185,   1,   1, { 4305, 2321, 3182, }, { 2, 2, 2, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 900, },
			[8758]  = {  nil, 1,  8,  8758,  7046, 140, 160, 175, 190,   1,   1, { 4305, 6260, 2321, }, { 4, 2, 3, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 540, },
			[8778]  = {  nil, 1,  8,  8778,  7027, 140, 160, 175, 190,   1,   1, { 4305, 2319, 6048, 2321, }, { 3, 2, 1, 2, }, },
			[3856]  = {  nil, 1,  8,  3856,  4321, 140, 160, 175, 190,   1,   1, { 4305, 3182, 2321, }, { 3, 1, 2, }, nil, nil, 4350, },
			[8760]  = {  nil, 1,  8,  8760,  7048, 145, 155, 160, 165,   1,   1, { 4305, 6260, 2321, }, { 2, 2, 1, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 540, },
			[3854]  = {  nil, 1,  8,  3854,  4319, 145, 165, 180, 195,   1,   1, { 4305, 4234, 6260, 2321, }, { 3, 2, 2, 2, }, nil, nil, 7114, },
			[8780]  = {  nil, 1,  8,  8780,  7047, 145, 165, 180, 195,   1,   1, { 4305, 4234, 6048, 2321, }, { 3, 2, 2, 2, }, nil, nil, 7092, },
			[3859]  = {  nil, 1,  8,  3859,  4324, 150, 170, 185, 200,   1,   1, { 4305, 6260, }, { 5, 4, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 675, },
			[8782]  = {  nil, 1,  8,  8782,  7049, 150, 170, 185, 200,   1,   1, { 4305, 4234, 929, 2321, }, { 3, 2, 4, 1, }, nil, nil, 7091, },
			[6692]  = {  nil, 1,  8,  6692,  5770, 150, 170, 185, 200,   1,   1, { 4305, 2321, 3182, }, { 4, 2, 2, }, nil, nil, 5773, },
			[3813]  = {  nil, 1,  8,  3813,  4245, 150, 170, 185, 200,   1,   1, { 4305, 4234, 2321, }, { 3, 2, 3, }, { 1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557, }, 720, },
			[3870]  = {  nil, 1,  8,  3870,  4333, 155, 165, 170, 175,   1,   1, { 4305, 4340, 2321, }, { 2, 2, 1, }, nil, nil, 6401, },
			[8762]  = {  nil, 1,  8,  8762,  7050, 160, 170, 175, 180,   1,   1, { 4305, 2321, }, { 3, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 675, },
			[8483]  = {  nil, 1,  8,  8483,  6795, 160, 170, 175, 180,   1,   1, { 4305, 2324, 4291, }, { 3, 2, 1, }, { 1346, 2399, 4576, 11052, 11557, }, 450, },
			[3857]  = {  nil, 1,  8,  3857,  4322, 165, 185, 200, 215,   1,   1, { 4305, 2321, 4337, }, { 3, 2, 2, }, nil, nil, 14630, },
			[8784]  = {  nil, 1,  8,  8784,  7065, 165, 185, 200, 215,   1,   1, { 4305, 2605, 4291, }, { 5, 2, 1, }, nil, nil, 7090, },
			[8764]  = {  nil, 1,  8,  8764,  7051, 170, 190, 205, 220,   1,   1, { 4305, 7067, 2321, }, { 3, 1, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 810, },
			[3858]  = {  nil, 1,  8,  3858,  4323, 170, 190, 205, 220,   1,   1, { 4305, 4291, 3824, }, { 4, 1, 1, }, nil, nil, 4351, },
			[3871]  = {  nil, 1,  8,  3871,  4334, 170, 180, 185, 190,   1,   1, { 4305, 2324, 2321, }, { 3, 2, 1, }, { 1346, 2399, 4576, 11052, 11557, }, 450, },
			[8489]  = {  nil, 1,  8,  8489,  6796, 175, 185, 190, 195,   1,   1, { 4305, 2604, 4291, }, { 3, 2, 1, }, { 1346, 2399, 4576, 11052, 11557, }, 675, },
			[8772]  = {  nil, 1,  8,  8772,  7055, 175, 195, 210, 225,   1,   1, { 4305, 7071, 2604, 4291, }, { 4, 1, 2, 1, }, { 1346, 2399, 4576, 11052, 11557, }, 900, },
			[8786]  = {  nil, 1,  8,  8786,  7053, 175, 195, 210, 225,   1,   1, { 4305, 6260, 2321, }, { 3, 2, 2, }, nil, nil, 7089, },
			[3860]  = {  nil, 1,  8,  3860,  4325, 175, 195, 210, 225,   1,   1, { 4305, 4291, 4337, }, { 4, 1, 2, }, nil, nil, 4352, },
			[8766]  = {  nil, 1,  8,  8766,  7052, 175, 195, 210, 225,   1,   1, { 4305, 7070, 6260, 2321, 7071, }, { 4, 1, 2, 2, 1, }, { 1346, 2399, 4576, 11052, 11557, }, 900, },
			[6693]  = {  nil, 1,  8,  6693,  5764, 175, 195, 210, 225,   1,   1, { 4305, 4234, 2321, 2605, }, { 4, 3, 3, 1, }, nil, nil, 5774, },
			[3865]  = {  nil, 1,  8,  3865,  4339, 175, 180, 182, 185,   1,   1, { 4338, }, { 5, }, { 1346, 2399, 4576, 11052, 11557, }, 900, },
			[3863]  = {  nil, 1,  8,  3863,  4328, 180, 200, 215, 230,   1,   1, { 4305, 4337, 7071, }, { 4, 2, 1, }, nil, nil, 4353, },
			[8774]  = {  nil, 1,  8,  8774,  7057, 180, 200, 215, 230,   1,   1, { 4305, 4291, }, { 5, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 900, },
			[8789]  = {  nil, 1,  8,  8789,  7056, 180, 200, 215, 230,   1,   1, { 4305, 2604, 6371, 4291, }, { 5, 2, 2, 1, }, nil, nil, 7087, },
			[6695]  = {  nil, 1,  8,  6695,  5765, 185, 205, 220, 235,   1,   1, { 4305, 2325, 2321, }, { 5, 1, 4, }, nil, nil, 5775, },
			[8791]  = {  nil, 1,  8,  8791,  7058, 185, 205, 215, 225,   1,   1, { 4305, 2604, 2321, }, { 4, 2, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 2250, },
			[3861]  = {  nil, 1,  8,  3861,  4326, 185, 205, 220, 235,   1,   1, { 4305, 3827, 4291, }, { 4, 1, 1, }, { 1346, 2399, 4576, 11052, 11557, }, 900, },
			[3872]  = {  nil, 1,  8,  3872,  4335, 185, 195, 200, 205,   1,   1, { 4305, 4342, 4291, }, { 4, 1, 1, }, nil, nil, 4354, },
			[8793]  = {  nil, 1,  8,  8793,  7059, 190, 210, 225, 240,   1,   1, { 4305, 6371, 2604, 4291, }, { 5, 2, 2, 2, }, nil, nil, 7084, },
			[21945] = {  nil, 1,  8, 21945, 17723, 190, 200, 205, 210,   1,   1, { 4305, 2605, 4291, }, { 5, 4, 1, }, nil, nil, 17724, },
			[8795]  = {  nil, 1,  8,  8795,  7060, 190, 210, 225, 240,   1,   1, { 4305, 7072, 6260, 4291, }, { 6, 2, 2, 2, }, nil, nil, 7085, },
			[8770]  = {  nil, 1,  8,  8770,  7054, 190, 210, 225, 240,   1,   1, { 4339, 7067, 7070, 7068, 7069, 4291, }, { 2, 2, 2, 2, 2, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 900, },
			[8799]  = {  nil, 1,  8,  8799,  7062, 195, 215, 225, 235,   1,   1, { 4305, 2604, 4291, }, { 4, 2, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 2700, },
			[8797]  = {  nil, 1,  8,  8797,  7061, 195, 215, 230, 245,   1,   1, { 4305, 7067, 4234, 7071, 4291, }, { 5, 4, 4, 1, 2, }, nil, nil, 7086, },
			[3862]  = {  nil, 1,  8,  3862,  4327, 200, 220, 235, 250,   1,   1, { 4339, 4291, 3829, 4337, }, { 3, 2, 1, 2, }, nil, nil, 4355, },
			[3864]  = {  nil, 1,  8,  3864,  4329, 200, 220, 235, 250,   1,   1, { 4339, 4234, 3864, 7071, 4291, }, { 4, 4, 1, 1, 1, }, nil, nil, 4356, },
			[3873]  = {  nil, 1,  8,  3873,  4336, 200, 210, 215, 220,   1,   1, { 4305, 2325, 4291, }, { 5, 1, 1, }, nil, nil, 10728, },
			[8802]  = {  nil, 1,  8,  8802,  7063, 205, 220, 235, 250,   1,   1, { 4305, 7068, 3827, 2604, 4291, }, { 8, 4, 2, 4, 1, }, nil, nil, 7088, },
			[12048] = {  nil, 1,  8, 12048,  9998, 205, 220, 235, 250,   1,   1, { 4339, 4291, }, { 2, 3, }, { 1346, 2399, 4576, 11052, 11557, }, 3600, },
			[12049] = {  nil, 1,  8, 12049,  9999, 205, 220, 235, 250,   1,   1, { 4339, 4291, }, { 2, 3, }, { 1346, 2399, 4576, 11052, 11557, }, 3600, },
			[12052] = {  nil, 1,  8, 12052, 10002, 210, 225, 240, 255,   1,   1, { 4339, 10285, 8343, }, { 3, 2, 1, }, { 4578, 9584, }, 4050, },
			[12050] = {  nil, 1,  8, 12050, 10001, 210, 225, 240, 255,   1,   1, { 4339, 8343, }, { 3, 1, }, { 1346, 2399, 4576, 11052, 11557, }, 3600, },
			[8804]  = {  nil, 1,  8,  8804,  7064, 210, 225, 240, 255,   1,   1, { 4305, 7068, 6371, 4304, 2604, 4291, }, { 6, 2, 2, 2, 4, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 4500, },
			[12060] = {  nil, 1,  8, 12060, 10009, 215, 230, 245, 260,   1,   1, { 4339, 2604, 8343, }, { 3, 2, 1, }, nil, nil, 10302, },
			[12055] = {  nil, 1,  8, 12055, 10004, 215, 230, 245, 260,   1,   1, { 4339, 10285, 8343, }, { 3, 2, 1, }, { 4578, 9584, }, 4455, },
			[12056] = {  nil, 1,  8, 12056, 10007, 215, 230, 245, 260,   1,   1, { 4339, 2604, 8343, }, { 3, 2, 1, }, nil, nil, 10300, },
			[12061] = {  nil, 1,  8, 12061, 10056, 215, 220, 225, 230,   1,   1, { 4339, 6261, 8343, }, { 1, 1, 1, }, { 1346, 2399, 4576, 11052, 11557, }, 2250, },
			[12059] = {  nil, 1,  8, 12059, 10008, 215, 220, 225, 230,   1,   1, { 4339, 2324, 8343, }, { 1, 1, 1, }, nil, nil, 10301, },
			[12053] = {  nil, 1,  8, 12053, 10003, 215, 230, 245, 260,   1,   1, { 4339, 8343, }, { 2, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 4500, },
			[12064] = {  nil, 1,  8, 12064, 10052, 220, 225, 230, 235,   1,   1, { 4339, 6261, 8343, }, { 2, 2, 1, }, nil, nil, 10311, },
			[12062] = {  nil, 1,  8, 12062, 10010, 220, 235, 250, 265,   1,   1, { 4339, 7079, 8343, }, { 4, 2, 2, }, },
			[12063] = {  nil, 1,  8, 12063, 10011, 220, 235, 250, 265,   1,   1, { 4339, 7079, 8343, }, { 3, 2, 2, }, },
			[12070] = {  nil, 1,  8, 12070, 10021, 225, 240, 255, 270,   1,   1, { 4339, 8153, 10286, 8343, }, { 6, 6, 2, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 4500, },
			[12068] = {  nil, 1,  8, 12068, 10020, 225, 240, 255, 270,   1,   1, { 4339, 7079, 8343, }, { 5, 3, 2, }, },
			[12066] = {  nil, 1,  8, 12066, 10018, 225, 240, 255, 270,   1,   1, { 4339, 2604, 8343, }, { 3, 2, 2, }, nil, nil, 10312, },
			[12065] = {  nil, 1,  8, 12065, 10050, 225, 240, 255, 270,   1,   1, { 4339, 4291, }, { 4, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 4500, },
			[12067] = {  nil, 1,  8, 12067, 10019, 225, 240, 255, 270,   1,   1, { 4339, 8153, 10286, 8343, }, { 4, 4, 2, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 4500, },
			[27658] = {  nil, 1,  8, 27658, 22246, 225, 240, 255, 270,   1,   1, { 4339, 11137, 8343, }, { 4, 4, 2, }, nil, nil, 22307, },
			[12069] = {  nil, 1,  8, 12069, 10042, 225, 240, 255, 270,   1,   1, { 4339, 7077, 8343, }, { 5, 2, 2, }, { 1346, 2399, 4576, 11052, 11557, }, 4500, },
			[12071] = {  nil, 1,  8, 12071, 10023, 225, 240, 255, 270,   1,   1, { 4339, 10285, 8343, }, { 5, 5, 2, }, { 4578, 9584, }, 4860, },
			[12075] = {  nil, 1,  8, 12075, 10054, 230, 235, 240, 245,   1,   1, { 4339, 4342, 8343, }, { 2, 2, 2, }, nil, nil, 10314, },
			[12074] = {  nil, 1,  8, 12074, 10027, 230, 245, 260, 275,   1,   1, { 4339, 8343, }, { 3, 2, }, { 2399, 4578, 9584, 11052, 11557, }, 2400, },
			[12072] = {  nil, 1,  8, 12072, 10024, 230, 245, 260, 275,   1,   1, { 4339, 8343, }, { 3, 2, }, { 2399, 11052, 11557, }, 6000, },
			[12073] = {  nil, 1,  8, 12073, 10026, 230, 245, 260, 275,   1,   1, { 4339, 8343, 4304, }, { 3, 2, 2, }, { 2399, 11052, 11557, }, 5400, },
			[12078] = {  nil, 1,  8, 12078, 10029, 235, 250, 265, 280,   1,   1, { 4339, 2604, 8343, }, { 4, 2, 3, }, nil, nil, 10315, },
			[12077] = {  nil, 1,  8, 12077, 10053, 235, 240, 245, 250,   1,   1, { 4339, 2325, 8343, 2324, }, { 3, 1, 1, 1, }, { 2399, 11052, 11557, }, 4500, },
			[12076] = {  nil, 1,  8, 12076, 10028, 235, 250, 265, 280,   1,   1, { 4339, 10285, 8343, }, { 5, 4, 2, }, { 4578, 9584, }, 5265, },
			[12080] = {  nil, 1,  8, 12080, 10055, 235, 240, 245, 250,   1,   1, { 4339, 10290, 8343, }, { 3, 1, 1, }, nil, nil, 10317, },
			[12079] = {  nil, 1,  8, 12079, 10051, 235, 250, 265, 280,   1,   1, { 4339, 2604, 8343, }, { 4, 2, 2, }, { 2399, 11052, 11557, }, 5850, },
			[12082] = {  nil, 1,  8, 12082, 10031, 240, 255, 270, 285,   1,   1, { 4339, 10285, 8343, 4304, }, { 6, 6, 3, 2, }, { 4578, 9584, }, 5670, },
			[12083] = {  nil, 1,  8, 12083, 10032, 240, 255, 270, 285,   1,   1, { 4339, 7079, 8343, }, { 4, 4, 2, }, },
			[12084] = {  nil, 1,  8, 12084, 10033, 240, 255, 270, 285,   1,   1, { 4339, 2604, 8343, }, { 4, 2, 2, }, nil, nil, 10320, },
			[12085] = {  nil, 1,  8, 12085, 10034, 240, 245, 250, 255,   1,   1, { 4339, 8343, }, { 4, 2, }, nil, nil, 10321, },
			[12081] = {  nil, 1,  8, 12081, 10030, 240, 255, 270, 285,   1,   1, { 4339, 4589, 8343, }, { 3, 6, 2, }, nil, nil, 10318, },
			[12089] = {  nil, 1,  8, 12089, 10035, 245, 250, 255, 260,   1,   1, { 4339, 8343, }, { 4, 3, }, nil, nil, 10323, },
			[12087] = {  nil, 1,  8, 12087, 10038, 245, 260, 275, 290,   1,   1, { 4339, 7079, 8343, }, { 5, 6, 3, }, },
			[12088] = {  nil, 1,  8, 12088, 10044, 245, 260, 275, 290,   1,   1, { 4339, 7077, 8343, 4304, }, { 5, 1, 3, 2, }, { 2399, 11052, 11557, }, 6750, },
			[12086] = {  nil, 1,  8, 12086, 10025, 245, 260, 275, 290,   1,   1, { 4339, 10285, 8343, }, { 2, 8, 2, }, nil, nil, 10463, },
			[26407] = {  nil, 1,  8, 26407, 21542, 250, 265, 280, 295,   1,   1, { 14048, 4625, 2604, 14341, }, { 4, 2, 2, 1, }, nil, nil, 21723, },
			[12093] = {  nil, 1,  8, 12093, 10036, 250, 265, 280, 295,   1,   1, { 4339, 8343, }, { 5, 3, }, nil, nil, 10326, },
			[18560] = {  nil, 1,  8, 18560, 14342, 250, 290, 305, 320,   1,   1, { 14256, }, { 2, }, nil, nil, 14526, },
			[26403] = {  nil, 1,  8, 26403, 21154, 250, 265, 280, 295,   1,   1, { 14048, 4625, 2604, 14341, }, { 4, 2, 2, 1, }, nil, nil, 21722, },
			[12090] = {  nil, 1,  8, 12090, 10039, 250, 265, 280, 295,   1,   1, { 4339, 7079, 8343, 4304, }, { 6, 6, 3, 2, }, },
			[18401] = {  nil, 1,  8, 18401, 14048, 250, 255, 257, 260,   1,   1, { 14047, }, { 5, }, { 2399, 11052, 11557, }, 10000, },
			[12092] = {  nil, 1,  8, 12092, 10041, 250, 265, 280, 295,   1,   1, { 4339, 8153, 10286, 8343, 6037, 1529, }, { 8, 4, 2, 3, 1, 1, }, { 2399, 11052, 11557, }, 6750, },
			[12091] = {  nil, 1,  8, 12091, 10040, 250, 255, 260, 265,   1,   1, { 4339, 8343, 2324, }, { 5, 3, 1, }, nil, nil, 10325, },
			[18403] = {  nil, 1,  8, 18403, 13869, 255, 270, 285, 300,   1,   1, { 14048, 7079, 14341, }, { 5, 2, 1, }, nil, nil, 14466, },
			[18402] = {  nil, 1,  8, 18402, 13856, 255, 270, 285, 300,   1,   1, { 14048, 14341, }, { 3, 1, }, { 2399, 11052, 11557, }, 10000, },
			[18404] = {  nil, 1,  8, 18404, 13868, 255, 270, 285, 300,   1,   1, { 14048, 7079, 14341, }, { 5, 2, 1, }, nil, nil, 14467, },
			[18408] = {  nil, 1,  8, 18408, 14042, 260, 275, 290, 305,   1,   1, { 14048, 7077, 14341, }, { 5, 3, 1, }, nil, nil, 14471, },
			[26085] = {  nil, 1,  8, 26085, 21340, 260, 275, 290, 305,   1,   1, { 14048, 8170, 7972, 14341, }, { 6, 4, 2, 1, }, nil, nil, 21358, },
			[18407] = {  nil, 1,  8, 18407, 13857, 260, 275, 290, 305,   1,   1, { 14048, 14227, 14341, }, { 5, 1, 1, }, nil, nil, 14470, },
			[18406] = {  nil, 1,  8, 18406, 13858, 260, 275, 290, 305,   1,   1, { 14048, 14227, 14341, }, { 5, 1, 1, }, nil, nil, 14469, },
			[18405] = {  nil, 1,  8, 18405, 14046, 260, 275, 290, 305,   1,   1, { 14048, 8170, 14341, }, { 5, 2, 1, }, nil, nil, 14468, },
			[18411] = {  nil, 1,  8, 18411, 13870, 265, 280, 295, 310,   1,   1, { 14048, 7080, 14341, }, { 3, 1, 1, }, nil, nil, 14474, },
			[18410] = {  nil, 1,  8, 18410, 14143, 265, 280, 295, 310,   1,   1, { 14048, 9210, 14227, 14341, }, { 3, 2, 1, 1, }, nil, nil, 14473, },
			[18409] = {  nil, 1,  8, 18409, 13860, 265, 280, 295, 310,   1,   1, { 14048, 14227, 14341, }, { 4, 1, 1, }, nil, nil, 14472, },
			[18412] = {  nil, 1,  8, 18412, 14043, 270, 285, 300, 315,   1,   1, { 14048, 7077, 14341, }, { 4, 3, 1, }, nil, nil, 14476, },
			[18415] = {  nil, 1,  8, 18415, 14101, 270, 285, 300, 315,   1,   1, { 14048, 3577, 14341, }, { 4, 2, 1, }, nil, nil, 14479, },
			[18413] = {  nil, 1,  8, 18413, 14142, 270, 285, 300, 315,   1,   1, { 14048, 9210, 14227, 14341, }, { 4, 2, 1, 1, }, nil, nil, 14477, },
			[18414] = {  nil, 1,  8, 18414, 14100, 270, 285, 300, 315,   1,   1, { 14048, 3577, 14341, }, { 5, 2, 1, }, nil, nil, 14478, },
			[18420] = {  nil, 1,  8, 18420, 14103, 275, 290, 305, 320,   1,   1, { 14048, 3577, 14341, }, { 4, 2, 1, }, nil, nil, 14484, },
			[18418] = {  nil, 1,  8, 18418, 14044, 275, 290, 305, 320,   1,   1, { 14048, 7078, 14341, }, { 5, 1, 1, }, nil, nil, 14482, },
			[18416] = {  nil, 1,  8, 18416, 14141, 275, 290, 305, 320,   1,   1, { 14048, 9210, 14227, 14341, }, { 6, 4, 1, 1, }, nil, nil, 14480, },
			[18422] = {  nil, 1,  8, 18422, 14134, 275, 290, 305, 320,   1,   1, { 14048, 7078, 7077, 7068, 14341, }, { 6, 4, 4, 4, 1, }, nil, nil, 14486, },
			[27724] = {  nil, 5,  8, 27724, 22251, 275, 290, 305, 320,   1,   1, { 14048, 8831, 11040, 14341, }, { 5, 10, 8, 2, }, nil, nil, 22310, },
			[27659] = {  nil, 5,  8, 27659, 22248, 275, 290, 305, 320,   1,   1, { 14048, 16203, 14341, }, { 5, 2, 2, }, nil, nil, 22308, },
			[18419] = {  nil, 1,  8, 18419, 14107, 275, 290, 305, 320,   1,   1, { 14048, 14256, 14341, }, { 5, 4, 1, }, nil, nil, 14483, },
			[18417] = {  nil, 1,  8, 18417, 13863, 275, 290, 305, 320,   1,   1, { 14048, 8170, 14341, }, { 4, 4, 1, }, nil, nil, 14481, },
			[18421] = {  nil, 1,  8, 18421, 14132, 275, 290, 305, 320,   1,   1, { 14048, 11176, 14341, }, { 6, 1, 1, }, nil, nil, 14485, },
			[18434] = {  nil, 1,  8, 18434, 14045, 280, 295, 310, 325,   1,   1, { 14048, 7078, 14341, }, { 6, 1, 1, }, nil, nil, 14490, },
			[18423] = {  nil, 1,  8, 18423, 13864, 280, 295, 310, 325,   1,   1, { 14048, 14227, 8170, 14341, }, { 4, 2, 4, 1, }, nil, nil, 14488, },
			[18424] = {  nil, 1,  8, 18424, 13871, 280, 295, 310, 325,   1,   1, { 14048, 7080, 14341, }, { 6, 1, 1, }, nil, nil, 14489, },
			[22813] = {  nil, 2,  8, 22813, 18258, 285, 285, 290, 295,   1,   1, { 14048, 8170, 18240, 14341, }, { 2, 4, 1, 1, }, nil, nil, nil, { 5519, }, },
			[26086] = {  nil, 1,  8, 26086, 21341, 285, 300, 315, 330,   1,   1, { 14256, 12810, 20520, 14227, }, { 12, 6, 2, 4, }, nil, nil, nil, nil, 180794, },
			[18436] = {  nil, 1,  8, 18436, 14136, 285, 300, 315, 330,   1,   1, { 14048, 14256, 12808, 7080, 14341, }, { 10, 12, 4, 4, 1, }, nil, nil, 14493, },
			[18438] = {  nil, 1,  8, 18438, 13865, 285, 300, 315, 330,   1,   1, { 14048, 14227, 14341, }, { 6, 2, 1, }, nil, nil, 14491, },
			[18437] = {  nil, 1,  8, 18437, 14108, 285, 300, 315, 330,   1,   1, { 14048, 14256, 8170, 14341, }, { 6, 4, 4, 1, }, nil, nil, 14492, },
			[23662] = {  nil, 3,  8, 23662, 19047, 290, 305, 320, 335,   1,   1, { 14048, 7076, 12803, 14227, }, { 8, 3, 3, 2, }, nil, nil, 19215, },
			[19435] = {  nil, 1,  8, 19435, 15802, 290, 295, 310, 325,   1,   1, { 14048, 14342, 7971, 14341, }, { 6, 4, 2, 1, }, nil, nil, nil, { 6032, }, },
			[18442] = {  nil, 1,  8, 18442, 14111, 290, 305, 320, 335,   1,   1, { 14048, 14256, 14341, }, { 5, 4, 1, }, nil, nil, 14496, },
			[23664] = {  nil, 3,  8, 23664, 19056, 290, 305, 320, 335,   1,   1, { 14048, 12810, 13926, 12809, 14227, }, { 6, 4, 2, 2, 2, }, nil, nil, 19216, },
			[18439] = {  nil, 1,  8, 18439, 14104, 290, 305, 320, 335,   1,   1, { 14048, 3577, 14227, 14341, }, { 6, 4, 1, 1, }, nil, nil, 14494, },
			[18440] = {  nil, 1,  8, 18440, 14137, 290, 305, 320, 335,   1,   1, { 14048, 14342, 14341, }, { 6, 4, 1, }, nil, nil, 14497, },
			[18441] = {  nil, 1,  8, 18441, 14144, 290, 305, 320, 335,   1,   1, { 14048, 9210, 14341, }, { 6, 4, 1, }, nil, nil, 14495, },
			[18444] = {  nil, 1,  8, 18444, 13866, 295, 310, 325, 340,   1,   1, { 14048, 14227, 14341, }, { 4, 2, 1, }, nil, nil, 14498, },
			[27725] = {  nil, 5,  8, 27725, 22252, 300, 315, 330, 345,   1,   1, { 14048, 14342, 13468, 14227, }, { 6, 2, 1, 4, }, nil, nil, 22312, },
			[24903] = {  nil, 4,  8, 24903, 20537, 300, 315, 330, 345,   1,   1, { 14048, 20520, 14256, 12810, 14227, }, { 4, 6, 4, 2, 2, }, nil, nil, 20547, },
			[18452] = {  nil, 1,  8, 18452, 14140, 300, 315, 330, 345,   1,   1, { 14048, 14342, 12800, 12810, 14341, }, { 4, 6, 1, 2, 2, }, nil, nil, 14509, },
			[26087] = {  nil, 1,  8, 26087, 21342, 300, 315, 330, 345,   1,   1, { 14256, 17012, 19726, 7078, 14227, }, { 20, 16, 8, 4, 4, }, nil, nil, 21371, },
			[24902] = {  nil, 4,  8, 24902, 20539, 300, 315, 330, 345,   1,   1, { 14048, 20520, 14256, 12810, 14227, }, { 2, 6, 2, 2, 2, }, nil, nil, 20548, },
			[18457] = {  nil, 1,  8, 18457, 14152, 300, 315, 330, 345,   1,   1, { 14048, 7078, 7082, 7076, 7080, 14341, }, { 12, 10, 10, 10, 10, 2, }, nil, nil, 14513, },
			[28209] = {  nil, 6,  8, 28209, 22655, 300, 315, 330, 345,   1,   1, { 22682, 14048, 7080, 14227, }, { 4, 2, 2, 4, }, { 16365, }, 0, nil, { 9233, }, },
			[22866] = {  nil, 2,  8, 22866, 18405, 300, 315, 330, 345,   1,   1, { 14048, 9210, 14342, 7080, 7078, 14344, 14341, }, { 16, 10, 10, 12, 12, 6, 6, }, nil, nil, 18414, },
			[23665] = {  nil, 3,  8, 23665, 19059, 300, 315, 330, 345,   1,   1, { 14342, 12809, 14227, }, { 5, 2, 2, }, nil, nil, 19217, },
			[24901] = {  nil, 4,  8, 24901, 20538, 300, 315, 330, 345,   1,   1, { 14048, 20520, 14256, 14227, }, { 6, 8, 6, 2, }, nil, nil, 20546, },
			[28482] = {  nil, 6,  8, 28482, 22758, 300, 315, 330, 345,   1,   1, { 14048, 12803, 14227, }, { 2, 4, 2, }, nil, nil, 22772, },
			[18454] = {  nil, 1,  8, 18454, 14146, 300, 315, 330, 345,   1,   1, { 14048, 14342, 9210, 13926, 12364, 12810, 14341, }, { 10, 10, 10, 6, 6, 8, 2, }, nil, nil, 14511, },
			[22867] = {  nil, 2,  8, 22867, 18407, 300, 315, 330, 345,   1,   1, { 14048, 14256, 12662, 12808, 14341, }, { 12, 20, 6, 8, 2, }, nil, nil, 18415, },
			[22870] = {  nil, 2,  8, 22870, 18413, 300, 315, 330, 345,   1,   1, { 14048, 12809, 12360, 14341, }, { 12, 4, 1, 2, }, nil, nil, 18418, },
			[18458] = {  nil, 1,  8, 18458, 14153, 300, 315, 330, 345,   1,   1, { 14048, 12662, 14256, 7078, 12808, 14341, }, { 12, 20, 40, 12, 12, 2, }, nil, nil, 14514, },
			[28208] = {  nil, 6,  8, 28208, 22658, 300, 315, 330, 345,   1,   1, { 22682, 14048, 7080, 14227, }, { 5, 4, 2, 4, }, { 16365, }, 0, nil, { 9233, }, },
			[20848] = {  nil, 1,  8, 20848, 16980, 300, 315, 330, 345,   1,   1, { 14048, 17010, 17011, 12810, 14341, }, { 12, 4, 4, 6, 2, }, nil, nil, 17017, },
			[28481] = {  nil, 6,  8, 28481, 22757, 300, 315, 330, 345,   1,   1, { 14048, 14342, 12803, 14227, }, { 4, 2, 2, 2, }, nil, nil, 22773, },
			[22759] = {  nil, 1,  8, 22759, 18263, 300, 320, 335, 350,   1,   1, { 14342, 17010, 7078, 12810, 14341, }, { 6, 8, 2, 6, 4, }, nil, nil, 18265, },
			[24091] = {  nil, 4,  8, 24091, 19682, 300, 315, 330, 345,   1,   1, { 14342, 19726, 12804, 14048, 14227, }, { 3, 5, 4, 4, 2, }, nil, nil, 19764, },
			[18453] = {  nil, 1,  8, 18453, 14112, 300, 315, 330, 345,   1,   1, { 14048, 14256, 12662, 8170, 14341, }, { 7, 6, 4, 4, 2, }, nil, nil, 14508, },
			[28210] = {  nil, 6,  8, 28210, 22660, 300, 315, 330, 345,   1,   1, { 19726, 14342, 12803, 14227, }, { 1, 2, 4, 4, }, nil, nil, 22683, },
			[18446] = {  nil, 1,  8, 18446, 14128, 300, 315, 330, 345,   1,   1, { 14048, 11176, 14341, }, { 8, 2, 1, }, nil, nil, 14500, },
			[28480] = {  nil, 6,  8, 28480, 22756, 300, 315, 330, 345,   1,   1, { 14048, 19726, 12803, 14227, }, { 4, 2, 2, 2, }, nil, nil, 22774, },
			[23663] = {  nil, 3,  8, 23663, 19050, 300, 315, 330, 345,   1,   1, { 14342, 7076, 12803, 14227, }, { 5, 5, 5, 2, }, nil, nil, 19218, },
			[18449] = {  nil, 1,  8, 18449, 13867, 300, 315, 330, 345,   1,   1, { 14048, 14227, 8170, 14341, }, { 7, 2, 4, 1, }, nil, nil, 14504, },
			[28207] = {  nil, 6,  8, 28207, 22652, 300, 315, 330, 345,   1,   1, { 22682, 14048, 7080, 14227, }, { 7, 8, 6, 8, }, { 16365, }, 0, nil, { 9233, }, },
			[23666] = {  nil, 3,  8, 23666, 19156, 300, 315, 330, 345,   1,   1, { 14342, 17010, 17011, 7078, 14227, }, { 10, 2, 3, 6, 4, }, nil, nil, 19219, },
			[18455] = {  nil, 1,  8, 18455, 14156, 300, 315, 330, 345,   1,   1, { 14048, 14342, 14344, 17012, 14341, }, { 8, 12, 2, 2, 2, }, nil, nil, 14510, },
			[23667] = {  nil, 3,  8, 23667, 19165, 300, 315, 330, 345,   1,   1, { 14342, 17010, 17011, 7078, 14227, }, { 8, 5, 3, 10, 4, }, nil, nil, 19220, },
			[18448] = {  nil, 1,  8, 18448, 14139, 300, 315, 330, 345,   1,   1, { 14048, 14342, 14341, }, { 5, 5, 1, }, nil, nil, 14507, },
			[28205] = {  nil, 6,  8, 28205, 22654, 300, 315, 330, 345,   1,   1, { 22682, 14048, 7080, 14227, }, { 5, 4, 4, 4, }, { 16365, }, 0, nil, { 9233, }, },
			[24092] = {  nil, 4,  8, 24092, 19683, 300, 315, 330, 345,   1,   1, { 14342, 19726, 12804, 14048, 14227, }, { 4, 4, 4, 4, 2, }, nil, nil, 19765, },
			[18450] = {  nil, 1,  8, 18450, 14130, 300, 315, 330, 345,   1,   1, { 14048, 11176, 7910, 14341, }, { 6, 4, 1, 1, }, nil, nil, 14505, },
			[18447] = {  nil, 1,  8, 18447, 14138, 300, 315, 330, 345,   1,   1, { 14048, 14342, 14341, }, { 6, 4, 1, }, nil, nil, 14501, },
			[24093] = {  nil, 4,  8, 24093, 19684, 300, 315, 330, 345,   1,   1, { 14342, 19726, 12810, 14048, 14227, }, { 3, 3, 4, 4, 4, }, nil, nil, 19766, },
			[22902] = {  nil, 2,  8, 22902, 18486, 300, 315, 330, 345,   1,   1, { 14048, 14342, 13926, 14341, }, { 6, 4, 2, 2, }, nil, nil, 18487, },
			[22868] = {  nil, 2,  8, 22868, 18408, 300, 315, 330, 345,   1,   1, { 14048, 7078, 7910, 14341, }, { 12, 10, 2, 2, }, nil, nil, 18416, },
			[18456] = {  nil, 1,  8, 18456, 14154, 300, 315, 330, 345,   1,   1, { 14048, 14342, 12811, 13926, 9210, 14341, }, { 12, 10, 4, 4, 10, 2, }, nil, nil, 14512, },
			[18451] = {  nil, 1,  8, 18451, 14106, 300, 315, 330, 345,   1,   1, { 14048, 14256, 12662, 14341, }, { 8, 8, 4, 2, }, nil, nil, 14506, },
			[22869] = {  nil, 2,  8, 22869, 18409, 300, 315, 330, 345,   1,   1, { 14048, 14342, 13926, 14341, }, { 12, 6, 2, 2, }, nil, nil, 18417, },
			[20849] = {  nil, 1,  8, 20849, 16979, 300, 315, 330, 345,   1,   1, { 14048, 17010, 7078, 12810, 14341, }, { 8, 6, 4, 2, 2, }, nil, nil, 17018, },
			[18445] = {  nil, 1,  8, 18445, 14155, 300, 315, 330, 345,   1,   1, { 14048, 14342, 14341, }, { 4, 1, 1, }, nil, nil, 14499, },
			[27660] = {  nil, 5,  8, 27660, 22249, 300, 315, 330, 345,   1,   1, { 14048, 14344, 12810, 14227, }, { 6, 4, 4, 4, }, nil, nil, 22309, },
			[12900] = {  nil, 1,  9, 12900, 10719,   1, 205, 225, 245,   1,   1, { 10559, 10560, 3860, }, { 1, 1, 4, }, },
			[3919]  = {  nil, 1,  9,  3919,  4358,   1,  30,  45,  60,   2,   2, { 4357, 2589, }, { 2, 1, }, },
			[12722] = {  nil, 1,  9, 12722, 10585,   1, 240, 250, 260,   1,   1, { 10561, 3860, 4389, 10560, }, { 1, 2, 1, 1, }, },
			[12719] = {  nil, 1,  9, 12719, 10579,   1, 210, 230, 250, 100, 100, { 3030, 10505, 3860, }, { 100, 2, 2, }, },
			[3918]  = {  nil, 1,  9,  3918,  4357,   1,  20,  30,  40,   1,   1, { 2835, }, { 1, }, },
			[12720] = {  nil, 1,  9, 12720, 10580,   1, 235, 245, 255,   1,   1, { 10561, 10505, 10558, 3860, }, { 1, 2, 1, 2, }, },
			[12904] = {  nil, 1,  9, 12904, 10723,   1, 240, 250, 260,   1,   1, { 10561, 3860, 4389, 10560, }, { 1, 2, 1, 1, }, },
			[3920]  = {  nil, 1,  9,  3920,  8067,   1,  30,  45,  60, 200, 200, { 4357, 2840, }, { 1, 1, }, },
			[3923]  = {  nil, 1,  9,  3923,  4360,  30,  60,  75,  90,   2,   2, { 2840, 4359, 4357, 2589, }, { 1, 1, 2, 1, }, { 1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037, }, 130, },
			[3922]  = {  nil, 1,  9,  3922,  4359,  30,  45,  52,  60,   1,   1, { 2840, }, { 1, }, { 1676, 1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037, }, 115, },
			[3924]  = {  nil, 1,  9,  3924,  4361,  50,  80,  95, 110,   1,   1, { 2840, 2880, }, { 2, 1, }, { 1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037, }, 150, },
			[3925]  = {  nil, 1,  9,  3925,  4362,  50,  80,  95, 110,   1,   1, { 4361, 4359, 4399, }, { 1, 1, 1, }, { 1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037, }, 150, },
			[7430]  = {  nil, 1,  9,  7430,  6219,  50,  70,  80,  90,   1,   1, { 2840, }, { 6, }, { 1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037, }, 150, },
			[3977]  = {  nil, 1,  9,  3977,  4405,  60,  90, 105, 120,   1,   1, { 4361, 774, 4359, }, { 1, 1, 1, }, { 1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037, }, 200, },
			[3926]  = {  nil, 1,  9,  3926,  4363,  65,  95, 110, 125,   1,   1, { 4359, 2840, 2589, }, { 2, 1, 2, }, { 1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037, }, 225, },
			[3928]  = {  nil, 1,  9,  3928,  4401,  75, 105, 120, 135,   1,   1, { 4363, 4359, 2840, 774, }, { 1, 1, 1, 2, }, nil, nil, 4408, },
			[3929]  = {  nil, 1,  9,  3929,  4364,  75,  85,  90,  95,   1,   1, { 2836, }, { 1, }, { 1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037, }, 250, },
			[3931]  = {  nil, 1,  9,  3931,  4365,  75,  90,  97, 105,   1,   3, { 4364, 2589, }, { 3, 1, }, { 1676, 1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037, }, 250, },
			[3930]  = {  nil, 1,  9,  3930,  8068,  75,  85,  90,  95, 200, 200, { 4364, 2840, }, { 1, 1, }, { 1676, 1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037, }, 250, },
			[3932]  = {  nil, 1,  9,  3932,  4366,  85, 115, 130, 145,   1,   1, { 4363, 4359, 2841, 2592, }, { 1, 2, 1, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 270, },
			[3973]  = {  nil, 1,  9,  3973,  4404,  90, 110, 125, 140,   5,   5, { 2842, }, { 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 270, },
			[3934]  = {  nil, 1,  9,  3934,  4368, 100, 130, 145, 160,   1,   1, { 2318, 818, }, { 6, 2, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 360, },
			[8339]  = {  nil, 1,  9,  8339,  6714, 100, 115, 122, 130,   1,   3, { 4364, 2592, }, { 4, 1, }, nil, nil, 6716, },
			[3933]  = {  nil, 1,  9,  3933,  4367, 100, 130, 145, 160,   1,   1, { 4364, 4363, 2318, 159, }, { 2, 1, 1, 1, }, nil, nil, 4409, },
			[8334]  = {  nil, 1,  9,  8334,  6712, 100, 115, 122, 130,   1,   1, { 2841, 4359, 2880, }, { 1, 2, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 270, },
			[3938]  = {  nil, 1,  9,  3938,  4371, 105, 105, 130, 155,   1,   1, { 2841, 2880, }, { 2, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 405, },
			[3937]  = {  nil, 1,  9,  3937,  4370, 105, 105, 130, 155,   2,   4, { 2840, 4364, 4404, }, { 3, 4, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 405, },
			[3936]  = {  nil, 1,  9,  3936,  4369, 105, 130, 142, 155,   1,   1, { 4361, 4359, 4399, 2319, }, { 2, 4, 1, 2, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 378, },
			[3978]  = {  nil, 1,  9,  3978,  4406, 110, 135, 147, 160,   1,   1, { 4371, 1206, }, { 1, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 427, },
			[3941]  = {  nil, 1,  9,  3941,  4374, 120, 120, 145, 170,   1,   3, { 4364, 2841, 4404, 2592, }, { 4, 2, 1, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 450, },
			[3939]  = {  nil, 1,  9,  3939,  4372, 120, 145, 157, 170,   1,   1, { 4371, 4359, 4400, 1206, }, { 2, 2, 1, 3, }, nil, nil, 13309, },
			[3940]  = {  nil, 1,  9,  3940,  4373, 120, 145, 157, 170,   1,   1, { 2319, 1210, }, { 4, 2, }, nil, nil, 4410, },
			[3942]  = {  nil, 1,  9,  3942,  4375, 125, 125, 150, 175,   1,   1, { 2841, 2592, }, { 2, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 450, },
			[3944]  = {  nil, 1,  9,  3944,  4376, 125, 125, 150, 175,   1,   1, { 4375, 4402, }, { 1, 1, }, nil, nil, 4411, },
			[26418] = {  nil, 1,  9, 26418, 21557, 125, 125, 137, 150,   3,   3, { 4364, 2319, }, { 1, 1, }, nil, nil, 21726, },
			[3946]  = {  nil, 1,  9,  3946,  4378, 125, 125, 135, 145,   1,   5, { 4377, 2592, }, { 2, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 450, },
			[9269]  = {  nil, 1,  9,  9269,  7506, 125, 150, 162, 175,   1,   1, { 2841, 4375, 814, 818, 774, }, { 6, 1, 2, 1, 1, }, nil, nil, 7560, },
			[26417] = {  nil, 1,  9, 26417, 21559, 125, 125, 137, 150,   3,   3, { 4364, 2319, }, { 1, 1, }, nil, nil, 21725, },
			[3947]  = {  nil, 1,  9,  3947,  8069, 125, 125, 135, 145, 200, 200, { 4377, 2841, }, { 1, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 270, },
			[26416] = {  nil, 1,  9, 26416, 21558, 125, 125, 137, 150,   3,   3, { 4364, 2319, }, { 1, 1, }, nil, nil, 21724, },
			[3945]  = {  nil, 1,  9,  3945,  4377, 125, 125, 135, 145,   1,   1, { 2838, }, { 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 450, },
			[3949]  = {  nil, 1,  9,  3949,  4379, 130, 155, 167, 180,   1,   1, { 4371, 4375, 4400, 2842, }, { 2, 2, 1, 3, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 495, },
			[6458]  = {  nil, 1,  9,  6458,  5507, 135, 160, 172, 185,   1,   1, { 4371, 4375, 4363, 1206, }, { 2, 2, 1, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 360, },
			[3950]  = {  nil, 1,  9,  3950,  4380, 140, 140, 165, 190,   2,   4, { 4377, 2841, 4404, }, { 2, 3, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 540, },
			[3952]  = {  nil, 1,  9,  3952,  4381, 140, 165, 177, 190,   1,   1, { 4371, 4375, 2319, 1206, }, { 1, 2, 2, 1, }, nil, nil, 14639, },
			[3953]  = {  nil, 1,  9,  3953,  4382, 145, 145, 170, 195,   1,   1, { 2841, 2319, 2592, }, { 2, 1, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 540, },
			[3954]  = {  nil, 1,  9,  3954,  4383, 145, 170, 182, 195,   1,   1, { 4371, 4375, 4400, 1705, }, { 3, 3, 1, 2, }, nil, nil, 4412, },
			[3956]  = {  nil, 1,  9,  3956,  4385, 150, 175, 187, 200,   1,   1, { 2319, 1206, 4368, }, { 4, 2, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 675, },
			[23066] = {  nil, 1,  9, 23066,  9318, 150, 150, 162, 175,   3,   3, { 4377, 4234, }, { 1, 1, }, nil, nil, 18647, },
			[23067] = {  nil, 1,  9, 23067,  9312, 150, 150, 162, 175,   3,   3, { 4377, 4234, }, { 1, 1, }, nil, nil, 18649, },
			[12584] = {  nil, 1,  9, 12584, 10558, 150, 150, 170, 190,   3,   3, { 3577, }, { 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 900, },
			[3955]  = {  nil, 1,  9,  3955,  4384, 150, 175, 187, 200,   1,   1, { 4382, 4375, 4377, 2592, }, { 1, 1, 2, 2, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 675, },
			[9271]  = {  nil, 1,  9,  9271,  6533, 150, 150, 160, 170,   3,   3, { 2841, 6530, 4364, }, { 2, 1, 1, }, { 1676, 3412, 5174, 5518, 8736, 11017, 11029, 11031, }, 450, },
			[23068] = {  nil, 1,  9, 23068,  9313, 150, 150, 162, 175,   3,   3, { 4377, 4234, }, { 1, 1, }, nil, nil, 18648, },
			[3957]  = {  nil, 1,  9,  3957,  4386, 155, 175, 185, 195,   1,   1, { 4375, 3829, }, { 1, 1, }, nil, nil, 13308, },
			[3959]  = {  nil, 1,  9,  3959,  4388, 160, 180, 190, 200,   1,   1, { 4375, 4306, 1529, 4371, }, { 3, 2, 1, 1, }, nil, nil, 4413, },
			[3958]  = {  nil, 1,  9,  3958,  4387, 160, 160, 170, 180,   1,   1, { 3575, }, { 2, }, { 5174, 8736, 11017, }, 720, },
			[3960]  = {  nil, 1,  9,  3960,  4403, 165, 185, 195, 205,   1,   1, { 4371, 4387, 4377, 2319, }, { 4, 1, 4, 4, }, nil, nil, 4414, },
			[9273]  = {  nil, 1,  9,  9273,  7148, 165, 160, 180, 200,   1,   1, { 3575, 4375, 814, 4306, 1210, 7191, }, { 6, 2, 2, 2, 2, 1, }, nil, nil, 7561, },
			[3961]  = {  nil, 1,  9,  3961,  4389, 170, 170, 190, 210,   1,   1, { 3575, 10558, }, { 1, 1, }, { 5174, 8736, 11017, }, 810, },
			[26421] = {  nil, 1,  9, 26421, 21590, 175, 175, 187, 200,   3,   3, { 4377, 4234, }, { 1, 1, }, nil, nil, 21728, },
			[12587] = {  nil, 1,  9, 12587, 10499, 175, 195, 205, 215,   1,   1, { 4234, 3864, }, { 6, 2, }, nil, nil, 10601, },
			[26420] = {  nil, 1,  9, 26420, 21589, 175, 175, 187, 200,   3,   3, { 4377, 4234, }, { 1, 1, }, nil, nil, 21727, },
			[3963]  = {  nil, 1,  9,  3963,  4391, 175, 175, 195, 215,   1,   1, { 4387, 4382, 4389, 4234, }, { 2, 1, 2, 4, }, { 5174, 8736, 11017, }, 900, },
			[12586] = {  nil, 1,  9, 12586, 10507, 175, 175, 185, 195,   2,   2, { 10505, 4306, }, { 1, 1, }, { 5174, 8736, 11017, }, 900, },
			[12585] = {  nil, 1,  9, 12585, 10505, 175, 175, 185, 195,   1,   1, { 7912, }, { 2, }, { 5174, 8736, 11017, }, 900, },
			[12590] = {  nil, 1,  9, 12590, 10498, 175, 175, 195, 215,   1,   1, { 3859, }, { 4, }, { 5174, 8736, 11017, }, 900, },
			[3962]  = {  nil, 1,  9,  3962,  4390, 175, 175, 195, 215,   2,   4, { 3575, 4377, 4306, }, { 1, 1, 1, }, { 5174, 8736, 11017, }, 900, },
			[26422] = {  nil, 1,  9, 26422, 21592, 175, 175, 187, 200,   3,   3, { 4377, 4234, }, { 1, 1, }, nil, nil, 21729, },
			[3979]  = {  nil, 1,  9,  3979,  4407, 180, 200, 210, 220,   1,   1, { 4371, 1529, 3864, }, { 1, 1, 1, }, nil, nil, 13310, },
			[3965]  = {  nil, 1,  9,  3965,  4392, 185, 185, 205, 225,   1,   1, { 4387, 4382, 4389, 4234, }, { 1, 1, 1, 4, }, { 5174, 8736, 11017, }, 1080, },
			[8243]  = {  nil, 1,  9,  8243,  4852, 185, 185, 205, 225,   1,   1, { 4611, 4377, 4306, }, { 1, 1, 1, }, nil, nil, 6672, },
			[3966]  = {  nil, 1,  9,  3966,  4393, 185, 205, 215, 225,   1,   1, { 4234, 3864, }, { 6, 2, }, nil, nil, 4415, },
			[3967]  = {  nil, 1,  9,  3967,  4394, 190, 190, 210, 230,   2,   2, { 3575, 4377, 4404, }, { 3, 3, 1, }, { 5174, 8736, 11017, }, 1260, },
			[21940] = {  nil, 1,  9, 21940, 17716, 190, 190, 210, 230,   1,   1, { 3860, 4389, 17202, 3829, }, { 8, 4, 4, 1, }, nil, nil, 17720, },
			[3968]  = {  nil, 1,  9,  3968,  4395, 195, 215, 225, 235,   1,   1, { 4377, 3575, 4389, }, { 3, 2, 1, }, nil, nil, 4416, },
			[12589] = {  nil, 1,  9, 12589, 10559, 195, 195, 215, 235,   1,   1, { 3860, }, { 3, }, { 5174, 8736, 11017, }, 1170, },
			[12895] = {  nil, 1,  9, 12895, 10713, 205, 205, 205, 205,   1,   1, { 10648, 10647, }, { 1, 1, }, { 7406, 7944, 8738, }, 0, },
			[15255] = {  nil, 1,  9, 15255, 11590, 200, 200, 220, 240,   1,   1, { 3860, 4338, 10505, }, { 1, 1, 1, }, { 5174, 8736, 11017, }, 1350, },
			[23069] = {  nil, 1,  9, 23069, 18588, 200, 200, 210, 220,   1,   1, { 10505, 4338, }, { 1, 2, }, nil, nil, 18650, },
			[3971]  = {  nil, 1,  9,  3971,  4397, 200, 220, 230, 240,   1,   1, { 4389, 1529, 1705, 3864, 7191, }, { 4, 2, 2, 2, 1, }, nil, nil, 7742, },
			[3969]  = {  nil, 1,  9,  3969,  4396, 200, 220, 230, 240,   1,   1, { 4382, 4387, 4389, 3864, 7191, }, { 1, 4, 4, 2, 1, }, nil, nil, 13311, },
			[3972]  = {  nil, 1,  9,  3972,  4398, 200, 200, 220, 240,   1,   1, { 10505, 4234, 159, }, { 2, 2, 1, }, nil, nil, 4417, },
			[12591] = {  nil, 1,  9, 12591, 10560, 200, 200, 220, 240,   1,   1, { 3860, 4338, 10505, }, { 1, 1, 1, }, { 5174, 8736, 11017, }, 1350, },
			[12715] = {  nil, 1,  9, 12715, 10644, 205, 205, 205, 205,   1,   1, { 10648, 10647, }, { 1, 1, }, { 8126, 8738, }, 0, },
			[12594] = {  nil, 1,  9, 12594, 10500, 205, 225, 235, 245,   1,   1, { 4385, 3864, 7068, 4234, }, { 1, 2, 2, 4, }, { 5174, 8736, 11017, }, 1440, },
			[12760] = {  nil, 1,  9, 12760, 10646, 205, 205, 225, 245,   1,   1, { 4338, 10505, 10560, }, { 1, 3, 1, }, { 8126, 8738, }, 0, },
			[15628] = {  nil, 1,  9, 15628, 11825, 205, 205, 205, 205,   1,   1, { 4394, 7077, 7191, 3860, }, { 1, 1, 1, 6, }, nil, nil, 11828, },
			[12717] = {  nil, 1,  9, 12717, 10542, 205, 225, 235, 245,   1,   1, { 3860, 3864, 7067, }, { 8, 1, 4, }, { 8126, 8738, }, 0, },
			[12899] = {  nil, 1,  9, 12899, 10716, 205, 225, 235, 245,   1,   1, { 10559, 10560, 3860, 8151, 1529, }, { 1, 1, 4, 4, 2, }, { 7406, 7944, }, 0, },
			[13240] = {  nil, 1,  9, 13240, 10577, 205, 225, 235, 245,   1,   1, { 10577, 3860, 10505, }, { 1, 1, 3, }, { 8126, }, 0, },
			[12716] = {  nil, 1,  9, 12716, 10577, 205, 225, 235, 245,   1,   1, { 10559, 3860, 10505, 10558, 7068, }, { 2, 4, 5, 1, 1, }, { 8126, 8738, }, 0, },
			[15633] = {  nil, 1,  9, 15633, 11826, 205, 205, 205, 205,   1,   1, { 7075, 4389, 7191, 3860, 6037, }, { 1, 2, 1, 2, 1, }, nil, nil, 11827, },
			[12718] = {  nil, 1,  9, 12718, 10543, 205, 225, 235, 245,   1,   1, { 3860, 3864, 7068, }, { 8, 1, 4, }, { 8126, 8738, }, 0, },
			[12595] = {  nil, 1,  9, 12595, 10508, 205, 225, 235, 245,   1,   1, { 10559, 10560, 4400, 3860, 7068, }, { 1, 1, 1, 4, 2, }, { 5174, 8736, 11017, }, 1440, },
			[12596] = {  nil, 1,  9, 12596, 10512, 210, 210, 230, 250, 200, 200, { 3860, 10505, }, { 1, 1, }, { 5174, 8736, 11017, }, 1530, },
			[12897] = {  nil, 1,  9, 12897, 10545, 210, 230, 240, 250,   1,   1, { 10500, 10559, 10558, 8151, 4234, }, { 1, 1, 2, 2, 2, }, { 7406, 7944, }, 0, },
			[12902] = {  nil, 1,  9, 12902, 10720, 210, 230, 240, 250,   1,   1, { 10559, 10285, 4337, 10505, 3860, }, { 1, 2, 4, 2, 4, }, { 7406, 7944, }, 0, },
			[12597] = {  nil, 1,  9, 12597, 10546, 210, 230, 240, 250,   1,   1, { 10559, 7909, 4304, }, { 1, 2, 2, }, nil, nil, 10602, },
			[12599] = {  nil, 1,  9, 12599, 10561, 215, 215, 235, 255,   1,   1, { 3860, }, { 3, }, { 5174, 8736, 11017, }, 1620, },
			[12907] = {  nil, 1,  9, 12907, 10726, 235, 255, 265, 275,   1,   1, { 3860, 6037, 10558, 7910, 4338, }, { 10, 4, 1, 2, 4, }, { 7406, 7944, }, 0, },
			[12903] = {  nil, 1,  9, 12903, 10721, 215, 235, 245, 255,   1,   1, { 7387, 3860, 6037, 10560, 7909, }, { 1, 4, 2, 1, 2, }, { 7406, 7944, }, 0, },
			[12603] = {  nil, 1,  9, 12603, 10514, 215, 215, 235, 255,   3,   3, { 10561, 10560, 10505, }, { 1, 1, 1, }, { 5174, 8736, 11017, }, 1620, },
			[12614] = {  nil, 1,  9, 12614, 10510, 220, 240, 250, 260,   1,   1, { 10559, 10560, 4400, 3860, 3864, }, { 2, 1, 1, 6, 2, }, nil, nil, 10604, },
			[12607] = {  nil, 1,  9, 12607, 10501, 220, 240, 250, 260,   1,   1, { 4304, 7909, 10592, }, { 4, 2, 1, }, nil, nil, 10603, },
			[26442] = {  nil, 1,  9, 26442, 21569, 225, 245, 255, 265,   1,   1, { 9060, 9061, 10560, 10561, }, { 1, 1, 1, 1, }, nil, nil, 21738, },
			[12616] = {  nil, 1,  9, 12616, 10518, 225, 245, 255, 265,   1,   1, { 4339, 10285, 10560, 10505, }, { 4, 2, 1, 4, }, nil, nil, 10606, },
			[12905] = {  nil, 1,  9, 12905, 10724, 225, 245, 255, 265,   1,   1, { 10026, 10559, 4234, 10505, 4389, }, { 1, 2, 4, 8, 4, }, { 7406, 7944, }, 0, },
			[12615] = {  nil, 1,  9, 12615, 10502, 225, 245, 255, 265,   1,   1, { 4304, 7910, }, { 4, 2, }, nil, nil, 10605, },
			[26423] = {  nil, 1,  9, 26423, 21571, 225, 225, 237, 250,   3,   3, { 10505, 4304, }, { 1, 1, }, nil, nil, 21730, },
			[12754] = {  nil, 1,  9, 12754, 10586, 235, 235, 255, 275,   2,   2, { 10561, 9061, 10507, 10560, }, { 1, 1, 6, 1, }, { 8126, 8738, }, 0, },
			[8895]  = {  nil, 1,  9,  8895,  7189, 225, 245, 255, 265,   1,   1, { 10026, 10559, 4234, 9061, 10560, }, { 1, 2, 4, 2, 1, }, { 8126, 8738, }, 2200, },
			[26425] = {  nil, 1,  9, 26425, 21576, 225, 225, 237, 250,   3,   3, { 10505, 4304, }, { 1, 1, }, nil, nil, 21732, },
			[26424] = {  nil, 1,  9, 26424, 21574, 225, 225, 237, 250,   3,   3, { 10505, 4304, }, { 1, 1, }, nil, nil, 21731, },
			[12906] = {  nil, 1,  9, 12906, 10725, 230, 250, 260, 270,   1,   1, { 10561, 6037, 3860, 9060, 10558, 1529, }, { 1, 6, 6, 2, 1, 2, }, { 7406, 7944, }, 0, },
			[12617] = {  nil, 1,  9, 12617, 10506, 230, 250, 260, 270,   1,   1, { 3860, 10561, 6037, 818, 774, }, { 8, 1, 1, 4, 4, }, nil, nil, 10607, },
			[12618] = {  nil, 1,  9, 12618, 10503, 230, 250, 260, 270,   1,   1, { 4304, 7910, }, { 6, 2, }, { 8736, }, 1980, },
			[12755] = {  nil, 1,  9, 12755, 10587, 230, 230, 250, 270,   1,   1, { 10561, 10505, 6037, 10560, 4407, }, { 2, 4, 6, 1, 2, }, { 8126, 8738, }, 0, },
			[12619] = {  nil, 1,  9, 12619, 10562, 235, 235, 255, 275,   4,   4, { 10561, 10560, 10505, }, { 2, 1, 2, }, { 8736, }, 2160, },
			[12758] = {  nil, 1,  9, 12758, 10588, 245, 265, 275, 285,   1,   1, { 10543, 9061, 3860, 10560, }, { 1, 4, 4, 1, }, { 8126, 8738, }, 0, },
			[12908] = {  nil, 1,  9, 12908, 10727, 240, 260, 270, 280,   1,   1, { 10559, 9061, 3860, 6037, 10560, }, { 2, 4, 6, 6, 1, }, { 8126, 8738, }, 0, },
			[12620] = {  nil, 1,  9, 12620, 10548, 240, 260, 270, 280,   1,   1, { 10559, 7910, 6037, }, { 1, 1, 2, }, nil, nil, 10608, },
			[12759] = {  nil, 1,  9, 12759, 10645, 240, 260, 270, 280,   1,   1, { 10559, 10560, 12808, 7972, 9060, }, { 2, 1, 1, 4, 1, }, { 7406, 7944, }, 0, },
			[12621] = {  nil, 1,  9, 12621, 10513, 245, 245, 265, 285, 200, 200, { 3860, 10505, }, { 2, 2, }, { 8736, }, 2800, },
			[12622] = {  nil, 1,  9, 12622, 10504, 245, 265, 275, 285,   1,   1, { 4304, 1529, 7909, 10286, 8153, }, { 8, 3, 3, 2, 2, }, { 8736, }, 2800, },
			[23070] = {  nil, 1,  9, 23070, 18641, 250, 250, 260, 270,   2,   2, { 15992, 14047, }, { 2, 3, }, { 8736, }, 5000, },
			[23507] = {  nil, 1,  9, 23507, 19026, 250, 250, 260, 270,   4,   4, { 15992, 14047, 8150, }, { 2, 2, 1, }, nil, nil, 19027, },
			[19567] = {  nil, 1,  9, 19567, 15846, 250, 270, 280, 290,   1,   1, { 10561, 12359, 10558, 10560, }, { 1, 6, 1, 4, }, { 8736, }, 4000, },
			[12624] = {  nil, 1,  9, 12624, 10576, 250, 270, 280, 290,   1,   1, { 3860, 7077, 6037, 9060, 9061, 7910, }, { 14, 4, 4, 2, 2, 2, }, nil, nil, 10609, },
			[26011] = {  nil, 1,  9, 26011, 21277, 250, 320, 330, 340,   1,   1, { 15407, 15994, 7079, 18631, 10558, }, { 1, 4, 2, 2, 1, }, nil, nil, nil, { 8798, }, },
			[19788] = {  nil, 1,  9, 19788, 15992, 250, 250, 255, 260,   1,   1, { 12365, }, { 2, }, { 8736, }, 4000, },
			[19790] = {  nil, 1,  9, 19790, 15993, 260, 280, 290, 300,   3,   3, { 15994, 12359, 15992, 14047, }, { 1, 3, 3, 3, }, nil, nil, 16041, },
			[23486] = {  nil, 1,  9, 23486, 18984, 260, 285, 295, 305,   1,   1, { 3860, 18631, 7077, 7910, 10586, }, { 10, 1, 4, 2, 1, }, { 8736, }, 0, },
			[23129] = {  nil, 1,  9, 23129, 18660, 260, 260, 265, 270,   1,   1, { 10561, 15994, 10558, 10560, 3864, }, { 1, 2, 1, 1, 1, }, nil, nil, 18661, },
			[23077] = {  nil, 1,  9, 23077, 18634, 260, 280, 290, 300,   1,   1, { 15994, 18631, 12361, 7078, 3829, 13467, }, { 6, 2, 2, 4, 2, 4, }, nil, nil, 18652, },
			[19792] = {  nil, 1,  9, 19792, 15995, 260, 280, 290, 300,   1,   1, { 10559, 10561, 15994, 12359, 10546, }, { 2, 2, 2, 4, 1, }, nil, nil, 16043, },
			[23071] = {  nil, 1,  9, 23071, 18631, 260, 270, 275, 280,   1,   1, { 6037, 7067, 7069, }, { 2, 2, 1, }, nil, nil, 18651, },
			[19791] = {  nil, 1,  9, 19791, 15994, 260, 280, 290, 300,   1,   1, { 12359, 14047, }, { 3, 1, }, nil, nil, 16042, },
			[23489] = {  nil, 1,  9, 23489, 18986, 260, 285, 295, 305,   1,   1, { 3860, 18631, 7075, 7079, 7909, 9060, }, { 12, 2, 4, 2, 4, 1, }, { 8736, }, 0, },
			[23078] = {  nil, 1,  9, 23078, 18587, 265, 285, 295, 305,   1,   1, { 15994, 18631, 7191, 14227, 7910, }, { 2, 2, 2, 2, 2, }, nil, nil, 18653, },
			[19793] = {  nil, 1,  9, 19793, 15996, 265, 285, 295, 305,   1,   1, { 12803, 15994, 10558, 8170, }, { 1, 4, 1, 1, }, nil, nil, 16044, },
			[23096] = {  nil, 1,  9, 23096, 18645, 265, 275, 280, 285,   1,   1, { 12359, 15994, 8170, 7910, 7191, }, { 4, 2, 4, 1, 1, }, nil, nil, 18654, },
			[19794] = {  nil, 1,  9, 19794, 15999, 270, 290, 300, 310,   1,   1, { 10502, 7910, 12810, 14047, }, { 1, 4, 2, 8, }, nil, nil, 16045, },
			[19814] = {  nil, 1,  9, 19814, 16023, 275, 295, 305, 315,   1,   1, { 10561, 16000, 15994, 6037, 8170, 14047, }, { 1, 1, 2, 1, 2, 4, }, nil, nil, 16046, },
			[26427] = {  nil, 1,  9, 26427, 21716, 275, 275, 280, 285,   3,   3, { 15992, 8170, }, { 1, 1, }, nil, nil, 21734, },
			[23079] = {  nil, 2,  9, 23079, 18637, 275, 285, 290, 295,   1,   1, { 16000, 18631, 14047, }, { 2, 1, 2, }, nil, nil, 18655, },
			[26443] = {  nil, 1,  9, 26443, 21570, 275, 295, 305, 315,   1,   1, { 9060, 9061, 18631, 10561, }, { 4, 4, 2, 1, }, nil, nil, 21737, },
			[19795] = {  nil, 1,  9, 19795, 16000, 275, 295, 305, 315,   1,   1, { 12359, }, { 6, }, nil, nil, 16047, },
			[28327] = {  nil, 3,  9, 28327, 22728, 275, 295, 305, 315,   1,   1, { 15994, 10561, 10558, }, { 2, 1, 1, }, nil, nil, 22729, },
			[26428] = {  nil, 1,  9, 26428, 21718, 275, 275, 280, 285,   3,   3, { 15992, 8170, }, { 1, 1, }, nil, nil, 21735, },
			[19796] = {  nil, 1,  9, 19796, 16004, 275, 295, 305, 315,   1,   1, { 16000, 11371, 10546, 12361, 12799, 8170, }, { 2, 6, 2, 2, 2, 4, }, nil, nil, 16048, },
			[26426] = {  nil, 1,  9, 26426, 21714, 275, 275, 280, 285,   3,   3, { 15992, 8170, }, { 1, 1, }, nil, nil, 21733, },
			[23080] = {  nil, 1,  9, 23080, 18594, 275, 275, 285, 295,   1,   1, { 15994, 15992, 8170, 159, }, { 2, 3, 2, 1, }, nil, nil, 18656, },
			[19800] = {  nil, 1,  9, 19800, 15997, 285, 305, 315, 325, 200, 200, { 12359, 15992, }, { 2, 1, }, nil, nil, 16051, },
			[19815] = {  nil, 1,  9, 19815, 16006, 285, 305, 315, 325,   1,   1, { 12360, 14227, }, { 1, 1, }, nil, nil, 16050, },
			[19799] = {  nil, 1,  9, 19799, 16005, 285, 305, 315, 325,   3,   3, { 15994, 11371, 15992, 14047, }, { 2, 1, 3, 3, }, nil, nil, 16049, },
			[23081] = {  nil, 1,  9, 23081, 18638, 290, 310, 320, 330,   1,   1, { 11371, 18631, 7080, 7910, 12800, }, { 4, 3, 6, 4, 2, }, nil, nil, 18657, },
			[19825] = {  nil, 1,  9, 19825, 16008, 290, 310, 320, 330,   1,   1, { 10500, 12364, 12810, }, { 1, 2, 4, }, nil, nil, 16053, },
			[19819] = {  nil, 1,  9, 19819, 16009, 290, 310, 320, 330,   1,   1, { 16006, 10558, 15994, 12799, }, { 2, 1, 1, 1, }, nil, nil, 16052, },
			[23082] = {  nil, 1,  9, 23082, 18639, 300, 320, 330, 340,   1,   1, { 11371, 18631, 12803, 12808, 12800, 12799, }, { 8, 4, 6, 4, 2, 2, }, nil, nil, 18658, },
			[19831] = {  nil, 1,  9, 19831, 16040, 300, 320, 330, 340,   3,   3, { 16006, 12359, 14047, }, { 1, 3, 1, }, nil, nil, 16055, },
			[22797] = {  nil, 1,  9, 22797, 18168, 300, 320, 330, 340,   1,   1, { 12360, 16006, 7082, 12803, 7076, }, { 6, 2, 8, 12, 8, }, nil, nil, 18291, },
			[22795] = {  nil, 1,  9, 22795, 18282, 300, 320, 330, 340,   1,   1, { 17010, 17011, 12360, 16006, 16000, }, { 4, 2, 6, 2, 2, }, nil, nil, 18292, },
			[22793] = {  nil, 1,  9, 22793, 18283, 300, 320, 330, 340,   1,   1, { 17011, 7076, 16006, 11371, 16000, }, { 2, 2, 4, 6, 1, }, nil, nil, 18290, },
			[19830] = {  nil, 1,  9, 19830, 16022, 300, 320, 330, 340,   1,   1, { 10576, 16006, 12655, 15994, 10558, 12810, }, { 1, 8, 10, 6, 4, 6, }, nil, nil, 16054, },
			[19833] = {  nil, 1,  9, 19833, 16007, 300, 320, 330, 340,   1,   1, { 12360, 16000, 7078, 7076, 12800, 12810, }, { 10, 2, 2, 2, 2, 2, }, nil, nil, 16056, },
			[22704] = {  nil, 1,  9, 22704, 18232, 300, 320, 330, 340,   1,   1, { 12359, 8170, 7191, 7067, 7068, }, { 12, 4, 1, 2, 1, }, nil, nil, 18235, },
			[24356] = {  nil, 4,  9, 24356, 19999, 300, 320, 330, 340,   1,   1, { 19726, 19774, 16006, 12804, 12810, }, { 4, 5, 2, 8, 4, }, nil, nil, 20000, },
			[24357] = {  nil, 4,  9, 24357, 19998, 300, 320, 330, 340,   1,   1, { 19726, 19774, 16006, 12804, 12810, }, { 5, 5, 1, 8, 4, }, nil, nil, 20001, },
			[7421]  = {  nil, 1, 10,  7421,  6218,   1,   5,   7,  10,   1,   1, { 6217, 10940, 10938, }, { 1, 1, 1, }, },
			[7418]  = {  nil, 1, 10,  7418,   nil,   1,  70,  90, 110,   1,   1, { 10940, }, { 1, }, },
			[22434] = {  nil, 1, 10, 22434, 17968,   1, 320, 315, 310,   1,   1, { 17967, 16204, 16203, }, { 1, 2, 2, }, },
			[14293] = {  nil, 1, 10, 14293, 11287,  10,  75,  95, 115,   1,   1, { 4470, 10938, }, { 1, 1, }, { 1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11065, 11066, 11067, 11068, 11070, 11071, 11072, 11073, 11074, }, 50, },
			[7420]  = {  nil, 1, 10,  7420,   nil,  15,  70,  90, 110,   1,   1, { 10940, }, { 1, }, { 1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11065, 11066, 11067, 11068, 11070, 11071, 11072, 11073, 11074, }, 50, },
			[7443]  = {  nil, 1, 10,  7443,   nil,  20,  80, 100, 120,   1,   1, { 10938, }, { 1, }, nil, nil, 6342, },
			[7426]  = {  nil, 1, 10,  7426,   nil,  40,  90, 110, 130,   1,   1, { 10940, 10938, }, { 2, 1, }, { 1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11065, 11066, 11067, 11068, 11070, 11071, 11072, 11073, 11074, }, 100, },
			[7454]  = {  nil, 1, 10,  7454,   nil,  45,  95, 115, 135,   1,   1, { 10940, 10938, }, { 1, 2, }, { 1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11065, 11066, 11067, 11068, 11070, 11071, 11072, 11073, 11074, }, 100, },
			[25124] = {  nil, 5, 10, 25124, 20744,  45,  55,  65,  75,   1,   1, { 10940, 17034, 3371, }, { 2, 1, 1, }, nil, nil, 20758, },
			[7457]  = {  nil, 1, 10,  7457,   nil,  50, 100, 120, 140,   1,   1, { 10940, }, { 3, }, { 1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11065, 11066, 11067, 11068, 11070, 11071, 11072, 11073, 11074, }, 250, },
			[7748]  = {  nil, 1, 10,  7748,   nil,  60, 105, 125, 145,   1,   1, { 10940, 10938, }, { 2, 2, }, { 1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11065, 11066, 11067, 11068, 11070, 11071, 11072, 11073, 11074, }, 250, },
			[7766]  = {  nil, 1, 10,  7766,   nil,  60, 105, 125, 145,   1,   1, { 10938, }, { 2, }, nil, nil, 6344, },
			[14807] = {  nil, 1, 10, 14807, 11288,  70, 110, 130, 150,   1,   1, { 4470, 10939, }, { 1, 1, }, { 1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11065, 11066, 11067, 11068, 11070, 11071, 11072, 11073, 11074, }, 200, },
			[7771]  = {  nil, 1, 10,  7771,   nil,  70, 110, 130, 150,   1,   1, { 10940, 10939, }, { 3, 1, }, { 1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11065, 11066, 11067, 11068, 11070, 11071, 11072, 11073, 11074, }, 200, },
			[7776]  = {  nil, 1, 10,  7776,   nil,  80, 115, 135, 155,   1,   1, { 10939, 10938, }, { 1, 1, }, nil, nil, 6346, },
			[7428]  = {  nil, 1, 10,  7428,   nil,  80,  80, 100, 120,   1,   1, { 10938, 10940, }, { 1, 1, }, },
			[7782]  = {  nil, 1, 10,  7782,   nil,  80, 115, 135, 155,   1,   1, { 10940, }, { 5, }, nil, nil, 6347, },
			[7779]  = {  nil, 1, 10,  7779,   nil,  80, 115, 135, 155,   1,   1, { 10940, 10939, }, { 2, 1, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 400, },
			[7788]  = {  nil, 1, 10,  7788,   nil,  90, 120, 140, 160,   1,   1, { 10940, 10939, 10978, }, { 2, 1, 1, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 500, },
			[7786]  = {  nil, 1, 10,  7786,   nil,  90, 120, 140, 160,   1,   1, { 10940, 10939, }, { 4, 2, }, nil, nil, 6348, },
			[7793]  = {  nil, 1, 10,  7793,   nil, 100, 130, 150, 170,   1,   1, { 10939, }, { 3, }, nil, nil, 6349, },
			[7795]  = {  nil, 1, 10,  7795,  6339, 100, 130, 150, 170,   1,   1, { 6338, 10940, 10939, 1210, }, { 1, 6, 3, 1, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 1000, },
			[7745]  = {  nil, 1, 10,  7745,   nil, 100, 130, 150, 170,   1,   1, { 10940, 10978, }, { 4, 1, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 500, },
			[13378] = {  nil, 1, 10, 13378,   nil, 105, 130, 150, 170,   1,   1, { 10998, 10940, }, { 1, 2, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 600, },
			[13419] = {  nil, 1, 10, 13419,   nil, 110, 135, 155, 175,   1,   1, { 10998, }, { 1, }, nil, nil, 11039, },
			[13380] = {  nil, 1, 10, 13380,   nil, 110, 135, 155, 175,   1,   1, { 10998, 10940, }, { 1, 6, }, nil, nil, 11038, },
			[13464] = {  nil, 1, 10, 13464,   nil, 115, 140, 160, 180,   1,   1, { 10998, 10940, 10978, }, { 1, 1, 1, }, nil, nil, 11081, },
			[13421] = {  nil, 1, 10, 13421,   nil, 115, 140, 160, 180,   1,   1, { 10940, 10978, }, { 6, 1, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 800, },
			[7857]  = {  nil, 1, 10,  7857,   nil, 120, 145, 165, 185,   1,   1, { 10940, 10998, }, { 4, 1, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 1000, },
			[7859]  = {  nil, 1, 10,  7859,   nil, 120, 145, 165, 185,   1,   1, { 10998, }, { 2, }, nil, nil, 6375, },
			[7861]  = {  nil, 1, 10,  7861,   nil, 125, 150, 170, 190,   1,   1, { 6371, 10998, }, { 1, 1, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 1250, },
			[7863]  = {  nil, 1, 10,  7863,   nil, 125, 150, 170, 190,   1,   1, { 10940, }, { 8, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 1400, },
			[7867]  = {  nil, 1, 10,  7867,   nil, 125, 150, 170, 190,   1,   1, { 10940, 10998, }, { 6, 2, }, nil, nil, 6377, },
			[13501] = {  nil, 1, 10, 13501,   nil, 130, 155, 175, 195,   1,   1, { 11083, }, { 2, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 1500, },
			[13485] = {  nil, 1, 10, 13485,   nil, 130, 155, 175, 195,   1,   1, { 10998, 10940, }, { 2, 4, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 1500, },
			[13522] = {  nil, 1, 10, 13522,   nil, 135, 160, 180, 200,   1,   1, { 11082, 6048, }, { 1, 1, }, nil, nil, 11098, },
			[13503] = {  nil, 1, 10, 13503,   nil, 140, 165, 185, 205,   1,   1, { 11083, 11084, }, { 2, 1, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 2000, },
			[13536] = {  nil, 1, 10, 13536,   nil, 140, 165, 185, 205,   1,   1, { 11083, }, { 2, }, nil, nil, 11101, },
			[13538] = {  nil, 1, 10, 13538,   nil, 140, 165, 185, 205,   1,   1, { 10940, 11082, 11084, }, { 2, 1, 1, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 2500, },
			[13617] = {  nil, 1, 10, 13617,   nil, 145, 170, 190, 210,   1,   1, { 11083, 3356, }, { 1, 3, }, nil, nil, 11151, },
			[13620] = {  nil, 1, 10, 13620,   nil, 145, 170, 190, 210,   1,   1, { 11083, 6370, }, { 1, 3, }, nil, nil, 11152, },
			[13529] = {  nil, 1, 10, 13529,   nil, 145, 170, 190, 210,   1,   1, { 11083, 11084, }, { 3, 1, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 2400, },
			[13607] = {  nil, 1, 10, 13607,   nil, 145, 170, 190, 210,   1,   1, { 11082, 10998, }, { 1, 2, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 2400, },
			[13612] = {  nil, 1, 10, 13612,   nil, 145, 170, 190, 210,   1,   1, { 11083, 2772, }, { 1, 3, }, nil, nil, 11150, },
			[13628] = {  nil, 1, 10, 13628, 11130, 150, 175, 195, 215,   1,   1, { 11128, 5500, 11082, 11083, }, { 1, 1, 2, 2, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 2500, },
			[25125] = {  nil, 5, 10, 25125, 20745, 150, 160, 170, 180,   1,   1, { 11083, 17034, 3372, }, { 3, 2, 1, }, nil, nil, 20752, },
			[13622] = {  nil, 1, 10, 13622,   nil, 150, 175, 195, 215,   1,   1, { 11082, }, { 2, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 2500, },
			[13626] = {  nil, 1, 10, 13626,   nil, 150, 175, 195, 215,   1,   1, { 11082, 11083, 11084, }, { 1, 1, 1, }, { 1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074, }, 2500, },
			[14809] = {  nil, 1, 10, 14809, 11289, 155, 175, 195, 215,   1,   1, { 11291, 11134, 11083, }, { 1, 1, 1, }, { 11072, 11073, 11074, }, 2600, },
			[13631] = {  nil, 1, 10, 13631,   nil, 155, 175, 195, 215,   1,   1, { 11134, 11083, }, { 1, 1, }, { 11072, 11073, 11074, }, 2600, },
			[13635] = {  nil, 1, 10, 13635,   nil, 155, 175, 195, 215,   1,   1, { 11138, 11083, }, { 1, 3, }, { 11072, 11073, 11074, }, 2600, },
			[13640] = {  nil, 1, 10, 13640,   nil, 160, 180, 200, 220,   1,   1, { 11083, }, { 3, }, { 11072, 11073, 11074, }, 2800, },
			[13637] = {  nil, 1, 10, 13637,   nil, 160, 180, 200, 220,   1,   1, { 11083, 11134, }, { 1, 1, }, { 11072, 11073, 11074, }, 2800, },
			[13642] = {  nil, 1, 10, 13642,   nil, 165, 185, 205, 225,   1,   1, { 11134, }, { 1, }, { 11072, 11073, 11074, }, 2800, },
			[13648] = {  nil, 1, 10, 13648,   nil, 170, 190, 210, 230,   1,   1, { 11083, }, { 6, }, { 11072, 11073, 11074, }, 2800, },
			[13646] = {  nil, 1, 10, 13646,   nil, 170, 190, 210, 230,   1,   1, { 11134, 11083, }, { 1, 2, }, nil, nil, 11163, },
			[13644] = {  nil, 1, 10, 13644,   nil, 170, 190, 210, 230,   1,   1, { 11083, }, { 4, }, { 11072, 11073, 11074, }, 2800, },
			[13655] = {  nil, 1, 10, 13655,   nil, 175, 195, 215, 235,   1,   1, { 11134, 7067, 11138, }, { 1, 1, 1, }, nil, nil, 11165, },
			[13657] = {  nil, 1, 10, 13657,   nil, 175, 195, 215, 235,   1,   1, { 11134, 7068, }, { 1, 1, }, { 11072, 11073, 11074, }, 3000, },
			[14810] = {  nil, 1, 10, 14810, 11290, 175, 195, 215, 235,   1,   1, { 11291, 11135, 11137, }, { 1, 1, 1, }, { 11072, 11073, 11074, }, 3000, },
			[13653] = {  nil, 1, 10, 13653,   nil, 175, 195, 215, 235,   1,   1, { 11134, 5637, 11138, }, { 1, 2, 1, }, nil, nil, 11164, },
			[13661] = {  nil, 1, 10, 13661,   nil, 180, 200, 220, 240,   1,   1, { 11137, }, { 1, }, { 11072, 11073, 11074, }, 3600, },
			[13659] = {  nil, 1, 10, 13659,   nil, 180, 200, 220, 240,   1,   1, { 11135, 11137, }, { 1, 1, }, { 11072, 11073, 11074, }, 3200, },
			[13663] = {  nil, 1, 10, 13663,   nil, 185, 205, 225, 245,   1,   1, { 11135, }, { 1, }, { 11072, 11073, 11074, }, 3800, },
			[21931] = {  nil, 1, 10, 21931,   nil, 190, 210, 230, 250,   1,   1, { 11135, 11137, 11139, 3819, }, { 3, 3, 1, 2, }, nil, nil, 17725, },
			[13687] = {  nil, 1, 10, 13687,   nil, 190, 210, 230, 250,   1,   1, { 11135, 11134, }, { 1, 2, }, nil, nil, 11167, },
			[13693] = {  nil, 1, 10, 13693,   nil, 195, 215, 235, 255,   1,   1, { 11135, 11139, }, { 2, 1, }, { 11072, 11073, 11074, }, 4000, },
			[13689] = {  nil, 1, 10, 13689,   nil, 195, 215, 235, 255,   1,   1, { 11135, 11137, 11139, }, { 2, 2, 1, }, nil, nil, 11168, },
			[13702] = {  nil, 1, 10, 13702, 11145, 200, 220, 240, 260,   1,   1, { 11144, 7971, 11135, 11137, }, { 1, 1, 2, 2, }, { 11072, 11073, 11074, }, 4000, },
			[13695] = {  nil, 1, 10, 13695,   nil, 200, 220, 240, 260,   1,   1, { 11137, 11139, }, { 4, 1, }, { 11072, 11073, 11074, }, 4000, },
			[25126] = {  nil, 5, 10, 25126, 20746, 200, 210, 220, 230,   1,   1, { 11137, 17035, 3372, }, { 3, 2, 1, }, nil, nil, 20753, },
			[13700] = {  nil, 1, 10, 13700,   nil, 200, 220, 240, 260,   1,   1, { 11135, 11137, 11139, }, { 2, 2, 1, }, { 11072, 11073, 11074, }, 4000, },
			[13698] = {  nil, 1, 10, 13698,   nil, 200, 220, 240, 260,   1,   1, { 11137, 7392, }, { 1, 3, }, nil, nil, 11166, },
			[13746] = {  nil, 1, 10, 13746,   nil, 205, 225, 245, 265,   1,   1, { 11137, }, { 3, }, { 11072, 11073, 11074, }, 4200, },
			[13794] = {  nil, 1, 10, 13794,   nil, 205, 225, 245, 265,   1,   1, { 11174, }, { 1, }, { 11072, 11073, 11074, }, 4200, },
			[13817] = {  nil, 1, 10, 13817,   nil, 210, 230, 250, 270,   1,   1, { 11137, }, { 5, }, nil, nil, 11202, },
			[13815] = {  nil, 1, 10, 13815,   nil, 210, 230, 250, 270,   1,   1, { 11174, 11137, }, { 1, 1, }, { 11072, 11073, 11074, }, 4400, },
			[13822] = {  nil, 1, 10, 13822,   nil, 210, 230, 250, 270,   1,   1, { 11174, }, { 2, }, { 11072, 11073, 11074, }, 4400, },
			[13841] = {  nil, 1, 10, 13841,   nil, 215, 235, 255, 275,   1,   1, { 11137, 6037, }, { 3, 3, }, nil, nil, 11203, },
			[13836] = {  nil, 1, 10, 13836,   nil, 215, 235, 255, 275,   1,   1, { 11137, }, { 5, }, { 11072, 11073, 11074, }, 4600, },
			[13846] = {  nil, 1, 10, 13846,   nil, 220, 240, 260, 280,   1,   1, { 11174, 11137, }, { 3, 1, }, nil, nil, 11204, },
			[13858] = {  nil, 1, 10, 13858,   nil, 220, 240, 260, 280,   1,   1, { 11137, }, { 6, }, { 11072, 11073, 11074, }, 4800, },
			[13890] = {  nil, 1, 10, 13890,   nil, 225, 245, 265, 285,   1,   1, { 11177, 7909, 11174, }, { 1, 1, 1, }, { 11072, 11073, 11074, }, 5000, },
			[13882] = {  nil, 1, 10, 13882,   nil, 225, 245, 265, 285,   1,   1, { 11174, }, { 2, }, nil, nil, 11206, },
			[13887] = {  nil, 1, 10, 13887,   nil, 225, 245, 265, 285,   1,   1, { 11174, 11137, }, { 2, 3, }, { 11072, 11073, 11074, }, 5000, },
			[13868] = {  nil, 1, 10, 13868,   nil, 225, 245, 265, 285,   1,   1, { 11137, 8838, }, { 3, 3, }, nil, nil, 11205, },
			[13917] = {  nil, 1, 10, 13917,   nil, 230, 250, 270, 290,   1,   1, { 11175, 11174, }, { 1, 2, }, { 11073, }, 5400, },
			[13915] = {  nil, 1, 10, 13915,   nil, 230, 250, 270, 290,   1,   1, { 11177, 11176, 9224, }, { 1, 2, 1, }, nil, nil, 11208, },
			[13905] = {  nil, 1, 10, 13905,   nil, 230, 250, 270, 290,   1,   1, { 11175, 11176, }, { 1, 2, }, { 11073, }, 5400, },
			[13935] = {  nil, 1, 10, 13935,   nil, 235, 255, 275, 295,   1,   1, { 11175, }, { 2, }, { 11073, }, 5800, },
			[13931] = {  nil, 1, 10, 13931,   nil, 235, 255, 275, 295,   1,   1, { 11175, 11176, }, { 1, 2, }, nil, nil, 11223, },
			[13933] = {  nil, 1, 10, 13933,   nil, 235, 255, 275, 295,   1,   1, { 11178, 3829, }, { 1, 1, }, nil, nil, 11224, },
			[13937] = {  nil, 1, 10, 13937,   nil, 240, 260, 280, 300,   1,   1, { 11178, 11176, }, { 2, 2, }, { 11073, }, 6200, },
			[13939] = {  nil, 1, 10, 13939,   nil, 240, 260, 280, 300,   1,   1, { 11176, 11175, }, { 2, 1, }, { 11073, }, 6200, },
			[13943] = {  nil, 1, 10, 13943,   nil, 245, 265, 285, 305,   1,   1, { 11178, 11175, }, { 2, 2, }, { 11073, }, 6200, },
			[13945] = {  nil, 1, 10, 13945,   nil, 245, 265, 285, 305,   1,   1, { 11176, }, { 5, }, nil, nil, 11225, },
			[13941] = {  nil, 1, 10, 13941,   nil, 245, 265, 285, 305,   1,   1, { 11178, 11176, 11175, }, { 1, 3, 2, }, { 11073, }, 6200, },
			[17181] = {  nil, 1, 10, 17181, 12810, 250, 250, 255, 260,   1,   1, { 8170, 16202, }, { 1, 1, }, { 11073, }, 10000, },
			[25127] = {  nil, 5, 10, 25127, 20747, 250, 260, 270, 280,   1,   1, { 11176, 8831, 8925, }, { 3, 2, 1, }, nil, nil, 20754, },
			[13947] = {  nil, 1, 10, 13947,   nil, 250, 270, 290, 310,   1,   1, { 11178, 11176, }, { 2, 3, }, nil, nil, 11226, },
			[17180] = {  nil, 1, 10, 17180, 12655, 250, 250, 255, 260,   1,   1, { 12359, 11176, }, { 1, 3, }, { 11073, }, 10000, },
			[13948] = {  nil, 1, 10, 13948,   nil, 250, 270, 290, 310,   1,   1, { 11178, 8153, }, { 2, 2, }, { 11073, }, 6500, },
			[20008] = {  nil, 1, 10, 20008,   nil, 255, 275, 295, 315,   1,   1, { 16202, }, { 3, }, nil, nil, 16214, },
			[20020] = {  nil, 1, 10, 20020,   nil, 260, 280, 300, 320,   1,   1, { 11176, }, { 10, }, nil, nil, 16215, },
			[20014] = {  nil, 1, 10, 20014,   nil, 265, 285, 305, 325,   1,   1, { 16202, 7077, 7075, 7079, 7081, 7972, }, { 2, 1, 1, 1, 1, 1, }, nil, nil, 16216, },
			[20017] = {  nil, 1, 10, 20017,   nil, 265, 285, 305, 325,   1,   1, { 11176, }, { 10, }, nil, nil, 16217, },
			[15596] = {  nil, 1, 10, 15596, 11811, 265, 285, 305, 325,   1,   1, { 11382, 7078, 14343, }, { 1, 1, 3, }, nil, nil, 11813, },
			[13898] = {  nil, 1, 10, 13898,   nil, 265, 285, 305, 325,   1,   1, { 11177, 7078, }, { 4, 1, }, nil, nil, 11207, },
			[20012] = {  nil, 1, 10, 20012,   nil, 270, 290, 310, 330,   1,   1, { 16202, 16204, }, { 3, 3, }, nil, nil, 16219, },
			[20009] = {  nil, 1, 10, 20009,   nil, 270, 290, 310, 330,   1,   1, { 16202, 11176, }, { 3, 10, }, nil, nil, 16218, },
			[20026] = {  nil, 1, 10, 20026,   nil, 275, 295, 315, 335,   1,   1, { 16204, 14343, }, { 6, 1, }, nil, nil, 16221, },
			[20024] = {  nil, 1, 10, 20024,   nil, 275, 295, 315, 335,   1,   1, { 16203, 16202, }, { 2, 1, }, nil, nil, 16220, },
			[25128] = {  nil, 5, 10, 25128, 20750, 275, 285, 295, 305,   1,   1, { 16204, 4625, 8925, }, { 3, 2, 1, }, nil, nil, 20755, },
			[20016] = {  nil, 1, 10, 20016,   nil, 280, 300, 320, 340,   1,   1, { 16203, 16204, }, { 2, 4, }, nil, nil, 16222, },
			[20029] = {  nil, 1, 10, 20029,   nil, 285, 305, 325, 345,   1,   1, { 14343, 7080, 7082, 13467, }, { 4, 1, 1, 1, }, nil, nil, 16223, },
			[20015] = {  nil, 1, 10, 20015,   nil, 285, 305, 325, 345,   1,   1, { 16204, }, { 8, }, nil, nil, 16224, },
			[20051] = {  nil, 1, 10, 20051, 16207, 290, 310, 330, 350,   1,   1, { 16206, 13926, 16204, 16203, 14343, 14344, }, { 1, 1, 10, 4, 4, 2, }, nil, nil, 16243, },
			[23799] = {  nil, 3, 10, 23799,   nil, 290, 310, 330, 350,   1,   1, { 14344, 16203, 16204, 7076, }, { 6, 6, 4, 2, }, nil, nil, 19444, },
			[23801] = {  nil, 3, 10, 23801,   nil, 290, 310, 330, 350,   1,   1, { 16204, 16203, 7080, }, { 16, 4, 2, }, nil, nil, 19446, },
			[20028] = {  nil, 1, 10, 20028,   nil, 290, 310, 330, 350,   1,   1, { 16203, 14343, }, { 3, 1, }, nil, nil, 16242, },
			[27837] = {  nil, 5, 10, 27837,   nil, 290, 310, 330, 350,   1,   1, { 14344, 16203, 16204, 7082, }, { 10, 6, 14, 4, }, nil, nil, 22392, },
			[23800] = {  nil, 3, 10, 23800,   nil, 290, 310, 330, 350,   1,   1, { 14344, 16203, 16204, 7082, }, { 6, 6, 4, 2, }, nil, nil, 19445, },
			[20010] = {  nil, 1, 10, 20010,   nil, 295, 315, 335, 355,   1,   1, { 16204, 16203, }, { 6, 6, }, nil, nil, 16246, },
			[20030] = {  nil, 1, 10, 20030,   nil, 295, 315, 335, 355,   1,   1, { 14344, 16204, }, { 4, 10, }, nil, nil, 16247, },
			[20033] = {  nil, 1, 10, 20033,   nil, 295, 315, 335, 355,   1,   1, { 14344, 12808, }, { 4, 4, }, nil, nil, 16248, },
			[20013] = {  nil, 1, 10, 20013,   nil, 295, 315, 335, 355,   1,   1, { 16203, 16204, }, { 4, 4, }, nil, nil, 16244, },
			[20023] = {  nil, 1, 10, 20023,   nil, 295, 315, 335, 355,   1,   1, { 16203, }, { 8, }, nil, nil, 16245, },
			[25074] = {  nil, 5, 10, 25074,   nil, 300, 320, 340, 360,   1,   1, { 20725, 14344, 7080, }, { 3, 10, 4, }, nil, nil, 20728, },
			[22750] = {  nil, 1, 10, 22750,   nil, 300, 320, 340, 360,   1,   1, { 14344, 16203, 12803, 7080, 12811, }, { 4, 8, 6, 6, 1, }, nil, nil, 18260, },
			[20031] = {  nil, 1, 10, 20031,   nil, 300, 320, 340, 360,   1,   1, { 14344, 16203, }, { 2, 10, }, nil, nil, 16250, },
			[20034] = {  nil, 1, 10, 20034,   nil, 300, 320, 340, 360,   1,   1, { 14344, 12811, }, { 4, 2, }, nil, nil, 16252, },
			[25080] = {  nil, 5, 10, 25080,   nil, 300, 320, 340, 360,   1,   1, { 20725, 14344, 7082, }, { 3, 8, 4, }, nil, nil, 20731, },
			[25072] = {  nil, 5, 10, 25072,   nil, 300, 320, 340, 360,   1,   1, { 20725, 14344, 18512, }, { 4, 6, 8, }, nil, nil, 20726, },
			[20011] = {  nil, 1, 10, 20011,   nil, 300, 320, 340, 360,   1,   1, { 16204, }, { 15, }, nil, nil, 16251, },
			[22749] = {  nil, 1, 10, 22749,   nil, 300, 320, 340, 360,   1,   1, { 14344, 16203, 7078, 7080, 7082, 13926, }, { 4, 12, 4, 4, 4, 2, }, nil, nil, 18259, },
			[25079] = {  nil, 5, 10, 25079,   nil, 300, 320, 340, 360,   1,   1, { 20725, 14344, 12811, }, { 3, 8, 1, }, nil, nil, 20730, },
			[25073] = {  nil, 5, 10, 25073,   nil, 300, 320, 340, 360,   1,   1, { 20725, 14344, 12808, }, { 3, 10, 6, }, nil, nil, 20727, },
			[23803] = {  nil, 3, 10, 23803,   nil, 300, 320, 340, 360,   1,   1, { 14344, 16203, 16204, }, { 10, 8, 15, }, nil, nil, 19448, },
			[25083] = {  nil, 5, 10, 25083,   nil, 300, 320, 340, 360,   1,   1, { 20725, 14344, 13468, }, { 3, 8, 2, }, nil, nil, 20734, },
			[20032] = {  nil, 1, 10, 20032,   nil, 300, 320, 340, 360,   1,   1, { 14344, 12808, 12803, }, { 6, 6, 6, }, nil, nil, 16254, },
			[25129] = {  nil, 5, 10, 25129, 20749, 300, 310, 320, 330,   1,   1, { 14344, 4625, 18256, }, { 2, 3, 1, }, nil, nil, 20756, },
			[25130] = {  nil, 5, 10, 25130, 20748, 300, 310, 320, 330,   1,   1, { 14344, 8831, 18256, }, { 2, 3, 1, }, nil, nil, 20757, },
			[25078] = {  nil, 5, 10, 25078,   nil, 300, 320, 340, 360,   1,   1, { 20725, 14344, 7078, }, { 2, 10, 4, }, nil, nil, 20729, },
			[20035] = {  nil, 1, 10, 20035,   nil, 300, 320, 340, 360,   1,   1, { 16203, 14344, }, { 12, 2, }, nil, nil, 16255, },
			[25082] = {  nil, 5, 10, 25082,   nil, 300, 320, 340, 360,   1,   1, { 20725, 14344, 12803, }, { 2, 8, 4, }, nil, nil, 20733, },
			[23802] = {  nil, 3, 10, 23802,   nil, 300, 320, 340, 360,   1,   1, { 14344, 16204, 16203, 12803, }, { 2, 20, 4, 6, }, nil, nil, 19447, },
			[25084] = {  nil, 5, 10, 25084,   nil, 300, 320, 340, 360,   1,   1, { 20725, 14344, 11754, }, { 4, 6, 2, }, nil, nil, 20735, },
			[20036] = {  nil, 1, 10, 20036,   nil, 300, 320, 340, 360,   1,   1, { 16203, 14344, }, { 12, 2, }, nil, nil, 16249, },
			[23804] = {  nil, 3, 10, 23804,   nil, 300, 320, 340, 360,   1,   1, { 14344, 16203, 16204, }, { 15, 12, 20, }, nil, nil, 19449, },
			[25081] = {  nil, 5, 10, 25081,   nil, 300, 320, 340, 360,   1,   1, { 20725, 14344, 7078, }, { 3, 8, 4, }, nil, nil, 20732, },
			[20025] = {  nil, 1, 10, 20025,   nil, 300, 320, 340, 360,   1,   1, { 14344, 16204, 16203, }, { 4, 15, 10, }, nil, nil, 16253, },
			[25086] = {  nil, 5, 10, 25086,   nil, 300, 320, 340, 360,   1,   1, { 20725, 14344, 12809, }, { 3, 8, 8, }, nil, nil, 20736, },
			[3420]  = {  nil, 1, 13,  3420,  3775,   1, 125, 150, 175,   1,   1, { 2930, 3371, }, { 1, 1, }, { 917, 918, 1234, 1411, 2130, 3170, 3327, 3328, 3401, 3599, 4163, 4214, 4215, 4582, 4583, 4585, 5165, 5166, 5167, 6707, 13283, }, 3000, },
			[8681]  = {  nil, 1, 13,  8681,  6947,   1, 125, 150, 175,   1,   1, { 2928, 3371, }, { 1, 1, }, { 917, 918, 1234, 1411, 2130, 3170, 3327, 3328, 3401, 3599, 4163, 4214, 4215, 4582, 4583, 4585, 5165, 5166, 5167, 6707, 13283, }, 0, },
			[5763]  = {  nil, 1, 13,  5763,  5237, 100, 150, 175, 200,   1,   1, { 2928, 2930, 3371, }, { 1, 1, 1, }, { 917, 918, 1234, 1411, 2130, 3170, 3327, 3328, 3401, 3599, 4163, 4214, 4215, 4582, 4583, 4585, 5165, 5166, 5167, 6707, 13283, }, 5000, },
			[8687]  = {  nil, 1, 13,  8687,  6949, 120, 165, 190, 215,   1,   1, { 2928, 3372, }, { 3, 1, }, { 917, 918, 1234, 1411, 2130, 3170, 3327, 3328, 3401, 3599, 4163, 4214, 4215, 4582, 4583, 4585, 5165, 5166, 5167, 6707, 13283, }, 8000, },
			[2835]  = {  nil, 1, 13,  2835,  2892, 130, 175, 200, 225,   1,   1, { 5173, 3372, }, { 1, 1, }, { 917, 918, 1234, 1411, 2130, 3170, 3327, 3328, 3401, 3599, 4163, 4214, 4215, 4582, 4583, 4585, 5165, 5166, 5167, 6707, 13283, }, 10000, },
			[13220] = {  nil, 1, 13, 13220, 10918, 140, 185, 210, 235,   1,   1, { 2930, 5173, 3372, }, { 1, 1, 1, }, { 917, 918, 1234, 1411, 2130, 3170, 3327, 3328, 3401, 3599, 4163, 4214, 4215, 4582, 4583, 4585, 5165, 5166, 5167, 6707, 13283, }, 12000, },
			-- [6510]  = {  nil, 1, 13,  6510,  5530, 150, 170, 195, 220,   3,   3, { 3818, }, { 1, }, { 917, 918, 1234, 1411, 2130, 3170, 3327, 3328, 3401, 3599, 4163, 4214, 4215, 4582, 4583, 4585, 5165, 5166, 5167, 6707, 13283, }, 14000, },
			[8691]  = {  nil, 1, 13,  8691,  6950, 160, 205, 230, 255,   1,   1, { 8924, 3372, }, { 1, 1, }, { 917, 918, 1234, 1411, 2130, 3170, 3327, 3328, 3401, 3599, 4163, 4214, 4215, 4582, 4583, 4585, 5165, 5166, 5167, 6707, 13283, }, 16000, },
			[2837]  = {  nil, 1, 13,  2837,  2893, 170, 215, 240, 265,   1,   1, { 5173, 3372, }, { 2, 1, }, { 917, 918, 1234, 1411, 2130, 3170, 3327, 3328, 3401, 3599, 4163, 4214, 4215, 4582, 4583, 4585, 5165, 5166, 5167, 6707, 13283, }, 18000, },
			[8694]  = {  nil, 1, 13,  8694,  6951, 170, 215, 240, 265,   1,   1, { 2928, 2930, 3372, }, { 4, 4, 1, }, { 917, 918, 1234, 1411, 2130, 3170, 3327, 3328, 3401, 3599, 4163, 4214, 4215, 4582, 4583, 4585, 5165, 5166, 5167, 6707, 13283, }, 18000, },
			[13228] = {  nil, 1, 13, 13228, 10920, 180, 225, 250, 275,   1,   1, { 2930, 5173, 3372, }, { 1, 2, 1, }, { 917, 918, 1234, 1411, 2130, 3170, 3327, 3328, 3401, 3599, 4163, 4214, 4215, 4582, 4583, 4585, 5165, 5166, 5167, 6707, 13283, }, 20000, },
			[11341] = {  nil, 1, 13, 11341,  8926, 200, 245, 270, 295,   1,   1, { 8924, 8925, }, { 2, 1, }, { 917, 918, 1234, 1411, 2130, 3170, 3327, 3328, 3401, 3599, 4163, 4214, 4215, 4582, 4583, 4585, 5165, 5166, 5167, 6707, 13283, }, 29000, },
			[11357] = {  nil, 1, 13, 11357,  8984, 210, 255, 280, 305,   1,   1, { 5173, 8925, }, { 3, 1, }, { 917, 918, 1234, 1411, 2130, 3170, 3327, 3328, 3401, 3599, 4163, 4214, 4215, 4582, 4583, 4585, 5165, 5166, 5167, 6707, 13283, }, 31000, },
			[13229] = {  nil, 1, 13, 13229, 10921, 220, 265, 290, 315,   1,   1, { 8923, 5173, 8925, }, { 1, 2, 1, }, { 917, 918, 1234, 1411, 2130, 3170, 3327, 3328, 3401, 3599, 4163, 4214, 4215, 4582, 4583, 4585, 5165, 5166, 5167, 6707, 13283, }, 33000, },
			[3421]  = {  nil, 1, 13,  3421,  3776, 230, 275, 300, 325,   1,   1, { 8923, 8925, }, { 3, 1, }, { 917, 918, 1234, 1411, 2130, 3170, 3327, 3328, 3401, 3599, 4163, 4214, 4215, 4582, 4583, 4585, 5165, 5166, 5167, 6707, 13283, }, 35000, },
			[11400] = {  nil, 1, 13, 11400,  9186, 240, 285, 310, 335,   1,   1, { 8924, 8923, 8925, }, { 2, 2, 1, }, { 917, 918, 1234, 1411, 2130, 3170, 3327, 3328, 3401, 3599, 4163, 4214, 4215, 4582, 4583, 4585, 5165, 5166, 5167, 6707, 13283, }, 46000, },
			[11342] = {  nil, 1, 13, 11342,  8927, 240, 285, 310, 335,   1,   1, { 8924, 8925, }, { 3, 1, }, { 917, 918, 1234, 1411, 2130, 3170, 3327, 3328, 3401, 3599, 4163, 4214, 4215, 4582, 4583, 4585, 5165, 5166, 5167, 6707, 13283, }, 46000, },
			[11358] = {  nil, 1, 13, 11358,  8985, 250, 295, 320, 345,   1,   1, { 5173, 8925, }, { 5, 1, }, { 917, 918, 1234, 1411, 2130, 3170, 3327, 3328, 3401, 3599, 4163, 4214, 4215, 4582, 4583, 4585, 5165, 5166, 5167, 6707, 13283, }, 48000, },
			[13230] = {  nil, 1, 13, 13230, 10922, 260, 305, 330, 355,   1,   1, { 8923, 5173, 8925, }, { 2, 2, 1, }, { 917, 918, 1234, 1411, 2130, 3170, 3327, 3328, 3401, 3599, 4163, 4214, 4215, 4582, 4583, 4585, 5165, 5166, 5167, 6707, 13283, }, 50000, },
			[11343] = {  nil, 1, 13, 11343,  8928, 280, 325, 350, 375,   1,   1, { 8924, 8925, }, { 4, 1, }, { 917, 918, 1234, 1411, 2130, 3170, 3327, 3328, 3401, 3599, 4163, 4214, 4215, 4582, 4583, 4585, 5165, 5166, 5167, 6707, 13283, }, 54000, },
			[25347] = {  nil, 5, 13, 25347, 20844, 300, 300, 325, 350,   1,   1, { 5173, 8925, }, { 7, 1, }, nil, nil, 21302, },
		};
		--[[	recipe_info[sid] = {
					1_validated, 2_phase, 3_pid, 4_sid, 5_cid,
					6_learn, 7_yellow, 8_green, 9_grey,
					10_made, 11_made, 12_reagents_id, 13_reagents_count, 
					14_trainer, 15_train_price, 16_rid, 17_quest, 18_object
				}
		--]]
		local recipe_sid_list_by_pid = {	--	[pid] = { sid }
			[1] = {
				3275,
				3276,
				7934,
				3277,
				3278,
				7935,
				7928,
				7929,
				10840,
				10841,
				18629,
				18630,
				23787,
			},
			[2] = {
				3115,
				2663,
				2660,
				12260,
				2662,
				2737,
				2738,
				3319,
				2739,
				3320,
				8880,
				9983,
				3293,
				2661,
				3321,
				3323,
				3324,
				3325,
				7408,
				2665,
				3116,
				3294,
				2666,
				3326,
				2667,
				2664,
				7817,
				3292,
				19666,
				3491,
				8367,
				7818,
				2668,
				2670,
				2740,
				3328,
				2741,
				6517,
				2672,
				2742,
				9985,
				2674,
				3330,
				3117,
				3295,
				3337,
				3331,
				9986,
				3296,
				2673,
				9987,
				3333,
				6518,
				3297,
				3334,
				2675,
				14379,
				8768,
				3336,
				7221,
				19667,
				3506,
				3494,
				12259,
				3492,
				3504,
				9813,
				9811,
				7222,
				3501,
				3495,
				3502,
				3507,
				9814,
				3505,
				3493,
				3496,
				3508,
				15972,
				9818,
				3498,
				9820,
				3513,
				7223,
				7224,
				21913,
				3503,
				15973,
				3511,
				9916,
				9920,
				9918,
				19668,
				9921,
				3497,
				11454,
				14380,
				3500,
				3515,
				11643,
				9928,
				9926,
				9931,
				9933,
				9980,
				9993,
				9972,
				9979,
				9937,
				9935,
				9957,
				9939,
				9945,
				9950,
				9995,
				9952,
				9997,
				9961,
				10001,
				9959,
				9964,
				10003,
				9968,
				9966,
				10005,
				9954,
				10007,
				9970,
				10009,
				9974,
				16639,
				16643,
				16641,
				16642,
				16640,
				10011,
				10013,
				16644,
				16645,
				10015,
				15292,
				16647,
				16646,
				16648,
				16649,
				16650,
				15293,
				16970,
				16969,
				20201,
				16651,
				19669,
				15294,
				15295,
				16973,
				16653,
				16971,
				16978,
				16652,
				15296,
				16667,
				16983,
				16654,
				16660,
				23632,
				16984,
				16656,
				16655,
				23628,
				16985,
				16658,
				16659,
				16661,
				20874,
				20872,
				16657,
				28461,
				23652,
				23650,
				28463,
				16993,
				22757,
				16988,
				28244,
				16742,
				27585,
				27830,
				16732,
				27832,
				16741,
				16744,
				27587,
				27588,
				16731,
				16995,
				20890,
				16729,
				27829,
				16746,
				20876,
				23633,
				23629,
				20897,
				16664,
				24136,
				23636,
				20873,
				21161,
				23637,
				24141,
				23653,
				16745,
				16994,
				16728,
				16726,
				16725,
				16724,
				16991,
				16662,
				16663,
				16990,
				16992,
				28243,
				24139,
				28462,
				24914,
				24137,
				16730,
				24138,
				23638,
				27586,
				27589,
				24140,
				24913,
				28242,
				16665,
				24912,
				24399,
				23639,
				27590,
			},
			[3] = {
				2881,
				7126,
				9058,
				9059,
				2152,
				2149,
				2153,
				3753,
				9060,
				9062,
				9064,
				3816,
				2160,
				5244,
				2161,
				3756,
				2163,
				2162,
				9065,
				3759,
				2164,
				3763,
				2159,
				3761,
				8322,
				2158,
				7953,
				6702,
				6703,
				9068,
				2167,
				3762,
				2169,
				20648,
				9070,
				3817,
				24940,
				2165,
				7133,
				7954,
				2168,
				7135,
				7955,
				3765,
				2166,
				9074,
				3767,
				9072,
				9145,
				3766,
				3768,
				3770,
				9146,
				9147,
				3769,
				9148,
				3764,
				9149,
				9194,
				20649,
				23190,
				3771,
				3818,
				3760,
				9193,
				3780,
				23399,
				3772,
				7147,
				3774,
				4096,
				9195,
				4097,
				6704,
				7149,
				3775,
				7151,
				9196,
				9197,
				3773,
				3776,
				9198,
				3778,
				9201,
				7153,
				6661,
				21943,
				6705,
				9202,
				7156,
				3777,
				9206,
				3779,
				10490,
				22711,
				10487,
				9208,
				9207,
				10482,
				20650,
				10499,
				10509,
				10507,
				10518,
				10516,
				10511,
				10520,
				10529,
				10533,
				10525,
				10531,
				14930,
				10542,
				10621,
				10544,
				10619,
				10546,
				14932,
				10630,
				10552,
				10558,
				10554,
				10548,
				10556,
				10564,
				10560,
				10562,
				10566,
				10568,
				10572,
				10632,
				10570,
				10647,
				19047,
				10574,
				19058,
				22331,
				19048,
				10650,
				19050,
				19049,
				19053,
				19051,
				19052,
				19055,
				19062,
				19060,
				19059,
				19061,
				19067,
				19064,
				19065,
				19063,
				19066,
				19068,
				19073,
				19072,
				19071,
				19070,
				24655,
				19080,
				19074,
				19078,
				19079,
				22815,
				19076,
				19077,
				19075,
				19086,
				19084,
				19081,
				23703,
				23705,
				19082,
				19085,
				19083,
				20853,
				19088,
				19089,
				19090,
				19087,
				24846,
				19094,
				24121,
				19092,
				19100,
				23708,
				23706,
				24850,
				19091,
				28219,
				19098,
				24848,
				24849,
				24851,
				28220,
				28224,
				28472,
				28221,
				28223,
				28473,
				28222,
				23704,
				24703,
				24123,
				22727,
				23707,
				20855,
				22928,
				20854,
				22926,
				26279,
				22923,
				22922,
				24124,
				24847,
				24125,
				22921,
				24122,
				28474,
				19102,
				19101,
				22927,
				19093,
				19104,
				19097,
				19107,
				23710,
				19103,
				19095,
				23709,
				19054,
				24654,
			},
			[4] = {
				7183,
				2330,
				2329,
				3170,
				2331,
				2332,
				4508,
				2334,
				3230,
				2337,
				6617,
				2335,
				7836,
				8240,
				3171,
				7179,
				7255,
				7841,
				3172,
				3447,
				3173,
				3174,
				3176,
				7837,
				3177,
				7256,
				2333,
				7845,
				3188,
				6624,
				7181,
				3452,
				7257,
				3448,
				3449,
				6618,
				3450,
				3451,
				11449,
				21923,
				7258,
				7259,
				3453,
				11450,
				3454,
				12609,
				11448,
				11451,
				11452,
				11453,
				11456,
				4942,
				22808,
				11457,
				11459,
				11480,
				11479,
				11458,
				11460,
				15833,
				11464,
				11465,
				11461,
				11466,
				11468,
				11467,
				11473,
				11472,
				11478,
				3175,
				11477,
				11476,
				26277,
				17551,
				17552,
				17553,
				17554,
				17555,
				17556,
				17557,
				17559,
				17560,
				17561,
				17562,
				17563,
				17564,
				17565,
				17566,
				17187,
				24365,
				24366,
				17571,
				17570,
				24367,
				17572,
				17573,
				17575,
				17577,
				17578,
				17574,
				24368,
				17576,
				17580,
				17634,
				17635,
				22732,
				17637,
				17636,
				25146,
				24266,
				17638,
			},
			[6] = {
				2540,
				7752,
				7751,
				15935,
				21143,
				2538,
				8604,
				2539,
				6412,
				6413,
				2795,
				6414,
				21144,
				8607,
				2541,
				7754,
				6416,
				6415,
				7753,
				7827,
				2542,
				6499,
				9513,
				3371,
				2543,
				2544,
				25704,
				3370,
				2546,
				8238,
				2545,
				3372,
				6417,
				6501,
				2547,
				7755,
				2549,
				6418,
				3397,
				3377,
				2548,
				6419,
				3373,
				15853,
				13028,
				3398,
				6500,
				3376,
				24418,
				3399,
				15865,
				15863,
				25954,
				4094,
				20916,
				3400,
				7213,
				7828,
				15855,
				15861,
				15856,
				21175,
				15910,
				15906,
				15933,
				18241,
				18238,
				15915,
				22480,
				20626,
				18239,
				18240,
				18242,
				18244,
				18243,
				18245,
				22761,
				18247,
				18246,
				24801,
				25659,
			},
			[7] = {
				2657,
				2659,
				3304,
				2658,
				3307,
				3308,
				3569,
				10097,
				10098,
				14891,
				16153,
				22967,
			},
			[8] = {
				2387,
				2393,
				2963,
				12044,
				3915,
				2385,
				8776,
				12045,
				7624,
				7623,
				3914,
				3840,
				2392,
				2394,
				8465,
				2389,
				3755,
				7629,
				7630,
				2397,
				3841,
				2386,
				7633,
				2396,
				3842,
				2395,
				6686,
				2964,
				2402,
				12046,
				3845,
				3757,
				2399,
				3843,
				6521,
				3758,
				2401,
				3847,
				3844,
				7639,
				2406,
				2403,
				3850,
				3866,
				3848,
				8467,
				7643,
				6688,
				12047,
				3849,
				7892,
				7893,
				3851,
				3839,
				3868,
				3855,
				3852,
				3869,
				6690,
				8758,
				3856,
				8760,
				3854,
				8780,
				3859,
				8782,
				6692,
				3813,
				3870,
				8762,
				8483,
				3857,
				8784,
				8764,
				3858,
				3871,
				8489,
				8772,
				8786,
				3860,
				8766,
				6693,
				3865,
				3863,
				8774,
				8789,
				6695,
				8791,
				3861,
				3872,
				8793,
				21945,
				8795,
				8770,
				8799,
				8797,
				3862,
				3864,
				3873,
				8802,
				12048,
				12049,
				12052,
				12050,
				8804,
				12060,
				12055,
				12056,
				12061,
				12059,
				12053,
				12064,
				12070,
				12066,
				12065,
				12067,
				27658,
				12069,
				12071,
				12075,
				12074,
				12072,
				12073,
				12078,
				12077,
				12076,
				12080,
				12079,
				12082,
				12084,
				12085,
				12081,
				12089,
				12088,
				12086,
				26407,
				12093,
				18560,
				26403,
				18401,
				12092,
				12091,
				18403,
				18402,
				18404,
				18408,
				26085,
				18407,
				18406,
				18405,
				18411,
				18410,
				18409,
				18412,
				18415,
				18413,
				18414,
				18420,
				18418,
				18416,
				18422,
				27724,
				27659,
				18419,
				18417,
				18421,
				18434,
				18423,
				18424,
				22813,
				26086,
				18436,
				18438,
				18437,
				23662,
				19435,
				18442,
				23664,
				18439,
				18440,
				18441,
				18444,
				27725,
				24903,
				18452,
				26087,
				24902,
				18457,
				28209,
				22866,
				23665,
				24901,
				28482,
				18454,
				22867,
				22870,
				18458,
				28208,
				20848,
				28481,
				22759,
				24091,
				18453,
				28210,
				18446,
				28480,
				23663,
				18449,
				28207,
				23666,
				18455,
				23667,
				18448,
				28205,
				24092,
				18450,
				18447,
				24093,
				22902,
				22868,
				18456,
				18451,
				22869,
				20849,
				18445,
				27660,
			},
			[9] = {
				3919,
				3918,
				3920,
				3923,
				3922,
				3924,
				3925,
				7430,
				3977,
				3926,
				3928,
				3929,
				3931,
				3930,
				3932,
				3973,
				3934,
				8339,
				3933,
				8334,
				3938,
				3937,
				3936,
				3978,
				3941,
				3939,
				3940,
				3942,
				3944,
				26418,
				3946,
				9269,
				26417,
				3947,
				26416,
				3945,
				3949,
				6458,
				3950,
				3952,
				3953,
				3954,
				3956,
				23066,
				23067,
				12584,
				3955,
				9271,
				23068,
				3957,
				3959,
				3958,
				3960,
				9273,
				3961,
				26421,
				12587,
				26420,
				3963,
				12586,
				12585,
				12590,
				3962,
				26422,
				3979,
				3965,
				8243,
				3966,
				3967,
				21940,
				3968,
				12589,
				12895,
				15255,
				23069,
				3971,
				3969,
				3972,
				12591,
				12715,
				12594,
				12760,
				15628,
				12717,
				12899,
				13240,
				12716,
				15633,
				12718,
				12595,
				12596,
				12897,
				12902,
				12597,
				12599,
				12907,
				12903,
				12603,
				12614,
				12607,
				26442,
				12616,
				12905,
				12615,
				26423,
				12754,
				8895,
				26425,
				26424,
				12906,
				12617,
				12618,
				12755,
				12619,
				12758,
				12908,
				12620,
				12759,
				12621,
				12622,
				23070,
				23507,
				19567,
				12624,
				26011,
				19788,
				19790,
				23486,
				23129,
				23077,
				19792,
				23071,
				19791,
				23489,
				23078,
				19793,
				23096,
				19794,
				19814,
				26427,
				23079,
				26443,
				19795,
				-- 28327,
				26428,
				19796,
				26426,
				23080,
				19800,
				19815,
				19799,
				23081,
				19825,
				19819,
				23082,
				19831,
				22797,
				22795,
				22793,
				19830,
				19833,
				22704,
				24356,
				24357,
			},
			[10] = {
				7421,
				7418,
				14293,
				7420,
				7443,
				7426,
				7454,
				25124,
				7457,
				7748,
				7766,
				14807,
				7771,
				7776,
				7428,
				7782,
				7779,
				7788,
				7786,
				7793,
				7795,
				7745,
				13378,
				13419,
				13380,
				13464,
				13421,
				7857,
				7859,
				7861,
				7863,
				7867,
				13501,
				13485,
				13522,
				13503,
				13536,
				13538,
				13617,
				13620,
				13529,
				13607,
				13612,
				13628,
				25125,
				13622,
				13626,
				14809,
				13631,
				13635,
				13640,
				13637,
				13642,
				13648,
				13646,
				13644,
				13655,
				13657,
				14810,
				13653,
				13661,
				13659,
				13663,
				21931,
				13687,
				13693,
				13689,
				13702,
				13695,
				25126,
				13700,
				13698,
				13746,
				13794,
				13817,
				13815,
				13822,
				13841,
				13836,
				13846,
				13858,
				13890,
				13882,
				13887,
				13868,
				13917,
				13915,
				13905,
				13935,
				13931,
				13933,
				13937,
				13939,
				13943,
				13945,
				13941,
				17181,
				25127,
				13947,
				17180,
				13948,
				20008,
				20020,
				20014,
				20017,
				15596,
				13898,
				20012,
				20009,
				20026,
				20024,
				25128,
				20016,
				20029,
				20015,
				20051,
				23799,
				23801,
				20028,
				27837,
				23800,
				20010,
				20030,
				20033,
				20013,
				20023,
				25074,
				22750,
				20031,
				20034,
				25080,
				25072,
				20011,
				22749,
				25079,
				25073,
				23803,
				25083,
				20032,
				25129,
				25130,
				25078,
				20035,
				25082,
				23802,
				25084,
				20036,
				23804,
				25081,
				20025,
				25086,
			},
			[13] = {
				3420,
				8681,
				5763,
				8687,
				2835,
				13220,
				-- 6510,
				8691,
				2837,
				8694,
				13228,
				11341,
				11357,
				13229,
				3421,
				11400,
				11342,
				11358,
				13230,
				11343,
				25347,
			},
		};
		local pid_sname_to_sid = {  };	--	[pid][sname] = { sid }
		local cid_to_sid = {  };		--	[cid] = { sid }
		local cid_pid_to_sid = {  };	--	[cid][pid] = { sid }
		local rid_to_sid = {  };		--	[rid] = sid
		--	id list
		local recipe_sid_list = {  };	--	{ sid }			--	actually unused
		local recipe_cid_list = {  };	--	{ cid }			--	actually unused
		--
		local reagent_to_sid = {  };
		--	cached
		local spell_info = {  };		--	[sid] = { 1_name, 2_name_lower, 3_link, 4_link_lower, 5_string }
		local item_info = {  };			--	[iid] = info{ 1_name, 2_link, 3_rarity, 4_loc, 5_icon, 6_sellPrice, 7_typeID, 8_subTypeId, 9_bindType, 10_name_lower, 11_link_lower, 12_string }
		--
		function NS.db_cache_spell(sid)
			local sname = GetSpellInfo(sid);
			if sname then
				local sname_lower = strlower(sname);
				local sinfo = {
					sname,
					sname_lower,
					"\124cff71d5ff\124Hspell:" .. sid .. "\124h[" .. sname .. "]\124h\124r",
					"\124cff71d5ff\124hspell:" .. sid .. "\124h[" .. sname_lower .. "]\124h\124r",
					"\124cff71d5ff[" .. sname .. "]\124r",
				};
				spell_info[sid] = sinfo;
				local info = recipe_info[sid];
				if info then
					local pid = info[index_pid];
					local pt = pid_sname_to_sid[pid];
					if pt == nil then
						pt = {  };
						pid_sname_to_sid[pid] = pt;
					end
					local ptn = pt[sname];
					if ptn == nil then
						ptn = {  };
						pt[sname] = ptn;
					end
					pt[sname_lower] = ptn;
					tinsert(ptn, sid);
				end
				return sinfo;
			-- else
				-- RequestLoadSpellData(sid);
			end
		end
		function NS.db_cache_item(iid)
			local iname, ilink, rarity, level, pLevel, type, subType, stackCount, loc, icon, sellPrice,
					typeID, subTypeID, bindType, expacID, setID, isReagent = GetItemInfo(iid); 
			if iname and ilink then
				local iname_lower = strlower(iname);
				local ilink_lower = strlower(ilink);
				local str = nil;
				if ITEM_QUALITY_COLORS then
					local c = ITEM_QUALITY_COLORS[rarity];
					if c then
						str = c.hex .. "[" .. iname .. "]\124r";
					end
				end
				str = str or "[" .. iname .. "]";
				local info = {
					[index_i_name]			= iname,
					[index_i_link]			= ilink,
					[index_i_rarity]		= rarity,
					[index_i_loc]			= loc,
					[index_i_icon]			= icon,
					[index_i_sellPrice]		= sellPrice,
					[index_i_typeID]		= typeID,
					[index_i_subTypeID]		= subTypeID,
					[index_i_bindType]		= bindType,
					[index_i_name_lower]	= iname_lower,
					[index_i_link_lower]	= ilink_lower,
					[index_i_string]		= str,
				};
				item_info[iid] = info;
				return info;
			else
				-- RequestLoadItemDataByID(iid);
				-- _error_("SPELL_DATA_LOAD_RESULT#1", iid);
			end
		end
		do	--	PRELOAD
			function NS.SPELL_DATA_LOAD_RESULT(sid, success)
				if success then
					--	trade skill line
					local pid = tradeskill_hash[sid];
					if pid then
						local pname = GetSpellInfo(sid);
						if pname then
							local pname_lower = strlower(pname);
							tradeskill_hash[sid] = nil;
							if tradeskill_id[pid] == sid then
								if L.extra_skill_name[pid] == nil then
									tradeskill_hash[pname] = pid;
									tradeskill_hash[pname_lower] = pid;
								else
									tradeskill_hash[L.extra_skill_name[pid]] = pid;
									tradeskill_hash[strlower(L.extra_skill_name[pid])] = pid;
								end
								tradeskill_name[pid] = pname;
							end
							if tradeskill_check_id[pid] == sid then
								tradeskill_check_name[pid] = pname;
							end
							spell_info[sid] = {
								pname,
								pname_lower,
								"\124cff71d5ff\124Hspell:" .. sid .. "\124h[" .. pname .. "]\124h\124r",
								"\124cff71d5ff\124hspell:" .. sid .. "\124h[" .. pname_lower .. "]\124h\124r",
								"\124cff71d5ff[" .. pname .. "]\124r",
							};
						-- else
							-- RequestLoadSpellData(sid);
						end
						return;
					end
					--	trade skill recipe
					if NS.db_is_tradeskill_sid(sid) then
						NS.db_cache_spell(sid);
					end
				-- else
					-- local info = recipe_info[sid];
					-- RequestLoadSpellData(sid);
					-- _error_("SPELL_DATA_LOAD_RESULT#0", sid);
				end
			end
			local function preload_check_spell()
				local completed = true;
				local maxonce = IsInRaid() and 500 or (IsInGroup() and 1000 or 10000);
				for pid = NS.db_min_pid(), NS.db_max_pid() do
					local sid = tradeskill_id[pid];
					if not tradeskill_name[pid] then
						RequestLoadSpellData(sid);
						tradeskill_hash[sid] = pid;
						local csid = tradeskill_check_id[pid];
						if csid and csid ~= sid then
							RequestLoadSpellData(csid);
							tradeskill_hash[csid] = pid;
						end
						completed = false;
						maxonce = maxonce - 1;
						if maxonce <= 0 then
							return false;
						end
					end
				end
				for sid, info in next, recipe_info do
					if not spell_info[sid] then
						RequestLoadSpellData(sid);
						completed = false;
						maxonce = maxonce - 1;
						if maxonce <= 0 then
							return false;
						end
					end
				end
				return completed;
			end
			local temp_iid_list = {  };	--	[iid] = 1	--	temp
			function NS.ITEM_DATA_LOAD_RESULT(iid, success)
				if temp_iid_list[iid] then
					if success then
						NS.db_cache_item(iid);
					else
						-- RequestLoadItemDataByID(iid);
						-- _error_("SPELL_DATA_LOAD_RESULT#0", iid);
					end
				end
			end
			local function preload_check_item()
				local completed = true;
				local maxonce = IsInRaid() and 500 or (IsInGroup() and 1000 or 10000);
				for sid, info in next, recipe_info do
					local cid = info[index_cid];
					if cid then
						if not item_info[cid] then
							RequestLoadItemDataByID(cid);
							temp_iid_list[cid] = 1;
							completed = false;
							maxonce = maxonce - 1;
							if maxonce <= 0 then
								return false;
							end
						end
					end
					local rid = info[index_rid]
					if rid then
						if not item_info[rid] then
							RequestLoadItemDataByID(rid);
							temp_iid_list[rid] = 1;
							completed = false;
							maxonce = maxonce - 1;
							if maxonce <= 0 then
								return false;
							end
						end
					end
					local reagent_ids = info[index_reagents_id];
					if reagent_ids then
						for index2 = 1, #reagent_ids do
							local rid = reagent_ids[index2];
							if not item_info[rid] then
								RequestLoadItemDataByID(rid);
								temp_iid_list[rid] = 1;
								completed = false;
								maxonce = maxonce - 1;
								if maxonce <= 0 then
									return false;
								end
							end
						end
					end
				end
				if completed then
					wipe(temp_iid_list);
					temp_iid_list = nil;
				end
				return completed;
			end
			local preload_check_spell_times = 0;
			local function PRELOAD_SPELL()
				if preload_check_spell() then
					_EventHandler:UnregEvent("SPELL_DATA_LOAD_RESULT");
					_EventHandler:FireEvent("USER_EVENT_SPELL_DATA_LOADED");
				else
					_EventHandler:RegEvent("SPELL_DATA_LOAD_RESULT");	--	Events registered before loading screen went out may not work well. So reg here everytime.
					C_Timer.After(2.0, PRELOAD_SPELL);
					preload_check_spell_times = preload_check_spell_times + 1;
					if preload_check_spell_times >= 10 then
						_error_("PRELOAD_SPELL#0", preload_check_spell_times);
					end
				end
			end
			local preload_check_item_times = 0;
			local function PRELOAD_ITEM()
				if preload_check_item() then
					_EventHandler:UnregEvent("ITEM_DATA_LOAD_RESULT");
					_EventHandler:FireEvent("USER_EVENT_ITEM_DATA_LOADED");
				else
					_EventHandler:RegEvent("ITEM_DATA_LOAD_RESULT");	--	Events registered before loading screen went out may not work well. So reg here everytime.
					C_Timer.After(2.0, PRELOAD_ITEM);
					preload_check_item_times = preload_check_item_times + 1;
					if preload_check_item_times >= 10 then
						_error_("PRELOAD_ITEM#0", preload_check_item_times);
					end
				end
			end
			function NS.db_preload()
				PRELOAD_SPELL();
				PRELOAD_ITEM();
			end
		end
		function NS.db_init()
			for pid, fix in next, train_price_fix do
				for sid, price in next, fix do
					local info = recipe_info[sid];
					if info then
						info[index_train_price] = price;
					end
				end
			end
			for pid = NS.db_min_pid(), NS.db_max_pid() do
				local list = recipe_sid_list_by_pid[pid];
				if list then
					pid_sname_to_sid[pid] = {  };
					cid_pid_to_sid[pid] = cid_pid_to_sid[pid] or {  };
					for index = 1, #list do
						local sid = list[index];
						local info = recipe_info[sid];
						info[index_validated] = true;
						local cid = info[index_cid];
						if cid then
							local h1 = cid_to_sid[cid];
							if not h1 then
								h1 = {  };
								cid_to_sid[cid] = h1;
							end
							tinsert(h1, sid);
							local h2 = cid_pid_to_sid[pid][cid];
							if not h2 then
								h2 = {  };
								cid_pid_to_sid[pid][cid] = h2;
							end
							tinsert(h2, sid);
						end
						local rid = info[index_rid];
						if rid then
							rid_to_sid[rid] = sid;
						end
						--	list
						tinsert(recipe_sid_list, sid);
						if cid then
							tinsert(recipe_cid_list, cid);
						end
						--	material
						local regeants_id = info[index_reagents_id];
						local reagents_num = info[index_reagents_count];
						for index = 1, #regeants_id do
							local reagent_id = regeants_id[index];
							local val = reagent_to_sid[reagent_id];
							if val == nil then
								val = { {  }, {  }, };
								reagent_to_sid[reagent_id] = val;
							end
							tinsert(val[1], sid);
							tinsert(val[2], reagents_num[index]);
						end
					end
				end
			end
			for sid, info in next, recipe_info do
				if not info[index_validated] then
					recipe_info[sid] = nil;
				end
			end
			if IsInRaid() then
				C_Timer.After(4, NS.db_preload);
			elseif IsInGroup() then
				C_Timer.After(2, NS.db_preload);
			else
				NS.db_preload();
			end
		end
		--	GET TABLE
			--	| tradeskill_check_id{ [pid] = p_check_sid }
			function NS.db_table_tradeskill_check_id()
				return tradeskill_check_id;
			end
			--	| tradeskill_check_name{ [pid] = p_check_sname }
			function NS.db_table_tradeskill_check_name()
				return tradeskill_check_name;
			end
		--	QUERY RECIPE DB
			function NS.db_min_pid()
				return 1;
			end
			function NS.db_max_pid()
				return 14;
			end
			--	pid | is_tradeskill
			function NS.db_is_pid(pid)
				return pid ~= nil and tradeskill_id[pid] ~= nil;
			end
			--	pname | pid
			function NS.db_get_pid_by_pname(pname)
				if pname ~= nil then
					return tradeskill_hash[pname];
				end
			end
			--	pid | pname
			function NS.db_get_pname_by_pid(pid)
				if pid ~= nil then
					return tradeskill_name[pid];
				end
			end
			--	pid | ptexture
			function NS.db_get_texture_by_pid(pid)
				if pid ~= nil then
					return tradeskill_texture[pid];
				end
			end
			--	pid | has_win
			function NS.db_is_pid_has_win(pid)
				if NS.db_is_pid(pid) then
					return tradeskill_has_win[pid];
				end
			end
			--	pid | check_id
			function NS.db_get_check_id_by_pid(pid)
				if pid ~= nil then
					return tradeskill_check_id[pid];
				end
			end
			--	pid | check_name
			function NS.db_get_check_name_by_pid(pid)
				if pid ~= nil then
					return tradeskill_check_name[pid];
				end
			end
			--	sid | is_tradeskill
			function NS.db_is_tradeskill_sid(sid)
				return sid ~= nil and recipe_info[sid] ~= nil;
			end
			--	pid | list{ sid, }
			function NS.db_get_list_by_pid(pid)
				if pid ~= nil then
					return recipe_sid_list_by_pid[pid];
				end
			end
			--	<query_recipe_info
			--	sid | info{  }
			function NS.db_get_info_by_sid(sid)
				if sid ~= nil then
					return recipe_info[sid];
				end
			end
			--	sid | phase
			function NS.db_get_phase_by_sid(sid)
				if sid ~= nil then
					local info = recipe_info[sid];
					if info then
						return info[index_phase];
					end
				end
			end
			--	sid | pid
			function NS.db_get_pid_by_sid(sid)
				if sid ~= nil then
					local info = recipe_info[sid];
					if info then
						return info[index_pid];
					end
				end
			end
			--	sid | cid
			function NS.db_get_cid_by_sid(sid)
				if sid ~= nil then
					local info = recipe_info[sid];
					if info then
						return info[index_cid];
					end
				end
			end
			--	sid | learn_rank
			function NS.db_get_learn_rank_by_sid(sid)
				if sid ~= nil then
					local info = recipe_info[sid];
					if info then
						return info[index_learn_rank];
					end
				end
			end
			--	sid | learn_rank, yellow_rank, green_rank, grey_rank
			function NS.db_get_difficulty_rank_list_by_sid(sid)
				if sid ~= nil then
					local info = recipe_info[sid];
					if info then
						return info[index_learn_rank], info[index_yellow_rank], info[index_green_rank], info[index_grey_rank];
					end
				end
			end
			--	sid | text"[[red ]yellow green grey]"
			function NS.db_get_difficulty_rank_list_text_by_sid(sid)
				if sid ~= nil then
					local red, yellow, green, grey = NS.db_get_difficulty_rank_list_by_sid(sid);
					if red and yellow and green and grey then
						if red < yellow then
							return "\124cffff8f00" .. red .. " \124cffffff00" .. yellow .. " \124cff8fff00" .. green .. " \124cff8f8f8f" .. grey;
						else
							return "\124cffffff00" .. yellow .. " \124cff8fff00" .. green .. " \124cff8f8f8f" .. grey;
						end
					end
				end
				return "";
			end
			--	sid | difficulty	--	rank: red-1, yellow-2, green-3, grey-4
			function NS.db_get_difficulty_rank_by_sid(sid, cur)
				if sid ~= nil then
					local info = recipe_info[sid];
					if info then
						if cur >= info[index_grey_rank] then
							return 4;
						elseif cur >= info[index_green_rank] then
							return 3;
						elseif cur >= info[index_yellow_rank] then
							return 2;
						elseif cur >= info[index_learn_rank] then
							return 1;
						else
							return 0;
						end
					end
				end
				return BIG_NUMBER;
			end
			--	sid | avg_made, min_made, max_made
			function NS.db_get_num_made_by_sid(sid)
				if sid ~= nil then
					local info = recipe_info[sid];
					if info then
						return (info[index_num_made_min] + info[index_num_made_max]) / 2, info[index_num_made_min], info[index_num_made_max];
					end
				end
			end
			--	sid | reagent_ids{  }, reagent_nums{  }
			function NS.db_get_reagents_by_sid(sid)
				if sid ~= nil then
					local info = recipe_info[sid];
					if info then
						return info[index_reagents_id], info[index_reagents_count];
					end
				end
			end
			--	query_recipe_info>
			--	pid, sname | num, pids{  }
			function NS.db_get_sid_by_pid_sname(pid, sname)
				if pid ~= nil and sname ~= nil then
					local pt = pid_sname_to_sid[pid];
					if pt then
						local ptn = pt[sname];
						if ptn then
							return #ptn, ptn;
						end
					end
				end
				return 0;
			end
			--	pid, sname, cid | sid
			function NS.db_get_sid_by_pid_sname_cid(pid, sname, cid)
				if pid ~= nil and sname ~= nil and cid ~= nil then
					local nsids, sids = NS.db_get_sid_by_pid_sname(pid, sname);
					local index_xid = pid == 10 and index_sid or index_cid;
					if nsids > 0 then
						for index = 1, #sids do
							local sid = sids[index];
							local info = recipe_info[sid];
							if info and cid == info[index_xid] then
								return sid;
							end
						end
					end
				end
			end
			--	cid | is_tradeskill
			function NS.db_is_tradeskill_cid(cid)
				return cid ~= nil and cid_to_sid[cid] ~= nil;
			end
			--	cid | nsids, sids{  }
			function NS.db_get_sid_by_cid(cid)
				if cid ~= nil then
					local sids = cid_to_sid[cid];
					if sids then
						return #sids, sids;
					end
				end
				return 0;
			end
			--	pid, cid | nsids, sids{  }
			function NS.db_get_sid_by_pid_cid(pid, cid)
				if pid ~= nil and cid ~= nil then
					local p = cid_pid_to_sid[pid];
					if p then
						local sids = p[cid];
						return #sids, sids;
					end
				end
				return 0;
			end
			function NS.db_get_sid_by_rid(rid)
				if rid ~= nil then
					return rid_to_sid[rid];
				end
			end
			function NS.db_get_sid_by_reagent(iid)
				if iid ~= nil then
					return reagent_to_sid[iid];
				end
			end
		--	QUERY OBJ INFO
			function NS.__db_spell_info(sid)
				if sid ~= nil then
					local info = spell_info[sid];
					if info == nil then
						return NS.db_cache_spell(sid);
					else
						return info;
					end
				end
			end
			function NS.db_spell_name(sid)
				local info = NS.__db_spell_info(sid);
				if info ~= nil then
					return info[1];
				end
			end
			function NS.db_spell_name_lower(sid)
				local info = NS.__db_spell_info(sid);
				if info ~= nil then
					return info[2];
				end
			end
			function NS.db_spell_link(sid)
				local info = NS.__db_spell_info(sid);
				if info ~= nil then
					return info[3];
				end
			end
			function NS.db_spell_link_lower(sid)
				local info = NS.__db_spell_info(sid);
				if info ~= nil then
					return info[4];
				end
			end
			function NS.db_spell_string(sid)
				local info = NS.__db_spell_info(sid);
				if info ~= nil then
					return info[5];
				end
			end
			--
			function NS.__db_item_info(iid)
				if iid ~= nil then
					local info = item_info[iid];
					if info == nil then
						return NS.db_cache_item(iid);
					else
						return info;
					end
				end
			end
			function NS.db_item_info(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return unpack(info);
				end
			end
			function NS.db_item_name(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_name];
				end
			end
			function NS.db_item_link(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_link];
				end
			end
			function NS.db_item_rarity(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_rarity];
				end
			end
			function NS.db_item_loc(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_loc];
				end
			end
			function NS.db_item_icon(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_icon];
				end
			end
			function NS.db_item_sellPrice(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_sellPrice];
				end
			end
			function NS.db_item_typeID(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_typeID];
				end
			end
			function NS.db_item_subTypeID(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_subTypeID];
				end
			end
			function NS.db_item_bindType(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_bindType];
				end
			end
			function NS.db_item_name_lower(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_name];
				end
			end
			function NS.db_item_link_lower(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_link];
				end
			end
			function NS.db_item_string(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_string];
				end
			end
			--	secure
			function NS.db_spell_name_s(sid)
				return NS.db_spell_name(sid) or ("spellId:" .. sid);
			end
			function NS.db_spell_link_s(sid)
				return NS.db_spell_link(sid) or ("spellId:" .. sid);
			end
			function NS.db_spell_string_s(sid)
				return NS.db_spell_string(sid) or ("spellId:" .. sid);
			end
			function NS.db_item_name_s(iid)
				return NS.db_item_name(iid) or ("itemId:" .. iid);
			end
			function NS.db_item_link_s(iid)
				return NS.db_item_link(iid) or ("itemId:" .. iid);
			end
			function NS.db_item_string_s(iid)
				return NS.db_item_string(iid) or ("itemId:" .. iid);
			end
		--	MTSL
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
			function NS.db_get_mtsl_pname(pid)
				if pid ~= nil then
					return tradeskill_mtsl_name[pid];
				else
					return nil;
				end
			end
		--	pid, list, check_hash, phase, rank, rankReversed, showKnown, showUnkown, showHighRank, donot_wipe_list | list{ sid, }
		function NS.db_get_ordered_list(pid, list, check_hash, phase, rank, rankReversed, showKnown, showUnkown, showHighRank, donot_wipe_list)
			if pid == nil then
				_log_("NS.db_get_ordered_list\124cff00ff00#1L1\124r");
				if not donot_wipe_list then
					wipe(list);
				end
				for pid = NS.db_min_pid(), NS.db_max_pid() do
					 if recipe_sid_list_by_pid[pid] then
						NS.db_get_ordered_list(pid, list, check_hash, phase, rank, rankReversed, showKnown, showUnkown, showHighRank, true);
					end
				end
			elseif recipe_sid_list_by_pid[pid] ~= nil then
				_log_("NS.db_get_ordered_list\124cff00ff00#1L2\124r", pid);
				local recipe = recipe_sid_list_by_pid[pid];
				if not donot_wipe_list then
					wipe(list);
				end
				phase = phase or curPhase;
				if check_hash ~= nil and rank ~= nil then
					if showKnown and showUnkown then
						if rankReversed then
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and info[index_grey_rank] <= rank then
									tinsert(list, sid);
								end
							end
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and info[index_green_rank] <= rank and info[index_grey_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and info[index_yellow_rank] <= rank and info[index_green_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and info[index_learn_rank] <= rank and info[index_yellow_rank] > rank then
									tinsert(list, sid);
								end
							end
							if showHighRank then
								for i = 1, #recipe do
									local sid = recipe[i];
									local info = recipe_info[sid]
									if info[index_phase] <= phase and info[index_learn_rank] > rank then
										tinsert(list, sid);
									end
								end
							end
						else
							if showHighRank then
								for i = #recipe, 1, -1 do
									local sid = recipe[i];
									local info = recipe_info[sid]
									if info[index_phase] <= phase and info[index_learn_rank] > rank then
										tinsert(list, sid);
									end
								end
							end
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and info[index_learn_rank] <= rank and info[index_yellow_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and info[index_yellow_rank] <= rank and info[index_green_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and info[index_green_rank] <= rank and info[index_grey_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and info[index_grey_rank] <= rank then
									tinsert(list, sid);
								end
							end
						end
					elseif showKnown then
						if rankReversed then
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] ~= nil and info[index_grey_rank] <= rank then
									tinsert(list, sid);
								end
							end
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] ~= nil and info[index_green_rank] <= rank and info[index_grey_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] ~= nil and info[index_yellow_rank] <= rank and info[index_green_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] ~= nil and info[index_learn_rank] <= rank and info[index_yellow_rank] > rank then
									tinsert(list, sid);
								end
							end
						else
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] ~= nil and info[index_learn_rank] <= rank and info[index_yellow_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] ~= nil and info[index_yellow_rank] <= rank and info[index_green_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] ~= nil and info[index_green_rank] <= rank and info[index_grey_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] ~= nil and info[index_grey_rank] <= rank then
									tinsert(list, sid);
								end
							end
						end
					elseif showUnkown then
						if rankReversed then
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] == nil and info[index_grey_rank] <= rank then
									tinsert(list, sid);
								end
							end
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] == nil and info[index_green_rank] <= rank and info[index_grey_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] == nil and info[index_yellow_rank] <= rank and info[index_green_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] == nil and info[index_learn_rank] <= rank and info[index_yellow_rank] > rank then
									tinsert(list, sid);
								end
							end
							if showHighRank then
								for i = 1, #recipe do
									local sid = recipe[i];
									local info = recipe_info[sid]
									if info[index_phase] <= phase and check_hash[sid] == nil and info[index_learn_rank] > rank then
										tinsert(list, sid);
									end
								end
							end
						else
							if showHighRank then
								for i = #recipe, 1, -1 do
									local sid = recipe[i];
									local info = recipe_info[sid]
									if info[index_phase] <= phase and check_hash[sid] == nil and info[index_learn_rank] > rank then
										tinsert(list, sid);
									end
								end
							end
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] == nil and info[index_learn_rank] <= rank and info[index_yellow_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] == nil and info[index_yellow_rank] <= rank and info[index_green_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] == nil and info[index_green_rank] <= rank and info[index_grey_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] == nil and info[index_grey_rank] <= rank then
									tinsert(list, sid);
								end
							end
						end
					end
				elseif check_hash ~= nil then
					if showKnown and showUnkown then
						if rankReversed then
							for i = 1, #recipe do
								local sid = recipe[i];
								tinsert(list, sid);
							end
						else
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								tinsert(list, sid);
							end
						end
					elseif showKnown then
						if rankReversed then
							for i = 1, #recipe do
								local sid = recipe[i];
								if check_hash[sid] ~= nil then
									tinsert(list, sid);
								end
							end
						else
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								if check_hash[sid] ~= nil then
									tinsert(list, sid);
								end
							end
						end
					elseif showUnkown then
						if rankReversed then
							for i = 1, #recipe do
								local sid = recipe[i];
								if check_hash[sid] == nil then
									tinsert(list, sid);
								end
							end
						else
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								if check_hash[sid] == nil then
									tinsert(list, sid);
								end
							end
						end
					end
				elseif rank ~= nil then
					if rankReversed then
						for i = 1, #recipe do
							local sid = recipe[i];
							local info = recipe_info[sid]
							if info[index_phase] <= phase and info[index_grey_rank] <= rank then
								tinsert(list, sid);
							end
						end
						for i = 1, #recipe do
							local sid = recipe[i];
							local info = recipe_info[sid]
							if info[index_phase] <= phase and info[index_green_rank] <= rank and info[index_grey_rank] > rank then
								tinsert(list, sid);
							end
						end
						for i = 1, #recipe do
							local sid = recipe[i];
							local info = recipe_info[sid]
							if info[index_phase] <= phase and info[index_yellow_rank] <= rank and info[index_green_rank] > rank then
								tinsert(list, sid);
							end
						end
						for i = 1, #recipe do
							local sid = recipe[i];
							local info = recipe_info[sid]
							if info[index_phase] <= phase and info[index_learn_rank] <= rank and info[index_yellow_rank] > rank then
								tinsert(list, sid);
							end
						end
						if showHighRank then
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and info[index_learn_rank] > rank then
									tinsert(list, sid);
								end
							end
						end
					else
						if showHighRank then
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and info[index_learn_rank] > rank then
									tinsert(list, sid);
								end
							end
						end
						for i = #recipe, 1, -1 do
							local sid = recipe[i];
							local info = recipe_info[sid]
							if info[index_phase] <= phase and info[index_learn_rank] <= rank and info[index_yellow_rank] > rank then
								tinsert(list, sid);
							end
						end
						for i = #recipe, 1, -1 do
							local sid = recipe[i];
							local info = recipe_info[sid]
							if info[index_phase] <= phase and info[index_yellow_rank] <= rank and info[index_green_rank] > rank then
								tinsert(list, sid);
							end
						end
						for i = #recipe, 1, -1 do
							local sid = recipe[i];
							local info = recipe_info[sid]
							if info[index_phase] <= phase and info[index_green_rank] <= rank and info[index_grey_rank] > rank then
								tinsert(list, sid);
							end
						end
						for i = #recipe, 1, -1 do
							local sid = recipe[i];
							local info = recipe_info[sid]
							if info[index_phase] <= phase and info[index_grey_rank] <= rank then
								tinsert(list, sid);
							end
						end
					end
				else
					if rankReversed then
						Mixin(list, recipe);
					else
						for i = #recipe, 1, -1 do
							local sid = recipe[i];
							tinsert(list, sid);
						end
					end
				end
			else
				_log_("NS.db_get_ordered_list\124cff00ff00#1L3\124r", pid);
			end
			return list;
		end
		--
		-- if select(2, BNGetInfo()) == 'alex#516722' then
			function NS.link_db()	--	recipe_info, spell_info, item_info
				return recipe_info, spell_info, item_info;
			end
		-- end
	end

	local explorer_hash = {  };
	local explorer_stat_list = { skill = {  }, type = {  }, subType = {  }, eqLoc = {  }, };
	do	--	func
		local function func_add_known_recipe(sid, GUID)
			local list = explorer_hash[sid];
			if list == nil then
				list = {  };
				explorer_hash[sid] = list;
			end
			list[GUID] = 1;
		end
		local function func_sub_known_recipe(sid, GUID)
			local list = explorer_hash[sid];
			if list then
				list[GUID] = nil;
			end
			for _ in next, list do
				return;
			end
			explorer_hash[sid] = nil;
		end
		--
		function NS.init_hash_known_recipe()
			for GUID, VAR in next, AVAR do
				if VAR.realm_id == PLAYER_REALM_ID then
					for pid = NS.db_min_pid(), NS.db_max_pid() do
						local var = rawget(VAR, pid);
						if var and NS.db_is_pid(pid) then
							local list = var[1];
							for index = 1, #list do
								func_add_known_recipe(list[index], GUID);
							end
						end
					end
				end
			end
		end
		--
		function NS.SKILL_LINES_CHANGED()	--	Donot process the first trigger after login. And wait for 1sec.
			local func_SKILL_LINES_CHANGED = function()
				local check_name = NS.db_table_tradeskill_check_name();
				for pid = NS.db_min_pid(), NS.db_max_pid() do
					local cpname = check_name[pid];
					if cpname then
						if not GetSpellInfo(cpname) then
							rawset(VAR, pid, nil);
						end
					end
				end
				for index = 1, GetNumSkillLines() do
					local pname, header, expanded, cur_rank, _, _, max_rank  = GetSkillLineInfo(index);
					if not header then
						local pid = NS.db_get_pid_by_pname(pname);
						if pid then
							local var = VAR[pid];
							var.update = true;
							var.cur_rank, var.max_rank = cur_rank, max_rank;
							NS.cooldown_check(pid, var);
						end
					end
				end
				local tf = gui.Blizzard_TradeSkillUI;
				local cf = gui.Blizzard_CraftUI;
				if tf then
					tf.tabFrame:Update();
					tf.switch:Update();
				end
				if cf then
					cf.tabFrame:Update();
					cf.switch:Update();
				end
			end
			C_Timer.After(1.0, function()
				func_SKILL_LINES_CHANGED();
				NS.SKILL_LINES_CHANGED = func_SKILL_LINES_CHANGED;
				func_SKILL_LINES_CHANGED = nil;
			end);
		end
		function NS.NEW_RECIPE_LEARNED(sid)
			local pid = NS.db_get_pid_by_sid(sid);
			if pid then
				local var = VAR[pid];
				var.update = true;
				tinsert(var[1], sid);
				var[2][sid] = -1;
				func_add_known_recipe(sid, PLAYER_GUID);
				_EventHandler:FireEvent("USER_EVENT_RECIPE_LIST_UPDATE");
			else
				_error_("NS.NEW_RECIPE_LEARNED#0", sid);
			end
		end
		--------
		local function process_search(list, searchText, searchNameOnly)
			local item_func = searchNameOnly and NS.db_item_name_lower or NS.db_item_link_lower;
			local spell_func = searchNameOnly and NS.db_spell_name_lower or NS.db_spell_link_lower;
			for index = #list, 1, -1 do
				local sid = list[index];
				local info = NS.db_get_info_by_sid(sid);
				if info then
					local removed = true;
					local cid = info[index_cid];
					local spell_lower = spell_func(sid);
					local item_lower = cid and item_func(cid);
					if (spell_lower and strfind(spell_lower, searchText)) or (item_lower and strfind(item_lower, searchText)) then
						removed = false;
					else
						local reagent_ids = info[index_reagents_id];
						if reagent_ids then
							for index2 = 1, #reagent_ids do
								local item_lower = item_func(reagent_ids[index2]);
								if item_lower and strfind(item_lower, searchText) then
									removed = false;
								end
							end
						end
					end
					if removed then
						tremove(list, index);
					end
				end
			end
		end
		local function safe_process_search(frame, regular_exp, list, searchText, searchNameOnly)
			if regular_exp then
				searchText = strlower(searchText);
				local result, ret = pcall(process_search, list, searchText, searchNameOnly);
				if result then
					frame:SearchEditValid();
				else
					frame:SearchEditInvalid();
				end
			else
				searchText = gsub(strlower(searchText), "[%^%$%%%.%+%-%*%?%[%]%(%)]", "%%%1");
				process_search(list, searchText, searchNameOnly);
				frame:SearchEditValid();
			end
		end
		function NS.process_update(frame)
			-- if frame.mute_update then
			-- 	return;
			-- end
			-- frame.mute_update = true;
			if frame.hooked_frame:IsShown() then
				local skillName, cur_rank, max_rank = frame.pinfo();
				local pid = NS.db_get_pid_by_pname(skillName);
				frame.flag = pid;
				if pid then
					local set = SET[pid];
					local var = VAR[pid];
					local update_var = var.update or frame.prev_pid ~= pid or var.cur_rank ~= cur_rank or frame.update;
					if not update_var then
						local t = GetTime();
						if t - frame.prev_var_update_time > MAXIMUM_VAR_UPDATE_PERIOD then
							frame.prev_var_update_time = t;
							update_var = true;
						end
					end
					var.update = update_var;	--	Redundancy for error
					local update_list = update_var or set.update;
					set.update = update_list;	--	Redundancy for error
					-- if frame.prev_pid ~= pid then
						if set.shown then
							frame:Show();
							frame.call:SetText(L["Close"]);
						else
							frame:Hide();
							frame.call:SetText(L["Open"]);
						end
					-- end
					if SET.show_call then
						frame.call:Show();
					end
					if frame:IsShown() then
						if update_list then
							local sids = var[1];
							local hash = var[2];
							if update_var then
								_log_("NS.process_update\124cff00ff00#1L1\124r");
								local num = frame.recipe_num();
								if num <= 0 then
									-- frame.mute_update = false;
									return;
								end
								var.cur_rank = cur_rank;
								for index = 1, #sids do
									func_sub_known_recipe(sids[index], PLAYER_GUID);
								end
								wipe(sids);
								wipe(hash);
								for index = 1, num do
									local sname, srank = frame.recipe_info(index);
									if sname and srank and srank ~= 'header' then
										local cid = frame.recipe_itemId(index);
										if cid then
											local sid = NS.db_get_sid_by_pid_sname_cid(pid, sname, cid);
											local info = NS.db_get_info_by_sid(sid);
											if info then
												if hash[sid] then
													_error_("NS.process_update#0E3", pid .. "#" .. cid .. "#" .. sname .. "#" .. sid);
												else
													tinsert(sids, sid);
													hash[sid] = index;
													func_add_known_recipe(sid, PLAYER_GUID);
												end
												if index == frame.get_select() then
													frame.selected_sid = sid;
												end
											else
												_error_("NS.process_update#0E2", pid .. "#" .. cid .. "#" .. sname);
											end
										else
											_error_("NS.process_update#0E1", pid .. "#" .. sname);
										end
									end
								end
								var.update = nil;
								frame.update = nil;
							else
								_log_("NS.process_update\124cff00ff00#1L2\124r");
							end
							if #sids > 0 then
								if frame.prev_pid ~= pid then
									if set.showProfit then
										frame.profitFrame:Show();
									else
										frame.profitFrame:Hide();
									end
									if set.showSet then
										-- frame.setFrame:Show();
										frame:ShowSetFrame(true);
									else
										-- frame.setFrame:Hide();
										frame:HideSetFrame();
									end
									frame.searchEditNameOnly:SetChecked(set.searchNameOnly);
								end
								frame.prev_pid = pid;
								frame.hash = hash;
								local list = frame.list;
								NS.db_get_ordered_list(pid, list, hash, set.phase, cur_rank, set.rankReversed, set.showKnown, set.showUnkown, set.showHighRank);
								if set.haveMaterials then
									for i = #list, 1, -1 do
										local sid = list[i];
										local index = hash[sid];
										if index == nil or select(3, frame.recipe_info(index)) <= 0 then
											tremove(list, i);
										end
									end
								end
								do
									local C_top = 1;
									for index = 1, #list do
										local sid = list[index];
										if FAV[sid] then
											tremove(list, index);
											tinsert(list, C_top, sid);
											C_top = C_top + 1;
										end
									end
								end
								local searchText = set.searchText;
								if searchText then
									safe_process_search(frame, SET.regular_exp, list, searchText, set.searchNameOnly);
								else
									frame:SearchEditValid();
								end
								frame.scroll:SetNumValue(#list);
								frame.scroll:Update();
								frame:RefreshSetFrame();
								frame:RefreshSearchEdit();
								NS.process_profit_update(frame);
								set.update = nil;
								_EventHandler:FireEvent("USER_EVENT_RECIPE_LIST_UPDATE");
							else
								var.update = true;
								-- frame.mute_update = false;
							end
						else
							_log_("NS.process_update\124cff00ff00#2L1\124r");
							if #var[1] > 0 then
								frame.scroll:Update();
								if frame.profitFrame:IsShown() then
									frame.profitScroll:Update();
								end
							end
						end
					else
						frame.prev_pid = pid;
						var.cur_rank = cur_rank;
						set.update = nil;
						var.update = nil;
						frame.update = nil;
						if update_list then
							local sids = var[1];
							local hash = var[2];
							if update_var then
								_log_("NS.process_update\124cff00ff00#1L1\124r");
								local num = frame.recipe_num();
								if num <= 0 then
									-- frame.mute_update = false;
									return;
								end
								var.cur_rank = cur_rank;
								for index = 1, num do
									local sname, srank = frame.recipe_info(index);
									if sname and srank and srank ~= 'header' then
										local cid = frame.recipe_itemId(index);
										if cid then
											local sid = NS.db_get_sid_by_pid_sname_cid(pid, sname, cid);
											local info = NS.db_get_info_by_sid(sid);
											if info then
												if hash[sid] == nil then
													tinsert(sids, sid);
													hash[sid] = index;
													func_add_known_recipe(sid, PLAYER_GUID);
												end
											else
												_error_("NS.process_update#0E2", pid .. "#" .. cid .. "#" .. sname);
											end
										else
											_error_("NS.process_update#0E1", pid .. "#" .. sname);
										end
									end
								end
								var.update = nil;
								frame.update = nil;
							end
						end
					end
					var.max_rank = max_rank;
					NS.cooldown_check(pid, var);
				else
					frame:Hide();
					frame.call:Hide();
				end
			end
			-- frame.mute_update = false;
		end
		function NS.process_profit_update_list(frame, list, only_cost)
			local sid_list = frame.list;
			wipe(list);
			if merc then
				local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
				if only_cost and frame.flag ~= 'explorer' then
					local var = rawget(VAR, pid);
					local cur_rank = var and var.cur_rank or 0;
					for index = 1, #sid_list do
						local sid = sid_list[index];
						local price_a_product, price_a_material, price_a_material_known, missing = NS.price_gen_info_by_sid(SET[pid].phase, sid, NS.db_get_num_made_by_sid(sid), nil);
						if price_a_material then
							tinsert(list, { sid, price_a_material, NS.db_get_difficulty_rank_by_sid(sid, cur_rank), });
						end
					end
					sort(list, function(v1, v2)
						if v1[3] < v2[3] then
							return true;
						elseif v1[3] == v2[3] then
							return v1[2] < v2[2];
						else
							return false;
						end
					end);
				else
					for index = 1, #sid_list do
						local sid = sid_list[index];
						local price_a_product, price_a_material, price_a_material_known, missing = NS.price_gen_info_by_sid(SET[pid].phase, sid, NS.db_get_num_made_by_sid(sid), nil);
						if price_a_product and price_a_material then
							if price_a_product > price_a_material then
								tinsert(list, { sid, price_a_product - price_a_material, });
							end
						end
					end
					sort(list, function(v1, v2) return v1[2] > v2[2]; end);
				end
			end
			return list;
		end
		function NS.process_profit_update(frame)
			local profitFrame = frame.profitFrame;
			if profitFrame:IsVisible() then
				_log_("NS.process_profit_update\124cff00ff00#1L1\124r");
				local list = profitFrame.list;
				local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
				if profitFrame.costOnly then
					local only_cost = SET[pid].costOnly;
					NS.process_profit_update_list(frame, list, only_cost);
					profitFrame.costOnly:SetChecked(only_cost);
				else
					NS.process_profit_update_list(frame, list);
				end
				profitFrame.scroll:SetNumValue(#list);
				profitFrame.scroll:Update();
			end
		end
		--
			local loc_to_lid = {
				["INVTYPE_AMMO"] = 0,	            --	Ammo
				["INVTYPE_HEAD"] = 1,	            --	Head
				["INVTYPE_NECK"] = 2,	            --	Neck
				["INVTYPE_SHOULDER"] = 3,	        --	Shoulder
				["INVTYPE_BODY"] = 4,	            --	Shirt
				["INVTYPE_CHEST"] = 5,	        --	Chest
				["INVTYPE_ROBE"] = 5,	            --	Chest
				["INVTYPE_WAIST"] = 6,	        --	Waist
				["INVTYPE_LEGS"] = 7,	            --	Legs
				["INVTYPE_FEET"] = 8,	            --	Feet
				["INVTYPE_WRIST"] = 9,	        --	Wrist
				["INVTYPE_HAND"] = 10,	        --	Hands
				["INVTYPE_FINGER"] = 11,	        --	Fingers
				["INVTYPE_TRINKET"] = 13,	        --	Trinkets
				["INVTYPE_CLOAK"] = 15,	        --	Cloaks
				["INVTYPE_WEAPON"] = 21,	        --	16  One-Hand
				["INVTYPE_SHIELD"] = 17,	        --	Shield
				["INVTYPE_2HWEAPON"] = 22,	    --	16  Two-Handed
				["INVTYPE_WEAPONMAINHAND"] = 16,	--	Main-Hand Weapon
				["INVTYPE_WEAPONOFFHAND"] = 17,	--	Off-Hand Weapon
				["INVTYPE_HOLDABLE"] = 17,	    --	Held In Off-Hand
				["INVTYPE_RANGED"] = 18,	        --	Bows
				["INVTYPE_THROWN"] = 18,	        --	Ranged
				["INVTYPE_RANGEDRIGHT"] = 18,	    --	Wands, Guns, and Crossbows
				["INVTYPE_RELIC"] = 18,	        --	Relics
				["INVTYPE_TABARD"] = 19,	        --	Tabard
				["INVTYPE_BAG"] = 20,	            --	Containers
				["INVTYPE_QUIVER"] = 20,	        --	Quivers
			};
			local no_one_learned_skill = {  };
			local filter_key = { "type", "subType", "eqLoc", };
			local filter_func = {
				type = NS.db_item_typeID,
				subType = NS.db_item_subTypeID,
				eqLoc = function(iid)
					local loc = NS.db_item_loc(iid);
					return loc and loc_to_lid[loc];
				end,
			};
		function NS.process_explorer_update_list(frame, stat, filter, searchText, searchNameOnly, list, check_hash, phase, rank, rankReversed, showKnown, showUnkown, showHighRank, donot_wipe_list)
			NS.db_get_ordered_list(filter.skill, list, check_hash, phase, rank, rankReversed, showKnown, showUnkown, showHighRank, donot_wipe_list);
			do
				local C_top = 1;
				for index = 1, #list do
					local sid = list[index];
					if FAV[sid] then
						tremove(list, index);
						tinsert(list, C_top, sid);
						C_top = C_top + 1;
					end
				end
			end
			for index = 1, #filter_key do
				local key = filter_key[index];
				local val = filter[key];
				local func = filter_func[key];
				if val and func then
					for index = #list, 1, -1 do
						local sid = list[index];
						local cid = NS.db_get_cid_by_sid(sid);
						if cid then
							if func(cid) ~= val then
								tremove(list, index);
							end
						else
							tremove(list, index);
						end
					end
				end
			end
			if searchText then
				safe_process_search(frame, SET.regular_exp, list, searchText, searchNameOnly)
			else
				frame:SearchEditValid();
			end
			do
				local skill_hash = stat.skill;
				local type_hash = stat.type;
				local subType_hash = stat.subType;
				local eqLoc_hash = stat.eqLoc;
				wipe(skill_hash);
				wipe(type_hash);
				wipe(subType_hash);
				wipe(eqLoc_hash);
				for index = 1, #list do
					local sid = list[index];
					local info = NS.db_get_info_by_sid(sid);
					if info then
						local pid = info[index_pid];
						skill_hash[pid] = explorer_hash[sid] or no_one_learned_skill;
						local cid = info[index_cid];
						if cid then
							local _type = NS.db_item_typeID(cid);
							local _subType = NS.db_item_subTypeID(cid);
							local _eqLoc = NS.db_item_loc(cid);
							local _eqLid = loc_to_lid[_eqLoc];
							type_hash[_type] = 1;
							subType_hash[_subType] = 1;
							if _eqLid then
								eqLoc_hash[_eqLid] = 1;
							end
						end
					end
				end
			end
			return stat;
		end
		function NS.process_explorer_update(frame, update_list)
			if frame:IsVisible() then
				local set = SET.explorer;
				local hash = frame.hash;
				local list = frame.list;
				if update_list then
					_log_("NS.process_explorer_update\124cff00ff00#1L1\124r");
					if set.showProfit then
						frame.profitFrame:Show();
					else
						frame.profitFrame:Hide();
					end
					if set.showSet then
						frame.setFrame:Show();
					else
						frame.setFrame:Hide();
					end
					frame.searchEditNameOnly:SetChecked(set.searchNameOnly);
					NS.process_explorer_update_list(frame, explorer_stat_list, set.filter, set.searchText, set.searchNameOnly,
												list, hash, set.phase, nil, set.rankReversed, set.showKnown, set.showUnkown, set.showHighRank);
					NS.process_profit_update(frame);
				else
					_log_("NS.process_explorer_update\124cff00ff00#1L2\124r");
				end
				frame.scroll:SetNumValue(#list);
				frame.scroll:Update();
				frame:RefreshSetFrame();
				frame:RefreshSearchEdit();
			end
		end
		--
		function NS.func_add_char(key, VAR, before_initialized)
			if key and VAR and AVAR[key] == nil then
				for index = #SET.char_list, 1, -1 do
					if SET.char_list[index] == key then
						tremove(SET.char_list, index);
					end
				end
				AVAR[key] = VAR;
				tinsert(SET.char_list, key);
				if not before_initialized then
					NS.ui_update_all();
				end
			end
		end
		function NS.func_del_char(index)
			local list = SET.char_list;
			if index and index <= #list then
				local key = list[index];
				if key ~= PLAYER_GUID then
					tremove(list, index);
					AVAR[key] = nil;
					NS.ui_update_all();
				end
			end
		end
		function NS.func_del_char_by_key(key)
			if key then
				local list = SET.char_list;
				for index = 1, #list do
					if list[index] == key then
						NS.func_del_char(index);
						break;
					end
				end
			end
		end
		function NS.enchant_link(sid)
			local name = GetSpellInfo(sid);
			if name then
				return "\124cffffffff\124Henchant:" .. sid .. "\124h[" .. name .. "]\124h\124r";
			else
				return nil;
			end
		end
		function NS.change_set_with_update(set, key, val)
			set[key] = val;
			set.update = true;
		end
		--
		local frames = {  };
		function NS.merc_AddFrame(frame)
			frames[frame] = true;
			if merc and merc.add_cache_callback then
				merc.add_cache_callback(function()
					frame.scroll:Update();
					NS.process_profit_update(frame);
					frame:updatePriceInfoInFrame();
				end);
			end
		end
		function NS.merc_RegAllFrames()
			for frame, _ in next, frames do
				NS.merc_AddFrame(frame);
			end
		end
	end

	local mouse_focus_sid = nil;
	local mouse_focus_phase = curPhase;
	do	--	hook ui
		--
			--	obj style
				function NS.ui_hide_permanently(obj)
					obj._SetAlpha = obj._SetAlpha or obj.SetAlpha;
					obj._EnableMouse = obj._EnableMouse or obj.EnableMouse;
					obj:_SetAlpha(0.0);
					obj:_EnableMouse(false);
				end
				function NS.ui_unhide_permanently(obj)
					obj._SetAlpha = obj._SetAlpha or obj.SetAlpha;
					obj._EnableMouse = obj._EnableMouse or obj.EnableMouse;
					obj:_SetAlpha(1.0);
					obj:_EnableMouse(true);
				end
				function NS.ui_ModernBackdrop(frame)
					frame:SetBackdrop(ui_style.modernFrameBackdrop);
					frame:SetBackdropColor(unpack(SET.bg_color));
				end
				function NS.ui_BlzBackdrop(frame)
					frame:SetBackdrop(ui_style.blzFrameBackdrop);
					frame:SetBackdropColor(1.0, 1.0, 1.0, 1.0);
					frame:SetBackdropBorderColor(1.0, 1.0, 1.0, 1.0);
				end
				function NS.ui_ModernButton(button, bak, texture)
					if button.Left then
						button.Left:SetAlpha(0.0);
					end
					if button.Middle then
						button.Middle:SetAlpha(0.0);
					end
					if button.Right then
						button.Right:SetAlpha(0.0);
					end
					local ntex = button:GetNormalTexture();
					local ptex = button:GetPushedTexture();
					local htex = button:GetHighlightTexture();
					local dtex = button:GetDisabledTexture();
					if bak and not bak._got then
						bak[1] = ntex and ntex:GetTexture() or nil;
						bak[2] = ptex and ptex:GetTexture() or nil;
						bak[3] = htex and htex:GetTexture() or nil;
						bak[4] = dtex and dtex:GetTexture() or nil;
						bak._got = true;
					end
					ntex = ntex or button:SetNormalTexture(ui_style.texture_unk) or button:GetNormalTexture();
					ptex = ptex or button:SetPushedTexture(ui_style.texture_unk) or button:GetPushedTexture();
					htex = htex or button:SetHighlightTexture(ui_style.texture_unk) or button:GetHighlightTexture();
					dtex = dtex or button:SetDisabledTexture(ui_style.texture_unk) or button:GetDisabledTexture();
					if texture then
						button:SetBackdrop(nil);
						button:SetNormalTexture(texture);
						button:SetPushedTexture(texture);
						button:SetHighlightTexture(texture);
						button:SetDisabledTexture(texture);
						ntex = ntex or button:GetNormalTexture();
						ptex = ptex or button:GetPushedTexture();
						htex = htex or button:GetHighlightTexture();
						dtex = dtex or button:GetDisabledTexture();
						ntex:SetVertexColor(unpack(ui_style.textureButtonColorNormal));
						ptex:SetVertexColor(unpack(ui_style.textureButtonColorPushed));
						htex:SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
						dtex:SetVertexColor(unpack(ui_style.textureButtonColorDisabled));
					else
						button:SetBackdrop(ui_style.modernButtonBackdrop);
						button:SetBackdropColor(unpack(ui_style.modernButtonBackdropColor));
						button:SetBackdropBorderColor(unpack(ui_style.modernButtonBackdropBorderColor));
						button:SetPushedTextOffset(0.0, 0.0);
						if ntex then ntex:SetColorTexture(unpack(ui_style.modernColorButtonColorNormal)); end
						if ptex then ptex:SetColorTexture(unpack(ui_style.modernColorButtonColorPushed)); end
						if htex then htex:SetColorTexture(unpack(ui_style.modernColorButtonColorHighlight)); end
						if dtex then dtex:SetColorTexture(unpack(ui_style.modernColorButtonColorDisabled)); end
					end
				end
				function NS.ui_BlzButton(button, bak)
					if button.Left then
						button.Left:SetAlpha(1.0);
					end
					if button.Middle then
						button.Middle:SetAlpha(1.0);
					end
					if button.Right then
						button.Right:SetAlpha(1.0);
					end
					if bak then
						button:SetNormalTexture(bak[1]);
						button:SetPushedTexture(bak[2]);
						button:SetHighlightTexture(bak[3]);
						button:SetDisabledTexture(bak[4]);
					end
					button:SetBackdrop(nil);
					button:SetPushedTextOffset(1.55, -1.55);
					local ntex = button:GetNormalTexture();
					local ptex = button:GetPushedTexture();
					local htex = button:GetHighlightTexture();
					local dtex = button:GetDisabledTexture();
					if ntex then ntex:SetVertexColor(1.0, 1.0, 1.0, 1.0); end
					if ptex then ptex:SetVertexColor(1.0, 1.0, 1.0, 1.0); end
					if htex then htex:SetVertexColor(1.0, 1.0, 1.0, 1.0); end
					if dtex then dtex:SetVertexColor(1.0, 1.0, 1.0, 1.0); end
				end
				function NS.ui_ModifyALAScrollFrame(scroll)
					local children = { scroll:GetChildren() };
					for index = 1, #children do
						local obj = children[index];
						if strupper(obj:GetObjectType()) == 'SLIDER' then
							scroll.ScrollBar = obj;
							local regions = { obj:GetRegions() };
							for index2 = 1, #regions do
								local obj2 = regions[index2];
								if strupper(obj2:GetObjectType()) == 'TEXTURE' then
									obj2:Hide();
								end
								obj:GetThumbTexture():Show();
							end
							obj:SetWidth(16);
							obj:ClearAllPoints();
							obj:SetPoint("TOPRIGHT", scroll, "TOPRIGHT", 0, -16);
							obj:SetPoint("BOTTOMRIGHT", scroll, "BOTTOMRIGHT", 0, 16);
							local up = CreateFrame("BUTTON", nil, obj);
							up:SetSize(18, 16);
							up:SetPoint("BOTTOM", obj, "TOP");
							up:SetScript("OnClick", function(self)
								obj:SetValue(obj:GetValue() - obj:GetValueStep());
							end);
							obj.ScrollUpButton = up;
							local down = CreateFrame("BUTTON", nil, obj);
							down:SetSize(18, 16);
							down:SetPoint("TOP", obj, "BOTTOM");
							down:SetScript("OnClick", function(self)
								obj:SetValue(obj:GetValue() + obj:GetValueStep());
							end);
							obj.ScrollDownButton = down;
							local function hook_OnValueChanged(self, val)
								val = val or self:GetValue();
								local minVal, maxVal = self:GetMinMaxValues();
								if minVal >= val then
									up:Disable();
								else
									up:Enable();
								end
								if maxVal <= val then
									down:Disable();
								else
									down:Enable();
								end
							end
							obj:HookScript("OnValueChanged", hook_OnValueChanged);
							hooksecurefunc(scroll, "SetNumValue", function(self)
								hook_OnValueChanged(obj);
							end);
							break;
						end
					end
				end
				function NS.ui_ModernScrollFrame(scroll)
					local regions = { scroll:GetRegions() };
					for index = 1, #regions do
						local obj = regions[index];
						if strupper(obj:GetObjectType()) == 'TEXTURE' then
							obj._Show = obj._Show or obj.Show;
							obj.Show = _noop_;
							obj:Hide();
						end
					end
					--
					local bar = scroll.ScrollBar;
					bar:SetBackdrop(ui_style.scrollBackdrop);
					bar:SetBackdropBorderColor(unpack(ui_style.modernScrollBackdropBorderColor));
					local thumb = bar:GetThumbTexture();
					if thumb == nil then
						bar:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob");
						thumb = bar:GetThumbTexture();
					end
					thumb:SetColorTexture(unpack(ui_style.modernScrollBackdropBorderColor));
					thumb:SetWidth(bar:GetWidth());
					local up = bar.ScrollUpButton;
					up:SetNormalTexture(ui_style.texture_modern_arrow_up);
					up:GetNormalTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					up:GetNormalTexture():SetVertexColor(unpack(ui_style.textureButtonColorNormal));
					up:SetPushedTexture(ui_style.texture_modern_arrow_up);
					up:GetPushedTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					up:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
					up:SetHighlightTexture(ui_style.texture_modern_arrow_up);
					up:GetHighlightTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					up:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
					up:SetDisabledTexture(ui_style.texture_modern_arrow_up);
					up:GetDisabledTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					up:GetDisabledTexture():SetVertexColor(unpack(ui_style.textureButtonColorDisabled));
					local down = bar.ScrollDownButton;
					down:SetNormalTexture(ui_style.texture_modern_arrow_down);
					down:GetNormalTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					down:GetNormalTexture():SetVertexColor(unpack(ui_style.textureButtonColorNormal));
					down:SetPushedTexture(ui_style.texture_modern_arrow_down);
					down:GetPushedTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					down:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
					down:SetHighlightTexture(ui_style.texture_modern_arrow_down);
					down:GetHighlightTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					down:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
					down:SetDisabledTexture(ui_style.texture_modern_arrow_down);
					down:GetDisabledTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					down:GetDisabledTexture():SetVertexColor(unpack(ui_style.textureButtonColorDisabled));
				end
				function NS.ui_BlzScrollFrame(scroll)
					local regions = { scroll:GetRegions() };
					for index = 1, #regions do
						local obj = regions[index];
						if strupper(obj:GetObjectType()) == 'TEXTURE' then
							obj._Show = obj._Show or obj.Show;
							obj.Show = _noop_;
							obj:Hide();
							-- if obj._Show then
							-- 	obj.Show = obj._Show;
							-- end
							-- obj:Show();
						end
					end
					--
					local bar = scroll.ScrollBar;
					bar:SetBackdrop(ui_style.scrollBackdrop);
					bar:SetBackdropBorderColor(unpack(ui_style.blzScrollBackdropBorderColor));
					bar:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob");
					bar:GetThumbTexture():SetWidth(bar:GetWidth());
					local up = bar.ScrollUpButton;
					up:SetNormalTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Up");
					up:GetNormalTexture():SetTexCoord(0.2, 0.8, 0.25, 0.75);
					up:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					up:SetPushedTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Down");
					up:GetPushedTexture():SetTexCoord(0.2, 0.8, 0.25, 0.75);
					up:GetPushedTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					up:SetHighlightTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Highlight");
					up:GetHighlightTexture():SetTexCoord(0.2, 0.8, 0.25, 0.75);
					up:GetHighlightTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					up:SetDisabledTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Disabled");
					up:GetDisabledTexture():SetTexCoord(0.2, 0.8, 0.25, 0.75);
					up:GetDisabledTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					local down = bar.ScrollDownButton;
					down:SetNormalTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Up");
					down:GetNormalTexture():SetTexCoord(0.2, 0.8, 0.25, 0.75);
					down:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					down:SetPushedTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Down");
					down:GetPushedTexture():SetTexCoord(0.2, 0.8, 0.25, 0.75);
					down:GetPushedTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					down:SetHighlightTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Highlight");
					down:GetHighlightTexture():SetTexCoord(0.2, 0.8, 0.25, 0.75);
					down:GetHighlightTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					down:SetDisabledTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Disabled");
					down:GetDisabledTexture():SetTexCoord(0.2, 0.8, 0.25, 0.75);
					down:GetDisabledTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
				end
				function NS.ui_Re_LayoutDropDownMenu(drop)
					drop.hooked = true;
					drop:SetWidth(135);
					drop.Left:ClearAllPoints();
					drop.Left:SetPoint("LEFT", -17, -1);
					local button = drop.Button;
					button:ClearAllPoints();
					button:SetPoint("CENTER", drop, "RIGHT", -12, 0);
					button:GetNormalTexture():SetAllPoints();
					button:GetPushedTexture():SetAllPoints();
					button:GetHighlightTexture():SetAllPoints();
					button:GetDisabledTexture():SetAllPoints();
					drop:SetScale(0.9);
					drop._SetHeight = drop.SetHeight;
					drop.SetHeight = _noop_;
					drop:_SetHeight(22);
				end
				function NS.ui_ModernDropDownMenu(drop)
					if not drop.hooked then
						NS.ui_Re_LayoutDropDownMenu(drop);
					end
					drop.Left:Hide();
					drop.Middle:Hide();
					drop.Right:Hide();
					drop:SetBackdrop(ui_style.modernButtonBackdrop);
					drop:SetBackdropColor(unpack(ui_style.modernButtonBackdropColor));
					drop:SetBackdropBorderColor(unpack(ui_style.modernButtonBackdropBorderColor));
					local button = drop.Button;
					button:SetSize(17, 16);
					button:SetNormalTexture(ui_style.texture_modern_arrow_down);
					button:SetPushedTexture(ui_style.texture_modern_arrow_down);
					button:SetHighlightTexture(ui_style.texture_modern_arrow_down);
					button:SetDisabledTexture(ui_style.texture_modern_arrow_down);
					button:GetNormalTexture():SetVertexColor(unpack(ui_style.textureButtonColorNormal));
					button:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
					button:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
					button:GetDisabledTexture():SetVertexColor(unpack(ui_style.textureButtonColorDisabled));
				end
				function NS.ui_BlzDropDownMenu(drop)
					drop.Left:Show();
					drop.Middle:Show();
					drop.Right:Show();
					drop:SetBackdrop(nil);
					local button = drop.Button;
					button:SetSize(24, 24);
					button:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up");
					button:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down");
					button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight");
					button:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled");
					button:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					button:GetPushedTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					button:GetHighlightTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					button:GetDisabledTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
				end
				function NS.ui_ModernEditBox(edit)
					local regions = { edit:GetRegions() };
					for index = 1, #regions do
						local obj = regions[index];
						if strupper(obj:GetObjectType()) == "TEXTURE" then
							obj:Hide();
						end
					end
					edit:SetBackdrop(ui_style.modernButtonBackdrop);
					edit:SetBackdropColor(unpack(ui_style.modernButtonBackdropColor));
					edit:SetBackdropBorderColor(unpack(ui_style.modernButtonBackdropBorderColor));
				end
				function NS.ui_BlzEditBox(edit)
					local regions = { edit:GetRegions() };
					for index = 1, #regions do
						regions[index]:Show();
					end
					edit:SetBackdrop(nil);
				end
				function NS.ui_ModernCheckButton(check)
					check:SetNormalTexture(ui_style.texture_modern_check_button_border);
					check:GetNormalTexture():SetVertexColor(unpack(ui_style.modernCheckButtonColorNormal));
					check:SetPushedTexture(ui_style.texture_modern_check_button_center);
					check:GetPushedTexture():SetVertexColor(unpack(ui_style.modernCheckButtonColorPushed));
					check:SetHighlightTexture(ui_style.texture_modern_check_button_border);
					check:GetHighlightTexture():SetVertexColor(unpack(ui_style.modernCheckButtonColorHighlight));
					check:SetCheckedTexture(ui_style.texture_modern_check_button_center);
					check:GetCheckedTexture():SetVertexColor(unpack(ui_style.modernCheckButtonColorChecked));
					check:SetDisabledTexture(ui_style.texture_modern_check_button_border);
					check:GetDisabledTexture():SetVertexColor(unpack(ui_style.modernCheckButtonColorDisabled));
					check:GetDisabledTexture():SetDesaturated(false);
					check:SetDisabledCheckedTexture(ui_style.texture_modern_check_button_border);
					check:GetDisabledCheckedTexture():SetVertexColor(unpack(ui_style.modernCheckButtonColorDisabledChecked));
				end
				function NS.ui_BlzCheckButton(check)
					check:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up");
					check:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					check:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down");
					check:GetPushedTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					check:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight");
					check:GetHighlightTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
					check:GetCheckedTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					check:SetDisabledTexture("Interface\\Buttons\\UI-CheckBox-Up");
					check:GetDisabledTexture():SetDesaturated(true);
					check:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled");
					check:GetDisabledCheckedTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
				end
				--
					local skillButton_TextureHash = {
						["Interface\\Buttons\\UI-MinusButton-Up"] = ui_style.texture_modern_button_minus,
						["Interface\\Buttons\\UI-PlusButton-Up"] = ui_style.texture_modern_button_plus,
						["Interface\\Buttons\\UI-PlusButton-Hilight"] = ui_style.texture_modern_button_plus,
					};
					local function _SetTexture(self, tex)
						self:_SetTexture(skillButton_TextureHash[tex] or tex);
					end
					local function _SetNormalTexture(self, tex)
						tex = skillButton_TextureHash[tex] or tex;
						self:_SetNormalTexture(tex);
						self:_SetHighlightTexture(tex);
					end
					local function _SetPushedTexture(self, tex)
						self:_SetPushedTexture(skillButton_TextureHash[tex] or tex);
					end
					local function _SetHighlightTexture(self, tex)
						-- self:_SetHighlightTexture(skillButton_TextureHash[tex] or tex);
					end
					local function _SetDisabledTexture(self, tex)
						self:_SetDisabledTexture(skillButton_TextureHash[tex] or tex);
					end
				function NS.ui_ModernSkillButton(button)
					button._SetNormalTexture = button._SetNormalTexture or button.SetNormalTexture;
					button.SetNormalTexture = _SetNormalTexture;
					local NormalTexture = button:GetNormalTexture();
					if NormalTexture then
						NormalTexture._SetTexture = NormalTexture._SetTexture or NormalTexture.SetTexture;
						NormalTexture.SetTexture = _SetTexture;
					end
					--
					button._SetPushedTexture = button._SetPushedTexture or button.SetPushedTexture;
					button.SetPushedTexture = _SetPushedTexture;
					local PushedTexture = button:GetPushedTexture();
					if PushedTexture then
						PushedTexture._SetTexture = PushedTexture._SetTexture or PushedTexture.SetTexture;
						PushedTexture.SetTexture = _SetTexture;
					end
					--
					button._SetHighlightTexture = button._SetHighlightTexture or button.SetHighlightTexture;
					button.SetHighlightTexture = _SetHighlightTexture;
					local HighlightTexture = button:GetHighlightTexture();
					if HighlightTexture then
						HighlightTexture._SetTexture = HighlightTexture._SetTexture or HighlightTexture.SetTexture;
						HighlightTexture.SetTexture = _noop_;
					end
					--
					button._SetDisabledTexture = button._SetDisabledTexture or button.SetDisabledTexture;
					button.SetDisabledTexture = _SetDisabledTexture;
					local DisabledTexture = button:GetDisabledTexture();
					if DisabledTexture then
						DisabledTexture._SetTexture = DisabledTexture._SetTexture or DisabledTexture.SetTexture;
						DisabledTexture.SetTexture = _SetTexture;
					end
					button:SetPushedTextOffset(0.0, 0.0);
				end
				function NS.ui_BlzSkillButton(button)
					if button._SetNormalTexture then
						button.SetNormalTexture = button._SetNormalTexture;
					end
					local NormalTexture = button:GetNormalTexture();
					if NormalTexture and NormalTexture._SetTexture then
						NormalTexture.SetTexture = NormalTexture._SetTexture;
					end
					if button._SetPushedTexture then
						button.SetPushedTexture = button._SetPushedTexture;
					end
					local PushedTexture = button:GetPushedTexture();
					if PushedTexture and PushedTexture._SetTexture then
						PushedTexture.SetTexture = PushedTexture._SetTexture;
					end
					if button._SetHighlightTexture then
						button.SetHighlightTexture = button._SetHighlightTexture;
					end
					local HighlightTexture = button:GetHighlightTexture();
					if HighlightTexture and HighlightTexture._SetTexture then
						HighlightTexture.SetTexture = HighlightTexture._SetTexture;
					end
					if button._SetDisabledTexture then
						button.SetDisabledTexture = button._SetDisabledTexture;
					end
					local DisabledTexture = button:GetDisabledTexture();
					if DisabledTexture and DisabledTexture._SetTexture then
						DisabledTexture.SetTexture = DisabledTexture._SetTexture;
					end
					button:SetPushedTextOffset(1.55, -1.55);
				end
				--
				function NS.ui_ModernALADropButton(drop)
					drop:SetNormalTexture(ui_style.texture_modern_arrow_down);
					drop:GetNormalTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					drop:GetNormalTexture():SetVertexColor(unpack(ui_style.textureButtonColorNormal));
					drop:SetPushedTexture(ui_style.texture_modern_arrow_down);
					drop:GetPushedTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					drop:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
					drop:SetHighlightTexture(ui_style.texture_modern_arrow_down);
					drop:GetHighlightTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					drop:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
					drop:SetDisabledTexture(ui_style.texture_modern_arrow_down);
					drop:GetDisabledTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					drop:GetDisabledTexture():SetVertexColor(unpack(ui_style.textureButtonColorDisabled));
				end
				function NS.ui_BlzALADropButton(drop)
					drop:SetNormalTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
					drop:GetNormalTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
					drop:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					drop:SetPushedTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
					drop:GetPushedTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
					drop:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
					drop:SetHighlightTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
					drop:GetHighlightTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
					drop:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
					drop:SetDisabledTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
					drop:GetDisabledTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
					drop:GetDisabledTexture():SetVertexColor(unpack(ui_style.textureButtonColorDisabled));
				end
			--	list button handler
				local function query_who_can_craft_it(_, frame, pid, sid)
					NS.cmm_Query_sid(sid);
				end
				local function add_to_fav(_, frame, pid, sid)
					SET[pid].update = true;
					FAV[sid] = 1;
					frame.update_func();
				end
				local function sub_to_fav(_, frame, pid, sid)
					SET[pid].update = true;
					FAV[sid] = nil;
					frame.update_func();
				end
				local list_drop_add_fav = {
					handler = add_to_fav,
					text = L["add_fav"],
					para = {  },
				};
				local list_drop_sub_fav = {
					handler = sub_to_fav,
					text = L["sub_fav"],
					para = {  },
				};
				local list_drop_query_who_can_craft_it = {
					handler = query_who_can_craft_it,
					text = L["query_who_can_craft_it"],
					para = {  },
				};
				local list_drop_meta = {
					handler = _noop_,
					elements = {
						-- [2] =list_drop_query_who_can_craft_it,
					},
				};
				if select(2, BNGetInfo()) == 'alex#516722' or select(2, BNGetInfo()) == '单酒窝#51637' then
					list_drop_meta.elements[2] =list_drop_query_who_can_craft_it;
				end
			--
			function NS.ui_skillListButton_OnEnter(self)
				local frame = self.frame;
				local sid = self.list[self:GetDataIndex()];
				if type(sid) == 'table' then
					sid = sid[1];
				end
				local pid = self.flag or NS.db_get_pid_by_sid(sid);
				if pid then
					local set = SET[pid];
					mouse_focus_sid = sid;
					mouse_focus_phase = set.phase;
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
					local info = NS.db_get_info_by_sid(sid);
					if info then
						if set.showItemInsteadOfSpell and info[index_cid] then
							GameTooltip:SetItemByID(info[index_cid]);
						else
							GameTooltip:SetSpellByID(sid);
						end
						local phase = info[index_phase];
						if phase > curPhase then
							GameTooltip:AddLine("\124cffff0000" .. L["available_in_phase_"] .. phase .. "\124r");
						end
						GameTooltip:Show();
					else
						GameTooltip:SetSpellByID(sid);
					end
					local text = NS.db_get_difficulty_rank_list_text_by_sid(sid);
					if text then
						GameTooltip:AddDoubleLine(L["LABEL_RANK_LEVEL"], text);
						GameTooltip:Show();
					end
					local data = frame.hash[sid];
					if pid == 'explorer' then
						local hash = explorer_hash[sid];
						if hash then
							local str = L["RECIPE_LEARNED"] .. ": ";
							local index = 0;
							for GUID, _ in next, hash do
								if index ~= 0 and index % 3 == 0 then
									str = str .. "\n        ";
								end
								local lClass, class, lRace, race, sex, name = GetPlayerInfoByGUID(GUID);
								if name and class then
									local classColorTable = RAID_CLASS_COLORS[strupper(class)];
									name = format("\124cff%.2x%.2x%.2x", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. name .. "\124r";
									str = str .. " " .. name;
								else
									str = str .. " " .. GUID;
								end
								index = index + 1;
							end
							GameTooltip:AddLine(str);
							GameTooltip:Show();
						else
						end
						data = data and data[PLAYER_GUID];
					end
					if not data then
						NS.ui_set_tooltip_mtsl(sid);
					end
				end
			end
			function NS.ui_skillListButton_OnLeave(self)
				mouse_focus_sid = nil;
				button_info_OnLeave(self);
			end
			function NS.ui_listButton_OnClick(self, button)
				local frame = self.frame;
				local sid = self.list[self:GetDataIndex()];
				if type(sid) == 'table' then
					sid = sid[1];
				end
				local data = frame.hash[sid];
				if button == "LeftButton" then
					if IsShiftKeyDown() then
						local cid = NS.db_get_cid_by_sid(sid);
						if cid then
							ChatEdit_InsertLink(NS.db_item_link(cid), ADDON);
						else
							ChatEdit_InsertLink(NS.enchant_link(sid), ADDON);
						end
					elseif IsAltKeyDown() then
						local text1 = nil;
						local text2 = nil;
						if data then
							local n = frame.reagent_num(data);
							if n and n > 0 then
								local m1, m2 = frame.recipe_num_made(data);
								if m1 == m2 then
									text1 = frame.recipe_link(data) .. "x" .. m1 .. L["PRINT_MATERIALS: "];
								else
									text1 = frame.recipe_link(data) .. "x" .. m1 .. "-" .. m2 .. L["PRINT_MATERIALS: "];
								end
								text2 = "";
								if n > 4 then
									for i = 1, n do
										text2 = text2 .. frame.reagent_info(data, i) .. "x" .. select(3, frame.reagent_info(data, i));
									end
								else
									for i = 1, n do
										text2 = text2 .. frame.reagent_link(data, i) .. "x" .. select(3, frame.reagent_info(data, i));
									end
								end
							end
						else
							local info = NS.db_get_info_by_sid(sid);
							local cid = info[index_cid];
							if info then
								if cid then
									text1 = NS.db_item_link_s(cid) .. "x" .. (info[index_num_made_min] == info[index_num_made_max] and info[index_num_made_min] or (info[index_num_made_min] .. "-" .. info[index_num_made_max])) .. L["PRINT_MATERIALS: "];
								else
									text1 = NS.db_spell_name_s(sid) .. L["PRINT_MATERIALS: "];
								end
								text2 = "";
								local rinfo = info[index_reagents_id];
								if #rinfo > 4 then
									for i = 1, #rinfo do
										text2 = text2 .. NS.db_item_name_s(rinfo[i]) .. "x" .. info[index_reagents_count][i];
									end
								else
									for i = 1, #rinfo do
										text2 = text2 .. NS.db_item_link_s(rinfo[i]) .. "x" .. info[index_reagents_count][i];
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
						local cid = NS.db_get_cid_by_sid(sid);
						if cid then
							local link = NS.db_item_link(cid);
							if link then
								DressUpItemLink(link);
							end
						end
					else
						if data and type(data) == 'number' then
							frame.select_func(data);
							frame.hooked_frame.numAvailable = select(3, frame.recipe_info(data));
							frame.selected_sid = sid;
							frame.update_func();
							frame.searchEdit:ClearFocus();
							local scroll = frame.hooked_scrollBar;
							local num = frame.recipe_num();
							local minVal, maxVal = scroll:GetMinMaxValues();
							local step = scroll:GetValueStep();
							local cur = scroll:GetValue() + step;
							local value = step * (data - 1);
							if value < cur or value > (cur + num * step - maxVal) then
								scroll:SetValue(min(maxVal, value));
							end
							frame.scroll:Update();
							if frame.profitFrame:IsShown() then
								frame.profitScroll:Update();
							end
						end
					end
				elseif button == "RightButton" then
					frame.searchEdit:ClearFocus();
					local pid = NS.db_get_pid_by_sid(sid);
					if FAV[sid] then
						list_drop_sub_fav.para[1] = frame;
						list_drop_sub_fav.para[2] = pid;
						list_drop_sub_fav.para[3] = sid;
						list_drop_meta.elements[1] = list_drop_sub_fav;
					else
						list_drop_add_fav.para[1] = frame;
						list_drop_add_fav.para[2] = pid;
						list_drop_add_fav.para[3] = sid;
						list_drop_meta.elements[1] = list_drop_add_fav;
					end
					list_drop_query_who_can_craft_it.para[1] = frame;
					list_drop_query_who_can_craft_it.para[2] = pid;
					list_drop_query_who_can_craft_it.para[3] = sid;
					ALADROP(self, "BOTTOMLEFT", list_drop_meta);
				end
			end
			function NS.ui_CreateProfitSkillListButton(parent, index, buttonHeight)
				local button = CreateFrame("BUTTON", nil, parent);
				button:SetHeight(buttonHeight);
				button:SetBackdrop(ui_style.listButtonBackdrop);
				button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
				button:SetBackdropBorderColor(unpack(ui_style.listButtonBackdropBorderColor));
				button:SetHighlightTexture(ui_style.texture_white);
				button:GetHighlightTexture():SetVertexColor(unpack(ui_style.listButtonHighlightColor));
				button:EnableMouse(true);
				button:Show();

				local icon = button:CreateTexture(nil, "BORDER");
				icon:SetTexture(ui_style.texture_unk);
				icon:SetSize(buttonHeight - 4, buttonHeight - 4);
				icon:SetPoint("LEFT", 8, 0);
				button.icon = icon;

				local title = button:CreateFontString(nil, "OVERLAY");
				title:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				title:SetPoint("LEFT", icon, "RIGHT", 4, 0);
				-- title:SetWidth(160);
				title:SetMaxLines(1);
				title:SetJustifyH("LEFT");
				button.title = title;

				local note = button:CreateFontString(nil, "ARTWORK");
				note:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				note:SetPoint("RIGHT", -4, 0);
				button.note = note;

				title:SetPoint("RIGHT", note, "LEFT", - 4, 0);

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
				glow:SetTexture(ui_style.texture_white);
				-- glow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
				glow:SetVertexColor(unpack(ui_style.listButtonSelectedColor));
				glow:SetAllPoints();
				glow:SetBlendMode("ADD");
				glow:Hide();
				button.glow = glow;

				button:SetScript("OnEnter", NS.ui_skillListButton_OnEnter);
				button:SetScript("OnLeave", NS.ui_skillListButton_OnLeave);
				button:RegisterForClicks("AnyUp");
				button:SetScript("OnClick", NS.ui_listButton_OnClick);
				button:RegisterForDrag("LeftButton");
				button:SetScript("OnHide", ALADROP);

				function button:Select()
					glow:Show();
				end
				function button:Deselect()
					glow:Hide();
				end

				local frame = parent:GetParent():GetParent();
				button.frame = frame:GetParent();
				button.list = frame.list;
				button.flag = frame.flag;

				return button;
			end
			function NS.ui_SetProfitSkillListButton(button, data_index)
				local frame = button.frame;
				local list = button.list;
				local hash = frame.hash;
				if data_index <= #list then
					local sid = list[data_index][1];
					local cid = NS.db_get_cid_by_sid(sid);
					local data = hash[sid];
					if data then
						if frame.flag == 'explorer' then
							button:Show();
							local _, quality, icon;
							if cid then
								_, _, quality, _, icon = NS.db_item_info(cid);
							else
								quality = nil;
								icon = ICON_FOR_NO_CID;
							end
							button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
							button.icon:SetTexture(icon);
							button.icon:SetVertexColor(1.0, 1.0, 1.0, 1.0);
							button.title:SetText(NS.db_spell_name_s(sid));
							button.title:SetTextColor(0.0, 1.0, 0.0, 1.0);
							button.note:SetText(merc.MoneyString(list[data_index][2]));
							if quality then
								local r, g, b, code = GetItemQualityColor(quality);
								button.quality_glow:SetVertexColor(r, g, b);
								button.quality_glow:Show();
							else
								button.quality_glow:Hide();
							end
							if FAV[sid] then
								button.star:Show();
							else
								button.star:Hide();
							end
							button:Deselect();
						else
							local name, rank, num = frame.recipe_info(data);
							if name and rank ~= 'header' then
								button:Show();
								button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
								local _, quality, icon;
								if cid then
									_, _, quality, _, icon = NS.db_item_info(cid);
								else
									quality = nil;
									icon = ICON_FOR_NO_CID;
								end
								button.icon:SetTexture(frame.recipe_icon(data));
								button.icon:SetVertexColor(1.0, 1.0, 1.0, 1.0);
								if num > 0 then
									button.title:SetText(name .. " [" .. num .. "]");
								else
									button.title:SetText(name);
								end
								button.title:SetTextColor(unpack(rank_color[rank_index[rank]] or ui_style.color_white));
								button.note:SetText(merc.MoneyString(list[data_index][2]));
								if quality then
									local r, g, b, code = GetItemQualityColor(quality);
									button.quality_glow:SetVertexColor(r, g, b);
									button.quality_glow:Show();
								else
									button.quality_glow:Hide();
								end
								if FAV[sid] then
									button.star:Show();
								else
									button.star:Hide();
								end
								if GetMouseFocus() == button then
									NS.ui_skillListButton_OnEnter(button);
								end
								if sid == frame.selected_sid then
									button:Select();
								else
									button:Deselect();
								end
							else
								button:Hide();
							end
						end
					else
						button:Show();
						if SET.colored_rank_for_unknown and frame.flag ~= 'explorer' then
							button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Disabled));
						else
							button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
						end
						local _, quality, icon;
						if cid then
							_, _, quality, _, icon = NS.db_item_info(cid);
						else
							quality = nil;
							icon = ICON_FOR_NO_CID;
						end
						button.icon:SetTexture(icon);
						button.icon:SetVertexColor(1.0, 0.0, 0.0, 1.0);
						button.title:SetText(NS.db_spell_name_s(sid));
						if SET.colored_rank_for_unknown and frame.flag ~= 'explorer' then
							local pid = NS.db_get_pid_by_sid(sid);
							local var = rawget(VAR, pid);
							local cur_rank = var and var.cur_rank or 0;
							button.title:SetTextColor(unpack(rank_color[NS.db_get_difficulty_rank_by_sid(sid, cur_rank)] or ui_style.color_white));
						else
							button.title:SetTextColor(1.0, 0.0, 0.0, 1.0);
						end
						button.note:SetText(merc.MoneyString(list[data_index][2]));
						if quality then
							local r, g, b, code = GetItemQualityColor(quality);
							button.quality_glow:SetVertexColor(r, g, b);
							button.quality_glow:Show();
						else
							button.quality_glow:Hide();
						end
						if FAV[sid] then
							button.star:Show();
						else
							button.star:Hide();
						end
						button:Deselect();
					end
					if GetMouseFocus() == button then
						NS.ui_skillListButton_OnEnter(button);
					end
					if button.prev_sid ~= sid then
						ALADROP(button);
						button.prev_sid = sid;
					end
				else
					ALADROP(button);
					button:Hide();
				end
			end
			function NS.ui_CreateSkillListButton(parent, index, buttonHeight)
				local button = CreateFrame("BUTTON", nil, parent);
				button:SetHeight(buttonHeight);
				button:SetBackdrop(ui_style.listButtonBackdrop);
				button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
				button:SetBackdropBorderColor(unpack(ui_style.listButtonBackdropBorderColor));
				button:SetHighlightTexture(ui_style.texture_white);
				button:GetHighlightTexture():SetVertexColor(unpack(ui_style.listButtonHighlightColor));
				button:EnableMouse(true);
				button:Show();

				local icon = button:CreateTexture(nil, "BORDER");
				icon:SetTexture(ui_style.texture_unk);
				icon:SetSize(buttonHeight - 4, buttonHeight - 4);
				icon:SetPoint("LEFT", 8, 0);
				button.icon = icon;

				local title = button:CreateFontString(nil, "OVERLAY");
				title:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				title:SetPoint("LEFT", icon, "RIGHT", 4, 0);
				-- title:SetWidth(160);
				title:SetMaxLines(1);
				title:SetJustifyH("LEFT");
				button.title = title;

				local note = button:CreateFontString(nil, "ARTWORK");
				note:SetFont(ui_style.frameFont, ui_style.frameFontSize - 1, ui_style.frameFontOutline);
				note:SetPoint("RIGHT", -4, 0);
				button.note = note;

				title:SetPoint("RIGHT", note, "LEFT", - 4, 0);

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
				glow:SetTexture(ui_style.texture_white);
				-- glow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
				glow:SetVertexColor(unpack(ui_style.listButtonSelectedColor));
				glow:SetAllPoints();
				glow:SetBlendMode("ADD");
				glow:Hide();
				button.glow = glow;

				button:SetScript("OnEnter", NS.ui_skillListButton_OnEnter);
				button:SetScript("OnLeave", NS.ui_skillListButton_OnLeave);
				button:RegisterForClicks("AnyUp");
				button:SetScript("OnClick", NS.ui_listButton_OnClick);
				button:RegisterForDrag("LeftButton");
				button:SetScript("OnHide", ALADROP);

				function button:Select()
					glow:Show();
				end
				function button:Deselect()
					glow:Hide();
				end

				local frame = parent:GetParent():GetParent();
				button.frame = frame;
				button.list = frame.list;
				button.flag = frame.flag;

				return button;
			end
			function NS.ui_SetSkillListButton(button, data_index)
				local frame = button.frame;
				local list = button.list;
				local hash = frame.hash;
				if data_index <= #list then
					local sid = list[data_index];
					local pid = frame.flag or NS.db_get_pid_by_sid(sid);
					local set = SET[pid];
					local cid = NS.db_get_cid_by_sid(sid);
					local data = hash[sid];
					if data then
						local name, rank, num = frame.recipe_info(data);
						if name and rank ~= 'header' then
							button:Show();
							button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
							local quality = cid and NS.db_item_rarity(cid);
							button.icon:SetTexture(frame.recipe_icon(data));
							button.icon:SetVertexColor(1.0, 1.0, 1.0, 1.0);
							if num > 0 then
								button.title:SetText(name .. " [" .. num .. "]");
							else
								button.title:SetText(name);
							end
							button.title:SetTextColor(unpack(rank_color[rank_index[rank]] or ui_style.color_white));
							if set.showRank then
								button.note:SetText(NS.db_get_difficulty_rank_list_text_by_sid(sid));
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
							if FAV[sid] then
								button.star:Show();
							else
								button.star:Hide();
							end
							if sid == frame.selected_sid then
								button:Select();
							else
								button:Deselect();
							end
						else
							button:Hide();
						end
					else
						button:Show();
						if SET.colored_rank_for_unknown then
							button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Disabled));
						else
							button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
						end
						local _, quality, icon;
						if cid then
							_, _, quality, _, icon = NS.db_item_info(cid);
						else
							quality = nil;
							icon = ICON_FOR_NO_CID;
						end
						button.icon:SetTexture(icon);
						button.icon:SetVertexColor(1.0, 0.0, 0.0, 1.0);
						button.title:SetText(NS.db_spell_name_s(sid));
						if SET.colored_rank_for_unknown then
							local var = rawget(VAR, pid);
							button.title:SetTextColor(unpack(rank_color[NS.db_get_difficulty_rank_by_sid(sid, var and var.cur_rank or 0)] or ui_style.color_white));
						else
							button.title:SetTextColor(1.0, 0.0, 0.0, 1.0);
						end
						if set.showRank then
							button.note:SetText(NS.db_get_difficulty_rank_list_text_by_sid(sid));
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
						if FAV[sid] then
							button.star:Show();
						else
							button.star:Hide();
						end
						button:Deselect();
					end
					if GetMouseFocus() == button then
						NS.ui_skillListButton_OnEnter(button);
					end
					if button.prev_sid ~= sid then
						ALADROP(button);
						button.prev_sid = sid;
					end
				else
					ALADROP(button);
					button:Hide();
				end
			end
			function NS.ui_defaultSkillListButton_OnEnter(self)
				if SET.default_skill_button_tip then
					local frame = self.frame;
					local index = self:GetID();
					local link = frame.recipe_link(index);
					if link then
						GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
						GameTooltip:SetHyperlink(link);
						GameTooltip:Show();
					else
						GameTooltip:Hide();
					end
				end
			end
			function NS.ui_updatePriceInfoInFrame(frame)
				local price_info_in_frame = frame.price_info_in_frame;
				if merc and SET.show_tradeskill_frame_price_info then
					local sid = frame.selected_sid;
					if sid == nil or sid <= 0 then
						price_info_in_frame[1]:SetText(nil);
						price_info_in_frame[2]:SetText(nil);
						price_info_in_frame[3]:SetText(nil);
						return;
					end
					local info = NS.db_get_info_by_sid(sid);
					if info then
						local pid = info[index_pid];
						local nMade = (info[index_num_made_min] + info[index_num_made_max]) / 2;
						local price_a_product, _, price_a_material, unk_in, cid = NS.price_gen_info_by_sid(SET[pid].phase, sid, nMade);
						if price_a_material > 0 then
							price_info_in_frame[2]:SetText(
								L["COST_PRICE"] .. ": " ..
								(unk_in > 0 and (merc.MoneyString(price_a_material) .. " (\124cffff0000" .. unk_in .. L["ITEMS_UNK"] .. "\124r)") or merc.MoneyString(price_a_material))
							);
						else
							price_info_in_frame[2]:SetText(
								L["COST_PRICE"] .. ": " ..
								"\124cffff0000" .. L["PRICE_UNK"] .. "\124r"
							);
						end

						if cid then
							-- local price_a_product = merc.query_ah_price_by_id(cid);
							local price_v_product = NS.db_item_sellPrice(info[index_cid]);
							-- local minMade, maxMade = frame.num_made(index);
							-- local nMade = (minMade + maxMade) / 2;
							-- price_a_product = price_a_product and price_a_product * nMade;
							price_v_product = price_v_product and price_v_product * nMade;
							if price_a_product and price_a_product > 0 then
								price_info_in_frame[1]:SetText(
									L["AH_PRICE"] .. ": " ..
									merc.MoneyString(price_a_product) .. " (" .. L["VENDOR_RPICE"] .. (price_v_product and merc.MoneyString(price_v_product) or L["NEED_UPDATE"]) .. ")"
								);
								if price_a_material > 0 then
									local diff = price_a_product - price_a_material;
									if diff > 0 then
										price_info_in_frame[3]:SetText(L["PRICE_DIFF+"] .. ": " .. merc.MoneyString(diff));
									elseif diff < 0 then
										price_info_in_frame[3]:SetText(L["PRICE_DIFF-"] .. ": " .. merc.MoneyString(-diff));
									else
										price_info_in_frame[3]:SetText(L["PRICE_DIFF0"]);
									end
								else
									price_info_in_frame[3]:SetText(nil);
								end
							else
								local bindType = NS.db_item_bindType(cid);
								if bindType == 1 or bindType == 4 then
									price_info_in_frame[1]:SetText(
										L["AH_PRICE"] .. ": " ..
										L["BOP"] .. " (" .. L["VENDOR_RPICE"] .. (price_v_product and merc.MoneyString(price_v_product) or L["NEED_UPDATE"]) .. ")"
									);
								else
									price_info_in_frame[1]:SetText(
										L["AH_PRICE"] .. ": " ..
										"\124cffff0000" .. L["PRICE_UNK"] .. "\124r (" .. L["VENDOR_RPICE"] .. (price_v_product and merc.MoneyString(price_v_product) or L["NEED_UPDATE"]) .. ")"
									);
								end
								price_info_in_frame[3]:SetText(nil);
							end
						end
					else
						price_info_in_frame[1]:SetText(nil);
						price_info_in_frame[2]:SetText(nil);
						price_info_in_frame[3]:SetText(nil);
					end
				else
					price_info_in_frame[1]:SetText(nil);
					price_info_in_frame[2]:SetText(nil);
					price_info_in_frame[3]:SetText(nil);
				end
			end
			function NS.ui_updateRankInfoInFrame(frame)
				if SET.show_tradeskill_frame_rank_info then
					frame.rank_info_in_frame:SetText(NS.db_get_difficulty_rank_list_text_by_sid(frame.selected_sid));
				else
					frame.rank_info_in_frame:SetText(nil);
				end
			end
			--
			function NS.ui_CreateSearchBox(frame)
				local searchEdit = CreateFrame("EDITBOX", nil, frame);
				searchEdit:SetHeight(16);
				searchEdit:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				searchEdit:SetAutoFocus(false);
				searchEdit:SetJustifyH("LEFT");
				searchEdit:Show();
				searchEdit:EnableMouse(true);
				searchEdit:ClearFocus();
				searchEdit:SetScript("OnEnterPressed", function(self) self:ClearFocus(); end);
				searchEdit:SetScript("OnEscapePressed", function(self) self:ClearFocus(); end);
				frame.searchEdit = searchEdit;
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
				local searchCancel = CreateFrame("BUTTON", nil, searchEdit);
				searchCancel:SetSize(16, 16);
				searchCancel:SetPoint("RIGHT", searchEdit);
				searchCancel:Hide();
				searchCancel:SetNormalTexture("interface\\petbattles\\deadpeticon")
				searchCancel:SetScript("OnClick", function(self) searchEdit:SetText(""); frame:Search(""); searchEdit:ClearFocus(); end);

				local searchEditOK = CreateFrame("BUTTON", nil, frame);
				searchEditOK:SetSize(32, 16);
				searchEditOK:Disable();
				searchEditOK:SetNormalTexture(ui_style.texture_unk);
				searchEditOK:GetNormalTexture():SetColorTexture(0.25, 0.25, 0.25, 0.5);
				searchEditOK:Disable();
				local searchEditOKText = searchEditOK:CreateFontString(nil, "OVERLAY");
				searchEditOKText:SetFont(ui_style.frameFont, ui_style.frameFontSize);
				searchEditOKText:SetTextColor(1.0, 1.0, 1.0, 0.5);
				searchEditOKText:SetPoint("CENTER");
				searchEditOKText:SetText(L["OK"]);
				searchEditOK:SetFontString(searchEditOKText);
				searchEditOK:SetPushedTextOffset(0, - 1);
				searchEditOK:SetScript("OnClick", function(self) searchEdit:ClearFocus(); end);
				searchEditOK:SetScript("OnEnable", function(self) searchEditOKText:SetTextColor(1.0, 1.0, 1.0, 1.0); end);
				searchEditOK:SetScript("OnDisable", function(self) searchEditOKText:SetTextColor(1.0, 1.0, 1.0, 0.5); end);

				local searchEditNameOnly = CreateFrame("CHECKBUTTON", nil, frame, "OptionsBaseCheckButtonTemplate");
				searchEditNameOnly:SetSize(24, 24);
				searchEditNameOnly:SetHitRectInsets(0, 0, 0, 0);
				searchEditNameOnly:Show();
				searchEditNameOnly:SetChecked(false);
				searchEditNameOnly.info_lines = { L["TIP_SEARCH_NAME_ONLY_INFO"], };
				searchEditNameOnly:SetScript("OnEnter", button_info_OnEnter);
				searchEditNameOnly:SetScript("OnLeave", button_info_OnLeave);
				searchEditNameOnly:SetScript("OnClick", function(self)
					local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
					if pid then
						NS.change_set_with_update(SET[pid], "searchNameOnly", self:GetChecked());
					end
					frame.update_func();
				end);
				frame.searchEditNameOnly = searchEditNameOnly;

				function frame:Search(text)
					local pid = self.flag or NS.db_get_pid_by_pname(self.pname());
					if pid then
						if text == "" then
							NS.change_set_with_update(SET[pid], "searchText", nil);
							if not searchEdit:HasFocus() then
								searchEditNote:Show();
							end
							searchCancel:Hide();
						else
							NS.change_set_with_update(SET[pid], "searchText", text);
							searchCancel:Show();
							searchEditNote:Hide();
						end
					end
					frame.update_func();
				end
				function frame:RefreshSearchEdit()
					local pid = self.flag or NS.db_get_pid_by_pname(self.pname());
					if pid then
						local searchText = SET[pid].searchText or "";
						if searchEdit:GetText() ~= searchText then
							searchEdit:SetText(searchText);
						end
						if searchText == "" then
							if not searchEdit:HasFocus() then
								searchEditNote:Show();
							end
							searchCancel:Hide();
						else
							searchCancel:Show();
							searchEditNote:Hide();
						end
					end
				end
				function frame:SearchEditValid()
					searchEditTexture:SetVertexColor(0.25, 0.25, 0.25);
				end
				function frame:SearchEditInvalid()
					searchEditTexture:SetVertexColor(0.25, 0.0, 0.0);
				end
				searchEdit:SetScript("OnTextChanged", function(self, isUserInput)
					if isUserInput then
						frame:Search(self:GetText());
					end
				end);
				searchEdit:SetScript("OnEditFocusGained", function(self)
					searchEditNote:Hide();
					searchEditOK:Enable();
				end);
				searchEdit:SetScript("OnEditFocusLost", function(self)
					if self:GetText() == "" then
						searchEditNote:Show();
					end
					searchEditOK:Disable();
				end);

				return searchEdit, searchEditOK, searchEditNameOnly;
			end
			--
			function NS.ui_hook(meta)
				local hooked_frame = meta.hooked_frame;
				local frame = CreateFrame("FRAME", nil, hooked_frame);

				do	--	frame & hooked_frame
					--	frame
						frame:SetFrameStrata("HIGH");
						frame:EnableMouse(true);
						Mixin(frame, meta);
						function frame.update_func()
							NS.process_update(frame);
						end
						frame:SetScript("OnShow", function(self)
							self:with_ui_obj(NS.ui_hide_permanently);
							self.hooked_scroll:Hide();
							self.clear_filter();
							for name, func in next, self.inoperative_func do
								_G[name] = _noop_;
							end
						end);
						frame:SetScript("OnHide", function(self)
							self:with_ui_obj(NS.ui_unhide_permanently);
							self.hooked_scroll:Show();
							for name, func in next, self.inoperative_func do
								_G[name] = func;
							end
							self.hooked_frame_update_func()
						end);
						if meta.events_update then
							for index = 1, #meta.events_update do
								frame:RegisterEvent(meta.events_update[index]);
							end
							frame:SetScript("OnEvent", function(self, event, _1, ...)
								_EventHandler:frame_update_on_next_tick(self);
							end);
						end
						C_Timer.NewTicker(PERIODIC_UPDATE_PERIOD, frame.update_func);
						frame.list = {  };
						frame.prev_var_update_time = GetTime() - MAXIMUM_VAR_UPDATE_PERIOD;
						hooked_frame.frame = frame;

						local scroll = ALASCR(frame, nil, nil, ui_style.skillListButtonHeight, NS.ui_CreateSkillListButton, NS.ui_SetSkillListButton);
						scroll:SetPoint("BOTTOMLEFT", 4, 0);
						scroll:SetPoint("TOPRIGHT", - 4, - 28);
						NS.ui_ModifyALAScrollFrame(scroll);
						frame.scroll = scroll;

						local call = CreateFrame("BUTTON", nil, hooked_frame, "UIPanelButtonTemplate");
						call:SetSize(70, 18);
						call:SetPoint("RIGHT", meta.normal_anchor_top, "LEFT", - 2, 0);
						call:SetFrameLevel(127);
						call:SetScript("OnClick", function(self)
							local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
							if frame:IsShown() then
								frame:Hide();
								call:SetText(L["Open"]);
								if pid then
									SET[pid].shown = false;
								end
							else
								frame:Show();
								call:SetText(L["Close"]);
								if pid then
									SET[pid].shown = true;
								end
								frame.update = true;
								frame.update_func();
							end
						end);
						-- call:SetScript("OnEnter", Info_OnEnter);
						-- call:SetScript("OnLeave", Info_OnLeave);
						frame.call = call;
					--

					hooked_frame:HookScript("OnHide", function(self)
						frame:Hide();
					end);
					--	variable
					for index = 1, #meta.inoperative_name do
						local name = meta.inoperative_name[index];
						meta.inoperative_func[name] = _G[name];
					end
					local LAYOUT = meta.layout;
					for _, layout in next, LAYOUT do
						if layout.anchor then
							for index = 1, #layout.anchor do
								local point = layout.anchor[index];
								if point[2] == nil then
									point[2] = frame;
								end
							end
						end
						if layout.scroll_anchor then
							for index = 1, #layout.scroll_anchor do
								local point = layout.scroll_anchor[index];
								if point[2] == nil then
									point[2] = frame;
								end
							end
						end
						if layout.detail_anchor then
							for index = 1, #layout.detail_anchor do
								local point = layout.detail_anchor[index];
								if point[2] == nil then
									point[2] = frame;
								end
							end
						end
					end
					local hooked_frame_objects = meta.hooked_frame_objects;

					--	hide hooked_frame texture
						hooked_frame:SetHitRectInsets(15, 33, 13, 71);
						local regions = { hooked_frame:GetRegions() };
						for index = 1, #regions do
							local obj = regions[index];
							local name = obj:GetName();
							if obj ~= hooked_frame_objects.portrait and strupper(obj:GetObjectType()) == 'TEXTURE' then
								obj._Show = obj.Show;
								obj.Show = _noop_;
								obj:Hide();
							end
						end
					--	portrait
						hooked_frame_objects.portrait:ClearAllPoints();
						hooked_frame_objects.portrait:SetPoint("TOPLEFT", 7, -4);
						local portraitBorder = hooked_frame:CreateTexture(nil, "ARTWORK");
						portraitBorder:SetSize(70, 70);
						portraitBorder:SetPoint("CENTER", hooked_frame_objects.portrait);
						portraitBorder:SetTexture("Interface\\Tradeskillframe\\CapacitanceUIGeneral");
						portraitBorder:SetTexCoord(65 / 256, 117 / 256, 45 / 128, 97 / 128);
						portraitBorder:Show();
						frame.portraitBorder = portraitBorder;
					--	objects
						local drop_list = hooked_frame_objects.drop;
						if drop_list then
							local InvSlotDropDown = drop_list.InvSlotDropDown;
							if InvSlotDropDown then
								NS.ui_Re_LayoutDropDownMenu(InvSlotDropDown);
								InvSlotDropDown:ClearAllPoints();
								InvSlotDropDown:SetPoint("RIGHT", hooked_frame, "TOPLEFT", 342 / 0.9, -81 / 0.9);
							end
							local SubClassDropDown = drop_list.SubClassDropDown;
							if SubClassDropDown then
								NS.ui_Re_LayoutDropDownMenu(SubClassDropDown);
								SubClassDropDown:ClearAllPoints();
								SubClassDropDown:SetPoint("RIGHT", InvSlotDropDown, "LEFT", -4 / 0.9, 0);
							end
						end
						local button_list = hooked_frame_objects.button;
						do
							button_list.CancelButton:SetSize(72, 18);
							button_list.CreateButton:SetSize(72, 18);
							button_list.CancelButton:ClearAllPoints();
							button_list.CreateButton:ClearAllPoints();
							button_list.CancelButton:SetPoint("TOPRIGHT", -42, -415);
							button_list.CreateButton:SetPoint("RIGHT", button_list.CancelButton, "LEFT", -7, 0);
							button_list.CloseButton:ClearAllPoints();
							button_list.CloseButton:SetPoint("CENTER", hooked_frame, "TOPRIGHT", -51, -24);
							button_list.Call = call;
						end
						local edit_list = hooked_frame_objects.edit;
						if edit_list and edit_list.InputBox then
							local Left = getglobal(edit_list.InputBox:GetName() .. "Left");
							Left:ClearAllPoints();
							Left:SetPoint("LEFT", 0, 0);
							edit_list.InputBox:SetTextInsets(3, 0, 0, 0);
							button_list.CreateAllButton:SetSize(72, 18);
							button_list.IncrementButton:ClearAllPoints();
							edit_list.InputBox:ClearAllPoints();
							button_list.DecrementButton:ClearAllPoints();
							button_list.CreateAllButton:ClearAllPoints();
							button_list.IncrementButton:SetPoint("CENTER", button_list.CreateButton, "LEFT", -16, 0);
							edit_list.InputBox:SetHeight(18);
							edit_list.InputBox:SetPoint("RIGHT", button_list.IncrementButton, "CENTER", -16, 0);
							button_list.DecrementButton:SetPoint("CENTER", edit_list.InputBox, "LEFT", -16, 0);
							button_list.CreateAllButton:SetPoint("RIGHT", button_list.DecrementButton, "LEFT", -7, 0);
						end
						local CollapseAllButton = hooked_frame_objects.CollapseAllButton;
						if CollapseAllButton then
							CollapseAllButton:SetParent(hooked_frame);
							CollapseAllButton:ClearAllPoints();
							CollapseAllButton:SetPoint("BOTTOMLEFT", meta.hooked_scroll, "TOPLEFT", 0, 4);
						end
						local hooked_rank = meta.hooked_rank;
						do
							hooked_rank:ClearAllPoints();
							hooked_rank:SetPoint("TOP", 0, -42);
							local rankName = getglobal(hooked_rank:GetName() .. "SkillName");
							if rankName then rankName:Hide(); end
							local rankRank = getglobal(hooked_rank:GetName() .. "SkillRank");
							if rankRank then
								rankRank:ClearAllPoints();
								rankRank:SetPoint("CENTER");
								rankRank:SetJustifyH("CENTER");
							end
							local rankBorder = getglobal(hooked_rank:GetName() .. "Border");
							if rankBorder then
								rankBorder:ClearAllPoints();
								rankBorder:SetPoint("TOPLEFT", -5, 8);
								rankBorder:SetPoint("BOTTOMRIGHT", 5, -8);
							end
							function hooked_rank:Modern()
								rankBorder:Hide();
								self:SetBackdrop(ui_style.scrollBackdrop);
								self:SetBackdropBorderColor(unpack(ui_style.modernScrollBackdropBorderColor));
							end
							function hooked_rank:Blz()
								rankBorder:Show();
								self:SetBackdrop(nil);
							end
						end
					--	BACKGROUND and DEVIDER
						local background = CreateFrame("FRAME", nil, hooked_frame);
						background:SetPoint("TOPLEFT", 15, -13);
						background:SetPoint("BOTTOMRIGHT", -33, 75);
						background:SetFrameLevel(0);
						frame.BG = background;
						local line1 = background:CreateTexture(nil, "BACKGROUND");
						line1:SetDrawLayer("BACKGROUND", 7);
						line1:SetHorizTile(true);
						line1:SetHeight(4);
						line1:SetPoint("LEFT", 2, 0);
						line1:SetPoint("RIGHT", -2, 0);
						line1:SetPoint("BOTTOM", hooked_frame, "TOP", 0, -38);
						local line2 = background:CreateTexture(nil, "BACKGROUND");
						line2:SetDrawLayer("BACKGROUND", 7);
						line2:SetHorizTile(true);
						line2:SetHeight(4);
						line2:SetPoint("LEFT", 2, 0);
						line2:SetPoint("RIGHT", -2, 0);
						line2:SetPoint("TOP", hooked_frame, "TOP", 0, -61);
						local line3 = background:CreateTexture(nil, "BACKGROUND");
						line3:SetDrawLayer("BACKGROUND", 7);
						line3:SetHorizTile(true);
						line3:SetHeight(4);
						line3:SetPoint("LEFT", 2, 0);
						line3:SetPoint("RIGHT", -2, 0);
						line3:SetPoint("BOTTOM", meta.hooked_detail, "TOP", 0, 2);
						frame.line1 = line1;
						frame.line2 = line2;
						frame.line3 = line3;
					--	skillListButton
						local skillListButtons = {  };
						frame.skillListButtons = skillListButtons;
						for index = 1, getglobal(LAYOUT.skillListButton_num_name) do
							skillListButtons[index] = getglobal(hooked_frame_objects.skillListButton_name .. index);
						end
						for index = getglobal(LAYOUT.skillListButton_num_name) + 1, LAYOUT.expand.scroll_button_num do
							local button = CreateFrame("BUTTON", hooked_frame_objects.skillListButton_name .. index, hooked_frame, hooked_frame_objects.skillListButton_inherits);
							button:SetPoint("TOPLEFT", skillListButtons[index - 1], "BOTTOMLEFT", 0, 0);
							button:Hide();
							skillListButtons[index] = button;
						end
						skillListButtons[1]:ClearAllPoints();
						skillListButtons[1]:SetPoint("TOPLEFT", meta.hooked_scroll);
						for index = 1, #skillListButtons do
							local button = skillListButtons[index];
							button:SetScript("OnEnter", NS.ui_defaultSkillListButton_OnEnter);
							button:SetScript("OnLeave", button_info_OnLeave);
							button:SetID(index);
							button.frame = frame;
							button.scroll = meta.hooked_scroll;
						end
					--	reagentButton & productButton
						local reagentButtons = {  };
						frame.reagentButtons = reagentButtons;
						for index = 1, 8 do
							local button = getglobal(hooked_frame_objects.reagentButton_name .. index);
							reagentButtons[index] = button;
							button:HookScript("OnClick", function(self)
								if IsShiftKeyDown() then
									local editBox = ChatEdit_ChooseBoxForSend();
									if not editBox:HasFocus() then
										local name = frame.reagent_info(frame.get_select(), self:GetID());
										if name and name ~= "" then
											ALA_INSERT_NAME(name);
										end
									end
								end
							end);
							button.frame = frame;
						end
						hooked_frame_objects.productButton:HookScript("OnClick", function(self)
							if IsShiftKeyDown() then
								local editBox = ChatEdit_ChooseBoxForSend();
								if not editBox:HasFocus() then
									local name = frame.recipe_info(frame.get_select());
									if name and name ~= "" then
										ALA_INSERT_NAME(name);
									end
								end
							end
						end);
						hooked_frame_objects.productButton.frame = frame;
					--

					function frame:Expand(expanded)
						local LAYOUT = self.layout;
						local layout = LAYOUT[expanded and 'expand' or 'normal'];
						self:ClearAllPoints();
						for index = 1, #layout.anchor do
							self:SetPoint(unpack(layout.anchor[index]));
						end
						self:SetSize(unpack(layout.size));
						self.hooked_frame:SetSize(unpack(layout.frame_size));
						self.hooked_scroll:ClearAllPoints();
						for index = 1, #layout.scroll_anchor do
							self.hooked_scroll:SetPoint(unpack(layout.scroll_anchor[index]));
						end
						self.hooked_scroll:SetSize(unpack(layout.scroll_size));
						self.hooked_detail:ClearAllPoints();
						for index = 1, #layout.detail_anchor do
							self.hooked_detail:SetPoint(unpack(layout.detail_anchor[index]));
						end
						self.hooked_detail:SetSize(unpack(layout.detail_size));
						self.hooked_detail:UpdateScrollChildRect();
						if expanded then
							self.line3:Hide();
							self.hooked_rank:SetWidth(360);
							SetUIPanelAttribute(self.hooked_frame, 'width', 684);
							setglobal(LAYOUT.skillListButton_num_name, layout.scroll_button_num);
							self.hooked_frame_update_func();
						else
							self.line3:Show();
							self.hooked_rank:SetWidth(240);
							SetUIPanelAttribute(self.hooked_frame, 'width', 353);
							setglobal(LAYOUT.skillListButton_num_name, layout.scroll_button_num);
							for index = layout.scroll_button_num + 1, LAYOUT.expand.scroll_button_num do
								self.skillListButtons[index]:Hide();
							end
						end
					end
					local buttonTextureList = {
						CloseButton = ui_style.texture_modern_button_close,
						IncrementButton = ui_style.texture_modern_arrow_right,
						DecrementButton = ui_style.texture_modern_arrow_left,
					};
					frame.buttonTextureList = buttonTextureList;
					function frame:BlzStyle(blz_style, loading)
						if blz_style then
							NS.ui_BlzScrollFrame(self.scroll);
							NS.ui_BlzCheckButton(self.searchEditNameOnly);
							self.searchEditNameOnly:SetSize(24, 24);
							local setFrame = self.setFrame;
							setFrame:SetWidth(344);
							NS.ui_BlzBackdrop(setFrame);
							local checkBoxes = setFrame.checkBoxes;
							for index = 1, #checkBoxes do
								local check = checkBoxes[index];
								NS.ui_BlzCheckButton(check);
								check:SetSize(24, 24);
							end
							local profitFrame = self.profitFrame;
							NS.ui_BlzBackdrop(profitFrame);
							NS.ui_BlzScrollFrame(profitFrame.scroll);
							NS.ui_BlzCheckButton(profitFrame.costOnly);
							profitFrame.costOnly:SetSize(24, 24);

							self.hooked_frame:SetHitRectInsets(11, 29, 9, 67);
							self.BG:ClearAllPoints();
							self.BG:SetPoint("TOPLEFT", 11, -7);
							self.BG:SetPoint("BOTTOMRIGHT", -29, 67);
							NS.ui_BlzBackdrop(self.BG);
							self.line1:SetTexture("Interface\\Dialogframe\\UI-Dialogbox-Divider", "MIRROR");
							self.line1:SetTexCoord(4 / 256, 188 / 256, 5 / 32, 13 / 32);
							self.line1:SetHeight(4);
							self.line2:SetTexture("Interface\\Dialogframe\\UI-Dialogbox-Divider", "MIRROR");
							self.line2:SetTexCoord(4 / 256, 188 / 256, 5 / 32, 13 / 32);
							self.line2:SetHeight(4);
							self.line3:SetTexture("Interface\\Dialogframe\\UI-Dialogbox-Divider", "MIRROR");
							self.line3:SetTexCoord(4 / 256, 188 / 256, 5 / 32, 13 / 32);
							self.line3:SetHeight(4);

							NS.ui_BlzScrollFrame(self.hooked_scroll);
							NS.ui_BlzScrollFrame(self.hooked_detail);
							self.hooked_rank:Blz();
							self.portraitBorder:Show();
							local hooked_frame_objects = self.hooked_frame_objects;
							local button_list = hooked_frame_objects.button;
							if button_list.IncrementButton then
								button_list.IncrementButton:SetSize(23, 22);
							end
							if button_list.DecrementButton then
								button_list.DecrementButton:SetSize(23, 22);
							end
							button_list.CloseButton:SetSize(32, 32);
							local backup = hooked_frame_objects.backup;
							for _, button in next, button_list do
								local name = button:GetName();
								if name == nil then
									button.name = _;
									name = _;
								end
								NS.ui_BlzButton(button, not loading and backup[name] or nil);
							end
							local drop_list = hooked_frame_objects.drop;
							if drop_list then
								for _, drop in next, drop_list do
									NS.ui_BlzDropDownMenu(drop);
								end
							end
							local edit_list = hooked_frame_objects.edit;
							if edit_list then
								for _, edit in next, edit_list do
									NS.ui_BlzEditBox(edit);
								end
							end
							for index = 1, #self.skillListButtons do
								NS.ui_BlzSkillButton(self.skillListButtons[index]);
							end
							if hooked_frame_objects.CollapseAllButton then
								NS.ui_BlzSkillButton(hooked_frame_objects.CollapseAllButton);
							end
							self.hooked_frame_update_func();
						else
							NS.ui_ModernScrollFrame(self.scroll);
							NS.ui_ModernCheckButton(self.searchEditNameOnly);
							self.searchEditNameOnly:SetSize(14, 14);
							local setFrame = self.setFrame;
							setFrame:SetWidth(332);
							NS.ui_ModernBackdrop(setFrame);
							local checkBoxes = setFrame.checkBoxes;
							for index = 1, #checkBoxes do
								local check = checkBoxes[index];
								NS.ui_ModernCheckButton(check);
								check:SetSize(14, 14);
							end
							local profitFrame = self.profitFrame;
							NS.ui_ModernBackdrop(profitFrame);
							NS.ui_ModernScrollFrame(profitFrame.scroll);
							NS.ui_ModernCheckButton(profitFrame.costOnly);
							profitFrame.costOnly:SetSize(14, 14);

							self.hooked_frame:SetHitRectInsets(17, 35, 11, 73);
							self.BG:ClearAllPoints();
							self.BG:SetPoint("TOPLEFT", 17, -11);
							self.BG:SetPoint("BOTTOMRIGHT", -35, 73);
							NS.ui_ModernBackdrop(self.BG);
							self.line1:SetColorTexture(unpack(ui_style.modernDividerColor));
							self.line1:SetHeight(1);
							self.line2:SetColorTexture(unpack(ui_style.modernDividerColor));
							self.line2:SetHeight(1);
							self.line3:SetColorTexture(unpack(ui_style.modernDividerColor));
							self.line3:SetHeight(1);

							NS.ui_ModernScrollFrame(self.hooked_scroll);
							NS.ui_ModernScrollFrame(self.hooked_detail);
							self.hooked_rank:Modern();
							self.portraitBorder:Hide();
							local hooked_frame_objects = self.hooked_frame_objects;
							local button_list = hooked_frame_objects.button;
							if button_list.IncrementButton then
								button_list.IncrementButton:SetSize(14, 14);
							end
							if button_list.DecrementButton then
								button_list.DecrementButton:SetSize(14, 14);
							end
							button_list.CloseButton:SetSize(16, 16);
							local backup = hooked_frame_objects.backup;
							for _, button in next, button_list do
								local name = button:GetName();
								if name == nil then
									button.name = _;
									name = _;
								end
								if backup[name] == nil then
									local bak = {  };
									backup[name] = bak;
									NS.ui_ModernButton(button, bak, buttonTextureList[_]);
								else
									NS.ui_ModernButton(button, nil, buttonTextureList[_]);
								end
							end
							local drop_list = hooked_frame_objects.drop;
							if drop_list then
								for _, drop in next, drop_list do
									NS.ui_ModernDropDownMenu(drop);
								end
							end
							local edit_list = hooked_frame_objects.edit;
							if edit_list then
								for _, edit in next, edit_list do
									NS.ui_ModernEditBox(edit);
								end
							end
							for index = 1, #self.skillListButtons do
								NS.ui_ModernSkillButton(self.skillListButtons[index]);
							end
							if hooked_frame_objects.CollapseAllButton then
								NS.ui_ModernSkillButton(hooked_frame_objects.CollapseAllButton);
							end
							self.hooked_frame_update_func();
						end
					end
				end

				do	--	switch & tab
					local drop_meta = {
						handler = function(_, frame, name)
							if name == '@explorer' then
								NS.ui_toggleGUI("EXPLORER");
							elseif name == '@config' then
								NS.ui_toggleGUI("CONFIG");
							else
								CastSpellByName(name);
							end
						end,
						elements = {  },
					};
					local switch = CreateFrame("BUTTON", nil, hooked_frame);
					switch:SetSize(42, 42);
					switch:SetPoint("CENTER", meta.hooked_frame_objects.portrait);
					switch:RegisterForClicks("AnyUp");
					switch:SetScript("OnClick", function(self)
						ALADROP(self, "BOTTOM", drop_meta);
					end);
					function switch:Update()
						local elements = drop_meta.elements;
						wipe(elements);
						local pname = frame.pname();
						for pid = NS.db_min_pid(), NS.db_max_pid() do
							if rawget(VAR, pid) and NS.db_is_pid_has_win(pid) then
								local name = NS.db_get_check_name_by_pid(pid);
								if name and name ~= pname then
									local element = { text = name, para = { frame, name, }, };
									tinsert(elements, element);
								end
							end
						end
						tinsert(elements, { text = "explorer", para = { frame, '@explorer', }, });
						tinsert(elements, { text = "config", para = { frame, '@config', }, });
					end
					frame.switch = switch;
					--
					local tabFrame = CreateFrame("FRAME", nil, hooked_frame);
					tabFrame:SetBackdrop(ui_style.frameBackdrop);
					tabFrame:SetBackdropColor(unpack(ui_style.frameBackdropColor));
					tabFrame:SetBackdropBorderColor(unpack(ui_style.frameBackdropBorderColor));
					tabFrame:SetFrameStrata("HIGH");
					tabFrame:SetHeight(ui_style.tabSize + ui_style.tabInterval * 2);
					tabFrame:SetPoint("LEFT", frame);
					tabFrame:SetPoint("BOTTOM", meta.normal_anchor_top, "TOP", 0, -4);
					tabFrame:SetPoint("LEFT", meta.tab_anchor_left, "LEFT", 0, 0);
					tabFrame:Show();
					local tabs = {  };
					function tabFrame:CreateTab(index)
						local tab = CreateFrame("BUTTON", nil, tabFrame);
						tab:SetSize(ui_style.tabSize, ui_style.tabSize);
						tab:SetNormalTexture(ui_style.texture_unk);
						-- tab:GetNormalTexture():SetTexCoord(0.0625, 1.0, 0.0625, 1.0);
						tab:SetPushedTexture(ui_style.texture_unk);
						-- tab:GetPushedTexture():SetTexCoord(0.0, 0.9375, 0.0, 0.9375);
						tab:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
						tab:SetHighlightTexture(ui_style.texture_highlight);
						-- tab:GetHighlightTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75);
						-- tab:GetHighlightTexture():SetBlendMode("BLEND");
						tab:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
						tab.frame = frame;
						tab:EnableMouse(true);
						tab:SetScript("OnClick", function(self)
							local pname = self.pname;
							if pname and pname ~= frame.pname() then
								if pname == '@explorer' then
									NS.ui_toggleGUI("EXPLORER");
								elseif pname == '@config' then
									NS.ui_toggleGUI("CONFIG");
								else
									CastSpellByName(pname);
								end
							end
						end);
						tabs[index] = tab;
						if index == 1 then
							tab:SetPoint("LEFT", tabFrame, "LEFT", ui_style.tabInterval, 0);
						else
							tab:SetPoint("LEFT", tabs[index - 1], "RIGHT", ui_style.tabInterval, 0);
						end
						return tab;
					end
					function tabFrame:SetNumTabs(num)
						if #tabs > num then
							for index = num + 1, #tabs do
								tabs[index]:Hide();
							end
						else
							for index = 1, #tabs do
								tabs[index]:Show();
							end
							for index = #tabs + 1, num do
								self:CreateTab(index):Show();
							end
						end
						tabFrame:SetWidth(ui_style.tabSize * num + ui_style.tabInterval * (num + 1));
					end
					function tabFrame:SetTab(index, pname, ptexture)
						local tab = tabs[index] or self:CreateTab(index);
						tab:Show();
						tab.pname = pname;
						tab:SetNormalTexture(ptexture);
						tab:SetHighlightTexture(ptexture);
						tab:SetPushedTexture(ptexture);
					end
					function tabFrame:Update()
						local numSkill = 0;
						for pid = NS.db_min_pid(), NS.db_max_pid() do
							if rawget(VAR, pid) and NS.db_is_pid_has_win(pid) then
								numSkill = numSkill + 1;
								self:SetTab(numSkill, NS.db_get_check_name_by_pid(pid), NS.db_get_texture_by_pid(pid));
							end
						end
						numSkill = numSkill + 1;
						self:SetTab(numSkill, '@explorer', ui_style.texture_explorer);
						numSkill = numSkill + 1;
						self:SetTab(numSkill, '@config', ui_style.texture_config);
						self:SetNumTabs(numSkill);
					end
					frame.tabFrame = tabFrame;
					tabFrame.tabs = tabs;
				end

				do	--	search_box
					local searchEdit, searchEditOK, searchEditNameOnly = NS.ui_CreateSearchBox(frame);
					searchEdit:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, - 6);
					searchEdit:SetPoint("RIGHT", searchEditNameOnly, "LEFT", - 4, 0);
					searchEditNameOnly:SetPoint("RIGHT", searchEditOK, "LEFT", - 4, 0);
					searchEditOK:SetPoint("TOPRIGHT", frame, "TOPRIGHT", - 46, - 6);
				end

				do	--	profit_frame
					local profitFrame = CreateFrame("FRAME", nil, frame);
					profitFrame:SetFrameStrata("HIGH");
					profitFrame:EnableMouse(true);
					profitFrame:Hide();
					profitFrame:SetSize(320, 320);
					profitFrame:SetPoint("TOPLEFT", hooked_frame, "TOPRIGHT", -36, -68);
					profitFrame.list = {  };
					frame.profitFrame = profitFrame;

					local call = CreateFrame("BUTTON", nil, frame);
					call:SetSize(20, 20);
					call:SetNormalTexture("interface\\buttons\\ui-grouploot-coin-up");
					call:SetPushedTexture("interface\\buttons\\ui-grouploot-coin-down");
					call:SetHighlightTexture("interface\\buttons\\ui-grouploot-coin-highlight");
					call:SetPoint("TOPRIGHT", frame, "TOPRIGHT", - 24, -6);
					call:SetScript("OnEnter", button_info_OnEnter);
					call:SetScript("OnLeave", button_info_OnLeave);
					call.info_lines = { L["TIP_PROFIT_FRAME_CALL_INFO"] };
					call:SetScript("OnClick", function(self)
						if merc then
							local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
							if profitFrame:IsShown() then
								profitFrame:Hide();
								if pid then
									SET[pid].showProfit = false;
								end
							else
								profitFrame:Show();
								if pid then
									SET[pid].showProfit = true;
								end
							end
						end
					end);
					profitFrame.call = call;
					frame.profitCall = call;

					profitFrame:SetScript("OnShow", function(self)
						if merc then
							NS.process_profit_update(frame);
							call:SetNormalTexture("interface\\buttons\\ui-grouploot-coin-down");
							call:SetPushedTexture("interface\\buttons\\ui-grouploot-coin-up");
						else
							self:Hide();
						end
					end);
					profitFrame:SetScript("OnHide", function()
						call:SetNormalTexture("interface\\buttons\\ui-grouploot-coin-up");
						call:SetPushedTexture("interface\\buttons\\ui-grouploot-coin-down");
					end);

					local scroll = ALASCR(profitFrame, nil, nil, ui_style.skillListButtonHeight, NS.ui_CreateProfitSkillListButton, NS.ui_SetProfitSkillListButton);
					scroll:SetPoint("BOTTOMLEFT", 4, 4);
					scroll:SetPoint("TOPRIGHT", - 4, - 20);
					profitFrame.scroll = scroll;
					frame.profitScroll = scroll;

					local costOnly = CreateFrame("CHECKBUTTON", nil, profitFrame, "OptionsBaseCheckButtonTemplate");
					costOnly:SetSize(24, 24);
					costOnly:SetHitRectInsets(0, 0, 0, 0);
					costOnly:SetPoint("CENTER", profitFrame, "TOPLEFT", 17, -10);
					costOnly:Show();
					local str = profitFrame:CreateFontString(nil, "ARTWORK");
					str:SetFont(ui_style.frameFont, ui_style.frameFontSize, "OUTLINE");
					str:SetPoint("LEFT", costOnly, "CENTER", 10, 0);
					str:SetText(L["costOnly"]);
					costOnly.fontString = str;
					costOnly:SetScript("OnClick", function(self)
						local checked = self:GetChecked();
						local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
						if pid then
							SET[pid].costOnly = checked;
							NS.process_profit_update(frame);
						end
					end);
					profitFrame.costOnly = costOnly;

					local close = CreateFrame("BUTTON", nil, profitFrame);
					close:SetSize(16, 16);
					close:SetNormalTexture("interface\\buttons\\ui-stopbutton");
					close:SetPushedTexture("interface\\buttons\\ui-stopbutton");
					close:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
					close:SetHighlightTexture("interface\\buttons\\ui-stopbutton");
					close:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
					close:SetPoint("TOPRIGHT", profitFrame, "TOPRIGHT", -4, -2);
					close:SetScript("OnClick", function()
						local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
						if pid then
							SET[pid].showProfit = false;
						end
						profitFrame:Hide();
					end);
					profitFrame.close = close;

					NS.ui_ModifyALAScrollFrame(scroll);
				end

				do	--	set_frame
					local setFrame = CreateFrame("FRAME", nil, frame);
					setFrame:SetFrameStrata("HIGH");
					setFrame:SetSize(332, 48);
					setFrame:Hide();
					frame.setFrame = setFrame;

					local call = CreateFrame("BUTTON", nil, frame);
					call:SetSize(16, 16);
					call:SetNormalTexture(ui_style.texture_config);
					call:SetPushedTexture(ui_style.texture_config);
					call:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
					call:SetHighlightTexture(ui_style.texture_config);
					call:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
					call:SetPoint("TOPRIGHT", frame, "TOPRIGHT", - 4, - 6);
					call:SetScript("OnClick", function(self)
						local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
						if setFrame:IsShown() then
							frame:HideSetFrame();
							if pid then
								SET[pid].showSet = false;
							end
						else
							frame:ShowSetFrame(true);
							if pid then
								SET[pid].showSet = true;
							end
						end
					end);
					setFrame.call = call;
					frame.setCall = call;

					setFrame:SetScript("OnShow", function(self)
						call:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					end);
					setFrame:SetScript("OnHide", function(self)
						call:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					end);

					local checkBoxes = {  };
					local keyTables = { "showUnkown", "showKnown", "showHighRank", "showItemInsteadOfSpell", "showRank", "haveMaterials", };
					for index = 1, #keyTables do
						local key = keyTables[index];
						local check = CreateFrame("CHECKBUTTON", nil, setFrame, "OptionsBaseCheckButtonTemplate");
						check:SetSize(24, 24);
						check:SetHitRectInsets(0, 0, 0, 0);
						check:Show();
						check:SetChecked(false);
						local str = setFrame:CreateFontString(nil, "ARTWORK");
						str:SetFont(ui_style.frameFont, ui_style.frameFontSize, "OUTLINE");
						str:SetText(L[key]);
						check.fontString = str;
						str:SetPoint("LEFT", check, "RIGHT", 0, 0);
						if index % 3 == 1 then
							if index == 1 then
								check:SetPoint("CENTER", setFrame, "TOPLEFT", 16, -12);
							else
								check:SetPoint("CENTER", checkBoxes[index - 3], "CENTER", 0, -24);
							end
						else
							check:SetPoint("CENTER", checkBoxes[index - 1], "CENTER", 102, 0);
						end
						if index == 1 or index == 2 or index == 3 or index == 6 then
							check:SetScript("OnClick", function(self)
								local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
								if pid then
									NS.change_set_with_update(SET[pid], key, self:GetChecked());
								end
								frame.update_func();
							end);
						else
							check:SetScript("OnClick", function(self)
								local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
								if pid then
									NS.change_set_with_update(SET[pid], key, self:GetChecked());
								end
								frame.scroll:Update();
							end);
						end
						check.key = key;
						check.frame = frame;
						tinsert(checkBoxes, check);
					end
					setFrame.checkBoxes = checkBoxes;

					local phaseSlider = CreateFrame("SLIDER", nil, setFrame, "OptionsSliderTemplate");
					phaseSlider:SetPoint("BOTTOM", setFrame, "TOP", 0, 12);
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
							local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
							if pid then
								NS.change_set_with_update(SET[pid], "phase", value);
								frame.update_func();
							end
						end
						self.Text:SetText("\124cffffff00" .. L["phase"] .. "\124r " .. value);
					end);
					phaseSlider.frame = frame;
					setFrame.phaseSlider = phaseSlider;

					function frame:ShowSetFrame(show)
						if SET.show_tab then
							setFrame:ClearAllPoints();
							setFrame:SetPoint("LEFT", self.BG);
							-- setFrame:SetPoint("RIGHT", self);
							setFrame:SetPoint("BOTTOM", self.tabFrame, "TOP", 0, 2);
						else
							setFrame:ClearAllPoints();
							setFrame:SetPoint("LEFT", self.BG);
							-- setFrame:SetPoint("RIGHT", self);
							setFrame:SetPoint("BOTTOM", self.BG, "TOP", 0, 2);
						end
						if show then
							setFrame:Show();
						end
					end
					function frame:HideSetFrame()
						setFrame:Hide();
					end
					function frame:RefreshSetFrame()
						local pid = frame.flag or NS.db_get_pid_by_pname(self.pname());
						if pid then
							local set = SET[pid];
							for index = 1, #checkBoxes do
								local check = checkBoxes[index];
								check:SetChecked(set[check.key]);
							end
							phaseSlider:SetValue(set.phase);
						end
					end
				end

				do	--	info_in_frame
					local rank_info_in_frame = frame.hooked_detailChild:CreateFontString(nil, "OVERLAY");
					rank_info_in_frame:SetFont(GameFontNormal:GetFont());
					rank_info_in_frame:SetPoint("TOPLEFT", frame.hooked_detailChild, "TOPLEFT", 5, -50);
					frame.rank_info_in_frame = rank_info_in_frame;

					local price_info_in_frame = {  };
					price_info_in_frame[1] = frame.hooked_detailChild:CreateFontString(nil, "OVERLAY");
					price_info_in_frame[1]:SetFont(GameFontNormal:GetFont());
					price_info_in_frame[1]:SetPoint("TOPLEFT", rank_info_in_frame, "BOTTOMLEFT", 0, -3);
					price_info_in_frame[2] = frame.hooked_detailChild:CreateFontString(nil, "OVERLAY");
					price_info_in_frame[2]:SetFont(GameFontNormal:GetFont());
					price_info_in_frame[2]:SetPoint("TOPLEFT", price_info_in_frame[1], "BOTTOMLEFT", 0, 0);
					price_info_in_frame[3] = frame.hooked_detailChild:CreateFontString(nil, "OVERLAY");
					price_info_in_frame[3]:SetFont(GameFontNormal:GetFont());
					price_info_in_frame[3]:SetPoint("TOPLEFT", price_info_in_frame[2], "BOTTOMLEFT", 0, 0);
					frame.price_info_in_frame = price_info_in_frame;

					frame.info_in_frame_anchor:ClearAllPoints();
					frame.info_in_frame_anchor:SetPoint("TOPLEFT", price_info_in_frame[3], "BOTTOMLEFT", 0, -3);

					local function delayUpdateInfoInFrame()
						frame:updatePriceInfoInFrame();
						frame:updateRankInfoInFrame();
					end
					local prev_sid = nil;
					hooksecurefunc(frame.func_name.select_func, function()
						if not frame:IsShown() then
							local index = frame.get_select();
							if index then
								frame.selected_sid = NS.db_get_sid_by_pid_sname_cid(NS.db_get_pid_by_pname(frame.pname()), frame.recipe_info(index), frame.recipe_itemId(index));
							end
						end
						if prev_sid ~= frame.selected_sid then
							prev_sid = frame.selected_sid;
							price_info_in_frame[1]:SetText(nil);
							price_info_in_frame[2]:SetText(nil);
							price_info_in_frame[3]:SetText(nil);
						end
						C_Timer.After(0.5, delayUpdateInfoInFrame);
					end);
					frame.select_func = _G[frame.func_name.select_func];
					frame.updatePriceInfoInFrame = NS.ui_updatePriceInfoInFrame;
					frame.updateRankInfoInFrame = NS.ui_updateRankInfoInFrame;
				end

				ALA_HOOK_ChatEdit_InsertLink(function(link, addon)
					if frame:IsVisible() and addon ~= ADDON and not (BrowseName and BrowseName:IsVisible()) then
						local name, _, _, _, _, _, _, _, loc = GetItemInfo(link);
						if name and name ~= "" then
							local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
							frame.searchEdit:ClearFocus();
							if pid == 10 and loc and loc ~= "" then
								local id = tonumber(select(3, strfind(link, "item:(%d+)")));
								if id ~= 11287 and id ~= 11288 and id ~= 11289 and id ~= 11290 then
									if L.ENCHANT_FILTER[loc] then
										frame:Search(L.ENCHANT_FILTER[loc]);
									else
										frame:Search(L.ENCHANT_FILTER.NONE);
									end
								else
									frame:Search(name);
								end
							else
								frame:Search(name);
							end
							return true;
						end
					end
				end);
				ALA_HOOK_ChatEdit_InsertName(function(name, addon)
					if frame:IsVisible() and addon ~= ADDON and not (BrowseName and BrowseName:IsVisible()) then
						if name and name ~= "" then
							frame.searchEdit:SetText(name);
							frame.searchEdit:ClearFocus();
							frame:Search(name);
							return true;
						end
					end
				end);

				NS.merc_AddFrame(frame);

				return frame;
			end
			function NS.ui_initial_set(frame)
				for key, name in next, frame.func_name do
					frame[key] = _G[key] or frame[key];
				end
				--
				frame.tabFrame:Update();
				frame.switch:Update();
				frame:Expand(SET.expand);
				frame:BlzStyle(SET.blz_style, true);
				if SET.show_call then
					frame.call:Show();
				else
					frame.call:Hide();
				end
				if SET.show_tab then
					frame.tabFrame:Show();
				else
					frame.tabFrame:Hide();
				end
				if SET.portrait_button then
					frame.switch:Show();
				else
					frame.switch:Hide();
				end
				--
				local ticker = nil;
				ticker = C_Timer.NewTicker(0.1, function()
					if frame.hooked_frame_objects.portrait:GetTexture() == nil then
						SetPortraitTexture(frame.hooked_frame_objects.portrait, "player");
					else
						ticker:Cancel();
						ticker = nil;
					end
				end);
			end
		--
		function NS.ui_hook_Blizzard_TradeSkillUI(addon)
			local meta = {
				hooked_frame = TradeSkillFrame,
				hooked_detail = TradeSkillDetailScrollFrame,
				hooked_detailBar = TradeSkillDetailScrollFrameScrollBar,
				hooked_detailChild = TradeSkillDetailScrollChildFrame,
				hooked_scroll = TradeSkillListScrollFrame,
				hooked_scrollBar = TradeSkillListScrollFrameScrollBar,
				hooked_rank = TradeSkillRankFrame,
				with_ui_obj = function(self, func)
					func(TradeSkillCollapseAllButton);
					func(TradeSkillInvSlotDropDown);
					func(TradeSkillSubClassDropDown);
					func(TradeSkillListScrollFrame);
					func(TradeSkillListScrollFrameScrollBar)
					func(TradeSkillHighlightFrame);
					local skillListButtons = self.skillListButtons;
					if skillListButtons then
						for index = 1, #skillListButtons do
							func(skillListButtons[index]);
						end
					end
				end,
				layout = {
					normal = {
						frame_size = { 384, 512, },
						anchor = {
							{ "TOPLEFT", TradeSkillFrame, "TOPLEFT", 18, -68, },
							-- { "BOTTOMRIGHT", TradeSkillFrame, "TOPRIGHT", -38, -230, },
						},
						size = { 328, 156, },
						scroll_anchor = {
							{ "TOPLEFT", TradeSkillFrame, "TOPLEFT", 22, -96, },
						},
						scroll_size = { 298, 128, },
						scroll_button_num = 8,
						detail_anchor = {
							{ "TOPLEFT", TradeSkillFrame, "TOPLEFT", 22, -234, },
						},
						detail_size = { 298, 176 },
					},
					expand = {
						frame_size = { 715, 512, },
						anchor = {
							{ "TOPLEFT", TradeSkillFrame, "TOPLEFT", 18, -68, },
						},
						size = { 328, 366, },
						scroll_anchor = {
							{ "TOPLEFT", TradeSkillFrame, "TOPLEFT", 22, -96, },
						},
						scroll_size = { 298, 21 * 16, },
						scroll_button_num = 21,
						detail_anchor = {
							{ "TOPLEFT", nil, "TOPRIGHT", 2, -4, },
						},
						detail_size = { 298, 318, },
					},
					skillListButton_num_name = "TRADE_SKILLS_DISPLAYED",
				},
				normal_anchor_top = TradeSkillFrameCloseButton,
				tab_anchor_left = TradeSkillRankFrameBorder,
				info_in_frame_anchor = TradeSkillReagentLabel,
				hooked_frame_objects = {
					backup = {  },
					portrait = TradeSkillFramePortrait,
					skillListButton_name = "TradeSkillSkill",
					skillListButton_inherits = "TradeSkillSkillButtonTemplate",
					productButton = TradeSkillSkillIcon,
					reagentButton_name = "TradeSkillReagent",
					button = {
						CancelButton = TradeSkillCancelButton,
						CreateButton = TradeSkillCreateButton,
						IncrementButton = TradeSkillIncrementButton,
						DecrementButton = TradeSkillDecrementButton,
						CreateAllButton = TradeSkillCreateAllButton,
						CloseButton = TradeSkillFrameCloseButton,
					},
					CollapseAllButton = TradeSkillCollapseAllButton,
					drop = {
						InvSlotDropDown = TradeSkillInvSlotDropDown,
						SubClassDropDown = TradeSkillSubClassDropDown,
					},
					edit = {
						InputBox = TradeSkillInputBox,
					},
				},

				select_func = TradeSkillFrame_SetSelection,		-- SelectTradeSkill
				get_select = GetTradeSkillSelectionIndex,
				-- expand = ExpandTradeSkillSubClass,
				-- collapse = CollapseTradeSkillSubClass,
				clear_filter = function()
					SetTradeSkillSubClassFilter(0, 1, 1);
					UIDropDownMenu_SetSelectedID(TradeSkillSubClassDropDown, 1);
					SetTradeSkillInvSlotFilter(0, 1, 1);
					UIDropDownMenu_SetSelectedID(TradeSkillInvSlotDropDown, 1);
					ExpandTradeSkillSubClass(0);
					if TradeSkillCollapseAllButton then
						TradeSkillCollapseAllButton.collapsed = nil;
					end
				end,
				craft = DoTradeSkill,
				close = CloseTradeSkill,

				pname = GetTradeSkillLine,
				pinfo = GetTradeSkillLine,
					--	skillName, cur_rank, max_rank

				recipe_num = GetNumTradeSkills,
				recipe_info = GetTradeSkillInfo,
					--	skillName, difficult & header, numAvailable, isExpanded = GetTradeSkillInfo(skillIndex)
				recipe_itemId = function(arg1) local link = GetTradeSkillItemLink(arg1); return link and tonumber(select(3, strfind(link, "[a-zA-Z]:(%d+)"))) or 0; end,
				recipe_link = GetTradeSkillItemLink,
				recipe_icon = GetTradeSkillIcon,
				recipe_desc = function() return ""; end,
				recipe_need = GetTradeSkillTools,
				recipe_cool = GetTradeSkillCooldown,
				recipe_num_made = GetTradeSkillNumMade,
					--	num_Made_Min, num_Made_Max

				reagent_num = GetTradeSkillNumReagents,
				reagent_link = GetTradeSkillReagentItemLink,
				reagent_id = function(i, j) return tonumber(select(3, strfind(GetTradeSkillReagentItemLink(i, j), "[a-zA-Z]:(%d+)"))); end,
				reagent_info = GetTradeSkillReagentInfo,
					--	name, texture, numRequired, numHave = GetTradeSkillReagentInfo(tradeSkillRecipeId, reagentId);

				hooked_frame_update_func = TradeSkillFrame_Update,
				events_update = {
					-- "NEW_RECIPE_LEARNED",
					-- "TRADE_SKILL_SHOW",
					"TRADE_SKILL_UPDATE",
				},
				inoperative_func = {  },
				inoperative_name = {
					"CollapseTradeSkillSubClass",
					-- "ExpandTradeSkillSubClass",
					"SetTradeSkillSubClassFilter",
					"SetTradeSkillInvSlotFilter",
				},
				func_name = {
					select_func = "TradeSkillFrame_SetSelection",
					hooked_frame_update_func = "TradeSkillFrame_Update",
				},
			};
			local frame = NS.ui_hook(meta);
			gui[addon] = frame;
			NS.ui_initial_set(frame);
			--
			TradeSkillExpandButtonFrame:Hide();
			--
			NS.ElvUI_Blizzard_TradeSkillUI();
			NS.CloudyTradeSkill_Blizzard_TradeSkillUI();
		end
		function NS.ui_hook_Blizzard_CraftUI(addon)
			local meta = {
				hooked_frame = CraftFrame,
				hooked_detail = CraftDetailScrollFrame,
				hooked_detailBar = CraftDetailScrollFrameScrollBar,
				hooked_detailChild = CraftDetailScrollChildFrame,
				hooked_scroll = CraftListScrollFrame,
				hooked_scrollBar = CraftListScrollFrameScrollBar,
				hooked_rank = CraftRankFrame,
				with_ui_obj = function(self, func)
					func(CraftListScrollFrame);
					func(CraftListScrollFrameScrollBar);
					func(CraftHighlightFrame);
					local skillListButtons = self.skillListButtons;
					if skillListButtons then
						for index = 1, #skillListButtons do
							func(skillListButtons[index]);
						end
					end
				end,
				layout = {
					normal = {
						frame_size = { 384, 512, },
						anchor = {
							{ "TOPLEFT", CraftFrame, "TOPLEFT", 18, -68, },
							-- { "BOTTOMRIGHT", CraftFrame, "TOPRIGHT", -38, -230, },
						},
						size = { 328, 156, },
						scroll_anchor = {
							{ "TOPLEFT", CraftFrame, "TOPLEFT", 22, -96, },
						},
						scroll_size = { 298, 128, },
						scroll_button_num = 8,
						detail_anchor = {
							{ "TOPLEFT", CraftFrame, "TOPLEFT", 22, -234, },
						},
						detail_size = { 298, 176 },
					},
					expand = {
						frame_size = { 715, 512, },
						anchor = {
							{ "TOPLEFT", CraftFrame, "TOPLEFT", 18, -68, },
						},
						size = { 328, 366, },
						scroll_anchor = {
							{ "TOPLEFT", CraftFrame, "TOPLEFT", 22, -96, },
						},
						scroll_size = { 298, 21 * 16, },
						scroll_button_num = 21,
						detail_anchor = {
							{ "TOPLEFT", nil, "TOPRIGHT", 2, -4, },
						},
						detail_size = { 298, 318, },
					},
					skillListButton_num_name = "CRAFTS_DISPLAYED",
				},
				normal_anchor_top = CraftFrameCloseButton,
				tab_anchor_left = CraftRankFrameBorder,
				info_in_frame_anchor = CraftDescription,
				hooked_frame_objects = {
					backup = {  },
					portrait = CraftFramePortrait,
					skillListButton_name = "Craft",
					skillListButton_inherits = "CraftButtonTemplate",
					productButton = CraftIcon,
					reagentButton_name = "CraftReagent",
					button = {
						CancelButton = CraftCancelButton,
						CreateButton = CraftCreateButton,
						CloseButton = CraftFrameCloseButton,
					},
				},

				select = CraftFrame_SetSelection,		-- SelectCraft
				get_select = GetCraftSelectionIndex,
				-- expand = ExpandCraftSkillLine,
				-- collapse = CollapseCraftSkillLine,
				clear_filter = _noop_,
				-- craft = DoCraft,
				close = CloseCraft,

				pname = GetCraftName,
				pinfo = GetCraftDisplaySkillLine,
					--	skillName, cur_rank, max_rank

				recipe_num = GetNumCrafts,
				recipe_info = function(arg1) local _1, _2, _3, _4, _5, _6, _7 = GetCraftInfo(arg1); return _1, _3, _4, _5, _6, _7; end,
					--	craftName, craftSubSpellName(""), difficult, numAvailable, isExpanded, trainingPointCost, requiredLevel = GetCraftInfo(index)
				recipe_itemId = function(arg1) local link = GetCraftItemLink(arg1); return link and tonumber(select(3, strfind(link, "[a-zA-Z]:(%d+)"))) or 0; end,
				recipe_link = GetCraftItemLink,
				recipe_icon = GetCraftIcon,
				recipe_desc = GetCraftDescription,
				recipe_need = GetCraftSpellFocus,
				recipe_cool = function() return nil; end,
				recipe_num_made = function() return 1, 1; end,

				reagent_num = GetCraftNumReagents,
				reagent_link = GetCraftReagentItemLink,
				reagent_id = function(i, j) return tonumber(select(3, strfind(GetCraftReagentItemLink(i, j), "[a-zA-Z]:(%d+)"))); end,
				reagent_info = GetCraftReagentInfo,
					-- name, texture, numRequired, numHave = GetCraftReagentInfo(tradeSkillRecipeId, reagentId);

				hooked_frame_update_func = CraftFrame_Update,
				events_update = {
					-- "NEW_RECIPE_LEARNED",
					-- "CRAFT_SHOW",
					"CRAFT_UPDATE",
				},
				inoperative_func = {  },
				inoperative_name = {
					"CollapseCraftSkillLine",
					-- "ExpandCraftSkillLine",
				},
				func_name = {
					select_func = "CraftFrame_SetSelection",
					hooked_frame_update_func = "CraftFrame_Update",
				},
			};
			local frame = NS.ui_hook(meta);
			gui[addon] = frame;
			NS.ui_initial_set(frame);
			do	-- auto filter recipe when trading
				local function process_link()
					local link = GetTradeTargetItemLink(7);
					if link then
						local loc = select(9, GetItemInfo(link));
						if loc and L.ENCHANT_FILTER[loc] then
							frame.searchEdit:SetText(L.ENCHANT_FILTER[loc]);
							frame:Search(L.ENCHANT_FILTER[loc]);
						else
							frame.searchEdit:SetText(L.ENCHANT_FILTER.NONE);
							frame:Search(L.ENCHANT_FILTER.NONE);
						end
					end
				end
				function NS.TRADE_CLOSED()
					frame.searchEdit:SetText("");
				end
				function NS.TRADE_TARGET_ITEM_CHANGED(_1)
					if _1 == 7 then
						process_link();
					end
				end
				function NS.TRADE_UPDATE()
					process_link();
				end
				-- _EventHandler:RegEvent("TRADE_SHOW");
				_EventHandler:RegEvent("TRADE_CLOSED");
				_EventHandler:RegEvent("TRADE_UPDATE");
				_EventHandler:RegEvent("TRADE_TARGET_ITEM_CHANGED");
				frame:HookScript("OnShow", function()
					if CraftFrame and CraftFrame:IsShown() then
						_EventHandler:run_on_next_tick(process_link);
					end
				end);
			end
			NS.ElvUI_Blizzard_CraftUI();
			NS.CloudyTradeSkill_Blizzard_CraftUI();
		end
		--
			function NS.ui_CreateExplorerSkillListButton(parent, index, buttonHeight)
				local button = CreateFrame("BUTTON", nil, parent);
				button:SetHeight(buttonHeight);
				button:SetBackdrop(ui_style.listButtonBackdrop);
				button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
				button:SetBackdropBorderColor(unpack(ui_style.listButtonBackdropBorderColor));
				button:SetHighlightTexture(ui_style.texture_white);
				button:GetHighlightTexture():SetVertexColor(unpack(ui_style.listButtonHighlightColor));
				button:EnableMouse(true);
				button:Show();

				local icon = button:CreateTexture(nil, "BORDER");
				icon:SetTexture(ui_style.texture_unk);
				icon:SetSize(buttonHeight - 4, buttonHeight - 4);
				icon:SetPoint("LEFT", 8, 0);
				button.icon = icon;

				local title = button:CreateFontString(nil, "OVERLAY");
				title:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				title:SetPoint("LEFT", icon, "RIGHT", 4, 0);
				-- title:SetWidth(160);
				title:SetMaxLines(1);
				title:SetJustifyH("LEFT");
				button.title = title;

				local note = button:CreateFontString(nil, "ARTWORK");
				note:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				note:SetPoint("RIGHT", -4, 0);
				button.note = note;

				title:SetPoint("RIGHT", note, "LEFT", - 4, 0);

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
				glow:SetTexture(ui_style.texture_white);
				-- glow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
				glow:SetVertexColor(unpack(ui_style.listButtonSelectedColor));
				glow:SetAllPoints();
				glow:SetBlendMode("ADD");
				glow:Hide();
				button.glow = glow;

				button:SetScript("OnEnter", NS.ui_skillListButton_OnEnter);
				button:SetScript("OnLeave", NS.ui_skillListButton_OnLeave);
				button:RegisterForClicks("AnyUp");
				button:SetScript("OnClick", NS.ui_listButton_OnClick);
				button:RegisterForDrag("LeftButton");
				button:SetScript("OnHide", ALADROP);

				function button:Select()
					glow:Show();
				end
				function button:Deselect()
					glow:Hide();
				end

				local frame = parent:GetParent():GetParent();
				button.frame = frame;
				button.list = frame.list;
				button.flag = frame.flag;

				return button;
			end
			function NS.ui_SetExplorerSkillListButton(button, data_index)
				local frame = button.frame;
				local list = button.list;
				local hash = frame.hash;
				if data_index <= #list then
					local sid = list[data_index];
					local cid = NS.db_get_cid_by_sid(sid);
					button:Show();
					local _, quality, icon;
					if cid then
						_, _, quality, _, icon = NS.db_item_info(cid);
					else
						quality = nil;
						icon = ICON_FOR_NO_CID;
					end
					button.icon:SetTexture(icon);
					button.title:SetText(NS.db_spell_name_s(sid));
					if hash[sid] then
						button.icon:SetVertexColor(1.0, 1.0, 1.0, 1.0);
						button.title:SetTextColor(0.0, 1.0, 0.0, 1.0);
					else
						button.icon:SetVertexColor(1.0, 0.0, 0.0, 1.0);
						button.title:SetTextColor(1.0, 0.0, 0.0, 1.0);
					end
					local set = SET.explorer;
					if set.showRank then
						button.note:SetText(NS.db_get_difficulty_rank_list_text_by_sid(sid));
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
					if FAV[sid] then
						button.star:Show();
					else
						button.star:Hide();
					end
					if GetMouseFocus() == button then
						NS.ui_skillListButton_OnEnter(button);
					end
					button:Deselect();
					if button.prev_sid ~= sid then
						ALADROP(button);
						button.prev_sid = sid;
					end
				else
					ALADROP(button);
					button:Hide();
				end
			end
			--	set button handler
				--	L.TRADESKILL_NAME
				--	L.ITEM_TYPE_LIST
				--	L.ITEM_SUB_TYPE_LIST
				local index_bound = { skill = { BIG_NUMBER, -1, }, type = { BIG_NUMBER, -1, }, subType = {  }, eqLoc = { BIG_NUMBER, -1, }, };
				for index, _ in next, L.TRADESKILL_NAME do
					if index < index_bound.skill[1] then
						index_bound.skill[1] = index;
					end
					if index > index_bound.skill[2] then
						index_bound.skill[2] = index;
					end
				end
				for index, _ in next, L.ITEM_TYPE_LIST do
					if index < index_bound.type[1] then
						index_bound.type[1] = index;
					end
					if index > index_bound.type[2] then
						index_bound.type[2] = index;
					end
				end
				for index1, sub in next, L.ITEM_SUB_TYPE_LIST do
					if index1 < index_bound.type[1] then
						index_bound.type[1] = index1;
					end
					if index1 > index_bound.type[2] then
						index_bound.type[2] = index1;
					end
					index_bound.subType[index1] = { BIG_NUMBER, -1, };
					for index2, _ in next, sub do
						if index2 < index_bound.subType[index1][1] then
							index_bound.subType[index1][1] = index2;
						end
						if index2 > index_bound.subType[index1][2] then
							index_bound.subType[index1][2] = index2;
						end
					end
				end
				for index, _ in next, L.ITEM_EQUIP_LOC do
					if index < index_bound.eqLoc[1] then
						index_bound.eqLoc[1] = index;
					end
					if index > index_bound.eqLoc[2] then
						index_bound.eqLoc[2] = index;
					end
				end
				----
				local explorer_set_drop_meta = {
					handler = function(_, frame, key, val)
						SET.explorer.filter[key] = val;
						if key == 'type' then
							SET.explorer.filter.subType = nil;
						end
						frame.update_func();
					end,
					elements = {  },
				};
				local temp_filter = {  };
				local temp_list = {  };
				local temp_stat_list = { skill = {  }, type = {  }, subType = {  }, eqLoc = {  }, };
				function NS.ui_explorerSetDrop_OnClick(self)
					local key = self.key;
					local set = SET.explorer;
					local filter = set.filter;
					local bound = nil;
					if key == 'subType' then
						local key0 = filter.type;
						if key0 == nil then
							return;
						end
						bound = index_bound[key][key0];
					else
						bound = index_bound[key];
					end
					local frame = self.frame;
					local stat_list = nil;
					if filter[key] then
						wipe(temp_filter);
						Mixin(temp_filter, filter);
						temp_filter[key] = nil;
						if key == 'type' then
							temp_filter.subType = nil;
						end
						NS.process_explorer_update_list(frame, temp_stat_list, temp_filter, set.searchText, set.searchNameOnly,
													temp_list, frame.hash, set.phase, nil, set.rankReversed, set.showKnown, set.showUnkown, set.showHighRank);
						stat_list = temp_stat_list;
					else
						stat_list = explorer_stat_list;
					end
					local elements = explorer_set_drop_meta.elements;
					wipe(elements);
					elements[1] = { text = L["EXPLORER_CLEAR_FILTER"], para = { frame, key, nil, }, };
					local stat = stat_list[key];
					if key == 'skill' then
						for index = bound[1], bound[2] do
							if stat[index] then
								tinsert(elements, { text = L.TRADESKILL_NAME[index], para = { frame, key, index, }, });
							end
						end
					elseif key == 'type' then
						for index = bound[1], bound[2] do
							if stat[index] then
								tinsert(elements, { text = L.ITEM_TYPE_LIST[index], para = { frame, key, index, }, });
							end
						end
					elseif key == 'subType' then
						local key0 = filter.type;
						for index = bound[1], bound[2] do
							if stat[index] then
								tinsert(elements, { text = L.ITEM_SUB_TYPE_LIST[key0][index], para = { frame, key, index, }, });
							end
						end
					elseif key == 'eqLoc' then
						for index = bound[1], bound[2] do
							if stat[index] then
								tinsert(elements, { text = L.ITEM_EQUIP_LOC[index], para = { frame, key, index, }, });
							end
						end
					end
					ALADROP(self, "BOTTOMRIGHT", explorer_set_drop_meta);
				end
			--
		--
		function NS.ui_CreateExplorer()
			local frame = CreateFrame("FRAME", "ALA_TRADESKILL_EXPLORER", UIParent);
			tinsert(UISpecialFrames, "ALA_TRADESKILL_EXPLORER");

			do
				frame:SetSize(ui_style.explorerWidth, ui_style.explorerHeight);
				frame:SetFrameStrata("HIGH");
				frame:SetPoint("CENTER", 0, 0);
				frame:EnableMouse(true);
				frame:SetMovable(true);
				frame:RegisterForDrag("LeftButton");
				frame:SetScript("OnDragStart", function(self)
					self:StartMoving();
				end);
				frame:SetScript("OnDragStop", function(self)
					self:StopMovingOrSizing();
				end);
				frame:SetScript("OnShow", function(self)
					frame.update_func();
				end);
				frame:Hide();

				function frame.update_func()
					NS.process_explorer_update(frame, true);
				end
				frame.list = {  };
				frame.hash = explorer_hash;
				frame.flag = 'explorer';

				local title = frame:CreateFontString(nil, "ARTWORK");
				title:SetFont(ui_style.frameFont, ui_style.frameFontSize);
				title:SetPoint("TOP", 0, -4);
				title:SetText(L["EXPLORER_TITLE"]);

				local scroll = ALASCR(frame, nil, nil, ui_style.skillListButtonHeight, NS.ui_CreateExplorerSkillListButton, NS.ui_SetExplorerSkillListButton);
				scroll:SetPoint("BOTTOMLEFT", 4, 4);
				scroll:SetPoint("TOPRIGHT", - 4, - 40);
				frame.scroll = scroll;

				local close = CreateFrame("BUTTON", nil, frame);
				close:SetSize(16, 16);
				close:SetNormalTexture("interface\\buttons\\ui-stopbutton");
				close:SetPushedTexture("interface\\buttons\\ui-stopbutton");
				close:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
				close:SetHighlightTexture("interface\\buttons\\ui-stopbutton");
				close:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
				close:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, -4);
				close:SetScript("OnClick", function()
					frame:Hide();
				end);
				frame.close = close;

				NS.ui_ModifyALAScrollFrame(scroll);

				function frame:BlzStyle(blz_style, loading)
					if blz_style then
						NS.ui_BlzBackdrop(self);
						NS.ui_BlzCheckButton(self.searchEditNameOnly);
						self.searchEditNameOnly:SetSize(24, 24);
						NS.ui_BlzScrollFrame(self.scroll);
						local setFrame = self.setFrame;
						NS.ui_BlzBackdrop(setFrame);
						local checkBoxes = setFrame.checkBoxes;
						for index = 1, #checkBoxes do
							local check = checkBoxes[index];
							NS.ui_BlzCheckButton(check);
							check:SetSize(24, 24);
						end
						local dropDowns = setFrame.dropDowns;
						for index = 1, #dropDowns do
							local drop = dropDowns[index];
							NS.ui_BlzALADropButton(drop);
							drop:SetSize(20, 20);
						end
						NS.ui_BlzBackdrop(self.profitFrame);
						NS.ui_BlzScrollFrame(self.profitFrame.scroll);
						-- NS.ui_BlzButton(button, not loading and backup[name] or nil);
					else
						NS.ui_ModernBackdrop(self);
						NS.ui_ModernCheckButton(self.searchEditNameOnly);
						self.searchEditNameOnly:SetSize(14, 14);
						NS.ui_ModernScrollFrame(self.scroll);
						local setFrame = self.setFrame;
						NS.ui_ModernBackdrop(setFrame);
						local checkBoxes = setFrame.checkBoxes;
						for index = 1, #checkBoxes do
							local check = checkBoxes[index];
							NS.ui_ModernCheckButton(check);
							check:SetSize(14, 14);
						end
						local dropDowns = setFrame.dropDowns;
						for index = 1, #dropDowns do
							local drop = dropDowns[index];
							NS.ui_ModernALADropButton(drop);
							drop:SetSize(14, 14);
						end
						NS.ui_ModernBackdrop(self.profitFrame);
						NS.ui_ModernScrollFrame(self.profitFrame.scroll);
						-- NS.ui_ModernButton(button, bak, self.buttonTextureList[_]);
					end
				end

			end

			do	--	search_box
				local searchEdit, searchEditOK, searchEditNameOnly = NS.ui_CreateSearchBox(frame);
				searchEdit:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, - 24);
				searchEdit:SetPoint("RIGHT", searchEditNameOnly, "LEFT", - 4, 0);
				searchEditNameOnly:SetPoint("RIGHT", searchEditOK, "LEFT", - 4, 0);
				searchEditOK:SetPoint("TOPRIGHT", frame, "TOPRIGHT", - 46, - 24);
			end

			do	--	profit_frame
				local profitFrame = CreateFrame("FRAME", nil, frame);
				profitFrame:SetFrameStrata("HIGH");
				profitFrame:EnableMouse(true);
				profitFrame:Hide();
				profitFrame:SetWidth(320);
				profitFrame:SetPoint("TOPLEFT", frame, "TOPRIGHT", 2, 0);
				profitFrame:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 2, 0);
				profitFrame.list = {  };
				profitFrame.flag = 'explorer';
				frame.profitFrame = profitFrame;

				local call = CreateFrame("BUTTON", nil, frame);
				call:SetSize(20, 20);
				call:SetNormalTexture("interface\\buttons\\ui-grouploot-coin-up");
				call:SetPushedTexture("interface\\buttons\\ui-grouploot-coin-down");
				call:SetHighlightTexture("interface\\buttons\\ui-grouploot-coin-highlight");
				call:SetPoint("TOPRIGHT", frame, "TOPRIGHT", - 24, - 24);
				call:SetScript("OnEnter", button_info_OnEnter);
				call:SetScript("OnLeave", button_info_OnLeave);
				call.info_lines = { L["TIP_PROFIT_FRAME_CALL_INFO"] };
				call:SetScript("OnClick", function(self)
					if merc then
						if profitFrame:IsShown() then
							profitFrame:Hide();
							SET.explorer.showProfit = false;
						else
							profitFrame:Show();
							SET.explorer.showProfit = true;
						end
					end
				end);
				profitFrame.call = call;
				frame.profitCall = call;

				profitFrame:SetScript("OnShow", function(self)
					if merc then
						NS.process_profit_update(frame);
						call:SetNormalTexture("interface\\buttons\\ui-grouploot-coin-down");
						call:SetPushedTexture("interface\\buttons\\ui-grouploot-coin-up");
					else
						self:Hide();
					end
				end);
				profitFrame:SetScript("OnHide", function()
					call:SetNormalTexture("interface\\buttons\\ui-grouploot-coin-up");
					call:SetPushedTexture("interface\\buttons\\ui-grouploot-coin-down");
				end);

				local scroll = ALASCR(profitFrame, nil, nil, ui_style.skillListButtonHeight, NS.ui_CreateProfitSkillListButton, NS.ui_SetProfitSkillListButton);
				scroll:SetPoint("BOTTOMLEFT", 4, 4);
				scroll:SetPoint("TOPRIGHT", - 4, - 20);
				profitFrame.scroll = scroll;
				frame.profitScroll = scroll;

				-- local costOnly = CreateFrame("CHECKBUTTON", nil, profitFrame, "OptionsBaseCheckButtonTemplate");
				-- costOnly:SetSize(24, 24);
				-- costOnly:SetHitRectInsets(0, 0, 0, 0);
				-- costOnly:SetPoint("CENTER", profitFrame, "TOPLEFT", 17, -10);
				-- costOnly:Show();
				-- local str = profitFrame:CreateFontString(nil, "ARTWORK");
				-- str:SetFont(ui_style.frameFont, ui_style.frameFontSize, "OUTLINE");
				-- str:SetPoint("LEFT", costOnly, "RIGHT", 2, 0);
				-- str:SetText(L["costOnly"]);
				-- costOnly.fontString = str;
				-- costOnly:SetScript("OnClick", function(self)
				-- 	local checked = self:GetChecked();
				-- 	SET.explorer.costOnly = checked;
				-- 	NS.process_profit_update(frame);
				-- end);
				-- profitFrame.costOnly = costOnly;

				local close = CreateFrame("BUTTON", nil, profitFrame);
				close:SetSize(16, 16);
				close:SetNormalTexture("interface\\buttons\\ui-stopbutton");
				close:SetPushedTexture("interface\\buttons\\ui-stopbutton");
				close:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
				close:SetHighlightTexture("interface\\buttons\\ui-stopbutton");
				close:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
				close:SetPoint("TOPRIGHT", profitFrame, "TOPRIGHT", -4, -2);
				close:SetScript("OnClick", function()
					SET.explorer.showProfit = false;
					profitFrame:Hide();
				end);
				profitFrame.close = close;

				NS.ui_ModifyALAScrollFrame(frame.profitFrame.scroll);
			end

			do	--	set_frame
				local setFrame = CreateFrame("FRAME", nil, frame);
				setFrame:SetFrameStrata("HIGH");
				setFrame:SetHeight(64);
				setFrame:SetPoint("LEFT", frame);
				setFrame:SetPoint("RIGHT", frame);
				setFrame:SetPoint("BOTTOM", frame, "TOP", 0, 2);
				setFrame:Hide();
				frame.setFrame = setFrame;

				local call = CreateFrame("BUTTON", nil, frame);
				call:SetSize(16, 16);
				call:SetNormalTexture(ui_style.texture_config);
				call:SetPushedTexture(ui_style.texture_config);
				call:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
				call:SetHighlightTexture(ui_style.texture_config);
				call:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
				call:SetPoint("TOPRIGHT", frame, "TOPRIGHT", - 4, - 24);
				call:SetScript("OnClick", function(self)
					if setFrame:IsShown() then
						setFrame:Hide();
						SET.explorer.showSet = false;
						self:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					else
						setFrame:Show();
						SET.explorer.showSet = true;
						self:GetNormalTexture():SetVertexColor(0.75, 0.75, 0.75, 1.0);
					end
				end);
				setFrame.call = call;
				frame.setCall = call;

				setFrame:SetScript("OnShow", function(self)
					call:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
				end);
				setFrame:SetScript("OnHide", function(self)
					call:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
				end);

				local checkBoxes = {  };
				local keyTables = { "showUnkown", "showKnown", "showItemInsteadOfSpell", "showRank", };
				for index = 1, #keyTables do
					local key = keyTables[index];
					local check = CreateFrame("CHECKBUTTON", nil, setFrame, "OptionsBaseCheckButtonTemplate");
					check:SetSize(24, 24);
					check:SetHitRectInsets(0, 0, 0, 0);
					check:Show();
					check:SetChecked(false);
					local str = setFrame:CreateFontString(nil, "ARTWORK");
					str:SetFont(ui_style.frameFont, ui_style.frameFontSize, "OUTLINE");
					str:SetText(L[key]);
					check.fontString = str;
					str:SetPoint("LEFT", check, "RIGHT", 0, 0);
					if index % 4 == 1 then
						if index == 1 then
							check:SetPoint("CENTER", setFrame, "TOPLEFT", 16, -12);
						else
							check:SetPoint("CENTER", checkBoxes[index - 3], "CENTER", 0, -24);
						end
					else
						check:SetPoint("CENTER", checkBoxes[index - 1], "CENTER", 94, 0);
					end
					if index <= 2 then
						check:SetScript("OnClick", function(self)
							SET.explorer[key] = self:GetChecked()
							frame.update_func();
						end);
					else
						check:SetScript("OnClick", function(self)
							SET.explorer[key] = self:GetChecked()
							frame.scroll:Update();
						end);
					end
					check.key = key;
					tinsert(checkBoxes, check);
				end
				setFrame.checkBoxes = checkBoxes;

				local dropDowns = {  };
				local keyTables = { "skill", "type", "subType", "eqLoc", };
				for index = 1, #keyTables do
					local key = keyTables[index];
					local drop = CreateFrame("BUTTON", nil, setFrame);
					drop:SetSize(20, 20);
					drop:EnableMouse(true);
					drop:SetNormalTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
					drop:GetNormalTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
					drop:SetPushedTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
					drop:GetPushedTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
					drop:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
					drop:SetHighlightTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
					drop:GetHighlightTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
					drop:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));

					local label = setFrame:CreateFontString(nil, "ARTWORK");
					label:SetFont(ui_style.frameFont, ui_style.frameFontSize, "OUTLINE");
					label:SetText(L.EXPLORER_SET[key]);
					label:SetPoint("LEFT", drop, "RIGHT", 0, 0);
					drop.label = label;

					local cancel = CreateFrame("BUTTON", nil, setFrame);
					cancel:SetSize(16, 16);
					cancel:SetNormalTexture("interface\\buttons\\ui-grouploot-pass-up");
					cancel:SetPushedTexture("interface\\buttons\\ui-grouploot-pass-up");
					cancel:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
					cancel:SetHighlightTexture("interface\\buttons\\ui-grouploot-pass-up");
					cancel:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
					cancel:SetPoint("TOP", drop, "BOTTOM", 0, -1);
					cancel:SetScript("OnClick", function(self)
						local filter = SET.explorer.filter;
						if filter[key] ~= nil then
							filter[key] = nil;
							if key == 'type' then
								filter.subType = nil;
							end
							frame.update_func();
						end
					end);
					cancel.key = key;
					drop.cancel = cancel;

					local str = setFrame:CreateFontString(nil, "ARTWORK");
					str:SetFont(ui_style.frameFont, ui_style.frameFontSize, "OUTLINE");
					str:SetText(L[key]);
					str:SetPoint("LEFT", cancel, "RIGHT", 2, 0);
					str:SetVertexColor(0.0, 1.0, 0.0, 1.0);
					drop.fontString = str;
					if index % 4 == 1 then
						if index == 1 then
							drop:SetPoint("CENTER", checkBoxes[1], "CENTER", 0, -24);
						else
							drop:SetPoint("TOPLEFT", dropDowns[index - 3], "BOTTOMLEFT", 0, 0);
						end
					else
						drop:SetPoint("CENTER", dropDowns[index - 1], "CENTER", 94, 0);
					end
					drop:SetScript("OnClick", NS.ui_explorerSetDrop_OnClick);
					drop.key = key;
					drop.frame = frame;
					tinsert(dropDowns, drop);
				end
				setFrame.dropDowns = dropDowns;

				local phaseSlider = CreateFrame("SLIDER", nil, setFrame, "OptionsSliderTemplate");
				phaseSlider:SetPoint("BOTTOM", setFrame, "TOP", 0, 12);
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
						SET.explorer.phase = value;
						frame.update_func();
					end
					self.Text:SetText("\124cffffff00" .. L["phase"] .. "\124r " .. value);
				end);
				setFrame.phaseSlider = phaseSlider;

				function frame:RefreshSetFrame()
					local set = SET.explorer;
					for index = 1, #checkBoxes do
						local check = checkBoxes[index];
						check:SetChecked(set[check.key]);
					end
					local filter = set.filter;
					if filter.skill == nil then
						dropDowns[1].fontString:SetText("-");
						dropDowns[1].cancel:Hide();
					else
						dropDowns[1].fontString:SetText(L.TRADESKILL_NAME[filter.skill]);
						dropDowns[1].cancel:Show();
					end
					if filter.type == nil then
						dropDowns[2].fontString:SetText("-");
						dropDowns[3].fontString:SetText("-");
						dropDowns[2].cancel:Hide();
						dropDowns[3].cancel:Hide();
					else
						dropDowns[2].fontString:SetText(L.ITEM_TYPE_LIST[filter.type]);
						dropDowns[2].cancel:Show();
						if filter.subType == nil then
							dropDowns[3].fontString:SetText("-");
							dropDowns[3].cancel:Hide();
						else
							dropDowns[3].fontString:SetText(L.ITEM_SUB_TYPE_LIST[filter.type][filter.subType]);
							dropDowns[3].cancel:Show();
						end
					end
					if filter.eqLoc == nil then
						dropDowns[4].fontString:SetText("-");
						dropDowns[4].cancel:Hide();
					else
						dropDowns[4].fontString:SetText(L.ITEM_EQUIP_LOC[filter.eqLoc]);
						dropDowns[4].cancel:Show();
					end
					phaseSlider:SetValue(set.phase);
				end

			end

			ALA_HOOK_ChatEdit_InsertLink(function(link, addon)
				if frame:IsShown() and addon ~= ADDON and not (BrowseName and BrowseName:IsVisible()) then
					local name = GetItemInfo(link);
					if name and name ~= "" then
						frame.searchEdit:SetText(name);
						frame.searchEdit:ClearFocus();
						frame:Search(name);
						return true;
					end
				end
			end);
			ALA_HOOK_ChatEdit_InsertName(function(name, addon)
				if frame:IsShown() and addon ~= ADDON and not (BrowseName and BrowseName:IsVisible()) then
					if name and name ~= "" then
						frame.searchEdit:SetText(name);
						frame.searchEdit:ClearFocus();
						frame:Search(name);
						return true;
					end
				end
			end);

			frame.updatePriceInfoInFrame = _noop_;
			NS.merc_AddFrame(frame);

			return frame;
		end
		--
			local drop_menu_table = {
				handler = _noop_,
				elements = {
					{
						handler = function()
							SET.lock_board = true;
							gui["BOARD"]:lock();
						end,
						para = {  },
						text = L["BOARD_LOCK"],
					},
					{
						handler = function()
							SET.show_board = false;
							gui["BOARD"]:Hide();
						end,
						para = {  },
						text = L["BOARD_CLOSE"],
					},
				},
			};
			local function seconds_to_colored_formatted_time_len(sec)
				local p = max(0.0, 1.0 - sec / 1800);
				local r = 0.0;
				local g = 0.0;
				if p > 0.5 then
					r = (1.0 - p) * 255.0;
					g = 255.0;
				else
					r = 255.0;
					g = p * 255;
				end
				--
				local d = floor(sec / 86400);
				sec = sec % 86400;
				local h = floor(sec / 3600);
				sec = sec % 3600;
				local m = floor(sec / 60);
				sec = sec % 60;
				if d > 0 then
					return format(L["COLORED_FORMATTED_TIME_LEN"][1], r, g, d, h, m, sec);
				elseif h > 0 then
					return format(L["COLORED_FORMATTED_TIME_LEN"][2], r, g, h, m, sec);
				elseif m > 0 then
					return format(L["COLORED_FORMATTED_TIME_LEN"][3], r, g, m, sec);
				else
					return format(L["COLORED_FORMATTED_TIME_LEN"][4], r, g, sec);
				end
			end
			local function calendar_head(sid)			--	tex, coord, title, color
				return NS.db_get_texture_by_pid(NS.db_get_pid_by_sid(sid)), nil, NS.db_spell_name_s(sid), nil;
			end
			local function calendar_Line(sid, GUID)		--	tex, coord, title, color_title, cool, color_cool
				local lClass, class, lRace, race, sex, name = GetPlayerInfoByGUID(GUID);
				local cool;
				do
					local pid = NS.db_get_pid_by_sid(sid);
					if sid == 19566 then
						pid = 3;
					end
					if pid then
						local VAR = AVAR[GUID];
						if VAR then
							local var = rawget(VAR, pid);
							if var then
								local c = var[3];
								if c then
									cool = c[sid];
									if cool then
										if cool > 0 then
											local diff = cool - GetServerTime();
											if diff > 0 then
												cool = seconds_to_colored_formatted_time_len(diff);
											else
												cool = L["COOLDOWN_EXPIRED"];
											end
										else
											cool = L["COOLDOWN_EXPIRED"];
										end
									end
								end
							end
						end
					end
				end
				if cool then
					if name and class then
						return nil, nil, name, RAID_CLASS_COLORS[strupper(class)], cool;
					else
						return nil, nil, GUID, nil, cool;
					end
				else
					if name and class then
						return nil, nil, name, RAID_CLASS_COLORS[strupper(class)];
					else
						return nil, nil, GUID, nil;
					end
				end
			end
			local function update_func()
				local board = gui["BOARD"];
				if board:IsShown() then
					board:Clear();
					for GUID, VAR in next, AVAR do
						local add_label = true;
						for pid = NS.db_min_pid(), NS.db_max_pid() do
							local var = rawget(VAR, pid);
							if var and NS.db_is_pid(pid) then
								local cool = var[3];
								if cool and next(cool) ~= nil then
									if add_label then
										add_label = false;
										local lClass, class, lRace, race, sex, name = GetPlayerInfoByGUID(GUID);
										if name and class then
											local classColorTable = RAID_CLASS_COLORS[strupper(class)];
											name = format(">>\124cff%.2x%.2x%.2x", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. name .. "\124r<<";
											board:AddLine(nil, name);
										else
											board:AddLine(nil, GUID);
										end
									end
									local texture = NS.db_get_texture_by_pid(pid);
									if var.cur_rank and var.max_rank then
										board:AddLine("\124T" .. (texture or ui_style.texture_unk) .. ":12:12:0:0\124t " .. (NS.db_get_pname_by_pid(pid) or ""), nil, var.cur_rank .. " / " .. var.max_rank);
									else
										board:AddLine("\124T" .. (texture or ui_style.texture_unk) .. ":12:12:0:0\124t " .. (NS.db_get_pname_by_pid(pid) or ""));
									end
									for sid, c in next, cool do
										local texture = NS.db_item_icon(NS.db_get_cid_by_sid(sid));
										local sname = "\124T" .. (texture or ui_style.texture_unk) .. ":12:12:0:0\124t " .. NS.db_spell_name_s(sid);
										if c > 0 then
											local diff = c - GetServerTime();
											if diff > 0 then
												board:AddLine(sname, nil, seconds_to_colored_formatted_time_len(diff));
											else
												cool[sid] = -1;
												board:AddLine(sname, nil, L["COOLDOWN_EXPIRED"]);
											end
										else
											board:AddLine(sname, nil, L["COOLDOWN_EXPIRED"]);
										end
									end
								end
							end
						end
					end
					board:Update();
				end
				local cal = __ala_meta__.cal;
				if cal then
					cal.ext_Reset();
					for pid, list in next, NS.cooldown_list do
						if NS.db_is_pid(pid) then
							for index = 1, #list do
								local sid = list[index];
								local add_label = true;
								for GUID, VAR in next, AVAR do
									local var = rawget(VAR, pid);
									if var then
										local cool = var[3];
										if cool and cool[sid[1]] then
											if add_label then
												cal.ext_RegHeader(sid[1], calendar_head);
											end
											cal.ext_AddLine(sid[1], GUID, calendar_Line);
										end
									end
								end
							end
						end
					end
					cal.ext_UpdateBoard();
				end
			end
		--
		function NS.ui_CreateBoard()
			local board = CreateFrame("FRAME", nil, UIParent);
			if LOCALE == 'zhCN' or LOCALE == 'zhTW' or LOCALE == 'koKR' then
				board:SetWidth(260);
			else
				board:SetWidth(320);
			end
			board:SetBackdrop({
				bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
				edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
				tile = true,
				edgeSize = 1,
				tileSize = 5,
			});
			board:SetMovable(true);
			-- board:EnableMouse(true);
			-- board:RegisterForDrag("LeftButton");
			function board:lock()
				self:EnableMouse(false);
				self:SetBackdropColor(0.0, 0.0, 0.0, 0.0);
				self:SetBackdropBorderColor(0.0, 0.0, 0.0, 0.0);
			end
			function board:unlock()
				self:EnableMouse(true);
				self:SetBackdropColor(0.0, 0.0, 0.0, 0.5);
				self:SetBackdropBorderColor(0.0, 0.0, 0.0, 0.5);
			end
			board:SetScript("OnMouseDown", function(self, button)
				if button == "LeftButton" then
					self:StartMoving();
				else
					ALADROP(self, "BOTTOMLEFT", drop_menu_table);
				end
			end);
			board:SetScript("OnMouseUp", function(self, button)
				self:StopMovingOrSizing();
				local pos = { self:GetPoint(), };
				for index = 1, #pos do
					local val = pos[index];
					if type(val) == 'table' then
						pos[index] = val:GetName();
					end
				end
				SET.board_pos = pos;
			end);
			board:SetScript("OnEnter", button_info_OnEnter);
			board:SetScript("OnLeave", button_info_OnLeave);
			function board:AddLine(textL, textM, textR)
				local lines = self.lines;
				local index = self.curLine + 1;
				self.curLine = index;
				local line = lines[index];
				if not line then
					local lineL = self:CreateFontString(nil, "OVERLAY");
					lineL:SetFont(GameFontNormal:GetFont());
					lineL:SetPoint("TOPLEFT", self, "TOPLEFT", 0, - 16 * (index - 1));
					local lineM = self:CreateFontString(nil, "OVERLAY");
					lineM:SetFont(GameFontNormal:GetFont());
					lineM:SetPoint("TOP", self, "TOP", 0, - 16 * (index - 1));
					local lineR = self:CreateFontString(nil, "OVERLAY");
					lineR:SetFont(GameFontNormal:GetFont());
					lineR:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, - 16 * (index - 1));
					line = { lineL, lineM, lineR, };
					lines[index] = line;
				end
				if textL then
					line[1]:Show();
					line[1]:SetText(textL);
				else
					line[1]:Hide();
				end
				if textM then
					line[2]:Show()
					line[2]:SetText(textM);
				else
					line[2]:Hide();
				end
				if textR then
					line[3]:Show()
					line[3]:SetText(textR);
				else
					line[3]:Hide();
				end
			end
			function board:Clear()
				local lines = self.lines;
				for index = 1, self.curLine do
					lines[index][1]:Hide();
					lines[index][2]:Hide();
					lines[index][3]:Hide();
					self:SetHeight(16);
				end
				self.curLine = 0;
			end
			function board:Update()
				self:SetHeight(16 * max(self.curLine, 1));
			end
			board.info_lines = { L["BOARD_TIP"], };
			board.lines = {  };
			board.curLine = 0;
			C_Timer.NewTicker(1.0, update_func);
			if SET.show_board then
				board:Show();
			else
				board:Hide();
			end
			if SET.lock_board then
				board:lock();
			else
				board:unlock();
			end
			if SET.board_pos then
				board:SetPoint(unpack(SET.board_pos));
			else
				board:SetPoint("TOP", 0, -20);
			end
			return board;
		end
		--
			local char_drop_meta_del = {
				text = L.CHAR_DEL,
				para = {  },
			};
			local char_drop_meta = {
				handler = function(_, index)
					NS.func_del_char(index);
				end,
				elements = {
					char_drop_meta_del,
				},
			};
			function NS.ui_configCharListButton_OnClick(self, button)
				local list = SET.char_list;
				local data_index = self:GetDataIndex();
				if data_index <= #list then
					local key = list[data_index];
					if key ~= PLAYER_GUID then
						char_drop_meta_del.para[1] = data_index;
						ALADROP(self, "BOTTOM", char_drop_meta);
					end
				end
			end
			function NS.ui_configCharListButton_OnEnter(self)
				local list = SET.char_list;
				local data_index = self:GetDataIndex();
				if data_index <= #list then
					local key = list[data_index];
					local VAR = AVAR[key];
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
					local lClass, class, lRace, race, sex, name, realm = GetPlayerInfoByGUID(key);
					if name and class then
						class = strupper(class);
						if realm ~= nil and realm ~= "" then
							name = name .. "-" .. realm;
						end
						local classColorTable = RAID_CLASS_COLORS[class];
						if classColorTable then
							GameTooltip:AddLine(name, classColorTable.r, classColorTable.g, classColorTable.b);
						else
							GameTooltip:AddLine(name, 1.0, 1.0, 1.0);
						end
					else
						GameTooltip:AddLine(key, 1.0, 1.0, 1.0);
					end
					local add_blank = true;
					for pid = NS.db_min_pid(), NS.db_max_pid() do
						local var = rawget(VAR, pid);
						if var and NS.db_is_pid(pid) then
							if add_blank then
								GameTooltip:AddLine(" ");
								add_blank = false;
							end
							local right = var.cur_rank;
							if var.max_rank then
								right = (right or "") .. "/" .. var.max_rank;
							end
							if right then
								GameTooltip:AddDoubleLine("    " .. (NS.db_get_pname_by_pid(pid) or pid), right .. "    ", 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
							else
								GameTooltip:AddLine("    " .. (NS.db_get_pname_by_pid(pid) or pid), 1.0, 1.0, 1.0);
							end
						end
					end
					-- if VAR.PLAYER_LEVEL then
					-- 	button.note:SetText(VAR.PLAYER_LEVEL);
					-- else
					-- 	button.note:SetText(nil);
					-- end
					GameTooltip:Show();
				end
			end
			function NS.ui_CreateCharListButton(parent, index, buttonHeight)
				local button = CreateFrame("BUTTON", nil, parent);
				button:SetHeight(buttonHeight);
				button:SetBackdrop(ui_style.listButtonBackdrop);
				button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
				button:SetBackdropBorderColor(unpack(ui_style.listButtonBackdropBorderColor));
				button:SetHighlightTexture(ui_style.texture_white);
				button:GetHighlightTexture():SetVertexColor(unpack(ui_style.listButtonHighlightColor));
				button:EnableMouse(true);
				button:RegisterForClicks("AnyUp");

				local icon = button:CreateTexture(nil, "BORDER");
				icon:SetTexture(ui_style.texture_unk);
				icon:SetSize(buttonHeight - 4, buttonHeight - 4);
				icon:SetPoint("LEFT", 8, 0);
				icon:SetTexture("interface\\targetingframe\\ui-classes-circles");
				button.icon = icon;

				local title = button:CreateFontString(nil, "OVERLAY");
				title:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				title:SetPoint("LEFT", icon, "RIGHT", 4, 0);
				-- title:SetWidth(160);
				title:SetMaxLines(1);
				title:SetJustifyH("LEFT");
				button.title = title;

				local note = button:CreateFontString(nil, "OVERLAY");
				note:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				note:SetPoint("RIGHT", button, "RIGHT", -4, 0);
				-- note:SetWidth(160);
				note:SetMaxLines(1);
				note:SetJustifyH("LEFT");
				note:SetVertexColor(1.0, 0.25, 0.25, 1.0);
				button.note = note;

				button:SetScript("OnClick", NS.ui_configCharListButton_OnClick);
				button:SetScript("OnEnter", NS.ui_configCharListButton_OnEnter);
				button:SetScript("OnLeave", info_OnLeave);

				local frame = parent:GetParent():GetParent();
				button.frame = frame;

				return button;
			end
			function NS.ui_SetCharListButton(button, data_index)
				local list = SET.char_list;
				if data_index <= #list then
					local key = list[data_index];
					local VAR = AVAR[key];
					local lClass, class, lRace, race, sex, name, realm = GetPlayerInfoByGUID(key);
					if name and class then
						class = strupper(class);
						local coord = CLASS_ICON_TCOORDS[class];
						if coord then
							button.icon:Show();
							button.icon:SetTexCoord(coord[1] + 1 / 256, coord[2] - 1 / 256, coord[3] + 1 / 256, coord[4] - 1 / 256);
						else
							button.icon:Show();
						end
						if realm ~= nil and realm ~= "" then
							name = name .. "-" .. realm;
						end
						button.title:SetText(name);
						local classColorTable = RAID_CLASS_COLORS[class];
						if classColorTable then
							button.title:SetVertexColor(classColorTable.r, classColorTable.g, classColorTable.b, 1.0);
						else
							button.title:SetVertexColor(0.75, 0.75, 0.75, 1.0);
						end
					else
						button.icon:Hide();
						button.title:SetText(key);
						button.title:SetVertexColor(0.75, 0.75, 0.75, 1.0);
					end
					if VAR.PLAYER_LEVEL then
						button.note:SetText(VAR.PLAYER_LEVEL);
					else
						button.note:SetText(nil);
					end
					button:Show();
				else
					button:Hide();
				end
			end
			function NS.ui_config_CreateCheck(parent, key, text, OnClick)
				local check = CreateFrame("CHECKBUTTON", nil, parent, "OptionsBaseCheckButtonTemplate");
				check:SetSize(24, 24);
				check:SetHitRectInsets(0, 0, 0, 0);
				check:Show();
				local str = check:CreateFontString(nil, "ARTWORK");
				str:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
				str:SetText(text);
				check.fontString = str;
				str:SetPoint("LEFT", check, "RIGHT", 0, 0);
				check.key = key;
				check:SetScript("OnClick", OnClick);
				function check:SetVal(val)
					self:SetChecked(val);
				end
				check.right = str;
				return check;
			end
			function NS.ui_configDrop_OnClick(self)
				ALADROP(self, "BOTTOM", self.meta);
			end 
			function NS.ui_config_CreateDrop(parent, key, text, meta)
				local drop = CreateFrame("BUTTON", nil, parent);
				drop:SetSize(20, 20);
				drop:EnableMouse(true);
				drop:SetNormalTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
				drop:GetNormalTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
				drop:SetPushedTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
				drop:GetPushedTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
				drop:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
				drop:SetHighlightTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
				drop:GetHighlightTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
				drop:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
				local label = drop:CreateFontString(nil, "ARTWORK");
				label:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
				label:SetText(gsub(text, "%%[a-z]", ""));
				label:SetPoint("LEFT", drop, "RIGHT", 0, 0);
				drop.label = label;
				local str = drop:CreateFontString(nil, "ARTWORK");
				str:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
				str:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 0, -2);
				str:SetVertexColor(0.0, 1.0, 0.0, 1.0);
				drop.fontString = str;
				drop.key = key;
				drop.meta = meta;
				local elements = meta.elements;
				for index = 1, #elements do
					elements[index].para[1] = drop;
				end
				drop:SetScript("OnClick", NS.ui_configDrop_OnClick);
				function drop:SetVal(val)
					local elements = self.meta.elements;
					for index = 1, #elements do
						local element = elements[index];
						if element.para[2] == val then
							self.fontString:SetText(element.text);
							break;
						end
					end
				end
				drop.right = label;
				return drop;
			end
			function NS.ui_config_CreateSlider(parent, key, text, minVal, maxVal, step, OnValueChanged)
				local slider = CreateFrame("SLIDER", nil, parent, "OptionsSliderTemplate");
				local label = slider:CreateFontString(nil, "ARTWORK");
				label:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
				label:SetText(gsub(text, "%%[a-z]", ""));
				slider:SetWidth(200);
				slider:SetHeight(20);
				slider:SetMinMaxValues(minVal, maxVal)
				slider:SetValueStep(step);
				slider:SetObeyStepOnDrag(true);
				slider:SetPoint("LEFT", label, "LEFT", 60, 0);
				slider.Text:ClearAllPoints();
				slider.Text:SetPoint("TOP", slider, "BOTTOM", 0, 3);
				slider.Low:ClearAllPoints();
				slider.Low:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", 4, 3);
				slider.High:ClearAllPoints();
				slider.High:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", -4, 3);
				slider.Low:SetText(minVal);
				slider.High:SetText(maxVal);
				slider.key = key;
				slider.label = label;
				slider:HookScript("OnValueChanged", OnValueChanged);
				function slider:SetVal(val)
					self:SetValue(val);
				end
				function slider:SetStr(str)
					self.Text:SetText(str);
				end
				slider._SetPoint = slider.SetPoint;
				function slider:SetPoint(...)
					self.label:SetPoint(...);
				end
				slider.right = slider;
				return slider;
			end
			function NS.ui_config_CreateColor4(parent, key, text, OnColor)
				local button = CreateFrame("BUTTON", nil, parent);
				button:SetSize(20, 20);
				button:EnableMouse(true);
				button:SetNormalTexture(ui_style.texture_color_select);
				button:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
				button:SetPushedTexture(ui_style.texture_color_select);
				button:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
				button:SetHighlightTexture(ui_style.texture_color_select);
				button:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
				local valStr = button:CreateTexture(nil, "OVERLAY");
				valStr:SetAllPoints(true);
				local left = button:CreateFontString(nil, "ARTWORK");
				left:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
				left:SetText(">>");
				left:SetPoint("RIGHT", button, "LEFT", -2, 0);
				local label = button:CreateFontString(nil, "ARTWORK");
				label:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
				label:SetText("<<" .. gsub(text, "%%[a-z]", ""));
				label:SetPoint("LEFT", button, "RIGHT", 2, 0);
				button.label = label;
				button.key = key;
				button.valStr = valStr;
				local bakup = nil;
				button.func = function()
					local r, g, b = ColorPickerFrame:GetColorRGB();
					local a = 1.0 - OpacitySliderFrame:GetValue();
					OnColor(r, g, b, a);
					-- ColorPickerFrame.Alpha.bg:SetVertexColor(r, g, b);
				end
				button.opacityFunc = function()
					local r, g, b = ColorPickerFrame:GetColorRGB();
					local a = 1.0 - OpacitySliderFrame:GetValue();
					OnColor(r, g, b, a);
				end
				button.cancelFunc = function()
					if bakup then
						OnColor(unpack(bakup));
						bakup = nil;
					end
				end
				button:SetScript("OnClick", function(self)
					bakup = SET[self.key];
					-- ColorPickerFrame.Alpha:Show();
					ColorPickerFrame.func = button.func;
					ColorPickerFrame.hasOpacity = true;
					ColorPickerFrame.opacityFunc = button.opacityFunc;
					ColorPickerFrame.opacity = 1.0 - bakup[4];
					-- ColorPickerFrame.previousValues = { r = bakup[1], g = bakup[2], b = bakup[3], opacity = bakup[4], };
					ColorPickerFrame.cancelFunc = button.cancelFunc;
					ColorPickerFrame:ClearAllPoints();
					ColorPickerFrame:SetPoint("TOPLEFT", button, "BOTTOMRIGHT", 12, 12);
					ColorPickerFrame:SetColorRGB(unpack(bakup));
					ShowUIPanel(ColorPickerFrame);
				end);
				function button:SetVal(val)
					valStr:SetColorTexture(val[1], val[2], val[3], val[4] or 1.0);
				end
				button.right = label;
				return button;
			end
		--
		function NS.ui_CreateConfigFrame()
			local frame = CreateFrame("FRAME", "ALA_TRADESKILL_CONFIG", UIParent);
			tinsert(UISpecialFrames, "ALA_TRADESKILL_CONFIG");
			frame:SetBackdrop(ui_style.frameBackdrop);
			frame:SetBackdropColor(unpack(ui_style.frameBackdropColor));
			frame:SetBackdropBorderColor(unpack(ui_style.frameBackdropBorderColor));
			frame:SetSize(450, 250);
			frame:SetFrameStrata("DIALOG");
			frame:SetPoint("CENTER");
			frame:EnableMouse(true);
			frame:SetMovable(true);
			frame:RegisterForDrag("LeftButton");
			frame:SetScript("OnDragStart", function(self)
				self:StartMoving();
			end);
			frame:SetScript("OnDragStop", function(self)
				self:StopMovingOrSizing();
			end);
			frame:Hide();
			--
			local close = CreateFrame("BUTTON", nil, frame);
			close:SetSize(20, 20);
			close:SetNormalTexture("interface\\buttons\\ui-stopbutton");
			close:SetPushedTexture("interface\\buttons\\ui-stopbutton");
			close:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
			close:SetHighlightTexture("interface\\buttons\\ui-stopbutton");
			close:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
			close:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -2);
			close:SetScript("OnClick", function()
				frame:Hide();
			end);
			close:SetScript("OnEnter", info_OnEnter);
			close:SetScript("OnLeave", info_OnLeave);
			close.info_lines = { L.CLOSE, };
			close.frame = frame;
			frame.close = close;
			--
			local set_objects = {  };
			local px, py, h = 0, 0, 1;
			local set_cmd_list = NS.set_cmd_list;
			for index = 1, #set_cmd_list do
				local cmd = set_cmd_list[index];
				if px >= 1 then
					px = 0;
					py = py + h;
					h = 1;
				end
				local key = cmd[3];
				if cmd[1] == 'bool' then
					local check = NS.ui_config_CreateCheck(frame, key, L.SLASH_NOTE[key], cmd[8]);
					check:SetPoint("TOPLEFT", frame, "TOPLEFT", 10 + 150 * px, -25 - 25 * py);
					set_objects[key] = check;
					px = px + 1;
					h = max(h, 1);
				elseif cmd[7] == 'drop' then
					local drop = NS.ui_config_CreateDrop(frame, key, L.SLASH_NOTE[key], cmd[8]);
					drop:SetPoint("TOPLEFT", frame, "TOPLEFT", 10 + 150 * px, -25 - 25 * py);
					set_objects[key] = drop;
					px = px + 1;
					h = max(h, 2);
				elseif cmd[7] == 'slider' then
					if px > 2 then
						px = 0;
						py = py + h;
						h = 1;
					end
					local slider = NS.ui_config_CreateSlider(frame, key, L.SLASH_NOTE[key], cmd[9][1], cmd[9][2], cmd[9][3], cmd[8]);
					slider:SetPoint("TOPLEFT", frame, "TOPLEFT", 10 + 150 * px, -25 - 25 * py);
					set_objects[key] = slider;
					px = px + 2;
					h = max(h, 2);
				end
				local extra_list = cmd[10];
				if extra_list then
					local father = set_objects[key];
					local children_key = {  };
					father.children_key = children_key;
					for val, extra in next, extra_list do
						local exkey = extra[3];
						children_key[exkey] = val;
						if extra[7] == 'bool' then
							local check = NS.ui_config_CreateCheck(frame, exkey, L.SLASH_NOTE[exkey], extra[8]);
							check:SetPoint("LEFT", father.right, "RIGHT", 20, 0);
							set_objects[exkey] = check;
						elseif extra[7] == 'drop' then
							local drop = NS.ui_config_CreateDrop(frame, exkey, L.SLASH_NOTE[exkey], extra[8]);
							drop:SetPoint("LEFT", father.right, "RIGHT", 20, 0);
							set_objects[exkey] = drop;
						elseif extra[7] == 'slider' then
							local slider = NS.ui_config_CreateSlider(frame, exkey, L.SLASH_NOTE[exkey], extra[9][1], extra[9][2], extra[9][3], extra[8]);
							slider:SetPoint("LEFT", father.right, "RIGHT", 20, 0);
							set_objects[exkey] = slider;
						elseif extra[7] == 'color4' then
							local color4 = NS.ui_config_CreateColor4(frame, exkey, L.SLASH_NOTE[exkey], extra[8]);
							color4:SetPoint("LEFT", father.right, "RIGHT", 40, 0);
							set_objects[exkey] = color4;
						end
					end
				end
			end
			frame.set_objects = set_objects;
			if px ~= 0 then
				px = 0;
				py = py + h;
				h = 1;
			end
			do	--	character list
				local char_list = CreateFrame("FRAME", nil, frame);
				char_list:SetBackdrop(ui_style.frameBackdrop);
				char_list:SetBackdropColor(unpack(ui_style.frameBackdropColor));
				char_list:SetBackdropBorderColor(unpack(ui_style.frameBackdropBorderColor));
				char_list:SetSize(240, 400);
				char_list:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 2, 0);
				char_list:EnableMouse(true);
				char_list:SetMovable(false);
				-- char_list:RegisterForDrag("LeftButton");
				-- char_list:SetScript("OnDragStart", function(self)
				-- 	self:GetParent():StartMoving();
				-- end);
				-- char_list:SetScript("OnDragStop", function(self)
				-- 	self:GetParent():StopMovingOrSizing();
				-- end);
				char_list:Hide();

				local scroll = ALASCR(char_list, nil, nil, ui_style.charListButtonHeight, NS.ui_CreateCharListButton, NS.ui_SetCharListButton);
				scroll:SetPoint("BOTTOMLEFT", 4, 12);
				scroll:SetPoint("TOPRIGHT", - 4, - 24);
				char_list.scroll = scroll;
				scroll:SetNumValue(#SET.char_list);

				char_list:SetScript("OnShow", function(self)
					gui["CONFIG"].call_char_list:Texture(true);
				end);
				char_list:SetScript("OnHide", function(self)
					gui["CONFIG"].call_char_list:Texture(false);
				end);
				frame.char_list = char_list;

				local call = CreateFrame("BUTTON", nil, frame);
				call:SetSize(20, 20);
				call:SetNormalTexture(ui_style.texture_triangle);
				call:GetNormalTexture():SetVertexColor(0.5, 0.5, 0.5, 1.0);
				call:GetNormalTexture():SetBlendMode("ADD");
				call:SetPushedTexture(ui_style.texture_triangle);
				call:GetPushedTexture():SetVertexColor(0.25, 0.25, 0.25, 1.0);
				call:GetPushedTexture():SetBlendMode("ADD");
				call:SetHighlightTexture(ui_style.texture_triangle);
				call:GetHighlightTexture():SetAlpha(0.25);
				call:SetPoint("TOPLEFT", 420, -25 - 25 * py);
				function call:Texture(bool)
					if bool then
						self:GetNormalTexture():SetTexCoord(1.0, 0.0, 0.0, 1.0);
						self:GetPushedTexture():SetTexCoord(1.0, 0.0, 0.0, 1.0);
						self:GetHighlightTexture():SetTexCoord(1.0, 0.0, 0.0, 1.0);
					else
						self:GetNormalTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
						self:GetPushedTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
						self:GetHighlightTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					end
				end
				call:Texture(false);
				call.char_list = char_list;
				call:SetScript("OnClick", function(self)
					local char_list = self.char_list;
					if char_list:IsShown() then
						char_list:Hide();
					else
						char_list:Show();
					end
				end);
				frame.call_char_list = call;
				local str = call:CreateFontString(nil, "OVERLAY");
				str:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
				str:SetPoint("RIGHT", call, "LEFT", -2, 0);
				str:SetVertexColor(1.0, 1.0, 1.0, 1.0);
				str:SetText(L.CHAR_LIST);
				call.fontString = str;
				function char_list:update_func()
					self.scroll:SetNumValue(#SET.char_list);
					self.scroll:Update();
				end
			end
			function frame:Refresh()
				for key, obj in next, set_objects do
					obj:SetVal(SET[key]);
					local children_key = obj.children_key;
					if children_key then
						for exkey, val in next, children_key do
							local obj2 = set_objects[exkey];
							if obj2 then
								if SET[key] == val then
									obj2:Show();
								else
									obj2:Hide();
								end
							end
						end
					end
				end
			end
			function frame:update_func()
				-- self:Refresh();
				self.char_list:update_func();
			end
			frame:SetScript("OnShow", function(self)
				self:Refresh();
			end);
			frame:SetHeight(25 + py * 25 + 25);
			return frame;
		end
	end

	do	--	supreme craft
			function NS.ui_supremeListButton_OnEnter(self)
				local frame = self.frame;
				local sid = self.list[self:GetDataIndex()];
				if type(sid) == 'table' then
					sid = sid[1];
				end
				-- local pid = NS.db_get_pid_by_pname(frame.pname());
				local pid = self.flag or NS.db_get_pid_by_sid(sid);
				if pid then
					local set = SET[pid];
					mouse_focus_sid = sid;
					mouse_focus_phase = set.phase;
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
					local info = NS.db_get_info_by_sid(sid);
					if info then
						if set.showItemInsteadOfSpell and info[index_cid] then
							GameTooltip:SetItemByID(info[index_cid]);
						else
							GameTooltip:SetSpellByID(sid);
						end
						local phase = info[index_phase];
						if phase > curPhase then
							GameTooltip:AddLine("\124cffff0000" .. L["available_in_phase_"] .. phase .. "\124r");
						end
						GameTooltip:Show();
					else
						GameTooltip:SetSpellByID(sid);
					end
					local text = NS.db_get_difficulty_rank_list_text_by_sid(sid);
					if text then
						GameTooltip:AddDoubleLine(L["LABEL_RANK_LEVEL"], text);
						GameTooltip:Show();
					end
					local data = frame.hash[sid];
					if pid == 'explorer' then
						local hash = explorer_hash[sid];
						if hash then
							local str = L["RECIPE_LEARNED"] .. ": ";
							local index = 0;
							for GUID, _ in next, hash do
								if index ~= 0 and index % 3 == 0 then
									str = str .. "\n        ";
								end
								local lClass, class, lRace, race, sex, name = GetPlayerInfoByGUID(GUID);
								if name and class then
									local classColorTable = RAID_CLASS_COLORS[strupper(class)];
									name = format("\124cff%.2x%.2x%.2x", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. name .. "\124r";
									str = str .. " " .. name;
								else
									str = str .. " " .. GUID;
								end
								index = index + 1;
							end
							GameTooltip:AddLine(str);
							GameTooltip:Show();
						else
						end
						data = data and data[PLAYER_GUID];
					end
					if not data then
						NS.ui_set_tooltip_mtsl(sid);
					end
				end
			end
			function NS.ui_supremeListButton_OnLeave(self)
				mouse_focus_sid = nil;
				button_info_OnLeave(self);
			end
			function NS.ui_supremeListButton_OnClick(self, button)
				local frame = self.frame;
				local sid = self.list[self:GetDataIndex()];
				if type(sid) == 'table' then
					sid = sid[1];
				end
				local data = frame.hash[sid];
				if button == "LeftButton" then
					if IsShiftKeyDown() then
						local cid = NS.db_get_cid_by_sid(sid);
						if cid then
							ChatEdit_InsertLink(NS.db_item_link(cid), ADDON);
						else
							ChatEdit_InsertLink(NS.enchant_link(sid), ADDON);
						end
					elseif IsAltKeyDown() then
						local text1 = nil;
						local text2 = nil;
						if data then
							local n = frame.reagent_num(data);
							if n and n > 0 then
								local m1, m2 = frame.recipe_num_made(data);
								if m1 == m2 then
									text1 = frame.recipe_link(data) .. "x" .. m1 .. L["PRINT_MATERIALS: "];
								else
									text1 = frame.recipe_link(data) .. "x" .. m1 .. "-" .. m2 .. L["PRINT_MATERIALS: "];
								end
								text2 = "";
								if n > 4 then
									for i = 1, n do
										text2 = text2 .. frame.reagent_info(data, i) .. "x" .. select(3, frame.reagent_info(data, i));
									end
								else
									for i = 1, n do
										text2 = text2 .. frame.reagent_link(data, i) .. "x" .. select(3, frame.reagent_info(data, i));
									end
								end
							end
						else
							local info = NS.db_get_info_by_sid(sid);
							local cid = info[index_cid];
							if info then
								if cid then
									text1 = NS.db_item_link_s(cid) .. "x" .. (info[index_num_made_min] == info[index_num_made_max] and info[index_num_made_min] or (info[index_num_made_min] .. "-" .. info[index_num_made_max])) .. L["PRINT_MATERIALS: "];
								else
									text1 = NS.db_spell_name_s(sid) .. L["PRINT_MATERIALS: "];
								end
								text2 = "";
								local rinfo = info[index_reagents_id];
								if #rinfo > 4 then
									for i = 1, #rinfo do
										text2 = text2 .. NS.db_item_name_s(rinfo[i]) .. "x" .. info[index_reagents_count][i];
									end
								else
									for i = 1, #rinfo do
										text2 = text2 .. NS.db_item_link_s(rinfo[i]) .. "x" .. info[index_reagents_count][i];
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
						local cid = NS.db_get_cid_by_sid(sid);
						if cid then
							local link = NS.db_item_link(cid);
							if link then
								DressUpItemLink(link);
							end
						end
					else
						if data and type(data) == 'number' then
							frame.select_func(data);
							frame.hooked_frame.numAvailable = select(3, frame.recipe_info(data));
							frame.selected_sid = sid;
							frame.update_func();
							frame.searchEdit:ClearFocus();
							local scroll = frame.hooked_scrollBar;
							local num = frame.recipe_num();
							local minVal, maxVal = scroll:GetMinMaxValues();
							local step = scroll:GetValueStep();
							local cur = scroll:GetValue() + step;
							local value = step * (data - 1);
							if value < cur or value > (cur + num * step - maxVal) then
								scroll:SetValue(min(maxVal, value));
							end
							frame.scroll:Update();
							if frame.profitFrame:IsShown() then
								frame.profitScroll:Update();
							end
						end
					end
				elseif button == "RightButton" then
					frame.searchEdit:ClearFocus();
					local pid = NS.db_get_pid_by_sid(sid);
					if FAV[sid] then
						list_drop_sub_fav.para[1] = frame;
						list_drop_sub_fav.para[2] = pid;
						list_drop_sub_fav.para[3] = sid;
						list_drop_meta.elements[1] = list_drop_sub_fav;
					else
						list_drop_add_fav.para[1] = frame;
						list_drop_add_fav.para[2] = pid;
						list_drop_add_fav.para[3] = sid;
						list_drop_meta.elements[1] = list_drop_add_fav;
					end
					list_drop_query_who_can_craft_it.para[1] = frame;
					list_drop_query_who_can_craft_it.para[2] = pid;
					list_drop_query_who_can_craft_it.para[3] = sid;
					ALADROP(self, "BOTTOMLEFT", list_drop_meta);
				end
			end
			function NS.ui_CreateSupremeListButton(parent, index, buttonHeight)
				local frame = parent:GetParent():GetParent();

				local button = CreateFrame("BUTTON", nil, parent);
				button:SetHeight(buttonHeight);
				button:SetBackdrop(ui_style.listButtonBackdrop);
				button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
				button:SetBackdropBorderColor(unpack(ui_style.listButtonBackdropBorderColor));
				button:SetHighlightTexture(ui_style.texture_white);
				button:GetHighlightTexture():SetVertexColor(unpack(ui_style.listButtonHighlightColor));
				button:EnableMouse(true);
				button:Show();

				local del = CreateFrame("BUTTON", nil, button);
				del:SetSize(buttonHeight / 2, buttonHeight / 2);
				del:SetPoint("LEFT", 4, 0);
				NS.ui_ModernButton(del, nil, ui_style.texture_modern_button_close);
				del:SetScript("OnClick", frame.del);
				button.del = del;

				local icon = button:CreateTexture(nil, "BORDER");
				icon:SetTexture(ui_style.texture_unk);
				icon:SetSize(buttonHeight - 8, buttonHeight - 8);
				icon:SetPoint("LEFT", del, "RIGHT", 8, 0);
				button.icon = icon;

				local title = button:CreateFontString(nil, "OVERLAY");
				title:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				title:SetPoint("LEFT", icon, "RIGHT", 4, 0);
				-- title:SetWidth(160);
				title:SetMaxLines(1);
				title:SetJustifyH("LEFT");
				title:SetPoint("LEFT", icon, "RIGHT", 8, 0);
				button.title = title;

				local num = CreateFrame("EDITBOX", nil, button);
				num:SetHeight(16);
				num:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				num:SetAutoFocus(false);
				num:SetJustifyH("LEFT");
				num:Show();
				num:EnableMouse(true);
				num:ClearFocus();
				num:SetPoint("LEFT", title, "RIGHT", 48, 0);
				local numBG = num:CreateTexture(nil, "ARTWORK");
				numBG:SetPoint("TOPLEFT");
				numBG:SetPoint("BOTTOMRIGHT");
				numBG:SetTexture("Interface\\Buttons\\greyscaleramp64");
				numBG:SetTexCoord(0.0, 0.25, 0.0, 0.25);
				numBG:SetAlpha(0.75);
				numBG:SetBlendMode("ADD");
				numBG:SetVertexColor(0.25, 0.25, 0.25);
				num.BG = numBG;
				num:SetScript("OnEditFocusGained", function(self) self.BG:Show(); end);
				num:SetScript("OnEditFocusLost", function(self) self.BG:Hide(); end);
				num:SetScript("OnEnterPressed", function(self) self:ClearFocus(); end);
				num:SetScript("OnEscapePressed", function(self) self:ClearFocus(); end);
				button.num = num;
				
				local up = CreateFrame("BUTTON", nil, button);
				up:SetSize(buttonHeight / 2 - 3, buttonHeight / 2 - 3);
				up:SetPoint("TOPRIGHT", -4, -2);
				NS.ui_ModernButton(up, nil, ui_style.texture_modern_arrow_up);
				up:SetScript("OnClick", frame.change_order_up);
				button.up = up;

				local down = CreateFrame("BUTTON", nil, button);
				down:SetSize(buttonHeight / 2 - 3, buttonHeight / 2 - 3);
				down:SetPoint("BOTTOMRIGHT", -4, 2);
				NS.ui_ModernButton(down, nil, ui_style.texture_modern_arrow_down);
				down:SetScript("OnClick", frame.change_order_down);
				button.down = down;

				local quality_glow = button:CreateTexture(nil, "ARTWORK");
				quality_glow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border");
				quality_glow:SetBlendMode("ADD");
				quality_glow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
				quality_glow:SetSize(buttonHeight - 2, buttonHeight - 2);
				quality_glow:SetPoint("CENTER", icon);
				-- quality_glow:SetAlpha(0.75);
				quality_glow:Show();
				button.quality_glow = quality_glow;

				button:SetScript("OnEnter", NS.ui_supremeListButton_OnEnter);
				button:SetScript("OnLeave", NS.ui_supremeListButton_OnLeave);
				button:RegisterForClicks("AnyUp");
				button:SetScript("OnClick", NS.ui_supremeListButton_OnClick);
				button:RegisterForDrag("LeftButton");
				button:SetScript("OnHide", ALADROP);

				button.frame = frame;

				return button;
			end
			function NS.ui_SetSupremeListButton(button, data_index)
				local frame = button.frame;
				local list = frame.list;
				local hash = frame.hash;
				if data_index <= #list then
					local pid = NS.db_get_pid_by_pname(frame.pname());
					if pid then
						local set = SET[pid];
						local sid = list[data_index];
						local cid = NS.db_get_cid_by_sid(sid);
						local data = hash[sid];
						if data then
							local name, rank, num = frame.recipe_info(data);
							if name and rank ~= 'header' then
								button:Show();
								button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
								local quality = cid and NS.db_item_rarity(cid);
								button.icon:SetTexture(frame.recipe_icon(data));
								button.icon:SetVertexColor(1.0, 1.0, 1.0, 1.0);
								if num > 0 then
									button.title:SetText(name .. " [" .. num .. "]");
								else
									button.title:SetText(name);
								end
								button.title:SetTextColor(unpack(rank_color[rank_index[rank]] or ui_style.color_white));
								if set.showRank then
									button.note:SetText(NS.db_get_difficulty_rank_list_text_by_sid(sid));
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
								if FAV[sid] then
									button.star:Show();
								else
									button.star:Hide();
								end
								if sid == frame.selected_sid then
									button:Select();
								else
									button:Deselect();
								end
							else
								button:Hide();
							end
						else
							button:Show();
							if SET.colored_rank_for_unknown then
								button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Disabled));
							else
								button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
							end
							local _, quality, icon;
							if cid then
								_, _, quality, _, icon = NS.db_item_info(cid);
							else
								quality = nil;
								icon = ICON_FOR_NO_CID;
							end
							button.icon:SetTexture(icon);
							button.icon:SetVertexColor(1.0, 0.0, 0.0, 1.0);
							button.title:SetText(NS.db_spell_name_s(sid));
							if SET.colored_rank_for_unknown then
								local var = rawget(VAR, pid);
								button.title:SetTextColor(unpack(rank_color[NS.db_get_difficulty_rank_by_sid(sid, var and var.cur_rank or 0)] or ui_style.color_white));
							else
								button.title:SetTextColor(1.0, 0.0, 0.0, 1.0);
							end
							if set.showRank then
								button.note:SetText(NS.db_get_difficulty_rank_list_text_by_sid(sid));
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
							if FAV[sid] then
								button.star:Show();
							else
								button.star:Hide();
							end
							button:Deselect();
						end
						if GetMouseFocus() == button then
							NS.ui_skillListButton_OnEnter(button);
						end
						if button.prev_sid ~= sid then
							ALADROP(button);
							button.prev_sid = sid;
						end
					else
						ALADROP(button);
						button:Hide();
					end
				else
					ALADROP(button);
					button:Hide();
				end
			end
		function NS.ui_CreateSupreme(hooked_frame)
			local supreme = CreateFrame("FRAME", nil, hooked_frame);
			--	supreme
				supreme:SetFrameStrata("HIGH");
				supreme:EnableMouse(true);
				supreme:SetSize(256, 256);
				function supreme.update_func()
					supreme.scroll:SetNumValue(#list);
					supreme.scroll:Update();
				end
				function supreme.del(button)
					local index = button:GetDataIndex();
				end
				function supreme.set_num(edit)
					local index = edit:GetParent():GetDataIndex();
				end
				function supreme.change_order_up(button)
					local index = button:GetDataIndex();
				end
				function supreme.change_order_down(button)
					local index = button:GetDataIndex();
				end
				supreme:SetScript("OnShow", function(self)
				end);
				supreme:SetScript("OnHide", function(self)
				end);
				supreme.list = SET.supreme_list;
				supreme.hooked_frame = hooked_frame;
				supreme.frame = hooked_frame.frame;
				hooked_frame.supreme = supreme;

				local scroll = ALASCR(supreme, nil, nil, ui_style.supremeListButtonHeight, NS.ui_CreateSupremeListButton, NS.ui_SetSupremeListButton);
				scroll:SetPoint("BOTTOMLEFT", 4, 0);
				scroll:SetPoint("TOPRIGHT", - 4, - 28);
				NS.ui_ModifyALAScrollFrame(scroll);
				supreme.scroll = scroll;

				local call = CreateFrame("BUTTON", nil, hooked_frame, "UIPanelButtonTemplate");
				call:SetSize(18, 18);
				call:SetPoint("LEFT", hooked_frame, "RIGHT", - 2, 0);
				call:SetFrameLevel(127);
				call:SetScript("OnClick", function(self)
					if supreme:IsShown() then
						supreme:Hide();
						call:SetText(L["Open"]);
						SET.show_supreme = false;
					else
						supreme:Show();
						call:SetText(L["Close"]);
						SET.show_supreme = true;
						supreme.update_func();
					end
				end);
				-- call:SetScript("OnEnter", Info_OnEnter);
				-- call:SetScript("OnLeave", Info_OnLeave);
				supreme.call = call;
			--
			return supreme;
		end
	end

	do	-- 	tooltip
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
		local space_table = setmetatable({}, {
			__index = function(t, k)
				local str = "\124cff000000" .. strrep("*", 2 * k) .. "\124r";
				t[k] = str;
				return str;
			end,
		});
		--	return price, cost, cost_known, missing, cid
		function NS.price_gen_info_by_sid(phase, sid, num, lines, stack_level, is_enchanting, ...)	--	merc not checked
			local info = NS.db_get_info_by_sid(sid);
			if info then
				num = num or 1;
				stack_level = stack_level or 0;
				local cid = info[index_cid];
				local cost = nil;
				local cost_known = 0;
				local missing = 0;
				local detail_lines = lines and {  };
				if stack_level == 0 then
					phase = max(info[index_phase], phase);
				end
				if stack_level <= 4 then
					local pid = info[index_pid];
					if info[index_phase] <= phase then
						local reagid = info[index_reagents_id];
						local reagnum = info[index_reagents_count];
						cost = 0;
						for i = 1, #reagid do
							local iid = reagid[i];
							local num = reagnum[i];
							local p, c = nil, nil;
							local got = false;
							if not recipe_black_list_cid[iid] then
								if iid == cid then
									got = true;
									c = 0;
								else
									for index = 1, select("#", ...) do
										if iid == select(index, ...) then
											got = true;
											break;
										end
									end
								end
								if got then
									got = false;
								else
									local nsids, sids = NS.db_get_sid_by_cid(iid);
									if nsids > 0 then
										for index = 1, #sids do
											local sid = sids[index];
											if NS.db_get_pid_by_sid(sid) == pid then
												local p2, c2 = NS.price_gen_info_by_sid(phase, sid, num, detail_lines, stack_level + 1, nil, cid, ...);
												p = p or p2;
												if c2 then
													if c and c > c2 or not c then
														c = c2;
													end
												end
												got = true;
											end
										end
									end
								end
							end
							if not got then
								local name = merc.query_name_by_id(iid) or NS.db_item_name_s(iid);
								local quality = merc.query_quality_by_id(iid) or NS.db_item_rarity(iid);
								if quality then
									local _, _, _, code = GetItemQualityColor(quality);
									name = "\124c" .. code .. name .. "\124r";
								end
								if iid ~= cid then
									p = merc.query_ah_price_by_id(iid);
									local v = merc.get_material_vendor_price_by_id(iid);
									if v then
										if p == nil or p > v then
											p = v;
										end
									end
									if p then
										p = p * num;
										if detail_lines then
											tinsert(detail_lines, space_table[stack_level + 1] .. name .. "x" .. num);
											tinsert(detail_lines, merc.MoneyString(p));
										end
									else
										if detail_lines then
											local bindType = NS.db_item_bindType(iid);
											if bindType == 1 or bindType == 4 then
												tinsert(detail_lines, space_table[stack_level + 1] .. name .. "x" .. num);
												tinsert(detail_lines, L["BOP"]);
											else
												tinsert(detail_lines, space_table[stack_level + 1] .. name .. "x" .. num);
												tinsert(detail_lines, L["UNKOWN_PRICE"]);
											end
										end
									end
								else
									if detail_lines then
										tinsert(detail_lines, space_table[stack_level + 1] .. name .. "x" .. num);
										tinsert(detail_lines, "-");
									end
								end
							end
							if not p and not c then
								cost = nil;
								if stack_level > 0 then
									break;
								end
								missing = missing + 1;
							else
								if p then
									if c and p > c then
										p = c;
									end
								else
									p = c;
								end
								if cost then
									cost = cost + p;
								end
								cost_known = cost_known + p;
							end
						end
					end
				end
				local vendorPrice = cid and merc.get_material_vendor_price_by_id(cid);
				local price = cid and merc.query_ah_price_by_id(cid);
				if vendorPrice then
					if price == nil or vendorPrice < price then
						price = vendorPrice;
					end
				end
				price = price and price * num;
				local nMade = (info[index_num_made_min] + info[index_num_made_max]) / 2;
				cost = cost and cost * num / nMade;
				cost_known = cost_known and cost_known * num / nMade;
				local name = cid and (merc.query_name_by_id(cid) or NS.db_item_name_s(cid));
				local quality = cid and (merc.query_quality_by_id(cid) or NS.db_item_rarity(cid));
				if quality then
					local _, _, _, code = GetItemQualityColor(quality);
					name = name and ("\124c" .. code .. name .. "\124r") or "";
				else
					name = name or "";
				end
				if stack_level == 0 then
					if lines then
						for index = 1, #detail_lines do
							tinsert(lines, detail_lines[index]);
						end
						if is_enchanting then
							if cost then
								tinsert(lines, "\124cffff7f00**\124r" .. "\124cffffffff" .. NS.db_spell_name_s(sid) .. "\124r" or L["COST_PRICE"]);
								tinsert(lines, L["COST_PRICE"] .. merc.MoneyString(cost));
							else
								tinsert(lines, "\124cffff7f00**\124r" .. "\124cffffffff" .. NS.db_spell_name_s(sid) .. "\124r" or L["COST_PRICE"]);
								tinsert(lines, L["COST_PRICE_KNOWN"] .. merc.MoneyString(cost_known));
							end
						else
							if cost then
								tinsert(lines, "\124cffff7f00**\124r" .. name .. "x" .. num);
								tinsert(lines, L["COST_PRICE"] .. merc.MoneyString(cost));
							else
								tinsert(lines, "\124cffff7f00**\124r" .. name .. "x" .. num);
								tinsert(lines, L["COST_PRICE_KNOWN"] .. merc.MoneyString(cost_known));
							end
							if price then
								tinsert(lines, "\124cff00ff00**\124r" .. name .. "x" .. num);
								tinsert(lines, L["AH_PRICE"] .. merc.MoneyString(price));
							end
							if cost and price then
								local diff = price - cost;
								if diff > 0 then
									tinsert(lines, "\124cff00ff00**\124r" .. L["PRICE_DIFF+"]);
									tinsert(lines, L["PRICE_DIFF_INFO+"] .. merc.MoneyString(diff));
								elseif diff < 0 then
									tinsert(lines, "\124cffff0000**\124r" .. L["PRICE_DIFF-"]);
									tinsert(lines, L["PRICE_DIFF_INFO-"] .. merc.MoneyString(-diff));
								end
							end
						end
					end
				else
					if price and (not cost or cost >= price) then
						if lines then
							tinsert(lines, space_table[stack_level] .. name .. "x" .. num);
							tinsert(lines, merc.MoneyString(price));
						end
					elseif cost and (not price or cost < price) then
						if lines then
							tinsert(lines, space_table[stack_level] .. name .. "x" .. num);
							tinsert(lines, merc.MoneyString(cost));
							for index = 1, #detail_lines do
								tinsert(lines, detail_lines[index]);
							end
						end
						price = nil;
					else
						if lines then
							local bindType = NS.db_item_bindType(cid);
							if bindType == 1 or bindType == 4 then
								tinsert(lines, space_table[stack_level] .. name .. "x" .. num);
								tinsert(lines, L["BOP"]);
							else
								tinsert(lines, space_table[stack_level] .. name .. "x" .. num);
								tinsert(lines, L["UNKOWN_PRICE"]);
							end
						end
					end
				end
				return price, cost, cost_known, missing, cid;
			end
		end
		local function set_tip_by_sid(tip, sid)
			local info = NS.db_get_info_by_sid(sid);
			if info then
				tip:AddLine(L["CRAFT_INFO"]);
				local cid = info[index_cid];
				local pid = info[index_pid];
				local texture = NS.db_get_texture_by_pid(pid);
				local rank = info[index_learn_rank];
				local name = NS.db_get_pname_by_pid(pid);
				if texture then
					name = "\124T" .. texture .. ":12:12:0:0\124t " .. name;
				end
				if rank then
					name = name .. "(" .. rank .. ")";
				end
				tip:AddLine("\124cff00afff" .. name .. "\124r");
				local detail_lines = {  };
				NS.price_gen_info_by_sid(mouse_focus_sid == sid and mouse_focus_phase or curPhase, sid, (info[index_num_made_min] + info[index_num_made_max]) / 2, detail_lines, 0, cid == nil);
				if #detail_lines > 0 then
					for i = 1, #detail_lines, 2 do
						tip:AddDoubleLine(detail_lines[i], detail_lines[i + 1]);
					end
					tip:Show();
				end
			end
		end
		local function set_tip_by_cid(tip, cid)
			local nsids, sids = NS.db_get_sid_by_cid(cid);
			if nsids > 0 then
				tip:AddLine(L["CRAFT_INFO"]);
				for index = 1, #sids do
					local sid = sids[index];
					local info = NS.db_get_info_by_sid(sid);
					if info then
						local pid = info[index_pid];
						local texture = NS.db_get_texture_by_pid(pid);
						local rank = info[index_learn_rank];
						local name = NS.db_get_pname_by_pid(pid) or "";
						if texture then
							name = "\124T" .. texture .. ":12:12:0:0\124t " .. name;
						end
						if rank then
							name = name .. "(" .. rank .. ")";
						end
						tip:AddLine("\124cff00afff" .. name .. "\124r");
						local detail_lines = {  };
						NS.price_gen_info_by_sid(mouse_focus_sid == sid and mouse_focus_phase or curPhase, sid, (info[index_num_made_min] + info[index_num_made_max]) / 2, detail_lines, 0, false);
						if #detail_lines > 0 then
							for i = 1, #detail_lines, 2 do
								tip:AddDoubleLine(detail_lines[i], detail_lines[i + 1]);
							end
						end
					end
				end
				tip:Show();
			end
		end
		local function add_account_recipe_learned_info(tip, rid, sid)
			sid = sid or NS.db_get_sid_by_rid(rid);
			if sid then
				local info = NS.db_get_info_by_sid(sid);
				if info then
					local pid = info[index_pid];
					local add_head = true;
					local learn_rank = info[index_learn_rank];
					for GUID, VAR in next, AVAR do
						-- if PLAYER_GUID ~= GUID then
							local var = rawget(VAR, pid);
							if var then
								if add_head then
									tip:AddLine(L["LABEL_ACCOUT_RECIPE_LEARNED"]);
									add_head = false;
								end
								local lClass, class, lRace, race, sex, name = GetPlayerInfoByGUID(GUID);
								if name and class then
									local classColorTable = RAID_CLASS_COLORS[strupper(class)];
									name = format("\124cff%.2x%.2x%.2x", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. name .. "\124r";
								else
									name = GUID;
								end
								if var[2][sid] then
									name = space_table[1] .. L["RECIPE_LEARNED"] .. "  " .. name .. "  \124cffffffff" .. var.cur_rank .. "/" .. var.max_rank .. "\124r";
								else
									name = space_table[1] .. L["RECIPE_NOT_LEARNED"] .. "  " .. name
												.. ((var.cur_rank >= learn_rank) and "  \124cff00ff00" or "  \124cffff0000") .. var.cur_rank
												.. ((var.max_rank >= learn_rank) and "\124r\124cffffffff/\124r\124cff00ff00" or "\124r\124cffffffff/\124r\124cffff0000") .. var.max_rank .. "\124r";
									-- if var.cur_rank >= learn_rank then
									-- 	name = space_table[1] .. L["RECIPE_NOT_LEARNED"] .. "  " .. name .. "  \124cff00ff00" .. var.cur_rank .. "\124r\124cffffffff/" .. var.max_rank .. "\124r";
									-- else
									-- 	name = space_table[1] .. L["RECIPE_NOT_LEARNED"] .. "  " .. name .. "  \124cffff0000" .. var.cur_rank .. "\124r\124cffffffff/" .. var.max_rank .. "\124r";
									-- end
								end
								tip:AddLine(name);
							end
						-- end
					end
					tip:Show();
				end
			end
		end
		local function add_material_craft_info(tip, iid)
			local data = NS.db_get_sid_by_reagent(iid);
			if data then
				local not_show_all = not IsShiftKeyDown();
				tip:AddLine(L["LABEL_USED_AS_MATERIAL_IN"]);
				local lineL = nil;
				local lineR = nil;
				local nLines = 0;
				local sids, nums = data[1], data[2];
				for index = 1, #sids do
					local sid = sids[index];
					local num = nums[index];
					if not_show_all and nLines >= 8 then
						tip:AddLine(space_table[1] .. "\124cffff0000...\124r");
						break;
					end
					local info = NS.db_get_info_by_sid(sid);
					if info then
						local cid = info[index_cid];
						if cid then
							lineL = space_table[1] .. NS.db_item_string_s(cid) .. "x" .. num;
							lineR = "\124cff00afff" .. NS.db_get_pname_by_pid(info[index_pid]) .. info[index_learn_rank] .. "\124r";
						else
							lineL = space_table[1] .. NS.db_spell_string_s(sid) .. "x" .. num;
							lineR = "\124cff00afff" .. NS.db_get_pname_by_pid(info[index_pid]) .. info[index_learn_rank] .. "\124r";
						end
						tip:AddDoubleLine(lineL, lineR);
						nLines = nLines + 1;
					end
				end
				tip:Show();
			end
		end
		function NS.tooltip_Hyperlink(tip, link)
			local _, sid = tip:GetSpell();
			if sid then
				NS.tooltip_SpellByID(tip, sid);
				return;
			end
			if link then
				local cid = tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
				if cid then
					NS.tooltip_ItemByID(tip, cid);
				end
			end
		end
		function NS.tooltip_SpellByID(tip, sid)
			if merc then
				if SET.show_tradeskill_tip_craft_spell_price then
					if sid and NS.db_is_tradeskill_sid(sid) then
						set_tip_by_sid(tip, sid);
					end
				end
			end
		end
		function NS.tooltip_ItemByID(tip, iid)
			if SET.show_tradeskill_tip_recipe_account_learned then
				add_account_recipe_learned_info(tip, iid);
			end
			if SET.show_tradeskill_tip_material_craft_info then
				add_material_craft_info(tip, iid);
			end
			if merc then
				if SET.show_tradeskill_tip_craft_item_price then
					if iid and NS.db_is_tradeskill_cid(iid) then
						set_tip_by_cid(tip, iid);
					end
				end
				if SET.show_tradeskill_tip_recipe_price then
					local sid = NS.db_get_sid_by_rid(iid);
					if sid then
						set_tip_by_sid(tip, sid);
					end
				end
			end
		end
		function NS.tooltip_GUISpell(tip)
			local _, sid = tip:GetSpell();
			if sid then
				NS.tooltip_SpellByID(tip, sid);
			end
		end
		function NS.tooltip_GUIItem(tip)
			local _, link = tip:GetItem();
			if link then
				local iid = tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
				if iid then
					NS.tooltip_ItemByID(tip, iid);
				end
			end
		end
		function NS.tooltip_CraftSpell(tip)
			local _, sid = tip:GetSpell();
			if sid then
				NS.tooltip_SpellByID(tip, sid);
			else
				local _, link = tip:GetItem();
				local iid = link and tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
				if iid then
					NS.tooltip_ItemByID(tip, iid);
				end
			end
		end
		function NS.hook_tooltip()
			hooksecurefunc(GameTooltip, "SetHyperlink", NS.tooltip_Hyperlink);
			hooksecurefunc(ItemRefTooltip, "SetHyperlink", NS.tooltip_Hyperlink);
			hooksecurefunc(GameTooltip, "SetSpellByID", NS.tooltip_SpellByID);
			hooksecurefunc(ItemRefTooltip, "SetSpellByID", NS.tooltip_SpellByID);
			hooksecurefunc(GameTooltip, "SetItemByID", NS.tooltip_ItemByID);
			hooksecurefunc(ItemRefTooltip, "SetItemByID", NS.tooltip_ItemByID);
			hooksecurefunc(GameTooltip, "SetCraftSpell", NS.tooltip_CraftSpell);
			hooksecurefunc(ItemRefTooltip, "SetCraftSpell", NS.tooltip_CraftSpell);
			hooksecurefunc(GameTooltip, "SetMerchantItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetBuybackItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetBagItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetAuctionItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetAuctionSellItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetLootItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetLootRollItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetInventoryItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetTradePlayerItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetTradeTargetItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetQuestItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetQuestLogItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetInboxItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetSendMailItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetTradeSkillItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetCraftItem", function(tip, recipe_index, reagent_index)
				local link = GetCraftReagentItemLink(recipe_index, reagent_index);
				if link then
					local iid = tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
					if iid then
						NS.tooltip_ItemByID(tip, iid);
					end
				end
			end);
			hooksecurefunc(GameTooltip, "SetTrainerService", NS.tooltip_GUIItem);
		end
		--	mtsl
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
		local MTSL_LOCALE = mtsl_locale_list[LOCALE] or mtsl_locale_list.def;
		local tooltip_set_quest;
		local tooltip_set_item;
		local tooltip_set_object;
		local tooltip_set_npc;
		local function add_reputation_line(reputation)
			local line = nil;
			local fid = reputation.faction_id;
			for _, fv in next, MTSL_DATA["factions"] do
				if fv.id == fid then
					local name = fv.name[MTSL_LOCALE];
					if name then
						line = "\124cffff7f00" .. name .. "\124r";
					end
					break;
				end
			end
			line = line or "factionID: " .. fid;
			local lid = reputation.level_id;
			for _, lv in next, MTSL_DATA["reputation_levels"] do
				if lv.id == lid then
					local name = lv.name[MTSL_LOCALE];
					if name then
						line = line .. format("\124cff%.2xff00", min(255, max(0, 64 * (8 - lid) - 1))) .. name .. "\124r";
					end
					break;
				end
			end
			GameTooltip:AddDoubleLine(" ", line);
			GameTooltip:Show();
		end
		local npc_prefix = {	--	== "Alliance"
			[true] = {
				Alliance = ": \124Tinterface\\timer\\Alliance-logo:20\124t\124cff00ff00",
				Horde = ": \124Tinterface\\timer\\Horde-logo:20\124t\124cffff0000",
				Neutral = ": \124cffffff00",
				Hostile = ": \124cffff0000",
				["*"] = ": \124cffffffff",
			},
			[false] = {
				Alliance = ": \124Tinterface\\timer\\Alliance-logo:20\124t\124cffff0000",
				Horde = ": \124Tinterface\\timer\\Horde-logo:20\124t\124cff00ff00",
				Neutral = ": \124cffffff00",
				Hostile = ": \124cffff0000",
				["*"] = ": \124cffffffff",
			},
		};
		tooltip_set_npc = function(pid, nid, label, alliance_green, prefix, suffix, stack_size)
			if stack_size < 8 then
				if MTSL_DATA then
					local npcs = MTSL_DATA["npcs"];
					if npcs then
						local got_one_data = false;
						for _, nv in next, npcs do
							if nv.id == nid then
								got_one_data = true;
								local colorTable = npc_prefix[alliance_green];
								local line = prefix .. (colorTable[nv.reacts] or colorTable["*"]);
								local name = nv.name[MTSL_LOCALE];
								if name then
									line = line .. name;
								else
									line = line .. "npcID: " .. nid;
								end
								local xp_level = nv.xp_level;
								if xp_level then
									if xp_level.min ~= xp_level.max then
										line = line .. "Lv" .. xp_level.min .. "-" .. xp_level.max;
									else
										line = line .. "Lv" .. xp_level.min;
									end
									if xp_level.is_elite > 0 then
										line = line .. L["elite"];
									end
								end
								line = line .. " [" .. C_Map.GetAreaInfo(nv.zone_id);
								local location = nv.location;
								if location and location.x ~= "-" and location.y ~= "-" then
									line = line .. " " .. location.x .. ", " .. location.y .. "]";
								else
									line = line .. "]";
								end
								local phase = nv.phase;
								if phase and phase > curPhase then
									line = line .. " " .. L["phase"] .. phase;
								end
								GameTooltip:AddDoubleLine(label, line);
								local special_action = nv.special_action;
								if special_action then
									local sav = MTSL_DATA["special_actions"][special_action];
									if sav and sav.name then
										local sa = sav.name[MTSL_LOCALE];
										if sa then
											GameTooltip:AddDoubleLine(" ", sa);
										end
									end
								end
								line = line .. suffix;
								break;
							end
						end
						if not got_one_data then
							GameTooltip:AddDoubleLine(" ", L["sold_by"] .. ": \124cffff0000unknown\124r, npcID: " .. nid);
						end
						GameTooltip:Show();
					end
				end
			end
		end
		tooltip_set_quest = function(pid, qid, label, stack_size)
			if stack_size <= 8 then
				if MTSL_DATA then
					local quests = MTSL_DATA["quests"];
					if quests then
						local got_one_data = false;
						for _, qv in next, quests do
							if qv.id == qid then
								got_one_data = true;
								local line = "[";
								local name = qv.name[MTSL_LOCALE];
								if name then
									line = line .. qv.name[MTSL_LOCALE] .. "]";
								else
									line = line .. "\124cffffff00" .. L["quest"] .. "\124r ID: " .. qid .. "]";
								end
								local min_xp_level = qv.min_xp_level;
								if min_xp_level then
									line = line .. "Lv" .. min_xp_level;
								end
								local phase = qv.phase;
								if phase and phase > curPhase then
									line = line .. " " .. L["phase"] .. phase;
								end
								GameTooltip:AddDoubleLine(label, L["quest_reward"] .. ": \124cffffff00" .. line .. "\124r");
								if qv.npcs then
									for _, nid in next, qv.npcs do
										tooltip_set_npc(pid, nid, " ", UnitFactionGroup('player') == "Alliance", L["quest_accepted_from"], "\124r", stack_size + 1);
									end
								end
								if qv.items then
									for _, iid in next, qv.items do
										tooltip_set_item(pid, iid, " ", stack_size + 1);
									end
								end
								if qv.objects then
									for _, oid in next, qv.objects do
										tooltip_set_object(pid, oid, " ", stack_size + 1);
									end
								end
								if qv.reputation then
									add_reputation_line(qv.reputation);
								end
								local special_action = qv.special_action;
								if special_action then
									local sav = MTSL_DATA["special_actions"][special_action];
									if sav and sav.name then
										local sa = sav.name[MTSL_LOCALE];
										if sa then
											GameTooltip:AddDoubleLine(" ", "\124cffffffff" .. sa .. "\124r");
										end
									end
								end
								break;
							end
						end
						if not got_one_data then
							GameTooltip:AddDoubleLine(label, "\124cffffff00" .. L["quest"] .. "\124r ID: " .. qid);
						end
					end
					GameTooltip:Show();
				end
			end
		end
		tooltip_set_item = function(pid, iid, label, stack_size)
			if stack_size <= 8 then
				local _, line, _, _, _, _, _, _, bind = NS.db_item_info(iid);
				if not line then
					line = "\124cffffffff" .. L["item"] .. "\124r ID: " .. iid;
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
				GameTooltip:AddDoubleLine(label, line);
				if MTSL_DATA then
					local pname = NS.db_get_mtsl_pname(pid);
					local data = MTSL_DATA["items"][pname];
					if data then
						for i, iv in next, data do
							if iv.id == iid then
								local vendors = iv.vendors;
								if vendors then
									for _, nid in next, vendors.sources do
										tooltip_set_npc(pid, nid, " ", UnitFactionGroup('player') == "Alliance", L["sold_by"], "\124r", stack_size + 1);
									end
								end
								local drops = iv.drops;
								if drops then
									if drops.sources then
										for _, nid in next, drops.sources do
											tooltip_set_npc(pid, nid, " ", UnitFactionGroup('player') ~= "Alliance", L["dropped_by"], "\124r", stack_size + 1);
										end
									end
									local range = drops.range;
									if range then
										if range.min_xp_level and range.max_xp_level then
											local line = range.min_xp_level .. "-" .. range.max_xp_level;
											GameTooltip:AddDoubleLine(" ", L["world_drop"] .. ": \124cffff0000" .. L["dropped_by_mod_level"] .. line .. "\124r");
										else
											GameTooltip:AddDoubleLine(" ", L["world_drop"]);
										end
									end
								end
								if iv.quests then
									for _, qid in next, iv.quests do
										tooltip_set_quest(pid, qid, " ", stack_size + 1);
									end
								end
								if iv.objects then
									for _, oid in next, iv.objects do
										tooltip_set_object(pid, oid, " ", stack_size + 1);
									end
								end
								if iv.reputation then
									add_reputation_line(iv.reputation);
								end
								local line2 = nil;
								local holiday = iv.holiday;
								if holiday then
									for _, hv in next, MTSL_DATA["holidays"] do
										if hv.id == holiday then
											local h = hv.name[MTSL_LOCALE];
											if h then
												-- GameTooltip:AddDoubleLine(" ", h);
												line2 = "\124cff00ffff" .. h .. "\124r";
											end
											break;
										end
									end
								end
								local special_action = iv.special_action;
								if special_action then
									local sav = MTSL_DATA["special_actions"][special_action];
									if sav and sav.name then
										local sa = sav.name[MTSL_LOCALE];
										if sa then
											-- GameTooltip:AddDoubleLine(" ", sa);
											if line2 then
												line2 = line2 .. "\124cffffffff" .. sa .. "\124r";
											else
												line2 = "\124cffffffff" .. sa .. "\124r";
											end
										end
									end
								end
								if line2 then
									GameTooltip:AddDoubleLine(" ", line2);
								end
								break;
							end
						end
					end
				end
				GameTooltip:Show();
			end
		end
		tooltip_set_object = function(pid, oid, label, stack_size)
			if stack_size <= 8 then
				if MTSL_DATA then
					local objects = MTSL_DATA["objects"];
					if objects then
						local got_one_data = false;
						for _, ov in next, objects do
							if ov.id == oid then
								got_one_data = true;
								local line = ov.name[MTSL_LOCALE] or ("\124cffffffff" .. L["object"] .. "\124r ID: " .. oid);
								line = line .. " [" .. C_Map.GetAreaInfo(ov.zone_id);
								local location = ov.location;
								if location and location.x ~= "-" and location.y ~= "-" then
									line = line .. " " .. location.x .. ", " .. location.y .. "]";
								else
									line = line .. "]";
								end
								local phase = ov.phase;
								if phase and phase > curPhase then
									line = line .. " " .. L["phase"] .. phase;
								end
								GameTooltip:AddDoubleLine(label, L["object"] .. ": \124cffffffff" .. line .. "\124r");
								local special_action = ov.special_action;
								if special_action then
									local sav = MTSL_DATA["special_actions"][special_action];
									if sav and sav.name then
										local sa = sav.name[MTSL_LOCALE];
										if sa then
											GameTooltip:AddDoubleLine(" ", "\124cffffffff" .. sa .. "\124r");
										end
									end
								end
								break;
							end
						end
						if not got_one_data then
							GameTooltip:AddDoubleLine(label, "\124cffffffff" .. L["object"] .. "\124r ID: " .. oid);
						end
						GameTooltip:Show();
					end
				end
			end
		end
		function NS.ui_set_tooltip_mtsl(sid)
			local info = NS.db_get_info_by_sid(sid);
			if info then
				if info[index_trainer] then			-- trainer
					GameTooltip:AddDoubleLine(L["LABEL_GET_FROM"], "\124cffff00ff" .. L["trainer"] .. "\124r");
					GameTooltip:Show();
				end
				if info[index_rid] then					-- recipe
					tooltip_set_item(info[index_pid], info[index_rid], L["LABEL_GET_FROM"], 1)
				end
				if info[index_quest] then			-- quests
					for _, qid in next, info[index_quest] do
						tooltip_set_quest(info[index_pid], qid, L["LABEL_GET_FROM"], 1);
					end
				end
				if info[index_object] then			-- objects
					if type(info[index_object]) == 'table' then
						for _, oid in next, info[index_object] do
							tooltip_set_object(info[index_pid], oid, L["LABEL_GET_FROM"], 1);
						end
					else
						tooltip_set_object(info[index_pid], info[index_object], L["LABEL_GET_FROM"], 1);
					end
				end
				--
				if MTSL_DATA then
					local pname = NS.db_get_mtsl_pname(info[index_pid]);
					local data = MTSL_DATA["skills"][pname];
					if data then
						for _, sv in next, data do
							if sv.id == sid then
								local specialisation = sv.specialisation;
								if specialisation then
									local stable = MTSL_DATA["specialisations"][pname];
									if stable then
										for _, spv in next, stable do
											if spv.id == specialisation then
												GameTooltip:AddDoubleLine(" ", "\124cffffffff" .. spv.name[MTSL_LOCALE] .. "\124r");
												GameTooltip:Show();
											end
										end
									end
								end
								local reputation = sv.reputation;
								if reputation then
									add_reputation_line(reputation);
								end
								break;
							end
						end
					end
				end
			end
		end
	end

	do	--	check cooldown
		NS.cooldown_list = {
			[3] = {
				{ 19566, 250, },	--	筛盐器
			},
			[4] = {
				-- { 17563, },	--	死灵化水	--	17562	点水成气	17561	转土成水	17565	生命归土	17560	点火成土
				{ 17187, },	--	转化：奥金
			},
			[8] = {
				{ 18560, },	--	月布
			},
		};
		for pid, list in next, NS.cooldown_list do
			for index = 1, #list do
				local data = list[index];
				data[2] = NS.db_get_learn_rank_by_sid(data[1]) or data[2];
			end
		end
		local GetSpellModifiedCooldown = __ala_meta__.GetSpellModifiedCooldown;
		function NS.cooldown_check(pid, var)
			local list = NS.cooldown_list[pid];
			if list then
				local cool = var[3];
				if cool then
					wipe(cool);
				else
					cool = {  };
					var[3] = cool;
				end
				for index = 1, #list do
					local data = list[index];
					local sid = data[1];
					if var.cur_rank >= data[2] then
						local cooling, start, duration = GetSpellModifiedCooldown(sid);
						if cooling then
							cool[sid] = GetServerTime() + duration + start - GetTime();
						else
							cool[sid] = -1;
						end
					else
						cool[sid] = nil;
					end
				end
			end
		end
		function NS.BAG_UPDATE_COOLDOWN(...)
			for pid = NS.db_min_pid(), NS.db_max_pid() do
				local var = rawget(VAR, pid);
				if var and NS.db_is_pid(pid) then
					NS.cooldown_check(pid, var);
				end
			end
		end
	end

	do	--	COMMUNICATION
		local ADDON_PREFIX = "ALATSK";
		local ADDON_MSG_CONTROL_CODE_LEN = 6;
		local ADDON_MSG_SKILL_BROADCAST = "_b_skl";
		local ADDON_MSG_QUERY_SKILL = "_q_skl";
		local ADDON_MSG_REPLY_SKILL = "_r_skl";
		local ADDON_MSG_QUERY_RECIPE = "_q_rcp";
		local ADDON_MSG_REPLY_RECIPE = "_r_rcp";
		local ADDON_MSG_QUERY_SKILL_RECIPES = "_q_src";
		local ADDON_MSG_REPLY_SKILL_RECIPES = "_r_src";
		local ADDON_MSG_BROADCAST_BEGIN = "_p_beg";
		local ADDON_MSG_BROADCAST_BODY = "_p_bod";
		local ADDON_MSG_BROADCAST_END = "_p_end";
		--------------------------------------------------
		local queue_guild_msg = {  };
		local queue_whisper_msg = {  };
		local queried_sid = setmetatable({  }, {
			__index = function(t, k)
				local temp = setmetatable({  }, {
					__index = function(t1, k1)
						local temp1 = {  };
						t[k1] = temp1;
						return temp1;
					end,
					__call = function(t1, k1)
						local temp1 = rawget(t1, k1);
						if temp1 then
							wipe(temp1);
						else
							temp1 = t1[k1];
						end
						return temp1;
					end
				});
				t[k] = temp;
				return temp;
			end,
			__call = function(t, k)
				local temp = rawget(t, k);
				if temp then
					wipe(temp);
				else
					temp = t[k];
				end
				return temp;
			end
		});
		local function skill_msg(header)	--	head#pid:cur:max
			local msg = header;
			local valid = false;
			for pid = NS.db_min_pid(), NS.db_max_pid() do
				local var = rawget(VAR, pid);
				if var and NS.db_is_pid(pid) then
					if var.cur_rank and var.max_rank then
						msg = msg .. "#" .. PLAYER_GUID .. "#" .. pid .. ":" .. var.cur_rank .. ":" .. var.max_rank;
						valid = true;
					end
				end
			end
			return valid, msg;
		end
		local function skill_broadcast()
			if IsInGuild() then
				local valid, msg = skill_msg(ADDON_MSG_REPLY_SKILL);
				if valid then
					SendAddonMessage(ADDON_PREFIX, msg, "GUILD");
				end
			end
		end
		local function get_ColoredName(GUID)
			local lClass, class, lRace, race, sex, name = GetPlayerInfoByGUID(GUID);
			if name and class then
				local classColorTable = RAID_CLASS_COLORS[strupper(class)];
				return format("\124cff%.2x%.2x%.2x", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. name .. "\124r";
			end
		end
		local function get_PlayerLink(GUID)
			local lClass, class, lRace, race, sex, name = GetPlayerInfoByGUID(GUID);
			if name and class then
				local classColorTable = RAID_CLASS_COLORS[strupper(class)];
				return "\124Hplayer:" .. name .. ":0:WHISPER\124h" .. 
							format("\124cff%.2x%.2x%.2x[", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. name .. "]\124r"
							.. "\124h";
			end
		end
		function NS.CHAT_MSG_ADDON(prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID)
			if prefix == ADDON_PREFIX then
				local name, realm = strsplit("-", sender);
				if name and (realm == nil or realm == "" or realm == PLAYER_REALM_NAME) then
					local control_code = strsub(msg, 1, ADDON_MSG_CONTROL_CODE_LEN);
					local body = strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 2, - 1);
					if body == "" then
						return;
					end
					--[[if control_code == ADDON_MSG_QUERY_SKILL then
						local valid, msg = skill_msg(ADDON_MSG_REPLY_SKILL);
						if valid then
							SendAddonMessage(ADDON_PREFIX, msg, "WHISPER", sender);
						end
					else--]]if control_code == ADDON_MSG_SKILL_BROADCAST or control_code == ADDON_MSG_REPLY_SKILL then
						local _, _, GUID, val = strfind(body, "^([^#^:]+)#(.+)$");
						if GUID then
							local cmm = CMM[GUID];
							if cmm == nil then
								cmm = {  };
								CMM[GUID] = cmm;
							end
							local data = { strsplit("#", val) };
							for index = 1, #data do
								local skill = data[index];
								local _, _, pid, cur_rank, max_rank = strfind(skill, "^(%d+):([0-9%-]+):([0-9%-]+)$");
								if pid then
									pid = tonumber(pid);
									cur_rank = tonumber(cur_rank);
									max_rank = tonumber(max_rank);
									cmm[pid] = { cur_rank, max_rank, };
								end
							end
						end
					elseif control_code == ADDON_MSG_QUERY_RECIPE then
						if name ~= PLAYER_NAME then
							local sid = tonumber(body);
							if sid then
								local pid = NS.db_get_pid_by_sid(sid);
								if pid then
									local reply = PLAYER_GUID;
									local found = false;
									for GUID, VAR in next, AVAR do
										local var = rawget(VAR, pid);
										if var and var[2] and var[2][sid] then
											reply = reply .. "#" .. GUID;
											found = true;
										end
									end
									if found then
										SendAddonMessage(ADDON_PREFIX, ADDON_MSG_REPLY_RECIPE .. "#" .. sid .. "#" .. reply, "WHISPER", sender);
									end
								end
							end
						end
					elseif control_code == ADDON_MSG_REPLY_RECIPE then
						local _, _, sid, rGUID, val = strfind(body, "^([0-9]+)#([^#]+)#(.+)$");
						if sid then
							sid = tonumber(sid);
							if sid and NS.db_is_tradeskill_sid(sid) then
								local cid = NS.db_get_cid_by_sid(sid);
								local result = queried_sid[sid](rGUID);
								local data = { strsplit("#", val) };
								local output = get_PlayerLink(rGUID);
								local ok = output ~= nil;
								output = output ~= nil and (output .. ":");
								for index = 1, #data do
									local mGUID = data[index];
									result[mGUID] = true;
									-- print(rGUID, mGUID, GetPlayerInfoByGUID(mGUID));
									if ok then
										local name = get_ColoredName(mGUID);
										if name ~= nil then
											output = output .. " " .. name;
										else
											ok = false;
										end
									end
								end
								if ok then
									local link = cid and (NS.db_item_link_s(cid)) or NS.enchant_link(sid);
									if link then
										print(link, output);
									end
								end
							end
						end
					elseif control_code == ADDON_MSG_QUERY_SKILL_RECIPES then
					elseif control_code == ADDON_MSG_REPLY_SKILL_RECIPES then
					elseif control_code == ADDON_MSG_BROADCAST_BEGIN then
					elseif control_code == ADDON_MSG_BROADCAST_BODY then
					elseif control_code == ADDON_MSG_BROADCAST_END then
					end
				end
			end
		end
		NS.CHAT_MSG_ADDON_LOGGED = NS.CHAT_MSG_ADDON;
		function NS.cmm_Query_sid(sid)
			local t = GetServerTime();
			if IsInGuild() then
				SendAddonMessage(ADDON_PREFIX, ADDON_MSG_QUERY_RECIPE .. "#" .. sid, "GUILD");
			end
		end
		function NS.cmm_Broadcast(pid, list, channel, target)
			tinsert(queue_guild_msg, ADDON_MSG_BROADCAST_BEGIN .. "#" .. pid .. "#" .. #list);
			local msg = ADDON_MSG_BROADCAST_BODY .. "#".. pid;
			for index = 1, #list do
				msg = msg .. "#" .. list[index];
				if index % 40 == 0 then
					tinsert(queue_guild_msg, msg);
					msg = ADDON_MSG_BROADCAST_BODY .. "#" .. pid;
				end
			end
			--	#msg <= 250
			tinsert(queue_guild_msg, ADDON_MSG_BROADCAST_END .. "#" .. pid);
		end
		function NS.cmm_InitAddonMessage()
			if RegisterAddonMessagePrefix(ADDON_PREFIX) then
				_EventHandler:RegEvent("CHAT_MSG_ADDON");
				_EventHandler:RegEvent("CHAT_MSG_ADDON_LOGGED");
				do
					-- C_Timer.NewTicker(0.1, function()
					-- 	if IsInGuild() then
					-- 		local work = tremove(queue_guild_msg, 1);
					-- 		if work then
					-- 			SendAddonMessage(ADDON_PREFIX, work, "GUILD");
					-- 		end
					-- 	end
					-- end);
					-- C_Timer.NewTicker(0.02, function()
					-- 	if IsInGuild() then
					-- 		local work = tremove(queue_whisper_msg, 1);
					-- 		if work then
					-- 			SendAddonMessage(ADDON_PREFIX, work[1], "GUILD", work[2]);
					-- 		end
					-- 	end
					-- end);
					C_Timer.NewTicker(60.0, skill_broadcast);
				end
			else
				_error_("RegisterAddonMessagePrefix", ADDON_PREFIX);
			end
		end
	end

	function NS.USER_EVENT_SPELL_DATA_LOADED()
		NS.SKILL_LINES_CHANGED();
	end
	function NS.USER_EVENT_ITEM_DATA_LOADED()
	end
	function NS.USER_EVENT_RECIPE_LIST_UPDATE()
		NS.ui_update_all();
	end

	do	--	ElvUI
		function NS.ElvUI_Blizzard_TradeSkillUI()
			local t = gui.Blizzard_TradeSkillUI;
			if t and ElvUI and ElvUI[1] then
				local S = ElvUI[1]:GetModule('Skins');
				if S then
					if t.call then
						S:HandleButton(t.call);
						-- if t.profitFrame and t.profitFrame.costOnly then
							-- S:HandleCheckBox(t.profitFrame.costOnly);
						-- end
						NS.ElvUI_Blizzard_TradeSkillUI = _noop_;
					end
				end
			end
		end
		function NS.ElvUI_Blizzard_CraftUI()
			local c = gui.Blizzard_CraftUI;
			if c and ElvUI and ElvUI[1] then
				local S = ElvUI[1]:GetModule('Skins');
				if S then
					if c.call then
						S:HandleButton(c.call);
						-- if c.profitFrame and c.profitFrame.costOnly then
						-- 	S:HandleCheckBox(c.profitFrame.costOnly);
						-- end
						NS.ElvUI_Blizzard_CraftUI = _noop_;
					end
				end
			end
		end
		function NS.ElvUI()
			NS.ElvUI_Blizzard_TradeSkillUI();
			NS.ElvUI_Blizzard_CraftUI();
		end
	end

	do	--	CloudyTradeSkill
		function NS.CloudyTradeSkill_Blizzard_TradeSkillUI()
			C_Timer.After(1.0, function()
				local t = gui.Blizzard_TradeSkillUI;
				local opt = _G["CTSOption-TradeSkillFrame"];
				if t and opt and t.call then
					t.call:ClearAllPoints();
					t.call:SetPoint("RIGHT", opt, "LEFT", -2, 0);
				end
			end);
		end
		function NS.CloudyTradeSkill_Blizzard_CraftUI()
			C_Timer.After(1.0, function()
				local c = gui.Blizzard_CraftUI;
				local opt = _G["CTSOption-CraftFrame"];
				if c and opt and c.call then
					c.call:ClearAllPoints();
					c.call:SetPoint("RIGHT", opt, "LEFT", -2, 0);
				end
			end);
		end
		function NS.CloudyTradeSkill()
			NS.CloudyTradeSkill_Blizzard_TradeSkillUI();
			NS.CloudyTradeSkill_Blizzard_CraftUI();
		end
	end

	do	--	mtsl
		function NS.toggle_mtsl(hide)
			if hide then
				MTSLUI_TOGGLE_BUTTON.ui_frame:SetAlpha(0);
				MTSLUI_TOGGLE_BUTTON.ui_frame:EnableMouse(false);
				MTSLUI_TOGGLE_BUTTON.ui_frame:Hide();
				MTSLUI_MISSING_TRADESKILLS_FRAME.ui_frame:SetAlpha(0);
				MTSLUI_MISSING_TRADESKILLS_FRAME.ui_frame:EnableMouse(false);
				MTSLUI_MISSING_TRADESKILLS_FRAME.ui_frame:Hide();
			else
				MTSLUI_TOGGLE_BUTTON.ui_frame:SetAlpha(1);
				MTSLUI_TOGGLE_BUTTON.ui_frame:EnableMouse(true);
				MTSLUI_TOGGLE_BUTTON.ui_frame:Show();
				MTSLUI_MISSING_TRADESKILLS_FRAME.ui_frame:SetAlpha(1);
				MTSLUI_MISSING_TRADESKILLS_FRAME.ui_frame:EnableMouse(true);
				-- MTSLUI_MISSING_TRADESKILLS_FRAME.ui_frame:Show();
			end
		end
		function NS.hide_mtsl(val)
			if IsAddOnLoaded("MissingTradeSkillsList") then
				NS.toggle_mtsl(val);
			end
		end
	end

	do	--	ADDON_LOADED
		local handler_table = {
			["ElvUI"] = NS.ElvUI,
			["CloudyTradeSkill"] = NS.CloudyTradeSkill,
			["MissingTradeSkillsList"] = function()
				if SET then
					C_Timer.After(1.0, NS.hide_mtsl(SET.hide_mtsl));
				end
			end,
			["alaTrade"] = function()
				merc = __ala_meta__.merc;
				NS.merc_RegAllFrames();
			end,
			["Auctionator"] = function()
				merc = NS.meta_alt_merc_Auctionator();
				NS.merc_RegAllFrames();
			end,
			["aux-addon"] = function()
				merc = NS.meta_alt_merc_aux();
				NS.merc_RegAllFrames();
			end,
			["AuctionFaster"] = function()
				merc = NS.meta_alt_merc_AuctionFaster();
				NS.merc_RegAllFrames();
			end,
			["AuctionMaster"] = function()
				merc = NS.meta_alt_merc_AuctionMaster();
				NS.merc_RegAllFrames();
			end,
			["Leatrix_Plus"] = function()
				if LeaPlusDB then
					LeaPlusDB["EnhanceProfessions"] = "Off";
				end
			end,
		};
		function NS.ADDON_LOADED(addon)
			local handler = handler_table[addon];
			if handler then
				handler(addon);
			end
		end
		function NS.add_AddonLoadedHandler(addon, handler)
			handler_table[addon] = handler;
		end
	end

	--	ui
		function NS.ui_toggleGUI(key, on)
			local frame = gui[key];
			if frame then
				if frame:IsShown() or on == false then
					frame:Hide();
					return false;
				else
					frame:Show();
					return true;
				end
			end
		end
		function NS.ui_toggleCall(on)
			local t = gui["Blizzard_TradeSkillUI"];
			if t then
				if on then
					t.call:Show();
				else
					t.call:Hide();
				end
			end
			local c = gui["Blizzard_CraftUI"];
			if c then
				if on then
					c.call:Show();
				else
					c.call:Hide();
				end
			end
		end
		function NS.ui_toggleTab(on)
			local t = gui["Blizzard_TradeSkillUI"];
			if t then
				if on then
					t.tabFrame:Show();
				else
					t.tabFrame:Hide();
				end
				t:ShowSetFrame(false);
			end
			local c = gui["Blizzard_CraftUI"];
			if c then
				if on then
					c.tabFrame:Show();
				else
					c.tabFrame:Hide();
				end
				c:ShowSetFrame(false);
			end
		end
		function NS.ui_togglePortraitButton(on)
			local t = gui["Blizzard_TradeSkillUI"];
			if t then
				if on then
					t.switch:Show();
				else
					t.switch:Hide();
				end
			end
			local c = gui["Blizzard_CraftUI"];
			if c then
				if on then
					c.switch:Show();
				else
					c.switch:Hide();
				end
			end
		end
		function NS.ui_lock_board(on)
			if on then
				gui["BOARD"]:lock();
			else
				gui["BOARD"]:unlock();
			end
		end
		function NS.ui_update_all()
			local t = gui["Blizzard_TradeSkillUI"];
			if t then
				t:update_func();
			end
			local c = gui["Blizzard_CraftUI"];
			if c then
				c:update_func();
			end
			gui["EXPLORER"]:update_func();
			-- gui["CONFIG"]:update_func();
		end
		function NS.ui_refresh_all()
			local t = gui["Blizzard_TradeSkillUI"];
			if t then
				t.scroll:Update();
				local p = t.profitFrame;
				if p then
					p.scroll:Update();
				end
			end
			local c = gui["Blizzard_CraftUI"];
			if c then
				c.scroll:Update();
				local p = c.profitFrame;
				if p then
					p.scroll:Update();
				end
			end
			local e = gui["EXPLORER"];
			if e then
				e.scroll:Update();
				local p = e.profitFrame;
				if p then
					p.scroll:Update();
				end
			end
		end
		function NS.ui_refresh_style(loading)
			local t = gui["Blizzard_TradeSkillUI"];
			if t then
				t:BlzStyle(SET.blz_style, loading);
			end
			local c = gui["Blizzard_CraftUI"];
			if c then
				c:BlzStyle(SET.blz_style, loading);
			end
			local e = gui["EXPLORER"];
			if e then
				e:BlzStyle(SET.blz_style, loading);
			end
		end
		function NS.ui_refresh_config()
			gui["CONFIG"]:Refresh();
		end
	--

	function NS.ON_SET_CHANGED(key, val, loading)
		if key == 'expand' then
			local t = gui["Blizzard_TradeSkillUI"];
			if t then
				t:Expand(val);
			end
			local c = gui["Blizzard_CraftUI"];
			if c then
				c:Expand(val);
			end
		elseif key == 'blz_style' then
			NS.ui_refresh_style(loading);
		elseif key == 'bg_color' then
			NS.ui_refresh_style(loading);
		elseif key == 'show_tradeskill_frame_price_info' then
			local t = gui["Blizzard_TradeSkillUI"];
			if t then
				t:updatePriceInfoInFrame();
			end
			local c = gui["Blizzard_CraftUI"];
			if c then
				c:updatePriceInfoInFrame();
			end
		elseif key == 'show_tradeskill_frame_rank_info' then
			local t = gui["Blizzard_TradeSkillUI"];
			if t then
				t:updateRankInfoInFrame();
			end
			local c = gui["Blizzard_CraftUI"];
			if c then
				c:updateRankInfoInFrame();
			end
		elseif key == 'colored_rank_for_unknown' then
			NS.ui_refresh_all();
		elseif key == 'regular_exp' then
			for pid, set in next, SET do
				if NS.db_is_pid(pid) or pid == 'explorer' then
					set.update = true;
				end
			end
			NS.ui_update_all();
		elseif key == 'hide_mtsl' then
			NS.hide_mtsl(val);
		else
		end
		if not loading then
			NS.ui_refresh_config();
		end
	end
	function NS.init_regEvent()
		_EventHandler:RegEvent("SKILL_LINES_CHANGED");
		_EventHandler:RegEvent("NEW_RECIPE_LEARNED");
		_EventHandler:RegEvent("BAG_UPDATE_COOLDOWN");
	end
	function NS.init_hook()
	end
	function NS.init_createGUI()
		----	hook TradeSkillUI CraftUI
			if IsAddOnLoaded("Blizzard_TradeSkillUI") then
				NS.ui_hook_Blizzard_TradeSkillUI("Blizzard_TradeSkillUI");
			else
				NS.add_AddonLoadedHandler("Blizzard_TradeSkillUI", NS.ui_hook_Blizzard_TradeSkillUI);
			end
			if IsAddOnLoaded("Blizzard_CraftUI") then
				NS.ui_hook_Blizzard_CraftUI("Blizzard_CraftUI");
			else
				NS.add_AddonLoadedHandler("Blizzard_CraftUI", NS.ui_hook_Blizzard_CraftUI);
			end
		----
		_, gui["EXPLORER"] = safe_call(NS.ui_CreateExplorer);
		_, gui["CONFIG"] = safe_call(NS.ui_CreateConfigFrame);
		_, gui["BOARD"] = safe_call(NS.ui_CreateBoard);
	end

end

do	--	INITIALIZE
	local default_SET = {
		expand = false,
		blz_style = false,
		bg_color = { 0.0, 0.0, 0.0, 0.75, },
		show_tradeskill_frame_price_info = true,
		show_tradeskill_frame_rank_info = true,
		show_tradeskill_tip_craft_item_price = true,
		show_tradeskill_tip_craft_spell_price = true,
		show_tradeskill_tip_recipe_price = true,
		show_tradeskill_tip_recipe_account_learned = true,
		show_tradeskill_tip_material_craft_info = true,
		default_skill_button_tip = true,
		colored_rank_for_unknown = false,
		regular_exp = false,
		char_list = {  },
		show_call = true,
		show_tab = true,
		portrait_button = true,
		show_board = false,
		lock_board = false,
		board_pos = { "TOP", "UIParent", "BOTTOM", 260, 190, },
		hide_mtsl = false,
	};
	local default_set = {
		shown = true,
		showSet = false,
		showProfit = false,
		--
		showKnown = true,
		showUnkown = true,
		showHighRank = false,
		showItemInsteadOfSpell = false,
		showRank = true,
		haveMaterials = false,
		phase = curPhase,
		--
		searchText = "",
		searchNameOnly = false,
		--
		costOnly = false,
		--
	};
	local default_var = {
	};
	local default_explorer_set = {
		showSet = true,
		showProfit = false,
		--
		showKnown = true,
		showUnkown = false,
		showHighRank = false,
		showItemInsteadOfSpell = false,
		showRank = true,
		phase = curPhase,
		--
		filter = {
			-- realm = nil,
			skill = nil,
			type = nil,
			subType = nil,
			eqLoc = nil,
		},
		searchText = "",
		--
		-- costOnly = false,
	};
	function NS.MODIFY_SAVED_VARIABLE()
		if alaTradeSkillSV then
			if alaTradeSkillSV._version < 200730.0 then
				for key, VAR in next, alaTradeSkillSV.var do
					VAR.supreme_list = {  };
				end
			end
		elseif alaTradeFrameSV and alaTradeFrameSV._version and alaTradeFrameSV._version >= 200505.1 then
			if alaTradeFrameSV._version == nil then
				alaTradeFrameSV._version = 0.0;
			end
			if alaTradeFrameSV._version < 200513.1 then
				local char_list = {  };
				for GUID, _ in next, alaTradeFrameSV.var do
					tinsert(char_list, GUID);
				end
				alaTradeFrameSV.set.char_list = char_list
				local b = alaTradeFrameSV.set.board;
				if b then
					alaTradeFrameSV.set.board = nil;
					alaTradeFrameSV.set.show_board = b.shown;
					alaTradeFrameSV.set.lock_board = b.locked;
					alaTradeFrameSV.set.board_pos = b.pos or { "TOP", 0, -20, };
					alaTradeFrameSV._version = 200513.1;
				end
			end
			if alaTradeFrameSV._version < 200525.0 then
				alaTradeFrameSV.set.show_tradeskill_frame_rank = nil;
				alaTradeFrameSV._version = 200525.0;
			end
			if alaTradeFrameSV._version < 200602.0 then
				alaTradeFrameSV.err = nil;
				alaTradeFrameSV._version = 200602.0;
			end
			_G.alaTradeSkillSV = alaTradeFrameSV;
			_G.alaTradeFrameSV = nil;
		else
			_G.alaTradeSkillSV = {
				set = {
					explorer = default_explorer_set,
				},
				var = {  },
				fav = {  },
				cmm = {  },
			};
		end
		alaTradeSkillSV._version = 200730.0;
		SET = setmetatable(alaTradeSkillSV.set, {
			__index = function(t, pid)
				if NS.db_is_pid(pid) then
					local temp = Mixin({  }, default_set);
					t[pid] = temp;
					return temp;
				end
				return nil;
			end,
		});
		for key, val in next, default_SET do
			if rawget(SET, key) == nil then
				rawset(SET, key, val);
			end
		end
		for pid, set in next, SET do
			if NS.db_is_pid(pid) or pid == 'explorer' then
				set.update = true;
				if set.phase == nil or set.phase < curPhase then
					set.phase = curPhase;
				end
			end
		end
		AVAR = alaTradeSkillSV.var;
		for index = 1, #SET.char_list do
			if AVAR[SET.char_list[index]] == nil then
				SET.char_list[index] = nil;
			end
		end
		for GUID, VAR in next, AVAR do
			for pid = NS.db_min_pid(), NS.db_max_pid() do
				local var = rawget(VAR, pid);
				if var and NS.db_is_pid(pid) then
					var.cur_rank = var.cur_rank or "-";
					var.max_rank = var.max_rank or "-";
				end
			end
			local found = false;
			for index = 1, #SET.char_list do
				if SET.char_list[index] == GUID then
					found = true;
					break;
				end
			end
			if not found then
				tinsert(SET.char_list, GUID);
			end
		end
		if AVAR[PLAYER_GUID] == nil then
			NS.func_add_char(PLAYER_GUID, { realm_id = PLAYER_REALM_ID, realm_name = PLAYER_REALM_NAME, supreme_list = {  }, }, true);
		end
		VAR = setmetatable(AVAR[PLAYER_GUID], {
			__index = function(t, pid)
				if NS.db_is_pid(pid) then
					local temp = { {  }, {  }, update = true, };
					t[pid] = temp;
					return temp;
				else
					return default_var[pid];
				end
			end,
		});
		for pid = NS.db_min_pid(), NS.db_max_pid() do
			local var = rawget(VAR, pid);
			if var and NS.db_is_pid(pid) then
				var.update = true;
			end
		end
		FAV = alaTradeSkillSV.fav;
		CMM = alaTradeSkillSV.cmm[PLAYER_REALM_ID];
		if CMM == nil then
			CMM = {  };
			alaTradeSkillSV.cmm[PLAYER_REALM_ID] = CMM;
		end
	end
	local initialized = false;
	local function init()
		DisableAddOn("alaTradeFrame");
		if initialized then
			return;
		else
			initialized = true;
		end
		local success, err;
		safe_call(NS.db_init);		--	!!!must be run earlier than any others!!!
		success = safe_call(NS.MODIFY_SAVED_VARIABLE);
		if not success then
			local fav = alaTradeSkillSV.fav;
			alaTradeSkillSV = nil;
			success, err = safe_call(NS.MODIFY_SAVED_VARIABLE);
			if success then
				if type(fav) == 'table' then
					FAV = fav;
					alaTradeSkillSV.fav = fav;
				end
			else
				print("\124cffff0000alaTradeSkill fetal error", err);
			end
		end
		safe_call(NS.init_hash_known_recipe);
		safe_call(NS.init_regEvent);
		safe_call(NS.init_hook);
		safe_call(NS.init_createGUI);
		safe_call(NS.hook_tooltip);
		for GUID, _ in next, AVAR do
			GetPlayerInfoByGUID(GUID);
		end
		safe_call(NS.cmm_InitAddonMessage);
		merc = merc or __ala_meta__.merc or NS.meta_alt_merc_Auctionator() or NS.meta_alt_merc_aux() or NS.meta_alt_merc_AuctionFaster() or NS.meta_alt_merc_AuctionMaster();
		for key, val in next, SET do
			if type(val) ~= 'table' then
				NS.ON_SET_CHANGED(key, val, true);
			end
		end
		if __ala_meta__.initpublic then __ala_meta__.initpublic(); end
	end
	function NS.PLAYER_ENTERING_WORLD()
		_EventHandler:UnregEvent("PLAYER_ENTERING_WORLD");
		C_Timer.After(1.0, init);
	end
	function NS.LOADING_SCREEN_ENABLED()
		_EventHandler:UnregEvent("LOADING_SCREEN_ENABLED");
	end
	function NS.LOADING_SCREEN_DISABLED()
		_EventHandler:UnregEvent("LOADING_SCREEN_DISABLED");
		C_Timer.After(1.0, init);
	end
	-- _EventHandler:RegEvent("PLAYER_ENTERING_WORLD");
	-- _EventHandler:RegEvent("LOADING_SCREEN_ENABLED");
	_EventHandler:RegEvent("LOADING_SCREEN_DISABLED");
	_EventHandler:RegEvent("ADDON_LOADED");
	-->		fix for Leatrix_Plus
		function NS.VARIABLES_LOADED()
			_EventHandler:UnregEvent("VARIABLES_LOADED");
			if LeaPlusDB then
				LeaPlusDB["EnhanceProfessions"] = "Off";
			end
		end
		function NS.PLAYER_LOGIN()
			_EventHandler:UnregEvent("PLAYER_LOGIN");
			if LeaPlusDB then
				LeaPlusDB["EnhanceProfessions"] = "Off";
			end
		end
		_EventHandler:RegEvent("VARIABLES_LOADED");
		_EventHandler:RegEvent("PLAYER_LOGIN");
	-->
end

do	--	SLASH
	local function set_handler(cmd, val)
		if cmd[6] then
			val = cmd[6](val);
		end
		if val ~= nil then
			if SET[cmd[3]] ~= val then
				if not cmd.donotset then
					SET[cmd[3]] = val;
				end
				if cmd[4] then
					if type(cmd[4]) == 'function' then
						print(cmd[4](cmd[3], val));
					else
						print(cmd[4], val);
					end
				else
					print(cmd[3], val);
				end
				if cmd[5] then
					cmd[5](cmd[3], val);
				end
				NS.ON_SET_CHANGED(cmd[3], val);
			end
		else
			print(L["INVALID_COMMANDS"]);
		end
	end
	--	pattern, key, note, func(key, val)
	local SEPARATOR = "[ %`%~%!%@%#%$%%%^%&%*%(%)%-%_%=%+%[%{%]%}%\\%|%;%:%\'%\"%,%<%.%>%/%?]*";
	--	1type, 2pattern, 3key, 4note(string or func), 5proc_func(key, val), 6func_to_mod_val, 7config_type(nil for check), 8cmd_for_config / drop_meta, 9para[slider:{min, max, step}], 10sub_config_on_val
	NS.set_cmd_list = {
		{	--	expand
			'bool',
			"^expand" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"expand",
			L.SLASH_NOTE["expand"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setexpand1");
				else
					SlashCmdList["ALATRADEFRAME"]("setexpand0");
				end
			end,
		},
		{	--	blz_style
			'bool',
			"^blz" .. SEPARATOR .. "style" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"blz_style",
			L.SLASH_NOTE["blz_style"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setblzstyle1");
				else
					SlashCmdList["ALATRADEFRAME"]("setblzstyle0");
				end
			end,
			[10] = {
				[false] = {
					'table',
					nil,
					'bg_color',
					L.SLASH_NOTE["bg_color"],
					[7] = 'color4',
					[8] = function(r, g, b, a)
						SET.bg_color = { r or 1.0, g or 1.0, b or 1.0, a or 1.0, };
						NS.ON_SET_CHANGED('bg_color', SET.bg_color);
					end,
				},
			},
		},
		{	--	show_tradeskill_frame_price_info
			'bool',
			"^price" .. SEPARATOR .. "info" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"show_tradeskill_frame_price_info",
			L.SLASH_NOTE["show_tradeskill_frame_price_info"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setpriceinfo1");
				else
					SlashCmdList["ALATRADEFRAME"]("setpriceinfo0");
				end
			end,
		},
		{	--	show_tradeskill_frame_rank_info
			'bool',
			"^rank" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"show_tradeskill_frame_rank_info",
			L.SLASH_NOTE["show_tradeskill_frame_rank_info"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setrank1");
				else
					SlashCmdList["ALATRADEFRAME"]("setrank0");
				end
			end,
		},
		{	--	show_tradeskill_tip_craft_item_price
			'bool',
			"^tip" .. SEPARATOR .. "item" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"show_tradeskill_tip_craft_item_price",
			L.SLASH_NOTE["show_tradeskill_tip_craft_item_price"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("settipitem1");
				else
					SlashCmdList["ALATRADEFRAME"]("settipitem0");
				end
			end,
		},
		{	--	show_tradeskill_tip_craft_spell_price
			'bool',
			"^tip" .. SEPARATOR .. "spell" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"show_tradeskill_tip_craft_spell_price",
			L.SLASH_NOTE["show_tradeskill_tip_craft_spell_price"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("settipspell1");
				else
					SlashCmdList["ALATRADEFRAME"]("settipspell0");
				end
			end,
		},
		{	--	show_tradeskill_tip_recipe_price
			'bool',
			"^tip" .. SEPARATOR .. "recipe" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"show_tradeskill_tip_recipe_price",
			L.SLASH_NOTE["show_tradeskill_tip_recipe_price"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("settiprecipe1");
				else
					SlashCmdList["ALATRADEFRAME"]("settiprecipe0");
				end
			end,
		},
		{	--	show_tradeskill_tip_recipe_account_learned
			'bool',
			"^tip" .. SEPARATOR .. "learned" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"show_tradeskill_tip_recipe_account_learned",
			L.SLASH_NOTE["show_tradeskill_tip_recipe_account_learned"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("settiplearned1");
				else
					SlashCmdList["ALATRADEFRAME"]("settiplearned0");
				end
			end,
		},
		{	--	show_tradeskill_tip_material_craft_info
			'bool',
			"^tip" .. SEPARATOR .. "material" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"show_tradeskill_tip_material_craft_info",
			L.SLASH_NOTE["show_tradeskill_tip_material_craft_info"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("settipmaterial1");
				else
					SlashCmdList["ALATRADEFRAME"]("settipmaterial0");
				end
			end,
		},
		{	--	default_skill_button_tip
			'bool',
			"^tip" .. SEPARATOR .. "default" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"default_skill_button_tip",
			L.SLASH_NOTE["default_skill_button_tip"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("settipdefault1");
				else
					SlashCmdList["ALATRADEFRAME"]("settipdefault0");
				end
			end,
		},
		{	--	colored_rank_for_unknown
			'bool',
			"^style" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"colored_rank_for_unknown",
			L.SLASH_NOTE["colored_rank_for_unknown"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setstyle1");
				else
					SlashCmdList["ALATRADEFRAME"]("setstyle0");
				end
			end,
		},
		{	--	regular_exp
			'bool',
			"^regular" .. SEPARATOR .. "expression" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"regular_exp",
			L.SLASH_NOTE["regular_exp"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setregularexpression1");
				else
					SlashCmdList["ALATRADEFRAME"]("setregularexpression0");
				end
			end,
		},
		{	--	show_call
			'bool',
			"^show" .. SEPARATOR .. "call" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$",
			"show_call",
			L.SLASH_NOTE["show_call"],
			function(key, val)
				NS.ui_toggleCall(val);
			end,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setshowcall1");
				else
					SlashCmdList["ALATRADEFRAME"]("setshowcall0");
				end
			end,
		},
		{	--	show_tab
			'bool',
			"^show" .. SEPARATOR .. "tab" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$",
			"show_tab",
			L.SLASH_NOTE["show_tab"],
			function(key, val)
				NS.ui_toggleTab(val);
			end,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setshowtab1");
				else
					SlashCmdList["ALATRADEFRAME"]("setshowtab0");
				end
			end,
		},
		{	--	portrait_button
			'bool',
			"^portrait" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$",
			"portrait_button",
			L.SLASH_NOTE["portrait_button"],
			function(key, val)
				NS.ui_togglePortraitButton(val);
			end,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setportrait1");
				else
					SlashCmdList["ALATRADEFRAME"]("setportrait0");
				end
			end,
		},
		{	--	show_board		--	save var by itself
			'bool',
			"^show" .. SEPARATOR .. "board" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$",
			"show_board",
			L.SLASH_NOTE["show_board"],
			function(key, val)
				NS.ui_toggleGUI("BOARD", val);
			end,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setshowboard1");
				else
					SlashCmdList["ALATRADEFRAME"]("setshowboard0");
				end
			end,
		},
		{	--	lock_board		--	save var by itself
			'bool',
			"^lock" .. SEPARATOR .. "board" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$",
			"lock_board",
			L.SLASH_NOTE["lock_board"],
			function(key, val)
				NS.ui_lock_board(val);
			end,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setlockboard1");
				else
					SlashCmdList["ALATRADEFRAME"]("setlockboard0");
				end
			end,
		},
		{	--	hide_mtsl
			'bool',
			"^hide" .. SEPARATOR .. "mtsl" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$",
			"hide_mtsl",
			L.SLASH_NOTE["hide_mtsl"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("sethidemtsl1");
				else
					SlashCmdList["ALATRADEFRAME"]("sethidemtsl0");
				end
			end,
		},
	};
	_G.SLASH_ALATRADEFRAME1 = "/alatradeframe";
	_G.SLASH_ALATRADEFRAME2 = "/alatf";
	_G.SLASH_ALATRADEFRAME3 = "/atf";
	local SET_PATTERN = "^" .. SEPARATOR .. "set" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$";
	local UI_PATTERN = "^" .. SEPARATOR .. "ui" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$";
	local DUMP_PATTERN = "^" .. SEPARATOR .. "dump" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$";
	SlashCmdList["ALATRADEFRAME"] = function(msg)
		msg = strlower(msg);
		--	set
		local _, pattern;
		_, _, pattern = strfind(msg, SET_PATTERN);
		if pattern then
			local set_cmd_list = NS.set_cmd_list;
			for index = 1, #set_cmd_list do
				local cmd = set_cmd_list[index];
				local _, _, pattern2 = strfind(pattern, cmd[2]);
				if pattern2 then
					if cmd[1] == 'bool' then
						local val = nil;
						if pattern2 == "true" or pattern2 == "ture" or pattern2 == "treu" or pattern2 == "1" or pattern2 == "on" or pattern2 == "enable" then
							val = true;
						elseif pattern2 == "false" or pattern2 == "flase" or pattern2 == "fales" or pattern2 == "0" or pattern2 == "off" or pattern2 == "disable" then
							val = false;
						end
						if cmd[6] then
							val = cmd[6](val);
						end
						if val ~= nil then
							if SET[cmd[3]] ~= val then
								if not cmd.donotset then
									SET[cmd[3]] = val;
								end
								if cmd[4] then
									if type(cmd[4]) == 'function' then
										print(cmd[4](cmd[3], val));
									else
										print(cmd[4], val);
									end
								else
									print(cmd[3], val);
								end
								if cmd[5] then
									cmd[5](cmd[3], val);
								end
								NS.ON_SET_CHANGED(cmd[3], val);
							end
						else
							print(L["INVALID_COMMANDS"]);
						end
					elseif cmd[1] == 'num' then
						local val = tonumber(pattern2);
						if val then
							if cmd[6] then
								val = cmd[6](val);
							end
							if val then
								if SET[cmd[3]] ~= val then
									if not cmd.donotset then
										SET[cmd[3]] = val;
									end
									if cmd[4] then
										if type(cmd[4]) == 'function' then
											print(cmd[4](cmd[3], val));
										else
											print(cmd[4], val);
										end
									else
										print(cmd[3], val);
									end
									if cmd[5] then
										cmd[5](cmd[3], val);
									end
									NS.ON_SET_CHANGED(cmd[3], val);
								end
							else
								print("\124cffff0000Invalid parameter: ", pattern2);
							end
						end
					end
					return;
				end
			end
			return;
		end
		_, _, pattern = strfind(msg, UI_PATTERN);
		if pattern then
			if strfind(pattern, 'exp') then
				NS.ui_toggleGUI("EXPLORER");
			elseif strfind(pattern, 'conf') then
				NS.ui_toggleGUI("CONFIG");
			end
			return;
		end
		_, _, pattern = strfind(msg, DUMP_PATTERN);
		if pattern then
			print("PriceDB Status: ", merc ~= nil);
			return;
		end
		--	default
		if strfind(msg, "[A-Za-z0-9]+" ) then
			print("Invalid command: [[", msg, "]] Use: ");
			print("  /atf setexpand on/off");
			print("  /atf setblzstyle on/off");
			print("  /atf setpriceinfo on/off");
			print("  /atf setrank on/off");
			print("  /atf settipitem on/off");
			print("  /atf settipspell on/off");
			print("  /atf settiprecipe on/off");
			print("  /atf settiplearned on/off");
			print("  /atf settipmaterial on/off");
			print("  /atf settipdefault on/off");
			print("  /atf setstyle on/off");
			print("  /atf setregularexpression on/off");
			print("  /atf setshowcall on/off");
			print("  /atf setshowtab on/off");
			print("  /atf setportrait on/off");
			print("  /atf setshowboard on/off");
			print("  /atf setlockboard on/off");
			print("  /atf sethidemtsl on/off");
		else
			-- NS.ui_toggleGUI("CONFIG");
			NS.ui_toggleGUI("CONFIG");
		end
	end
end

do	--	run_on_next_tick	--	execute two ticks later
	local min_ticker_duration = 0.1;
	if false then	--	a universal method, unnecessary here
		local DELAY = 5;
		local delay_run_funcs = {  };
		for index = 1, DELAY do
			delay_run_funcs[index] = {  };
		end
		local timer = 0.0;
		local function delay_run_handler(self, elasped)
			timer = timer + elasped;
			if timer >= min_ticker_duration * DELAY then
				timer = 0.0;
				local funcs = delay_run_funcs[1];
				while true do
					local func = tremove(funcs, 1);
					if func then
						func();
					else
						break;
					end
				end
				for index = 2, DELAY do
					if #delay_run_funcs[index] > 0 then
						tinsert(delay_run_funcs, tremove(delay_run_funcs));
						return;
					end
				end
				_EventHandler:SetScript("OnUpdate", nil);
			end
		end
		function _EventHandler:delay_run(func, delay)
			delay = delay and max(min(delay, DELAY), 1) or 1;
			local dIndex = DELAY - delay + 1;
			for index = 1, DELAY do
				if index ~= dIndex then
					local funcs = delay_run_funcs[index];
					for i = 1, #funcs do
						if func == funcs[i] then
							tremove(funcs, i);
							break;
						end
					end
				end
			end
			local funcs = delay_run_funcs[dIndex];
			for index = 1, #funcs do
				if func == funcs[index] then
					return;
				end
			end
			tinsert(funcs, func);
			_EventHandler:SetScript("OnUpdate", delay_run_handler);
		end
		function _EventHandler:frame_delay_update(frame, delay)
			_EventHandler:delay_run(frame.update_func, delay);
		end
	end
	--
	local run_on_next_tick_func_1 = {  };
	local run_on_next_tick_func_2 = {  };
	local timer = 0.0;
	local function run_on_next_tick_handler(self, elasped)
		timer = timer + elasped;
		if timer >= min_ticker_duration * 2 then
			timer = 0.0;
			while true do
				local func = tremove(run_on_next_tick_func_1, 1);
				if func then
					func();
				else
					break;
				end
			end
			if #run_on_next_tick_func_1 + #run_on_next_tick_func_2 == 0 then
				_EventHandler:SetScript("OnUpdate", nil);
			else
				run_on_next_tick_func_1, run_on_next_tick_func_2 = run_on_next_tick_func_2, run_on_next_tick_func_1;
			end
		end
	end
	function _EventHandler:run_on_next_tick(func)
		for index = 1, #run_on_next_tick_func_1 do
			if func == run_on_next_tick_func_1[index] then
				tremove(run_on_next_tick_func_1, index);
				break;
			end
		end
		for index = 1, #run_on_next_tick_func_2 do
			if func == run_on_next_tick_func_2[index] then
				return;
			end
		end
		tinsert(run_on_next_tick_func_2, func);
		_EventHandler:SetScript("OnUpdate", run_on_next_tick_handler);
	end
	function _EventHandler:frame_update_on_next_tick(frame)
		_EventHandler:run_on_next_tick(frame.update_func);
	end
end

local extern_setting = {  };
__ala_meta__.prof.extern_setting = extern_setting;
do	--	EXTERN SETTING
	function extern_setting.toggle_tradeskill_frame_rank(on)
		SET.show_tradeskill_frame_rank_info = on;
		NS.ON_SET_CHANGED('show_tradeskill_frame_rank_info', on);
	end
	function extern_setting.toggle_tradeskill_frame_price_info(on)
		SET.show_tradeskill_frame_price_info = on;
		NS.ON_SET_CHANGED('show_tradeskill_frame_price_info', on);
	end
	function extern_setting.toggle_tradeskill_tip_craft_spell_price(on)
		SET.show_tradeskill_tip_craft_spell_price = on;
	end
	function extern_setting.toggle_tradeskill_tip_craft_item_price(on)
		SET.show_tradeskill_tip_craft_item_price = on;
	end
	function extern_setting.toggle_tradeskill_tip_recipe_price(on)
		SET.show_tradeskill_tip_recipe_price = on;
	end
	function extern_setting.toggle_tradeskill_tip_recipe_account_learned(on)
		SET.show_tradeskill_tip_recipe_account_learned = on;
	end
	function extern_setting.toggle_tradeskill_board_shown(on)
		SET.show_board = on;
		NS.ui_toggleGUI("BOARD", on);
	end
	function extern_setting.toggle_tradeskill_board_lock(on)
		SET.lock_board = on;
		NS.ui_lock_board(on);
	end
	function extern_setting.toggle_tradeskill_blz_style(on)
		SET.blz_style = on;
		NS.ui_refresh_style();
	end

	function extern_setting.set_tradeskill_bg_color(r, g, b, a)
		SET.bg_color[1] = r or SET.bg_color[1];
		SET.bg_color[2] = g or SET.bg_color[2];
		SET.bg_color[3] = b or SET.bg_color[3];
		SET.bg_color[4] = a or SET.bg_color[4];
		NS.ON_SET_CHANGED('bg_color', SET.bg_color);
	end

	function extern_setting.get_tradeskill_frame_price_info()
		return SET.show_tradeskill_frame_price_info;
	end
	function extern_setting.get_tradeskill_tip_craft_spell_price()
		return SET.show_tradeskill_tip_craft_spell_price;
	end
	function extern_setting.get_tradeskill_tip_craft_item_price()
		return SET.show_tradeskill_tip_craft_item_price;
	end
	function extern_setting.get_tradeskill_tip_recipe_price()
		return SET.show_tradeskill_tip_recipe_price;
	end
	function extern_setting.get_tradeskill_tip_recipe_account_learned()
		return SET.show_tradeskill_tip_recipe_account_learned;
	end
	function extern_setting.get_tradeskill_board_shown()
		return SET.show_board;
	end
	function extern_setting.get_tradeskill_board_lock()
		return SET.lock_board;
	end
	function extern_setting.get_tradeskill_blz_style()
		return SET.blz_style;
	end

	if select(2, GetAddOnInfo('\33\33\33\49\54\51\85\73\33\33\33')) then
		_G._163_tradeskill_frame_price_toggle = extern_setting.toggle_tradeskill_frame_price_info;
		_G._163_tradeskill_tip_craft_spell_price_toggle = extern_setting.toggle_tradeskill_tip_craft_spell_price;
		_G._163_tradeskill_tip_craft_item_toggle = extern_setting.toggle_tradeskill_tip_craft_item_price;
		_G._163_tradeskill_tip_recipe_toggle = extern_setting.toggle_tradeskill_tip_recipe_price;
		_G._163_tradeskill_tip_recipe_account_learned_toggle = extern_setting.toggle_tradeskill_tip_recipe_account_learned;
		_G._163_tradeskill_board_shown_toggle = extern_setting.toggle_tradeskill_board_shown;
		_G._163_tradeskill_board_lock_toggle = extern_setting.toggle_tradeskill_board_lock;
		_G._163_tradeskill_board_blz_style_toggle = extern_setting.toggle_tradeskill_blz_style;

		_G._163_tradeskill_bg_color_set = extern_setting.set_tradeskill_bg_color;

		_G._163_tradeskill_frame_price_get = extern_setting.get_tradeskill_frame_price_info;
		_G._163_tradeskill_tip_craft_spell_price_get = extern_setting.get_tradeskill_tip_craft_spell_price;
		_G._163_tradeskill_tip_crafted_item_get = extern_setting.get_tradeskill_tip_craft_item_price;
		_G._163_tradeskill_tip_recipe_get = extern_setting.get_tradeskill_tip_recipe_price;
		_G._163_tradeskill_tip_recipe_account_learned_get = extern_setting.get_tradeskill_tip_recipe_account_learned;
		_G._163_tradeskill_board_shown_get = extern_setting.get_tradeskill_board_shown;
		_G._163_tradeskill_board_lock_get = extern_setting.get_tradeskill_board_lock;
		_G._163_tradeskill_blz_style_get = extern_setting.get_tradeskill_blz_style;
	end
end

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
		[18256] = 6000,		-- 灌魔之瓶
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
		--	POISION
		[2928] = 20,		--	蚀骨灰
		[5140] = 25,		--	闪光粉
		[2930] = 50,		--	痛苦精华
		[8924] = 100,		--	堕落之尘
		[5173] = 100,		--	丧命草
		[8923] = 200,		--	苦楚精华
		--
		[5565] = 5000,		--	地狱火石
		[16583] = 10000,	--	恶魔雕像
		[17020] = 1000,		--	魔粉
		[17021] = 700,		--	野生浆果
		[17026] = 1000,		--	野生棘根草
		[17028] = 700,		--	圣洁蜡烛
		[17029] = 1000,		--	神圣蜡烛
		[17030] = 2000,		--	十字章
		[17031] = 1000,		--	传送符文
		[17032] = 2000,		--	传送门符文
		[17033] = 2000,		--	神圣符印
		[17034] = 200,		--	枫树种子
		[17035] = 400,		--	荆棘种子
		[17036] = 800,		--	灰木种子
		[17037] = 1400,		--	角树种子
		[17038] = 2000,		--	铁木种子
		[21177] = 300,		--	王者印记
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
		for id, price in next, material_sold_by_vendor do
			num_material_sold_by_vendor = num_material_sold_by_vendor + 1;
		end
		local frame = CreateFrame("FRAME");
		frame:RegisterEvent("ITEM_DATA_LOAD_RESULT");
		frame:SetScript("OnEvent", function(self, event, arg1, arg2)
			if material_sold_by_vendor[arg1] then
				if arg2 and cache_item_info(arg1) then
					num_material_sold_by_vendor = num_material_sold_by_vendor - 1;
				else
					RequestLoadItemDataByID(arg1);
				end
				if num_material_sold_by_vendor <= 0 then
					self:SetScript("OnEvent", nil);
					self:UnregisterAllEvents();
					frame = nil;
				end
			end
		end);
		for id, price in next, material_sold_by_vendor do
			RequestLoadItemDataByID(id);
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
		function NS.meta_alt_merc_Auctionator()
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
		function NS.meta_alt_merc_aux()
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
		function NS.meta_alt_merc_AuctionFaster()
			if IsAddOnLoaded("AuctionFaster") then
				GetItemFromCache = AuctionFaster.modules.ItemCache.GetItemFromCache;
				return Mixin({ query_ah_price_by_name = query_ah_price_by_name, query_ah_price_by_id = query_ah_price_by_id, }, alt_merc);
			end
		end
	end
	--------
	do	--	AuctionMaster
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
			if AucMasGetCurrentAuctionInfo then
				local _, link = GetItemInfo(id);
				if link then
					local _, _, bid, ap = AucMasGetCurrentAuctionInfo(link)
					if ap and ap > 0 then
						return ap * num;
					end
				end
			end
		end
		function NS.meta_alt_merc_AuctionMaster()
			if IsAddOnLoaded("AuctionMaster") then
				return Mixin({ query_ah_price_by_name = query_ah_price_by_name, query_ah_price_by_id = query_ah_price_by_id, add_cache_callback = AucMasRegisterStatisticCallback, }, alt_merc);
			end
		end
	end
	--------
end

do	--	DEV
	function _G.ATS_DEBUG(on)
		if on or on == nil then
			_log_ = function(...)
				print(date('\124cff00ff00%H:%M:%S\124r'), ...);
			end
		else
			_log_ = _noop_;
		end		
	end
	--	dev
		function _G.alatsdev_mtsl()
			if MTSL_DATA then
				local db, sinfo, iinfo = NS.link_db();	--	recipe_info, spell_info, item_info
				if db then
					local mtsl = MTSL_DATA["skills"];
					for p, mdb in next, mtsl do
						for _, m in next, mdb do
							local sid = m.id;
							if sid then
								local info = db[sid];
								if info then
									if m.phase ~= info[index_phase] then
										print(p, sid, 'phase', m.phase, info[index_phase]);
									end
									if m.min_skill and m.min_skill ~= info[index_learn_rank] then
										print(p, sid, 'min_skill', m.min_skill, info[index_learn_rank]);
									end
									if m.items and #m.items > 0 then
										if #m.items > 1 then
											print(p, sid, 'items', #m.items);
										end
										if info[index_rid] ~= m.items[1] then
											print(p, sid, 'items', info[index_rid], m.items[1]);
										end
									end
									if m.quests and #m.quests > 0 then
										if info[index_quest] and #info[index_quest] then
											if #m.quests == #info[index_quest] then
												for index = 1, #m.quests do
													if m.quests[index] ~= info[index_quest][index] then
														print(p, sid, 'quests', 'seq');
														break;
													end
												end
											else
												print(p, sid, 'quests#', #m.quests, #info[index_quest]);
											end
										else
											print(p, sid, 'quests');
										end
									end
									if m.objects and #m.objects > 0 then
										if #m.objects > 1 then
											print(p, sid, 'objects', #m.objects);
										end
										if info[index_object] ~= m.objects[1] then
											print(p, sid, 'objects', info[index_object], m.objects[1]);
										end
									end
									if m.trainers then
										if info[index_train_price] ~= m.trainers.price then
											print(p, sid, 'trainprice', info[index_train_price], m.trainers.price)
										end
										if info[index_trainer] then
											if #m.trainers.sources == #info[index_trainer] then
												for index = 1, #m.trainers.sources do
													if m.trainers.sources[index] ~= info[index_trainer][index] then
														print(p, sid, 'trainers', 'seq');
														break;
													end
												end
											else
												print(p, sid, 'trainers#', #m.trainers.sources, #info[index_trainer]);
											end
										else
											print(p, sid, 'trainers');
										end
									end
								else
									print(p, sid, 'missing');
								end
							else
								print(p, sid);
							end
						end
					end
				end
			end
		end
		function _G.alatsdev_atlas()
			if AtlasLoot and AtlasLoot.Data then
				local db, sinfo, iinfo = NS.link_db();	--	recipe_info, spell_info, item_info
				if db then
					_G.alaDevSV = alaDevSV or {  };
					alaDevSV.atf = alaDevSV.atf or {  };
					local atf = alaDevSV.atf;
					local function _print_(key, ...)
						print(key, ...)
						local t = atf[key];
						if t == nil then
							t = {  };
							atf[key] = t;
						end
						tinsert(t, { ... })
					end
					local atlasPhase = AtlasLoot.Data.ContentPhase;
					local atlasDB = AtlasLoot.Data.Profession;
					for sid, info in next, db do
						local pid = info[index_pid];
						local p = info[index_phase];
						if true then
							local cid = info[index_cid];
							local rid = info[index_rid];
							if cid == nil then
								if rid == nil then
									if p ~= 1 then
										_print_('p', pid, sid, 1, p)
									end
								else
									local p3 = atlasPhase:GetForItemID(rid);
									if (p > 4 and (p ~= p3)) or (p == 4 and p3 and p3 ~= 4) or (p < 4 and p3) then
										_print_('p', pid, sid, 2, p, p2);
									end
								end
							else
								if rid == nil then
									local p2 = atlasPhase:GetForItemID(cid);
									if (p > 4 and (p ~= p2)) or (p == 4 and p2 and p2 ~= 4) or (p < 4 and p2) then
										_print_('p', pid, sid, 3, p, p2);
									end
								else
									local p2 = atlasPhase:GetForItemID(cid);
									local p3 = atlasPhase:GetForItemID(rid);
									if p2 and p3 and p2 ~= p3 then
										_print_('p', pid, sid, 4, p, p2, p3);
									end
									if (p > 4 and (p ~= p3)) or (p == 4 and p3 and p3 ~= 4) or (p < 4 and p3) then
										_print_('p', pid, sid, 5, p, p2, p3);
									end
								end
							end
						end
						if true then
							local info2 = atlasDB.GetProfessionData(sid);
							-- [spellID] = { createdItemID, prof, minLvl, lowLvl, highLvl, reagents{}, reagentsCount{}, numCreatedItems }
							if info2 then
								if info2[1] ~= info[index_cid] then
									_print_('c', pid, sid, info[index_cid], info2[1]);
								end
								if info2[3] ~= info[index_learn_rank] then
									_print_('l', pid, sid, info[index_learn_rank], info2[3]);
								end
								if info2[4] ~= info[index_yellow_rank] then
									_print_('y', pid, sid, info[index_yellow_rank], info2[4]);
								end
								if info2[5] ~= info[index_grey_rank] then
									_print_('g', pid, sid, info[index_grey_rank], info2[5]);
								end
								if #info2[6] ~= #info[index_reagents_id] then
									_print_('r', pid, sid, 1, #info[index_reagents_id], #info2[6], #info2[7]);
								else
									if #info2[7] ~= #info2[6] then
										_print_('r', pid, sid, 2, #info2[7], #info2[6]);
									else
										for idx1, id1 in next, info[index_reagents_id] do
											local val = false;
											for idx2, id2 in next, info2[6] do
												if id1 == id2 then
													val = true;
													if info[index_reagents_count][idx1] ~= info2[7][idx2] then
														_print_('r', pid, sid, 3, info[index_reagents_count][idx1], info2[7][idx2]);
													end
													break;
												end
											end
											if not val then
												_print_('r', pid, sid, 4, idx1, id1);
											end
										end
									end
								end
								if info2[8] then
									if info[index_num_made_min] and info[index_num_made_max] then
										if info2[8] * 2 ~= info[index_num_made_min] + info[index_num_made_max] then
											_print_('n', pid, sid, 1, (info[index_num_made_min] + info[index_num_made_max]) * 0.5, info2[8]);
										end
									else
										_print_('n', pid, sid, 2, info2[8]);
									end
								end
							else
								_print_('m', pid, sid);
							end
						end
					end
				end
			end
		end
		function _G.alatsdev_atlas_recipe()
			_G.alaDevSV = alaDevSV or {  };
			alaDevSV.atf = alaDevSV.atf or {  };
			alaDevSV.atf.rid = {}
			local recipe = alaDevSV.atf.rid;
			local RECIPE = {};	--	manual
			local db, sinfo, iinfo = NS.link_db();	--	recipe_info, spell_info, item_info
			for rid, v in next, RECIPE do
				local sid = v[3];
				local info = db[sid];
				if info then
					local rid1 = info[index_rid];
					if rid1 == nil then
						tinsert(recipe, {'m', sid, rid})
					elseif rid1 ~= rid then
						tinsert(recipe, {'d', sid, rid, rid1})
					end
				else
					tinsert(recipe, {'e',sid,rid})
				end
			end
		end			
	--
	-- WorldFrame:EnableKeyboard();
	-- WorldFrame:HookScript("OnKeyDown", function(self, key)
	-- 	print(key, "D");
	-- end);
	-- WorldFrame:HookScript("OnKeyUp", function(self, key)
	-- 	print(key, "U");
	-- end);
	-- WorldFrame:GetScript("OnKeyDown")(WorldFrame, "W")
end

StackSplitFrame:SetFrameStrata("TOOLTIP");
