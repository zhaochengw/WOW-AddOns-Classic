--[[--
	by ALA @ 163UI
--]]--

local __addon__, __namespace__ = ...;
local __db__ = __namespace__.__db__;
local L = __namespace__.L;

-->		upvalue
	local next = next;

	local min = math.min;
	local max = math.max;
	local format = string.format;

	local C_Timer_After = C_Timer.After;
	local C_Map_GetAreaInfo = C_Map.GetAreaInfo;
	local UnitFactionGroup = UnitFactionGroup;
	local IsAddOnLoaded = IsAddOnLoaded;

	local _G = _G;
	--[[
		local GetLocale = GetLocale;
	]]
-->


local CURPHASE = __db__.CURPHASE;
local LOCALE = GetLocale();


local AuctionMod = nil;
-- local MTSL_DATA = nil;

---->	index
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
	local index_recipe = 16;
	local index_quest = 17;
	local index_object = 18;
	local index_class = 19;
	local index_spec = 20;
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


-->		****
__namespace__:BuildEnv("MissingTradeSkillsList");
-->		****


--	mtsl
local LT_MTSL_LocaleKey = {
	["enUS"] = "English",
	["frFR"] = "French",
	["deDE"] = "German",
	["ruRU"] = "Russian",
	["koKR"] = "Korean",
	["zhCN"] = "Chinese",
	["zhTW"] = "Chinese",
	["esES"] = "Spanish",
	["ptBR"] = "Portuguese",
};
local LT_MTSL_SkillName = {
	[1] = "First Aid",
	[2] = "Blacksmithing",
	[3] = "Leatherworking",
	[4] = "Alchemy",
	[6] = "Cooking",
	[7] = "Mining",
	[8] = "Tailoring",
	[9] = "Engineering",
	[10] = "Enchanting",
	[15] = "Jewelcrafting",
};
local MTSL_LOCALE = LT_MTSL_LocaleKey[LOCALE] or LT_MTSL_LocaleKey.enUS;
local LF_MTSL_SetQuest;
local LF_MTSL_SetItem;
local LF_MTSL_SetObject;
local LF_MTSL_SetUnit;
local function LF_MTSL_AddReputation(Tip, reputation)
	local line = nil;
	local fid = reputation.faction_id;
	for _, fv in next, MTSL_DATA["factions"] do
		if fv.id == fid then
			local name = fv.name[MTSL_LOCALE];
			if name then
				line = "|cffff7f00" .. name .. "|r";
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
				line = line .. format("|cff%.2xff00", min(255, max(0, 64 * (8 - lid) - 1))) .. name .. "|r";
			end
			break;
		end
	end
	Tip:AddDoubleLine(" ", line);
	Tip:Show();
end
local LT_MTSL_UnitPrefix = {	--	FactionGroup == "Alliance"
	[true] = {
		Alliance = ": |Tinterface\\timer\\Alliance-logo:20|t|cff00ff00",
		Horde = ": |Tinterface\\timer\\Horde-logo:20|t|cffff0000",
		Neutral = ": |cffffff00",
		Hostile = ": |cffff0000",
		["*"] = ": |cffffffff",
	},
	[false] = {
		Alliance = ": |Tinterface\\timer\\Alliance-logo:20|t|cffff0000",
		Horde = ": |Tinterface\\timer\\Horde-logo:20|t|cff00ff00",
		Neutral = ": |cffffff00",
		Hostile = ": |cffff0000",
		["*"] = ": |cffffffff",
	},
};
LF_MTSL_SetUnit = function(Tip, pid, uid, label, isAlliance, prefix, suffix, stack_size)
	if stack_size < 8 then
		if MTSL_DATA then
			local npcs = MTSL_DATA["npcs"];
			if npcs then
				local got_one_data = false;
				for _, nv in next, npcs do
					if nv.id == uid then
						got_one_data = true;
						local colorTable = LT_MTSL_UnitPrefix[isAlliance];
						local line = prefix .. (colorTable[nv.reacts] or colorTable["*"]);
						local name = nv.name[MTSL_LOCALE];
						if name then
							line = line .. name;
						else
							line = line .. "npcID: " .. uid;
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
						line = line .. " [" .. C_Map_GetAreaInfo(nv.zone_id) or L["unknown area"];
						local location = nv.location;
						if location and location.x ~= "-" and location.y ~= "-" then
							line = line .. " " .. location.x .. ", " .. location.y .. "]";
						else
							line = line .. "]";
						end
						local phase = nv.phase;
						if phase and phase > CURPHASE then
							line = line .. " " .. L["phase"] .. phase;
						end
						Tip:AddDoubleLine(label, line);
						local special_action = nv.special_action;
						if special_action then
							local sav = MTSL_DATA["special_actions"][special_action];
							if sav and sav.name then
								local sa = sav.name[MTSL_LOCALE];
								if sa then
									Tip:AddDoubleLine(" ", sa);
								end
							end
						end
						line = line .. suffix;
						break;
					end
				end
				if not got_one_data then
					Tip:AddDoubleLine(" ", L["sold_by"] .. ": |cffff0000unknown|r, npcID: " .. uid);
				end
				Tip:Show();
			end
		end
	end
end
LF_MTSL_SetQuest = function(Tip, pid, qid, label, stack_size)
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
							line = line .. "|cffffff00" .. L["quest"] .. "|r ID: " .. qid .. "]";
						end
						local min_xp_level = qv.min_xp_level;
						if min_xp_level then
							line = line .. "Lv" .. min_xp_level;
						end
						local phase = qv.phase;
						if phase and phase > CURPHASE then
							line = line .. " " .. L["phase"] .. phase;
						end
						Tip:AddDoubleLine(label, L["quest_reward"] .. ": |cffffff00" .. line .. "|r");
						if qv.npcs then
							for _, uid in next, qv.npcs do
								LF_MTSL_SetUnit(Tip, pid, uid, " ", UnitFactionGroup('player') == "Alliance", L["quest_accepted_from"], "|r", stack_size + 1);
							end
						end
						if qv.items then
							for _, iid in next, qv.items do
								LF_MTSL_SetItem(Tip, pid, iid, " ", stack_size + 1);
							end
						end
						if qv.objects then
							for _, oid in next, qv.objects do
								LF_MTSL_SetObject(Tip, pid, oid, " ", stack_size + 1);
							end
						end
						if qv.reputation then
							LF_MTSL_AddReputation(Tip, qv.reputation);
						end
						local special_action = qv.special_action;
						if special_action then
							local sav = MTSL_DATA["special_actions"][special_action];
							if sav and sav.name then
								local sa = sav.name[MTSL_LOCALE];
								if sa then
									Tip:AddDoubleLine(" ", "|cffffffff" .. sa .. "|r");
								end
							end
						end
						break;
					end
				end
				if not got_one_data then
					Tip:AddDoubleLine(label, "|cffffff00" .. L["quest"] .. "|r ID: " .. qid);
				end
			end
			Tip:Show();
		end
	end
end
LF_MTSL_SetItem = function(Tip, pid, iid, label, stack_size)
	if stack_size <= 8 then
		local _, line, _, _, _, _, _, _, bind = __db__.item_info(iid);
		if not line then
			line = "|cffffffff" .. L["item"] .. "|r ID: " .. iid;
		end
		if bind ~= 1 and bind ~= 4 then
			line = line .. "(|cff00ff00" .. L["tradable"] .. "|r)";
			if AuctionMod ~= nil then
				local price = AuctionMod.F_QueryPriceByID(iid);
				if price and price > 0 then
					line = line .. " |cff00ff00AH|r " .. __namespace__.F_GetMoneyString(price);
				end
			end
		else
			line = line .. "(|cffff0000" .. L["non_tradable"] .. "|r)";
		end
		Tip:AddDoubleLine(label, line);
		if MTSL_DATA then
			local pname = LT_MTSL_SkillName[pid];
			local data = MTSL_DATA["items"][pname];
			if data then
				for i, iv in next, data do
					if iv.id == iid then
						local vendors = iv.vendors;
						if vendors then
							for _, uid in next, vendors.sources do
								LF_MTSL_SetUnit(Tip, pid, uid, " ", UnitFactionGroup('player') == "Alliance", L["sold_by"], "|r", stack_size + 1);
							end
						end
						local drops = iv.drops;
						if drops then
							if drops.sources then
								for _, uid in next, drops.sources do
									LF_MTSL_SetUnit(Tip, pid, uid, " ", UnitFactionGroup('player') ~= "Alliance", L["dropped_by"], "|r", stack_size + 1);
								end
							end
							local range = drops.range;
							if range then
								if range.min_xp_level and range.max_xp_level then
									local line = range.min_xp_level .. "-" .. range.max_xp_level;
									Tip:AddDoubleLine(" ", L["world_drop"] .. ": |cffff0000" .. L["dropped_by_mod_level"] .. line .. "|r");
								else
									Tip:AddDoubleLine(" ", L["world_drop"]);
								end
							end
						end
						if iv.quests then
							for _, qid in next, iv.quests do
								LF_MTSL_SetQuest(Tip, pid, qid, " ", stack_size + 1);
							end
						end
						if iv.objects then
							for _, oid in next, iv.objects do
								LF_MTSL_SetObject(Tip, pid, oid, " ", stack_size + 1);
							end
						end
						if iv.reputation then
							LF_MTSL_AddReputation(Tip, iv.reputation);
						end
						local line2 = nil;
						local holiday = iv.holiday;
						if holiday then
							for _, hv in next, MTSL_DATA["holidays"] do
								if hv.id == holiday then
									local h = hv.name[MTSL_LOCALE];
									if h then
										-- Tip:AddDoubleLine(" ", h);
										line2 = "|cff00ffff" .. h .. "|r";
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
									-- Tip:AddDoubleLine(" ", sa);
									if line2 then
										line2 = line2 .. "|cffffffff" .. sa .. "|r";
									else
										line2 = "|cffffffff" .. sa .. "|r";
									end
								end
							end
						end
						if line2 then
							Tip:AddDoubleLine(" ", line2);
						end
						break;
					end
				end
			end
		end
		Tip:Show();
	end
end
LF_MTSL_SetObject = function(Tip, pid, oid, label, stack_size)
	if stack_size <= 8 then
		if MTSL_DATA then
			local objects = MTSL_DATA["objects"];
			if objects then
				local got_one_data = false;
				for _, ov in next, objects do
					if ov.id == oid then
						got_one_data = true;
						local line = ov.name[MTSL_LOCALE] or ("|cffffffff" .. L["object"] .. "|r ID: " .. oid);
						line = line .. " [" .. C_Map_GetAreaInfo(ov.zone_id);
						local location = ov.location;
						if location and location.x ~= "-" and location.y ~= "-" then
							line = line .. " " .. location.x .. ", " .. location.y .. "]";
						else
							line = line .. "]";
						end
						local phase = ov.phase;
						if phase and phase > CURPHASE then
							line = line .. " " .. L["phase"] .. phase;
						end
						Tip:AddDoubleLine(label, L["object"] .. ": |cffffffff" .. line .. "|r");
						local special_action = ov.special_action;
						if special_action then
							local sav = MTSL_DATA["special_actions"][special_action];
							if sav and sav.name then
								local sa = sav.name[MTSL_LOCALE];
								if sa then
									Tip:AddDoubleLine(" ", "|cffffffff" .. sa .. "|r");
								end
							end
						end
						break;
					end
				end
				if not got_one_data then
					Tip:AddDoubleLine(label, "|cffffffff" .. L["object"] .. "|r ID: " .. oid);
				end
				Tip:Show();
			end
		end
	end
end
local function LF_MTSL_SetSpellTip(Tip, sid)
	local info = __db__.get_info_by_sid(sid);
	if info then
		if info[index_trainer] then			-- trainer
			Tip:AddDoubleLine(L["LABEL_GET_FROM"], "|cffff00ff" .. L["trainer"] .. "|r");
			Tip:Show();
		end
		local pid = info[index_pid];
		local rids = info[index_recipe];
		if rids then				-- recipe
			for index = 1, #rids do
				local rid = rids[index];
				LF_MTSL_SetItem(Tip, pid, rid, L["LABEL_GET_FROM"], 1);
			end
		end
		local qids = info[index_quest];
		if qids then			-- quests
			for index = 1, #qids do
				local qid = qids[index];
				LF_MTSL_SetQuest(Tip, pid, qid, L["LABEL_GET_FROM"], 1);
			end
		end
		local oid = info[index_object];
		if oid ~= nil then			-- objects
			if type(oid) == 'table' then
				for _, oid in next, oid do
					LF_MTSL_SetObject(Tip, pid, oid, L["LABEL_GET_FROM"], 1);
				end
			else
				LF_MTSL_SetObject(Tip, pid, oid, L["LABEL_GET_FROM"], 1);
			end
		end
		--
		if MTSL_DATA then
			local pname = LT_MTSL_SkillName[pid];
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
										Tip:AddDoubleLine(" ", "|cffffffff" .. spv.name[MTSL_LOCALE] .. "|r");
										Tip:Show();
									end
								end
							end
						end
						local reputation = sv.reputation;
						if reputation then
							LF_MTSL_AddReputation(Tip, reputation);
						end
						break;
					end
				end
			end
		end
	end
end


function __namespace__.toggle_mtsl(hide)
end
function __namespace__.hide_mtsl(val)
end


local function callback()
	__namespace__:FireEvent("RECIPESOURCE_MOD_LOADED", {
		-- MTSL_DATA = _G.MTSL_DATA;
		SetSpell = LF_MTSL_SetSpellTip,
		SetItem = LF_MTSL_SetItem,
		SetUnit = LF_MTSL_SetUnit,
		SetObject = LF_MTSL_SetObject,
		SetQuest = LF_MTSL_SetQuest,
	});
	__namespace__:AddCallback("AUCTION_MOD_LOADED", function(mod)
		if mod ~= nil then
			AuctionMod = mod;
		end
	end);
	local SET = __namespace__.SET;
	if SET ~= nil then
		C_Timer_After(1.0, function() __namespace__.hide_mtsl(SET.hide_mtsl); end);
	end
	function __namespace__.toggle_mtsl(hide)
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
	function __namespace__.hide_mtsl(val)
		__namespace__.toggle_mtsl(val);
	end
end
__namespace__:AddAddOnCallback("MissingTradeSkillsList", callback);
__namespace__:AddAddOnCallback("MissingTradeSkillsList_TBC", callback);

__namespace__:AddAddOnCallback("MissingTradeSkillsList_TBC_Data", function()
	__namespace__:FireEvent("RECIPESOURCE_MOD_LOADED", {
		-- MTSL_DATA = _G.MTSL_DATA;
		SetSpell = LF_MTSL_SetSpellTip,
		SetItem = LF_MTSL_SetItem,
		SetUnit = LF_MTSL_SetUnit,
		SetObject = LF_MTSL_SetObject,
		SetQuest = LF_MTSL_SetQuest,
	});
	__namespace__:AddCallback("AUCTION_MOD_LOADED", function(mod)
		if mod ~= nil then
			AuctionMod = mod;
		end
	end);
end);

