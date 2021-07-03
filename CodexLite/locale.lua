--[[--
	by ALA @ 163UI/网易有爱, http://wowui.w.163.com/163ui/
	CREDIT shagu/pfQuest(MIT LICENSE) @ https://github.com/shagu
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __ns = ...;

if __ns.__dev then
	setfenv(1, __ns.__fenv);
end
local _G = _G;
local _ = nil;
----------------------------------------------------------------------------------------------------
--[=[dev]=]	if __ns.__dev then __ns._F_devDebugProfileStart('module.locale'); end

local UILOC = setmetatable(
	{  },
	{
		__newindex = function(tbl, key, val)
			if val == true then
				rawset(tbl, key, key);
			else
				rawset(tbl, key, val);
			end
		end,
		__index = function(tbl, key)
			return key;
		end,
		__call = function(tbl, key)
			return rawget(tbl, key) or key;
		end,
	}
);
__ns.UILOC = UILOC;

local LOCALE = GetLocale();

local LOC_PATTERN_LIST = {
	deDE = {
		name = "<name>",
		race = "<völker>",
		class = "<klasse>",
	},
	enUS = {
		name = "<name>",
		race = "<race>",
		class = "<class>",
	},
	esES = {
		name = "<nombre>",
		race = "<raza>",
		class = "<clase>",
	},
	esMX = {
		name = "<nombre>",
		race = "<raza>",
		class = "<clase>",
	},
	frFR = {
		name = "<nom>",
		race = "<race>",
		class = "<classe>",
	},
	koKR = {
		name = "<name>",
		race = "<race>",
		class = "<class>",
	},
	ptBR = {
		name = "<nome>",
		race = "<Raça>",
		class = "<class>",
	},
	ruRU = {
		name = "<имя>",
		race = "<раса>",
		class = "<класс>",
	},
	zhCN = {
		name = "<name>",
		race = "<race>",
		class = "<class>",
	},
	zhTW = {
		name = "<name>",
		race = "<race>",
		class = "<class>",
	},
};
UILOC.LOC_PATTERN_LIST = LOC_PATTERN_LIST;
UILOC.LOC_PATTERN = LOC_PATTERN_LIST[LOCALE];
if LOCALE == 'zhCN' then
	--	tip
	UILOC.TIP_WAYPOINT = "侦察";
	UILOC.TIP_QUEST_LVL = "等级: ";
	UILOC.TIP_QUEST_MIN = "可接: ";
	UILOC.QUEST_TAG = {
		[1] = "+",				--	Group
		[41] = "P",				--	PVP
		[64] = "团",			--	Raid
		[81] = "地",			--	Dungeon
		[83] = "Legendary",
		[85] = "Heroic",
		[98] = "Scenario",
		[102] = "Account",
		[117] = "Leatherworking World Quest",
	};
	UILOC.COMPLETED = "已完成";
	UILOC.IN_PROGRESS = "进行中";
	--	setting
	UILOC.TAG_SETTING = "有爱任务辅助";
	UILOC['tab.general'] = "综合";
	UILOC['tab.map'] = "地图";
	UILOC['tab.interact'] = "交互";
	UILOC['tab.misc'] = "杂项";
	UILOC['tab.blocked'] = "已隐藏";
	--	general
	UILOC.show_db_icon = "显示小地图设置菜单按钮";
	UILOC.show_buttons_in_log = "显示任务日志按钮";
	UILOC.show_id_in_tooltip = "在鼠标提示中显示id";
	--	map
	UILOC.show_quest_starter = "显示任务给予者";
	UILOC.show_quest_ender = "显示任务交还者";
	UILOC.min_rate = "最低物品掉率";
	UILOC.worldmap_alpha = "世界地图图标透明度";
	UILOC.minimap_alpha = "小地图图标透明度";
	UILOC.pin_size = "普通标记点大小";
	UILOC.large_size = "boss标记点大小";
	UILOC.varied_size = "交接npc标记点大小";
	UILOC.pin_scale_max = "地图缩放时标记点的最大缩放";
	UILOC.quest_lvl_lowest_ofs = "最低任务等级偏差";
	UILOC.quest_lvl_highest_ofs = "最高任务等级偏差";
	UILOC.hide_node_modifier = "弹出隐藏任务按键";
	UILOC.minimap_node_inset = "不显示小地图边缘上的任务图标";
	UILOC.minimap_player_arrow_on_top = "置顶小地图玩家箭头";
	--	interact
	UILOC.auto_accept = "自动接任务";
	UILOC.auto_complete = "自动交任务";
	UILOC.quest_auto_inverse_modifier = "自动交接反向按键";
	UILOC.objective_tooltip_info = "显示物件鼠标提示";
	--	questlogframe
	UILOC.show_quest = "显示";
	UILOC.hide_quest = "隐藏";
	UILOC.reset_filter = "重置";
	--	pin-onmenu
	UILOC.pin_menu_hide_quest = "|cffff3f00隐藏|r ";
	UILOC.pin_menu_show_quest = "|cff00ff00显示|r ";
	UILOC.pin_menu_send_quest = "|cffff7f00发送|r";
	--
	UILOC.CODEX_LITE_CONFLICTS = "是否关闭功能重复的插件ClassicCodex和Questie，并重载？";
elseif LOCALE == 'zhTW' then
	--	tip
	UILOC.TIP_WAYPOINT = "偵察";
	UILOC.TIP_QUEST_LVL = "等级: ";
	UILOC.TIP_QUEST_MIN = "可接: ";
	UILOC.QUEST_TAG = {
		[1] = "+",				--	Group
		[41] = "P",				--	PVP
		[64] = "團",			--	Raid
		[81] = "地",			--	Dungeon
		[83] = "Legendary",
		[85] = "Heroic",
		[98] = "Scenario",
		[102] = "Account",
		[117] = "Leatherworking World Quest",
	};
	UILOC.COMPLETED = "已完成";
	UILOC.IN_PROGRESS = "進行中";
	--	setting
	UILOC.TAG_SETTING = "有愛任務輔助";
	UILOC['tab.general'] = "綜合";
	UILOC['tab.map'] = "地圖";
	UILOC['tab.interact'] = "交互";
	UILOC['tab.misc'] = "雜項";
	UILOC['tab.blocked'] = "已隱藏";
	--	general
	UILOC.show_db_icon = "顯示小地圖設置菜單按鈕";
	UILOC.show_buttons_in_log = "顯示任務日志按鈕";
	UILOC.show_id_in_tooltip = "在鼠標提示中顯示id";
	--	map
	UILOC.show_quest_starter = "顯示任務給與者";
	UILOC.show_quest_ender = "顯示任務交還者";
	UILOC.min_rate = "最低物品掉率";
	UILOC.worldmap_alpha = "世界地圖圖標透明度";
	UILOC.minimap_alpha = "小地圖圖標透明度";
	UILOC.pin_size = "普通標記點大小";
	UILOC.large_size = "boss標記點大小";
	UILOC.varied_size = "交接npc標記點大小";
	UILOC.pin_scale_max = "地圖縮放時標記點的最大縮放";
	UILOC.quest_lvl_lowest_ofs = "最低任務等級偏差";
	UILOC.quest_lvl_highest_ofs = "最高任務等級偏差";
	UILOC.minimap_node_inset = "不顯示小地圖邊緣上的任務圖標";
	UILOC.hide_node_modifier = "彈出隱藏任務按鍵";
	UILOC.minimap_player_arrow_on_top = "置頂小地圖玩家箭頭";
	--	interact
	UILOC.auto_accept = "自動接任務";
	UILOC.auto_complete = "自動交任務";
	UILOC.quest_auto_inverse_modifier = "自動交接反向按鍵";
	UILOC.objective_tooltip_info = "顯示物件鼠標提示";
	--	questlogframe
	UILOC.show_quest = "顯示";
	UILOC.hide_quest = "隱藏";
	UILOC.reset_filter = "重置";
	--	pin-onmenu
	UILOC.pin_menu_hide_quest = "|cffff3f00隱藏|r ";
	UILOC.pin_menu_show_quest = "|cff00ff00顯示|r ";
	UILOC.pin_menu_send_quest = "|cffff7f00發送|r";
	--
	UILOC.CODEX_LITE_CONFLICTS = "是否关闭功能重复的插件ClassicCodex和Questie，并重载？";
else
	--	tip
	UILOC.TIP_WAYPOINT = "Explore";
	UILOC.TIP_QUEST_LVL = "Lvl: ";
	UILOC.TIP_QUEST_MIN = "Min: ";
	UILOC.QUEST_TAG = {
		[1] = "+",				--	Group
		[41] = "P",				--	PVP
		[64] = "R",				--	Raid
		[81] = "D",				--	Dungeon
		[83] = "Legendary",
		[85] = "Heroic",
		[98] = "Scenario",
		[102] = "Account",
		[117] = "Leatherworking World Quest",
	};
	UILOC.COMPLETED = "COMPLETED";
	UILOC.IN_PROGRESS = "Progress";
	--	setting
	UILOC.TAG_SETTING = "CodexLite";
	UILOC['tab.general'] = "General";
	UILOC['tab.map'] = "Map";
	UILOC['tab.interact'] = "Interact";
	UILOC['tab.misc'] = "Misc";
	UILOC['tab.blocked'] = "Blocked";
	--	general
	UILOC.show_db_icon = "Show DBIcon around minimap";
	UILOC.show_buttons_in_log = "Show buttons in questlog";
	UILOC.show_id_in_tooltip = "Show ID in tooltip";
	--	map
	UILOC.show_quest_starter = "Show Quest Giver";
	UILOC.show_quest_ender = "Show Quest Turn In";
	UILOC.min_rate = "Minium Drop Rate";
	UILOC.worldmap_alpha = "Alpha of icons on world map";
	UILOC.minimap_alpha = "Alpha of icons on minimap";
	UILOC.pin_size = "Size of normal pins";
	UILOC.large_size = "Size of BOSS pins";
	UILOC.varied_size = "Size of NPC pins";
	UILOC.pin_scale_max = "Maxium scale size";
	UILOC.quest_lvl_lowest_ofs = "Lowest Level Offset";
	UILOC.quest_lvl_highest_ofs = "Highest Level Offset";
	UILOC.minimap_node_inset = "Hide pin on the border of minimap";
	UILOC.hide_node_modifier = "Modifier of hiding quest";
	UILOC.minimap_player_arrow_on_top = "Player arrow on the top of minimap";
	--	interact
	UILOC.auto_accept = "Quest Auto Accept";
	UILOC.auto_complete = "Quest Auto Complete";
	UILOC.quest_auto_inverse_modifier = "Auto-Turn-In inverse modifier";
	UILOC.objective_tooltip_info = "Info in objective's tooltip";
	--	questlogframe
	UILOC.show_quest = "Show";
	UILOC.hide_quest = "Hide";
	UILOC.reset_filter = "Reset";
	--	pin-onmenu
	UILOC.pin_menu_hide_quest = "|cffff3f00Hide|r ";
	UILOC.pin_menu_show_quest = "|cff00ff00Show|r ";
	UILOC.pin_menu_send_quest = "|cffff7f00Send|r";
	--
	UILOC.CODEX_LITE_CONFLICTS = "Disable ClassicCodex and Questie, then reload UI?";
end

--[=[dev]=]	if __ns.__dev then __ns.__performance_log_tick('module.locale'); end
