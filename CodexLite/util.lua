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
--[=[dev]=]	if __ns.__dev then __ns._F_devDebugProfileStart('module.util'); end

-->		variables
	local type = type;
	local next = next;
	local tonumber = tonumber;
	local strsplit, strmatch, gsub = strsplit, strmatch, gsub;
	local GetItemInfoInstant = GetItemInfoInstant;
	local UnitGUID = UnitGUID;
	local UnitIsPlayer = UnitIsPlayer;
	local IsAltKeyDown = IsAltKeyDown;
	local IsControlKeyDown = IsControlKeyDown;
	local IsShiftKeyDown = IsShiftKeyDown;
	local GetQuestLogTitle = GetQuestLogTitle;
	local GetItemCount = GetItemCount;
	local GetMouseFocus = GetMouseFocus;
	local IsModifiedClick = IsModifiedClick;
	local ChatEdit_GetActiveWindow = ChatEdit_GetActiveWindow;
	local ChatEdit_InsertLink = ChatEdit_InsertLink;
	local GameTooltip = GameTooltip;
	local ChatFrame2 = ChatFrame2;
	local FauxScrollFrame_GetOffset = FauxScrollFrame_GetOffset;

	local __db = __ns.db;
	local __db_quest = __db.quest;
	local __db_unit = __db.unit;
	local __db_item = __db.item;
	local __db_object = __db.object;
	local __db_refloot = __db.refloot;
	local __db_event = __db.event;
	local __db_level_quest_list = __db.level_quest_list;
	local __db_avl_quest_hash = __db.avl_quest_hash;
	local __db_blacklist_item = __db.blacklist_item;
	local __db_large_pin = __db.large_pin;
	local __db_item_related_quest = __db.item_related_quest;

	local __loc = __ns.L;
	local __loc_quest = __loc.quest;
	local __loc_unit = __loc.unit;
	local __loc_item = __loc.item;
	local __loc_object = __loc.object;
	local __loc_profession = __loc.profession;
	local __UILOC = __ns.UILOC;

	local _F_SafeCall = __ns.core._F_SafeCall;
	local __eventHandler = __ns.core.__eventHandler;
	local __const = __ns.core.__const;
	local IMG_INDEX = __ns.core.IMG_INDEX;
	local IMG_LIST = __ns.core.IMG_LIST;
	local TIP_IMG_LIST = __ns.core.TIP_IMG_LIST;
	local GetQuestStartTexture = __ns.core.GetQuestStartTexture;

	local __core_meta = __ns.__core_meta;
	local __obj_lookup = __ns.__obj_lookup;
	local __core_quests_completed = __ns.__core_quests_completed;
	local __map_meta = __ns.__map_meta;
	local __comm_meta = __ns.__comm_meta;
	local __comm_obj_lookup = __ns.__comm_obj_lookup;

	local UnitHelpFac = __ns.core.UnitHelpFac;
	local _log_ = __ns._log_;

	local TIP_IMG_S_NORMAL = TIP_IMG_LIST[IMG_INDEX.IMG_S_NORMAL];
	local IMG_TAG_CPL = "\124T" .. __ns.core.IMG_PATH .. "TAG_CPL" .. ":0\124t";
	local IMG_TAG_PRG = "\124T" .. __ns.core.IMG_PATH .. "TAG_PRG" .. ":0\124t";
	local IMG_TAG_UNCPL = "\124T" .. __ns.core.IMG_PATH .. "TAG_UNCPL" .. ":0\124t";

	local SET = nil;
-->		MAIN
	-->		methods
		local function GetLevelTag(quest, info, modifier, colored)
			local lvl_str = "[";
				local tag = __ns.GetQuestTagInfo(quest);
				if tag ~= nil then
					tag = __UILOC.QUEST_TAG[tag];
				end
				local min = info.min;
				local lvl = info.lvl;
				if lvl <= 0 then
					lvl = min;
				end
				if colored ~= false then
					if lvl >= SET.quest_lvl_red then
						lvl_str = lvl_str .. "\124cffff0000" .. (tag ~= nil and (lvl .. tag) or lvl) .. "\124r";
					elseif lvl >= SET.quest_lvl_orange then
						lvl_str = lvl_str .. "\124cffff7f7f" .. (tag ~= nil and (lvl .. tag) or lvl) .. "\124r";
					elseif lvl >= SET.quest_lvl_yellow then
						lvl_str = lvl_str .. "\124cffffff00" .. (tag ~= nil and (lvl .. tag) or lvl) .. "\124r";
					elseif lvl >= SET.quest_lvl_green then
						lvl_str = lvl_str .. "\124cff7fbf3f" .. (tag ~= nil and (lvl .. tag) or lvl) .. "\124r";
					else
						lvl_str = lvl_str .. "\124cff7f7f7f" .. (tag ~= nil and (lvl .. tag) or lvl) .. "\124r";
					end
					if modifier then
						lvl_str = lvl_str .. "/";
						local diff = min - __ns.__player_level;
						if diff > 0 then
							if diff > 1 then
								lvl_str = lvl_str .. "\124cffff3f3f" .. min .. "\124r";
							else
								lvl_str = lvl_str .. "\124cffff0f0f" .. min .. "\124r";
							end
						else
							if min >= SET.quest_lvl_red then
								lvl_str = lvl_str .. "\124cffff0000" .. min .. "\124r";
							elseif min >= SET.quest_lvl_orange then
								lvl_str = lvl_str .. "\124cffff7f7f" .. min .. "\124r";
							elseif min >= SET.quest_lvl_yellow then
								lvl_str = lvl_str .. "\124cffffff00" .. min .. "\124r";
							elseif min >= SET.quest_lvl_green then
								lvl_str = lvl_str .. "\124cff7fbf3f" .. min .. "\124r";
							else
								lvl_str = lvl_str .. "\124cff7f7f7f" .. min .. "\124r";
							end
						end
					end
				else
					if lvl >= SET.quest_lvl_red then
						lvl_str = lvl_str .. (tag ~= nil and (lvl .. tag) or lvl);
					elseif lvl >= SET.quest_lvl_orange then
						lvl_str = lvl_str .. (tag ~= nil and (lvl .. tag) or lvl);
					elseif lvl >= SET.quest_lvl_yellow then
						lvl_str = lvl_str .. (tag ~= nil and (lvl .. tag) or lvl);
					elseif lvl >= SET.quest_lvl_green then
						lvl_str = lvl_str .. (tag ~= nil and (lvl .. tag) or lvl);
					else
						lvl_str = lvl_str .. (tag ~= nil and (lvl .. tag) or lvl);
					end
					if modifier then
						lvl_str = lvl_str .. "/";
						local diff = min - __ns.__player_level;
						if diff > 0 then
							if diff > 1 then
								lvl_str = lvl_str .. min;
							else
								lvl_str = lvl_str .. min;
							end
						else
							if min >= SET.quest_lvl_red then
								lvl_str = lvl_str .. min;
							elseif min >= SET.quest_lvl_orange then
								lvl_str = lvl_str .. min;
							elseif min >= SET.quest_lvl_yellow then
								lvl_str = lvl_str .. min;
							elseif min >= SET.quest_lvl_green then
								lvl_str = lvl_str .. min;
							else
								lvl_str = lvl_str .. min;
							end
						end
					end
				end
				lvl_str = lvl_str .. "]";
			return lvl_str;
		end
		local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
		local CLASS_ICON_TCOORDS = CLASS_ICON_TCOORDS;
		local function GetPlayerTag(name, class)
			if class == nil then
				return " > " .. name;
			else
				local color = RAID_CLASS_COLORS[class];
				local coord = CLASS_ICON_TCOORDS[class];
				return format(" > \124TInterface\\TargetingFrame\\UI-Classes-Circles:0:0:0:0:256:256:%d:%d:%d:%d\124t \124cff%.2x%.2x%.2x%s\124r",
							coord[1] * 256, coord[2] * 256, coord[3] * 256, coord[4] * 256,
							color.r * 255, color.g * 255, color.b * 255, name
						);
			end
		end
		-->
		-->
	-->		performance board
		--	display
		local function Create()
			local frame = CreateFrame("FRAME", nil, UIParent);
			frame:SetSize(256, 512);
			frame:SetPoint("CENTER");
		end
	-->		events and hooks
		local function GameTooltipSetQuestTip(tip, uuid, META)
			local modifier = IsShiftKeyDown();
			local refs = uuid[4];
			if next(refs) ~= nil then
				for quest, ref in next, refs do
					if META == nil then
						META = __core_meta;
					end
					local meta = META[quest];
					local info = __db_quest[quest];
					local color = IMG_LIST[GetQuestStartTexture(info)];
					--[[
						local lvl_str = "\124cff000000**\124r[ ";
							local lvl = info.lvl;
							local min = info.min;
							lvl_str = lvl_str .. __UILOC.TIP_QUEST_LVL;
							if lvl >= SET.quest_lvl_red then
								lvl_str = lvl_str .. "\124cffff0000" .. lvl .. "\124r ";
							elseif lvl >= SET.quest_lvl_orange then
								lvl_str = lvl_str .. "\124cffff7f7f" .. lvl .. "\124r ";
							elseif lvl >= SET.quest_lvl_yellow then
								lvl_str = lvl_str .. "\124cffffff00" .. lvl .. "\124r ";
							elseif lvl >= SET.quest_lvl_green then
								lvl_str = lvl_str .. "\124cff7fbf3f" .. lvl .. "\124r ";
							else
								lvl_str = lvl_str .. "\124cff7f7f7f" .. lvl .. "\124r ";
							end
							lvl_str = lvl_str .. __UILOC.TIP_QUEST_MIN;
							if min >= SET.quest_lvl_red then
								lvl_str = lvl_str .. "\124cffff0000" .. min .. "\124r ]\124cff000000**\124r";
							elseif min >= SET.quest_lvl_orange then
								lvl_str = lvl_str .. "\124cffff7f7f" .. min .. "\124r ]\124cff000000**\124r";
							elseif min >= SET.quest_lvl_yellow then
								lvl_str = lvl_str .. "\124cffffff00" .. min .. "\124r ]\124cff000000**\124r";
							elseif min >= SET.quest_lvl_green then
								lvl_str = lvl_str .. "\124cff7fbf3f" .. min .. "\124r ]\124cff000000**\124r";
							else
								lvl_str = lvl_str .. "\124cff7f7f7f" .. min .. "\124r ]\124cff000000**\124r";
							end
						if meta ~= nil then
							if line == 'start' then
								tip:AddLine(TIP_IMG_S_NORMAL .. meta.title .. "(" .. quest .. ")", color[2], color[3], color[4]);
								tip:AddLine(lvl_str, 1.0, 1.0, 1.0);
								if modifier then
									local loc = __loc_quest[quest];
									if loc ~= nil and loc[3] ~= nil then
										for _, text in next, loc[3] do
											tip:AddLine("\124cff000000**\124r" .. text, 1.0, 0.75, 0.0);
										end
									end
								end
							elseif line == 'end' then
								if meta.completed == 1 then
									tip:AddLine(TIP_IMG_LIST[IMG_INDEX.IMG_E_COMPLETED] .. meta.title .. "(" .. quest .. ")", color[2], color[3], color[4]);
									tip:AddLine(lvl_str, 1.0, 1.0, 1.0);
								elseif meta.completed == 0 then
									tip:AddLine(TIP_IMG_LIST[IMG_INDEX.IMG_E_UNCOMPLETED] .. meta.title .. "(" .. quest .. ")", color[2], color[3], color[4]);
									tip:AddLine(lvl_str, 1.0, 1.0, 1.0);
								end
								if modifier then
									local loc = __loc_quest[quest];
									if loc ~= nil and loc[3] ~= nil then
										for _, text in next, loc[3] do
											tip:AddLine("\124cff000000**\124r" .. text, 1.0, 0.75, 0.0);
										end
									end
								end
							elseif line == 'event' then
								tip:AddLine(TIP_IMG_S_NORMAL .. meta.title .. "(" .. quest .. ")", color[2], color[3], color[4]);
								tip:AddLine(lvl_str, 1.0, 1.0, 1.0);
								for index = 1, #meta do
									local meta_line = meta[index];
									if meta_line[2] == 'event' or meta_line[2] == 'log' then
										tip:AddLine("\124cff000000**\124r" .. meta_line[4], 1.0, 0.5, 0.0);
									end
								end
							else
								tip:AddLine(TIP_IMG_S_NORMAL .. meta.title .. "(" .. quest .. ")", color[2], color[3], color[4]);
								tip:AddLine(lvl_str, 1.0, 1.0, 1.0);
								if line > 0 then
									local meta_line = meta[line];
									if meta_line ~= nil then
										if meta_line[5] then
											tip:AddLine("\124cff000000**\124r" .. meta_line[4], 0.5, 1.0, 0.0);
										else
											tip:AddLine("\124cff000000**\124r" .. meta_line[4], 1.0, 0.5, 0.0);
										end
									end
								else
									line = - line;
									local meta_line = meta[line];
									if meta_line ~= nil then
										if meta_line[5] then
											tip:AddLine("\124cff000000**\124r" .. meta_line[4], 0.5, 1.0, 0.0);
										else
											tip:AddLine("\124cff000000**\124r" .. meta_line[4], 1.0, 0.5, 0.0);
										end
									end
								end
							end
						else
							local loc = __loc_quest[quest];
							if loc ~= nil then
								tip:AddLine(TIP_IMG_S_NORMAL .. loc[1] .. "(" .. quest .. ")", color[2], color[3], color[4]);
								if modifier and loc[3] then
									for _, text in next, loc[3] do
										tip:AddLine("\124cff000000**\124r" .. text, 1.0, 0.75, 0.0);
									end
								end
							else
								tip:AddLine(TIP_IMG_S_NORMAL .. "quest:" .. quest, color[2], color[3], color[4]);
							end
							tip:AddLine(lvl_str, 1.0, 1.0, 1.0);
						end
					--]]
					local lvl_str = GetLevelTag(quest, info, modifier);
					if meta ~= nil then
						if SET.show_id_in_tooltip then
							if ref['end'] then
								if meta.completed == 1 then
									tip:AddLine(TIP_IMG_LIST[IMG_INDEX.IMG_E_COMPLETED] .. lvl_str .. meta.title .. "(" .. quest .. ")", color[2], color[3], color[4]);
								elseif meta.completed == 0 then
									tip:AddLine(TIP_IMG_LIST[IMG_INDEX.IMG_E_UNCOMPLETED] .. lvl_str .. meta.title .. "(" .. quest .. ")", color[2], color[3], color[4]);
								end
							else
								tip:AddLine(TIP_IMG_S_NORMAL .. lvl_str .. meta.title .. "(" .. quest .. ")", color[2], color[3], color[4]);
							end
						else
							if ref['end'] then
								if meta.completed == 1 then
									tip:AddLine(TIP_IMG_LIST[IMG_INDEX.IMG_E_COMPLETED] .. lvl_str .. meta.title, color[2], color[3], color[4]);
								elseif meta.completed == 0 then
									tip:AddLine(TIP_IMG_LIST[IMG_INDEX.IMG_E_UNCOMPLETED] .. lvl_str .. meta.title, color[2], color[3], color[4]);
								end
							else
								tip:AddLine(TIP_IMG_S_NORMAL .. lvl_str .. meta.title, color[2], color[3], color[4]);
							end
						end
						for line, _ in next, ref do
							if line == 'start' or line == 'end' then
								if modifier then
									local loc = __loc_quest[quest];
									if loc ~= nil and loc[3] ~= nil then
										for _, text in next, loc[3] do
											tip:AddLine("\124cff000000**\124r" .. text, 1.0, 0.75, 0.0);
										end
									end
								end
							elseif line == 'event' then
								for index = 1, #meta do
									local meta_line = meta[index];
									if meta_line[2] == 'event' or meta_line[2] == 'log' then
										tip:AddLine("\124cff000000**\124r" .. meta_line[4], 1.0, 0.5, 0.0);
									end
								end
							else
								if line > 0 then
									local meta_line = meta[line];
									if meta_line ~= nil then
										if meta_line[5] then
											tip:AddLine("\124cff000000**\124r" .. meta_line[4], 0.5, 1.0, 0.0);
										else
											tip:AddLine("\124cff000000**\124r" .. meta_line[4], 1.0, 0.5, 0.0);
										end
									end
								else
									line = - line;
									local meta_line = meta[line];
									if meta_line ~= nil then
										if meta_line[5] then
											tip:AddLine("\124cff000000**\124r" .. meta_line[4], 0.5, 1.0, 0.0);
										else
											tip:AddLine("\124cff000000**\124r" .. meta_line[4], 1.0, 0.5, 0.0);
										end
									end
								end
							end
						end
					else
						local loc = __loc_quest[quest];
						if loc ~= nil and loc[1] ~= nil then
							if SET.show_id_in_tooltip then
								tip:AddLine(TIP_IMG_S_NORMAL .. lvl_str .. loc[1] .. "(" .. quest .. ")", color[2], color[3], color[4]);
							else
								tip:AddLine(TIP_IMG_S_NORMAL .. lvl_str .. loc[1], color[2], color[3], color[4]);
							end
							if modifier and loc[3] then
								for _, text in next, loc[3] do
									tip:AddLine("\124cff000000**\124r" .. text, 1.0, 0.75, 0.0);
								end
							end
						else
							tip:AddLine(TIP_IMG_S_NORMAL .. lvl_str .. "quest:" .. quest, color[2], color[3], color[4]);
						end
					end
				end
				tip:Show();
			end
		end
		local function OnTooltipSetUnit(self)
			if SET.objective_tooltip_info then
				local _, unit = self:GetUnit();
				if unit and not UnitIsPlayer(unit) then
					local GUID = UnitGUID(unit);
					if GUID ~= nil then
						-- local _, _, _id = strfind(GUID, "Creature%-0%-%d+%-%d+%-%d+%-(%d+)%-%x+");
						local _type, _, _, _, _, _id = strsplit("-", GUID);
						if _type == "Creature" and _id ~= nil then
							_id = tonumber(_id);
							if _id ~= nil then
								local uuid = __ns.CoreGetUUID('unit', _id);
								if uuid ~= nil then
									GameTooltipSetQuestTip(GameTooltip, uuid);
								end
								for name, val in next, __ns.__comm_group_members do
									local meta_table = __comm_meta[name];
									if meta_table ~= nil then
										local uuid = __ns.CommGetUUID(name, 'unit', _id);
										if uuid ~= nil and next(uuid[4]) ~= nil then
											local info = __ns.__comm_group_members_info[name];
											GameTooltip:AddLine(GetPlayerTag(name, info ~= nil and info[4]));
											GameTooltipSetQuestTip(GameTooltip, uuid, meta_table);
										end
									end
								end
							end
						end
					end
				end
			end
		end
		local function OnTooltipSetItem(tip)
			if SET.objective_tooltip_info then
				local name, link = tip:GetItem();
				if link ~= nil then
					local id = GetItemInfoInstant(link);
					if id ~= nil then
						local QUESTS = __db_item_related_quest[id];
						if QUESTS ~= nil and QUESTS[1] ~= nil then
							local modifier = IsShiftKeyDown();
							for _, quest in next, QUESTS do
								local meta = __core_meta[quest];
								if meta ~= nil then
									local qinfo = __db_quest[quest];
									local color = IMG_LIST[GetQuestStartTexture(qinfo)];
									local lvl_str = GetLevelTag(quest, qinfo, modifier);
									if modifier then
										if meta.completed == 1 then
											tip:AddLine(TIP_IMG_LIST[IMG_INDEX.IMG_E_COMPLETED] .. IMG_TAG_PRG .. lvl_str .. meta.title, 1.0, 0.9, 0.0);
										elseif meta.completed == 0 then
											tip:AddLine(TIP_IMG_LIST[IMG_INDEX.IMG_E_UNCOMPLETED] .. IMG_TAG_PRG .. lvl_str .. meta.title, 1.0, 0.9, 0.0);
										end
									else
										if meta.completed == 1 then
											tip:AddLine(TIP_IMG_LIST[IMG_INDEX.IMG_E_COMPLETED] ..  lvl_str .. meta.title, 1.0, 0.9, 0.0);
										elseif meta.completed == 0 then
											tip:AddLine(TIP_IMG_LIST[IMG_INDEX.IMG_E_UNCOMPLETED] .. lvl_str .. meta.title, 1.0, 0.9, 0.0);
										end
									end
									for index = 1, #meta do
										local meta_line = meta[index];
										if meta_line[2] == 'item' and meta_line[3] == id then
											if meta_line[5] then
												tip:AddLine("\124cff000000**\124r" .. meta_line[4], 0.5, 1.0, 0.0);
											else
												tip:AddLine("\124cff000000**\124r" .. meta_line[4], 1.0, 0.5, 0.0);
											end
											break;
										end
									end
									tip:Show();
								end
							end
							if modifier then
								for _, quest in next, QUESTS do
									if __core_meta[quest] == nil and __db_avl_quest_hash[quest] ~= nil then
										local qinfo = __db_quest[quest];
										local color = IMG_LIST[GetQuestStartTexture(qinfo)];
										local lvl_str = GetLevelTag(quest, qinfo, true);
										local loc = __loc_quest[quest];
										if loc ~= nil then
											if SET.show_id_in_tooltip then
												if __core_quests_completed[quest] ~= nil then
													tip:AddLine(TIP_IMG_S_NORMAL .. IMG_TAG_CPL .. lvl_str .. loc[1] .. "(" .. quest .. ")", color[2], color[3], color[4]);
												else
													tip:AddLine(TIP_IMG_S_NORMAL .. IMG_TAG_UNCPL .. lvl_str .. loc[1] .. "(" .. quest .. ")", color[2], color[3], color[4]);
												end
											else
												if __core_quests_completed[quest] ~= nil then
													tip:AddLine(TIP_IMG_S_NORMAL .. IMG_TAG_CPL .. lvl_str .. loc[1], color[2], color[3], color[4]);
												else
													tip:AddLine(TIP_IMG_S_NORMAL .. IMG_TAG_UNCPL .. lvl_str .. loc[1], color[2], color[3], color[4]);
												end
											end
										else
											if __core_quests_completed[quest] ~= nil then
												tip:AddLine(TIP_IMG_S_NORMAL .. IMG_TAG_CPL .. lvl_str .. "quest:" .. quest, color[2], color[3], color[4]);
											else
												tip:AddLine(TIP_IMG_S_NORMAL .. IMG_TAG_UNCPL .. lvl_str .. "quest:" .. quest, color[2], color[3], color[4]);
											end
										end
										tip:Show();
									end
								end
							end
							for name, val in next, __ns.__comm_group_members do
								local meta_table = __comm_meta[name];
								if meta_table ~= nil then
									local first_line_of_partner = true;
									for _, quest in next, QUESTS do
										local meta = meta_table[quest];
										if meta ~= nil then
											if first_line_of_partner then
												first_line_of_partner = false;
												local info = __ns.__comm_group_members_info[name];
												GameTooltip:AddLine(GetPlayerTag(name, info ~= nil and info[4]));
											end
											local qinfo = __db_quest[quest];
											local color = IMG_LIST[GetQuestStartTexture(qinfo)];
											local lvl_str = GetLevelTag(quest, qinfo, modifier);
											if meta.completed == 1 then
												tip:AddLine(TIP_IMG_LIST[IMG_INDEX.IMG_E_COMPLETED] ..  lvl_str .. meta.title, 1.0, 0.9, 0.0);
											elseif meta.completed == 0 then
												tip:AddLine(TIP_IMG_LIST[IMG_INDEX.IMG_E_UNCOMPLETED] .. lvl_str .. meta.title, 1.0, 0.9, 0.0);
											end
											for index = 1, #meta do
												local meta_line = meta[index];
												if meta_line[2] == 'item' and meta_line[3] == id then
													if meta_line[5] then
														tip:AddLine("\124cff000000**\124r" .. meta_line[4], 0.5, 1.0, 0.0);
													else
														tip:AddLine("\124cff000000**\124r" .. meta_line[4], 1.0, 0.5, 0.0);
													end
													break;
												end
											end
											tip:Show();
										end
									end
								end
							end
						end
					end
				end
			end
		end
		__ns.GameTooltipSetQuestTip = GameTooltipSetQuestTip;
		--	object
		local GameTooltipTextLeft1Text = nil;
		local updateTimer = 0.0;
		local function GameTooltipOnUpdate(self, elasped)
			if SET.objective_tooltip_info then
				if updateTimer <= 0.0 then
					updateTimer = 0.1;
					local uname, unit = self:GetUnit();
					local iname, link = self:GetItem();
					if uname == nil and unit == nil and iname == nil and link == nil then
						local text = GameTooltipTextLeft1:GetText();
						if text ~= nil and text ~= GameTooltipTextLeft1Text then
							GameTooltipTextLeft1Text = text;
							local oid = __obj_lookup[text];
							if oid ~= nil then
								local uuid = __ns.CoreGetUUID('object', oid);
								if uuid ~= nil then
									GameTooltipSetQuestTip(GameTooltip, uuid);
								end
								for name, val in next, __ns.__comm_group_members do
									local meta_table = __comm_meta[name];
									if meta_table ~= nil then
										local uuid = __ns.CommGetUUID(name, 'object', oid);
										if uuid ~= nil then
											local info = __ns.__comm_group_members_info[name];
											GameTooltip:AddLine(GetPlayerTag(name, info ~= nil and info[4]));
											GameTooltipSetQuestTip(GameTooltip, uuid, meta_table);
										end
									end
								end
							end
							local oid = __comm_obj_lookup[text];
							if oid ~= nil then
							end
						end
					end
				else
					updateTimer = updateTimer - elasped;
				end
			end
		end
		function __ns.MODIFIER_STATE_CHANGED()
			local focus = GetMouseFocus();
			if focus ~= nil and focus.__PIN_TAG ~= nil then
				__ns.Pin_OnEnter(focus);
			end
			if GameTooltip:IsShown() then
			end
		end
		function __ns.GameTooltipSetInfo(type, id)
			if type == 'event' then
				GameTooltip:AddLine(__UILOC.TIP_WAYPOINT, 0.0, 1.0, 0.0);
			else
				local _loc = __loc[type];
				if _loc ~= nil then
					if SET.show_id_in_tooltip then
						if type == 'unit' then
							local info = __db_unit[id];
							if info ~= nil then
								if UnitHelpFac[info.fac] then
									GameTooltip:AddLine(_loc[id] .. "(" .. id .. ")", 0.0, 1.0, 0.0);
								else
									local facId = info.facId;
									if facId ~= nil then
										local _, _, standing_rank, _, _, val = GetFactionInfoByID(facId);
										if standing_rank == nil then
											GameTooltip:AddLine(_loc[id] .. "(" .. id .. ")", 1.0, 0.0, 0.0);
										elseif standing_rank == 4 then
											GameTooltip:AddLine(_loc[id] .. "(" .. id .. ")", 1.0, 1.0, 0.0);
										elseif standing_rank < 4 then
											GameTooltip:AddLine(_loc[id] .. "(" .. id .. ")", 1.0, (standing_rank - 1) * 0.25, 0.0);
										else
											GameTooltip:AddLine(_loc[id] .. "(" .. id .. ")", 0.5 - (standing_rank - 4) * 0.125, 1.0, 0.0);
										end
									else
										GameTooltip:AddLine(_loc[id] .. "(" .. id .. ")", 1.0, 0.0, 0.0);
									end
								end
							end
						else
							GameTooltip:AddLine(_loc[id] .. "(" .. id .. ")", 1.0, 1.0, 1.0);
						end
					else
						if type == 'unit' then
							local info = __db_unit[id];
							if info ~= nil then
								if UnitHelpFac[info.fac] then
									GameTooltip:AddLine(_loc[id], 0.0, 1.0, 0.0);
								else
									local facId = info.facId;
									if facId ~= nil then
										local _, _, standing_rank, _, _, val = GetFactionInfoByID(facId);
										if standing_rank == nil then
											GameTooltip:AddLine(_loc[id], 1.0, 0.0, 0.0);
										elseif standing_rank == 4 then
											GameTooltip:AddLine(_loc[id], 1.0, 1.0, 0.0);
										elseif standing_rank < 4 then
											GameTooltip:AddLine(_loc[id], 1.0, (standing_rank - 1) * 0.25, 0.0);
										else
											GameTooltip:AddLine(_loc[id], 0.5 - (standing_rank - 4) * 0.125, 1.0, 0.0);
										end
									else
										GameTooltip:AddLine(_loc[id], 1.0, 0.0, 0.0);
									end
								end
							end
						else
							GameTooltip:AddLine(_loc[id], 1.0, 1.0, 1.0);
						end
					end
				end
			end
			local uuid = __ns.CoreGetUUID(type, id);
			if uuid ~= nil then
				__ns.GameTooltipSetQuestTip(GameTooltip, uuid);
			end
		end
		function __ns.button_info_OnEnter(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			local info_lines = self.info_lines;
			if info_lines then
				for index = 1, #info_lines do
					GameTooltip:AddLine(info_lines[index]);
				end
			end
			GameTooltip:Show();
		end
		function __ns.OnLeave(self)
			if GameTooltip:IsOwned(self) then
				GameTooltip:Hide();
			end
		end
		local function drop_handler_send(_, quest)
			local info = __db_quest[quest];
			local loc = __loc_quest[quest];
			local lvl = info.lvl;
			if lvl <= 0 then
				lvl = info.min;
			end
			local activeWindow = ChatEdit_GetActiveWindow();
			if activeWindow ~= nil then
				activeWindow:Insert("[[" .. lvl .. "] " .. (loc ~= nil and loc[1] or "Quest: " .. quest) .. " (" .. quest .. ")]");
			end
			-- ChatEdit_InsertLink("[[" .. lvl .. "] " .. (loc ~= nil and loc[1] or "Quest: " .. quest) .. " (" .. quest .. ")]");
		end
		local function drop_handler_toggle(_, quest)
			__ns.MapPermanentlyToggleQuestNodes(quest);
		end
		local function GetQuestTitle(quest, modifier)
			local info = __db_quest[quest];
			local color = IMG_LIST[GetQuestStartTexture(info)];
			local lvl_str = GetLevelTag(quest, info, modifier);
			local loc = __loc_quest[quest];
			return lvl_str .. "|c" .. color[5] .. (loc ~= nil and (loc[1] .. "(" .. quest .. ")") or "quest: " .. quest) .. "|r";
		end
		function __ns.NodeOnModifiedClick(node, uuid)
			local refs = uuid[4];
			if ChatEdit_GetActiveWindow() then
				local ele = {  };
				local data = { handler = drop_handler_send, elements = ele, };
				for quest, val in next, refs do
					ele[#ele + 1] = {
						text = __UILOC.pin_menu_send_quest .. GetQuestTitle(quest, true);
						para = { quest, },
					};
				end
				ALADROP(node, "BOTTOMLEFT", data);
				return true;
			else
				for quest, val in next, refs do
					if val["start"] ~= nil then
						local ele = {  };
						local data = { handler = drop_handler_toggle, elements = ele, };
						for quest, val in next, refs do
							if val["start"] ~= nil then
								if __ns.__quest_permanently_blocked[quest] then
									ele[#ele + 1] = {
										text = __UILOC.pin_menu_show_quest .. GetQuestTitle(quest, true);
										para = { quest, },
									};
								else
									ele[#ele + 1] = {
										text = __UILOC.pin_menu_hide_quest .. GetQuestTitle(quest, true);
										para = { quest, },
									};
								end
							end
						end
						ALADROP(node, "BOTTOMLEFT", data);
						return true;
					end
				end
			end
		end
	-->		DBIcon
		local function CreateDBIcon()
			local LDI = LibStub("LibDBIcon-1.0", true);
			if LDI then
				LDI:Register(
					"CodexLite",
					{
						icon = [[interface\icons\inv_misc_book_09]],
						OnClick = function(self, button)
							if __ns.__ui_setting:IsShown() then
								__ns.__ui_setting:Hide();
							else
								__ns.__ui_setting:Show();
							end
						end,
						text = "CodexLite",
						OnTooltipShow = function(tt)
							tt:AddLine("CodexLite");
							tt:Show();
						end,
					},
					__ns.__svar.minimap
				);
				LDI:Show(__addon);
				if SET.show_db_icon then
					LibStub("LibDBIcon-1.0", true):Show(__addon);
				else
					LibStub("LibDBIcon-1.0", true):Hide(__addon);
				end
			end
		end
	-->
	-->		Chat
		local function ChatFilterReplacer(body, id)
			local quest = tonumber(id);
			local info = __db_quest[quest];
			local loc = __loc_quest[quest];
			if info ~= nil and loc ~= nil then
				local color = IMG_LIST[GetQuestStartTexture(info)];
				return "|Hcdxl:" .. id .. "|h|c" .. color[5] .. "[" .. GetLevelTag(quest, info, false, false) .. (loc ~= nil and loc[1] or "Quest: " .. id) .. "]|r|h";
			end
			return body;
		end
		local function ChatFilter(ChatFrame, event, arg1, ...)
			if ChatFrame ~= ChatFrame2 then
				return false, gsub(arg1, "(%[%[[0-9]+%] .- %(([0-9]+)%)%])", ChatFilterReplacer), ...;
			end
		end
		local ItemRefTooltip = ItemRefTooltip;
		local _ItemRefTooltip_SetHyperlink = ItemRefTooltip.SetHyperlink;
		function ItemRefTooltip:SetHyperlink(link, ...)
			local id = strmatch(link, "cdxl:(%d+)");
			if id ~= nil then
				id = tonumber(id);
				if id ~= nil then
					local meta = __core_meta[id];
					local info = __db_quest[id];
					if meta ~= nil then
						ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE");
						local color = IMG_LIST[GetQuestStartTexture(info)];
						ItemRefTooltip:SetText("|c" .. color[5] .. GetLevelTag(id, info, true) .. meta.title .. "|r");
						if meta.completed == 1 then
							ItemRefTooltip:AddLine(__UILOC.IN_PROGRESS .. " (" .. __UILOC.COMPLETED .. ")", 0.0, 1.0, 0.0);
						else
							ItemRefTooltip:AddLine(__UILOC.IN_PROGRESS, 0.75, 1.0, 0.0);
						end
						ItemRefTooltip:AddLine(" ");
						ItemRefTooltip:AddLine(meta.sdesc, 1.0, 1.0, 1.0, true);
						local num = #meta;
						if num > 0 then
							ItemRefTooltip:AddLine(" ");
							for index = 1, num do
								local line = meta[index];
								if line[5] then
									ItemRefTooltip:AddLine(" - " .. line[4], 0.0, 1.0, 0.0);
								else
									ItemRefTooltip:AddLine(" - " .. line[4], 1.0, 0.5, 0.5);
								end
							end
						end
						ItemRefTooltip:Show();
						return;
					else
						local loc = __loc_quest[id];
						if info ~= nil and loc ~= nil then
							ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE");
							local color = IMG_LIST[GetQuestStartTexture(info)];
							ItemRefTooltip:SetText("|c" .. color[5] .. GetLevelTag(id, info, true) .. (loc ~= nil and loc[1] or "Quest: " .. id) .. "|r");
							if __core_quests_completed[id] then		--	1 = completed, -1 = excl completed, -2 = next completed
								ItemRefTooltip:AddLine(__UILOC.COMPLETED, 0.0, 1.0, 0.0);
							end
							local lines = loc[3];
							if lines ~= nil then
								ItemRefTooltip:AddLine(" ");
								for index = 1, #lines do
									ItemRefTooltip:AddLine(lines[index], 1.0, 1.0, 1.0, true);
								end
							end
							ItemRefTooltip:Show();
							return;
						end
					end
				end
			end
			return _ItemRefTooltip_SetHyperlink(self, link, ...);
		end
		local Num_Hooked_QuestLogTitle = 0;
		local function HookQuestLogTitle()
			if Num_Hooked_QuestLogTitle < QUESTS_DISPLAYED then
				for index = Num_Hooked_QuestLogTitle + 1, QUESTS_DISPLAYED do
					local button = _G["QuestLogTitle" .. index];
					local script = button:GetScript("OnClick");
					button:SetScript("OnClick", function(self, button)
						if IsModifiedClick("CHATLINK") and ChatEdit_GetActiveWindow() then
							if self.isHeader then
								return;
							end
							local title, level, group, header, collapsed, completed, frequency, quest_id = GetQuestLogTitle(self:GetID() + FauxScrollFrame_GetOffset(QuestLogListScrollFrame));
							local activeWindow = ChatEdit_GetActiveWindow();
							if activeWindow ~= nil then
								activeWindow:Insert("[[" .. level .. "] " .. title .. " (" .. quest_id .. ")]");
							end
							-- ChatEdit_InsertLink("[[" .. level .. "] " .. title .. " (" .. quest_id .. ")]");
							return;
						end
						return script(self, button);
					end);
					Num_Hooked_QuestLogTitle = index;
				end
			end
		end
		local function InitMessageFactory()
			QuestLogFrame:HookScript("OnShow", HookQuestLogTitle);
			ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", ChatFilter);
			ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", ChatFilter);
			ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", ChatFilter);		
			ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", ChatFilter);
			ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", ChatFilter);
			ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", ChatFilter);
			ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", ChatFilter);
			ChatFrame_AddMessageEventFilter("CHAT_MSG_BN", ChatFilter);
			ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", ChatFilter);
			ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER_INFORM", ChatFilter);
			ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", ChatFilter);
			ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", ChatFilter);
			ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", ChatFilter);
			ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", ChatFilter);
			ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", ChatFilter);
			ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", ChatFilter);
			ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER", ChatFilter);
			ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", ChatFilter);
		end
	-->		QuestLogFrame
		local function CreateQuestLogFrameButton()
			local QuestLogDetailScrollChildFrame = QuestLogDetailScrollChildFrame;
			local QuestLogDescriptionTitle = QuestLogDescriptionTitle;
			local _ShowQuest = CreateFrame('BUTTON', nil, QuestLogDetailScrollChildFrame, "UIPanelButtonTemplate");
			_ShowQuest:SetSize(85, 21);
			_ShowQuest:SetPoint("TOPLEFT", QuestLogDescriptionTitle, "TOPLEFT", 0, 0);
			_ShowQuest:SetScript("OnClick", function()
				__ns.MapTemporarilyShowQuestNodes(select(8, GetQuestLogTitle(GetQuestLogSelection())));
			end);
			_ShowQuest:SetText(__UILOC.show_quest);
			local _HideQuest = CreateFrame('BUTTON', nil, QuestLogDetailScrollChildFrame, "UIPanelButtonTemplate");
			_HideQuest:SetSize(85, 21);
			_HideQuest:SetPoint("LEFT", _ShowQuest, "RIGHT", 0, 0);
			_HideQuest:SetScript("OnClick", function()
				__ns.MapTemporarilyHideQuestNodes(select(8, GetQuestLogTitle(GetQuestLogSelection())));
			end);
			_HideQuest:SetText(__UILOC.hide_quest);
			local _ResetButton = CreateFrame('BUTTON', nil, QuestLogDetailScrollChildFrame, "UIPanelButtonTemplate");
			_ResetButton:SetSize(85, 21);
			_ResetButton:SetPoint("LEFT", _HideQuest, "RIGHT", 0, 0);
			_ResetButton:SetScript("OnClick", function()
				__ns.MapResetTemporarilyQuestNodesFilter();
			end);
			_ResetButton:SetText(__UILOC.reset_filter);
			__ns._ShowQuest = _ShowQuest;
			__ns._HideQuest = _HideQuest;
			__ns._ResetQuest = _ResetButton;
			QuestLogDescriptionTitle.__defHeight = QuestLogDescriptionTitle:GetHeight();
			if SET.show_buttons_in_log then
				QuestLogDescriptionTitle:SetHeight(QuestLogDescriptionTitle.__defHeight + 30);
				QuestLogDescriptionTitle:SetJustifyV("BOTTOM");
				_ShowQuest:Show();
				_HideQuest:Show();
				_ResetButton:Show();
			else
				_ShowQuest:Hide();
				_HideQuest:Hide();
				_ResetButton:Hide();
			end
		end
		local function SetQuestLogFrameButtonShown(shown)
			if shown then
				QuestLogDescriptionTitle:SetHeight(QuestLogDescriptionTitle.__defHeight + 30);
				QuestLogDescriptionTitle:SetJustifyV("BOTTOM");
				__ns._ShowQuest:Show();
				__ns._HideQuest:Show();
				__ns._ResetQuest:Show();
			else
				QuestLogDescriptionTitle:SetHeight(QuestLogDescriptionTitle.__defHeight);
				__ns._ShowQuest:Hide();
				__ns._HideQuest:Hide();
				__ns._ResetQuest:Hide();
			end
		end
	-->
	-->		extern
		__ns.GetQuestTitle = GetQuestTitle;
		__ns.SetQuestLogFrameButtonShown = SetQuestLogFrameButtonShown;
	-->
	function __ns.util_setup()
		SET = __ns.__setting;
		GameTooltip:HookScript("OnTooltipSetUnit", OnTooltipSetUnit);
		GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem);
		ItemRefTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem);
		GameTooltip:HookScript("OnShow", function()
			GameTooltipTextLeft1Text = nil;
			updateTimer = 0.0;
		end);
		GameTooltip:HookScript("OnHide", function()
			GameTooltipTextLeft1Text = nil;
			updateTimer = 0.0;
		end);
		GameTooltip:HookScript("OnUpdate", GameTooltipOnUpdate);
		__eventHandler:RegEvent("MODIFIER_STATE_CHANGED");
		--
		if LibStub ~= nil then
			CreateDBIcon();
		end
		CreateQuestLogFrameButton();
		InitMessageFactory();
		--
		_F_SafeCall(__ns._checkConflicts);
	end
-->

-->		Position Share
	function __ala_meta__.____OnMapPositionReceived(sender, map, x, y)
		if map > 0 then
			map, x, y = __ns.core.GetZonePositionFromWorldPosition(map, x, y);
		end
		if map ~= nil then
			if map > 0 then
				x = x - x % 0.0001;
				y = y - y % 0.0001;
				print(Ambiguate(sender, 'none'), __ns.L.map[map], x * 100, y * 100);
			else
				print(Ambiguate(sender, 'none'), "副本中");
			end
		end
	end
	local __pull_position_ticker = nil;
	local __listen_name = nil;
	local function __ticker_func_listen_position()
		__ala_meta__.__mapshare.PullPosition(__listen_name);
	end
	local function ListenPosition(name, period)
		__listen_name = Ambiguate(name, 'none');print('ListenPosition', name, __listen_name)
		if __pull_position_ticker == nil then
			__pull_position_ticker = C_Timer.NewTicker(period or 0.5, __ticker_func_listen_position);
		end
	end
	local function StopListeningPosition()
		if __pull_position_ticker ~= nil then
			__pull_position_ticker:Cancel();
			__pull_position_ticker = nil;
		end
	end
	__ala_meta__.____ListenPosition = ListenPosition;
	__ala_meta__.____StopListeningPosition = StopListeningPosition;
	local B_ERR_CHAT_PLAYER_NOT_FOUND_S = ERR_CHAT_PLAYER_NOT_FOUND_S;
	local P_ERR_CHAT_PLAYER_NOT_FOUND_S = gsub(B_ERR_CHAT_PLAYER_NOT_FOUND_S, "%%s", "(.+)");
	local function __listen_position_filter(self, event, msg, ...)
		if __pull_position_ticker ~= nil then
			if B_ERR_CHAT_PLAYER_NOT_FOUND_S ~= ERR_CHAT_PLAYER_NOT_FOUND_S then
				B_ERR_CHAT_PLAYER_NOT_FOUND_S = ERR_CHAT_PLAYER_NOT_FOUND_S;
				P_ERR_CHAT_PLAYER_NOT_FOUND_S = gsub(B_ERR_CHAT_PLAYER_NOT_FOUND_S, "%%s", "(.+)");
			end
			local _, _, name = strfind(msg, P_ERR_CHAT_PLAYER_NOT_FOUND_S);
			if name ~= nil then
				if name == __listen_name or Ambiguate(name, 'none') == __listen_name then
					StopListeningPosition();
					print("Cancel tracking ", __listen_name, "[\124cffff0000OFFLINE\124r]");
					return true, msg, ...;
				end
			end
		end
		return false, msg, ...;
	end
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", __listen_position_filter);
-->

-->		CONFLICTS
	function __ns._checkConflicts()
		if SET ~= nil and SET._checkedConflicts then
			return;
		end
		C_Timer.After(4.0, function()
			local _conflicts = false;
			if GetAddOnEnableState(UnitName('player'), "Questie") > 0 then
				_conflicts = true;
			end
			if GetAddOnEnableState(UnitName('player'), "ClassicCodex") > 0 then
				_conflicts = true;
			end
			if _conflicts then
				StaticPopupDialogs['CODEX_LITE_CONFLICTS'] = {
					preferredIndex = 3,
					text = __UILOC["CODEX_LITE_CONFLICTS"],
					button1 = YES,
					button2 = NO,
					OnAccept = function(self, data)
						DisableAddOn("Questie");
						DisableAddOn("ClassicCodex");
						SaveAddOns();
						ReloadUI();
					end,
					hideOnEscape = 1,
					timeout = 0,
					exclusive = 1,
					whileDead = 1,
				};
					StaticPopup_Show("CODEX_LITE_CONFLICTS");
			end
			if SET ~= nil then
				SET._checkedConflicts = true;
			end
		end);
	end
-->

--[=[dev]=]	if __ns.__dev then __ns.__performance_log_tick('module.util'); end