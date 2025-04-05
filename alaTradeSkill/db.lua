--[[--
	by ALA
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;

-->		upvalue
	local next = next;
	local unpack = unpack;

	local bitband = bit.band;
	local strlower = string.lower;
	local wipe = table.wipe;

	local RequestLoadSpellData = RequestLoadSpellData or C_Spell.RequestLoadSpellData;
	local RequestLoadItemDataByID = RequestLoadItemDataByID or C_Item.RequestLoadItemDataByID;
	local GetSpellInfo = GetSpellInfo;
	local GetItemInfo = GetItemInfo;
	local IsSpellKnown = IsSpellKnown;
	local IsInRaid = IsInRaid;
	local IsInGroup = IsInGroup;

	local ITEM_QUALITY_COLORS = ITEM_QUALITY_COLORS;

	local CreateFrame = CreateFrame;
	local _G = _G;

-->
	local DataAgent = DT.DataAgent;
	local l10n = CT.l10n;
	local USELFCLASSBIT = DataAgent.USELFCLASSBIT;

-->
MT.BuildEnv("db");
-->		predef
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
-->		db
local F = CreateFrame('FRAME');
F:SetScript("OnEvent", function(self, event, ...)
	return self[event](...);
end);
function DataAgent:FireEvent(event, ...)
	local func = F[event];
	if func ~= nil then
		return func(...);
	end
end

-->		Define
--	Constant
local T_CharRaceBonus = DataAgent.T_RaceBonus[CT.SELFRACEID] or {  };
--	Recipe Data
local T_Recipe_Data = DataAgent.T_Recipe_Data;
--[[	T_Recipe_Data[sid] = {
			1_validated, 2_phase, 3_pid, 4_sid, 5_cid,
			6_learn, 7_yellow, 8_green, 9_grey,
			10_made, 11_made, 12_reagents_id, 13_reagents_count, 
			14_trainer, 15_train_price, 16_rid, 17_quest, 18_object
		}
--]]
--
local T_TradeSkill_ID = DataAgent.T_TradeSkill_ID;
--[[auto]]local T_TradeSkill_Name = {  };								--	[pid] = prof_name
--[[auto]]local T_TradeSkill_Hash = {  };								--	[prof_name] = pid
local T_TradeSkill_Texture = DataAgent.T_TradeSkill_Texture;
local T_TradeSkill_CheckID = DataAgent.T_TradeSkill_CheckID;	--	[pid] = p_check_sid
--[[auto]]local T_TradeSkill_CheckName = {  };						--	[pid] = p_check_sname
local T_TradeSkill_HasUI = DataAgent.T_TradeSkill_HasUI;		--	[pid] = bool
local T_TradeSkill_Spec2Pid = DataAgent.T_TradeSkill_Spec2Pid;
local T_TradeSkill_RecipeList = DataAgent.T_TradeSkill_RecipeList;
--	Hash
--[[auto]]local T_sname2sid = {  };		--	[pid][sname] = { sid }
local T_cis2sid = {  };			--	[cid] = { sid }
local T_cidpid2sid = {  };		--	[cid][pid] = { sid }
local T_rid2sid = {  };			--	[rid] = sid
local T_IsSpecLearned = {  };
local T_material2sid = {  };
--[[auto]]local T_TradeSkill_SameSkillName = {  };
--	no-use list
local recipe_sid_list = {  };	--	{ sid }			--	actually unused
local recipe_cid_list = {  };	--	{ cid }			--	actually unused
--	cached
--[[dynamic]]local T_SpellData = {  };		--	[sid] = { 1_name, 2_name_lower, 3_link, 4_link_lower, 5_string }
--[[dynamic]]local T_ItemData = {  };		--	[iid] = info{ 1_name, 2_link, 3_rarity, 4_loc, 5_icon, 6_sellPrice, 7_typeID, 8_subTypeId, 9_bindType, 10_name_lower, 11_link_lower, 12_string }
--	Temp
local T_Temp_SpellHash = {  };
local T_Temp_ItemHash = {  };
local T_Temp_pid = {  };
--
local function LF_HashTradeSkill(pid, pname, pname_lower)
	T_TradeSkill_Name[pid] = pname;
	T_TradeSkill_Hash[pname] = pid;
	T_TradeSkill_Hash[pname_lower] = pid;
	if l10n.extra_skill_name[pid] ~= nil then
		for _, pn in next, l10n.extra_skill_name[pid] do
			T_TradeSkill_Hash[pn] = pid;
			T_TradeSkill_Hash[strlower(pn)] = pid;
		end
	end
end
local function LF_HashSpell(sid, sname, sname_lower)
	local info = T_Recipe_Data[sid];
	if info ~= nil then
		local pid = info[index_pid];
		local pt = T_sname2sid[pid];
		if pt == nil then
			pt = {  };
			T_sname2sid[pid] = pt;
		end
		local ptn = pt[sname];
		if ptn == nil then
			ptn = {  };
			pt[sname] = ptn;
			pt[sname_lower] = ptn;
		end
		ptn[#ptn + 1] = sid;
	end
end
local function LF_CacheSpell(sid)
	local sname = GetSpellInfo(sid);
	if sname ~= nil then
		local sname_lower = strlower(sname);
		local sinfo = {
			sname,
			sname_lower,
			"|cff71d5ff|Hspell:" .. sid .. "|h[" .. sname .. "]|h|r",
			"|cff71d5ff|hspell:" .. sid .. "|h[" .. sname_lower .. "]|h|r",
			"|cff71d5ff[" .. sname .. "]|r",
		};
		T_SpellData[sid] = sinfo;
		LF_HashSpell(sid, sname, sname_lower);
		T_Temp_SpellHash[sid] = nil;
		return sinfo;
	-- else
		-- RequestLoadSpellData(sid);
	end
end
local function LF_CacheItem(iid)
	local iname, ilink, rarity, level, pLevel, type, subType, stackCount, loc, icon, sellPrice,
			typeID, subTypeID, bindType, expacID, setID, isReagent = GetItemInfo(iid); 
	if iname ~= nil and ilink ~= nil then
		local iname_lower = strlower(iname);
		local ilink_lower = strlower(ilink);
		local color = ITEM_QUALITY_COLORS[rarity];
		local str = color ~= nil and color.hex .. "[" .. iname .. "]|r" or "[" .. iname .. "]";
		local iinfo = {
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
		T_ItemData[iid] = iinfo;
		T_Temp_ItemHash[iid] = nil;
		return iinfo;
	end
end
-->		preload
local _SPre, _IPre = 0, 0;		--	dev
if VT.__is_dev then
	local _RequestLoadSpellData = RequestLoadSpellData;
	RequestLoadSpellData = function(...)
		_SPre = _SPre + 1;
		return _RequestLoadSpellData(...);
	end
	local _RequestLoadItemDataByID = RequestLoadItemDataByID;
	RequestLoadItemDataByID = function(...)
		_IPre = _IPre + 1;
		return _RequestLoadItemDataByID(...);
	end
end

local LB_PreloadSpellFinished = false;
local LB_PreloadItemFinished = false;
function F.SPELL_DATA_LOAD_RESULT(sid, success)
	if success and T_Temp_SpellHash[sid] then
		--	trade skill line
		local pid = T_Temp_pid[sid];
		if pid ~= nil then
			local pname = GetSpellInfo(sid);
			if pname ~= nil then
				local pname_lower = strlower(pname);
				T_Temp_pid[sid] = nil;
				if T_TradeSkill_ID[pid] == sid then
					LF_HashTradeSkill(pid, pname, pname_lower);
				end
				if T_TradeSkill_CheckID[pid] == sid then
					T_TradeSkill_CheckName[pid] = pname;
				end
				T_SpellData[sid] = {
					pname,
					pname_lower,
					"|cff71d5ff|Hspell:" .. sid .. "|h[" .. pname .. "]|h|r",
					"|cff71d5ff|hspell:" .. sid .. "|h[" .. pname_lower .. "]|h|r",
					"|cff71d5ff[" .. pname .. "]|r",
				};
			-- else
				-- RequestLoadSpellData(sid);
			end
			return;
		end
		--	trade skill recipe & spec
		LF_CacheSpell(sid);
	end
end
function F.ITEM_DATA_LOAD_RESULT(iid, success)
	if success and T_Temp_ItemHash[iid] then
		LF_CacheItem(iid);
	end
end

local function LF_RequestSpell()
	local completed = true;
	local maxonce = IsInRaid() and 500 or (IsInGroup() and 1000 or 2000);
	for pid = DataAgent.DBMINPID, DataAgent.DBMAXPID do
		if T_TradeSkill_Name[pid] == nil then
			local sid = T_TradeSkill_ID[pid];
			if sid ~= nil then
				RequestLoadSpellData(sid);
				T_Temp_SpellHash[sid] = true;
				T_Temp_pid[sid] = pid;
				completed = false;
				maxonce = maxonce - 1;
				if maxonce <= 0 then
					return false;
				end
			end
		end
	end
	for pid = DataAgent.DBMINPID, DataAgent.DBMAXPID do
		local sid = T_TradeSkill_CheckID[pid];
		if T_SpellData[sid] == nil then
			RequestLoadSpellData(sid);
			T_Temp_SpellHash[sid] = true;
			T_Temp_pid[sid] = pid;
			completed = false;
			maxonce = maxonce - 1;
			if maxonce <= 0 then
				return false;
			end
		end
	end
	for sid, info in next, T_Recipe_Data do
		if T_SpellData[sid] == nil then
			RequestLoadSpellData(sid);
			T_Temp_SpellHash[sid] = true;
			completed = false;
			maxonce = maxonce - 1;
			if maxonce <= 0 then
				return false;
			end
		end
		local spec = info[index_spec];
		if spec ~= nil and T_SpellData[spec] == nil then
			RequestLoadSpellData(spec);
			T_Temp_SpellHash[spec] = true;
			completed = false;
			maxonce = maxonce - 1;
			if maxonce <= 0 then
				return false;
			end
		end
	end
	if completed then
		wipe(T_Temp_SpellHash);
		-- T_Temp_SpellHash = nil;
	end
	return completed;
end
local LN_Limited_RequestSpell = 0;
local function LF_PreloadSpell()
	if LF_RequestSpell() then
		F:UnregisterEvent("SPELL_DATA_LOAD_RESULT");
	else
		LN_Limited_RequestSpell = LN_Limited_RequestSpell + 1;
		if LN_Limited_RequestSpell >= 10 then
			MT.Error("LF_PreloadSpell#0", LN_Limited_RequestSpell);
			F:UnregisterEvent("SPELL_DATA_LOAD_RESULT");
		else
			F:RegisterEvent("SPELL_DATA_LOAD_RESULT");	--	Events registered before loading screen went out may not work well. So reg here everytime.
			MT.After(2.0, LF_PreloadSpell);
			return;
		end
	end
	MT.FireCallback("USER_EVENT_SPELL_DATA_LOADED");
	LB_PreloadSpellFinished = true;
	if LB_PreloadItemFinished then
		MT.FireCallback("USER_EVENT_DATA_LOADED");
	end
end

local function LF_RequestItem()
	local completed = true;
	local maxonce = IsInRaid() and 500 or (IsInGroup() and 1000 or 2000);
	for sid, info in next, T_Recipe_Data do
		local cid = info[index_cid];
		if cid ~= nil then
			if T_ItemData[cid] == nil then
				RequestLoadItemDataByID(cid);
				T_Temp_ItemHash[cid] = true;
				completed = false;
				maxonce = maxonce - 1;
				if maxonce <= 0 then
					return false;
				end
			end
		end
		local rids = info[index_recipe]
		if rids ~= nil then
			for index = 1, #rids do
				local rid = rids[index];
				if T_ItemData[rid] == nil then
					RequestLoadItemDataByID(rid);
					T_Temp_ItemHash[rid] = true;
					completed = false;
					maxonce = maxonce - 1;
					if maxonce <= 0 then
						return false;
					end
				end
			end
		end
		local reagent_ids = info[index_reagents_id];
		if reagent_ids ~= nil then
			for index = 1, #reagent_ids do
				local rid = reagent_ids[index];
				if T_ItemData[rid] == nil then
					RequestLoadItemDataByID(rid);
					T_Temp_ItemHash[rid] = true;
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
		wipe(T_Temp_ItemHash);
		-- T_Temp_ItemHash = nil;
	end
	return completed;
end
local LN_Limited_RequestItem = 0;
local function LF_PreloadItem()
	if LF_RequestItem() then
		F:UnregisterEvent("ITEM_DATA_LOAD_RESULT");
	else
		LN_Limited_RequestItem = LN_Limited_RequestItem + 1;
		if LN_Limited_RequestItem >= 10 then
			MT.Error("LF_PreloadItem#0", LN_Limited_RequestItem);
			F:UnregisterEvent("ITEM_DATA_LOAD_RESULT");
		else
			F:RegisterEvent("ITEM_DATA_LOAD_RESULT");	--	Events registered before loading screen went out may not work well. So reg here everytime.
			MT.After(2.0, LF_PreloadItem);
			return;
		end
	end
	MT.FireCallback("USER_EVENT_ITEM_DATA_LOADED");
	LB_PreloadItemFinished = true;
	if LB_PreloadSpellFinished then
		MT.FireCallback("USER_EVENT_DATA_LOADED");
	end
end
--
local function _LoadSavedVar()
	for pid = DataAgent.DBMINPID, DataAgent.DBMAXPID do
		local sid = T_TradeSkill_ID[pid];
		local sinfo = T_SpellData[sid];
		if sinfo ~= nil then
			LF_HashTradeSkill(pid, sinfo[1], sinfo[2]);
		end
		--
		local sid = T_TradeSkill_CheckID[pid];
		local sinfo = T_SpellData[sid];
		if sinfo ~= nil then
			T_TradeSkill_CheckName[pid] = sinfo[1];
		end
		--
	end
	for sid, sinfo in next, T_SpellData do
		LF_HashSpell(sid, sinfo[1], sinfo[2]);
	end
end
-->
function F.LEARNED_SPELL_IN_TAB(id, tab, isGuild)
	local pid = T_TradeSkill_Spec2Pid[id];
	if pid ~= nil and T_IsSpecLearned[id] ~= true then
		T_IsSpecLearned[id] = true;
		MT.MarkSkillToUpdate(pid);
	end
end
function F.SPELLS_CHANGED()
	for spec, pid in next, T_TradeSkill_Spec2Pid do
		local val = IsSpellKnown(spec) and true or nil;
		if T_IsSpecLearned[spec] ~= val then
			T_IsSpecLearned[spec] = val;
			MT.MarkSkillToUpdate(pid);
		end
	end
end
MT.AddCallback("USER_EVENT_DATA_LOADED", function()
	if LB_PreloadSpellFinished and LB_PreloadItemFinished then
		for pid = DataAgent.DBMINPID, DataAgent.DBMAXPID do
			local n1, n2 = T_TradeSkill_Name[pid], T_TradeSkill_CheckName[pid];
			if n1 ~= nil and n2 ~= nil then
				T_TradeSkill_SameSkillName[n1] = n2;
				T_TradeSkill_SameSkillName[n2] = n1;
			end
		end
		if VT.__is_dev then
			MT.Debug("Preload", _SPre, _IPre);
		end
	end
end);

-->		Query
--	GET TABLE
	--	| T_TradeSkill_CheckID{ [pid] = p_check_sid }
	function DataAgent.table_tradeskill_check_id()
		return T_TradeSkill_CheckID;
	end
	--	| T_TradeSkill_CheckName{ [pid] = p_check_sname }
	function DataAgent.table_tradeskill_check_name()
		return T_TradeSkill_CheckName;
	end
--	INSERT RECIPE DB
	function DataAgent.insert_info(sid, info)
		if T_Recipe_Data[sid] == nil then
			T_Recipe_Data[sid] = info;
			local pid = info[index_pid];
			local recipe = T_TradeSkill_RecipeList[pid];
			if recipe ~= nil then
				local num = #recipe;
				for i = 1, num do
					if sid == recipe[i] then
						return;
					end
				end
				recipe[num + 1] = sid;
			end
			LF_CacheSpell(sid);
			local cid = info[index_cid];
			if cid ~= nil then
				LF_CacheItem(cid);
				T_cidpid2sid[pid] = T_cidpid2sid[pid] or {  };
				local h2 = T_cidpid2sid[pid][cid];
				if h2 == nil then
					h2 = {  };
					T_cidpid2sid[pid][cid] = h2;
				end
				h2[#h2 + 1] = sid;
			end
		end
	end
--	QUERY RECIPE DB
	--	pid | is_tradeskill
	function DataAgent.is_pid(pid)
		return pid ~= nil and T_TradeSkill_ID[pid] ~= nil;
	end
	--	pname | pid
	function DataAgent.get_pid_by_pname(pname)
		if pname ~= nil then
			return T_TradeSkill_Hash[pname];
		end
	end
	--	pid | pname
	function DataAgent.get_pname_by_pid(pid)
		if pid ~= nil then
			return T_TradeSkill_Name[pid];
		end
	end
	--	pid | ptexture
	function DataAgent.get_texture_by_pid(pid)
		if pid ~= nil then
			return T_TradeSkill_Texture[pid];
		end
	end
	--	pid | has_win
	function DataAgent.is_pid_has_win(pid)
		if DataAgent.is_pid(pid) then
			return T_TradeSkill_HasUI[pid];
		end
	end
	--	pid | check_id
	function DataAgent.get_check_id_by_pid(pid)
		if pid ~= nil then
			return T_TradeSkill_CheckID[pid];
		end
	end
	--	pid | check_name
	function DataAgent.get_check_name_by_pid(pid)
		if pid ~= nil then
			return T_TradeSkill_CheckName[pid];
		end
	end
	--	sid | is_tradeskill
	function DataAgent.is_tradeskill_sid(sid)
		return sid ~= nil and T_Recipe_Data[sid] ~= nil;
	end
	--	pid | list{ sid, }
	function DataAgent.get_list_by_pid(pid)
		if pid ~= nil then
			return T_TradeSkill_RecipeList[pid];
		end
	end
	--	<query_T_Recipe_Data
	--	sid | info{  }
	function DataAgent.get_info_by_sid(sid)
		if sid ~= nil then
			return T_Recipe_Data[sid];
		end
	end
	--	sid | phase
	function DataAgent.get_phase_by_sid(sid)
		if sid ~= nil then
			local info = T_Recipe_Data[sid];
			if info ~= nil then
				return info[index_phase];
			end
		end
	end
	--	sid | pid
	function DataAgent.get_pid_by_sid(sid)
		if sid ~= nil then
			local info = T_Recipe_Data[sid];
			if info ~= nil then
				return info[index_pid];
			end
		end
	end
	--	sid | cid
	function DataAgent.get_cid_by_sid(sid)
		if sid ~= nil then
			local info = T_Recipe_Data[sid];
			if info ~= nil then
				return info[index_cid];
			end
		end
	end
	--	sid | learn_rank
	function DataAgent.get_learn_rank_by_sid(sid)
		if sid ~= nil then
			local info = T_Recipe_Data[sid];
			if info ~= nil then
				return info[index_learn_rank];
			end
		end
	end
	--	sid | learn_rank, yellow_rank, green_rank, grey_rank
	function DataAgent.get_difficulty_rank_list_by_sid(sid)
		if sid ~= nil then
			local info = T_Recipe_Data[sid];
			if info ~= nil then
				local bonus = T_CharRaceBonus[info[index_pid]];
				if bonus ~= nil then
					return info[index_learn_rank], info[index_yellow_rank] + bonus, info[index_green_rank] + bonus, info[index_grey_rank] + bonus, bonus;
				else
					return info[index_learn_rank], info[index_yellow_rank], info[index_green_rank], info[index_grey_rank];
				end
			end
		end
	end
	--	sid | text"[[red ]yellow green grey]"
	function DataAgent.get_difficulty_rank_list_text_by_sid(sid, tipbonus)
		if sid ~= nil then
			local red, yellow, green, grey, bonus = DataAgent.get_difficulty_rank_list_by_sid(sid);
			if (red == nil and yellow == nil and green == nil and grey == nil) or (red <= 0 and yellow <= 0 and green <= 0 and grey <= 0) then
				return "";
			end
			if bonus and tipbonus then
				-- if red < yellow then
					return "|cffff8f00" .. red .. "|r |cffffff00" .. yellow .. "|r |cff8fff00" .. green .. "|r |cff8f8f8f" .. grey .. "|r |cff00ff00*" .. CT.SELFRACE .. " " .. bonus .. "*|r";
				-- else
					-- return "|cffffff00" .. yellow .. "|r |cff8fff00" .. green .. "|r |cff8f8f8f" .. grey .. "|r |cff00ff00*" .. CT.SELFRACE .. " " .. bonus .. "*|r";
				-- end
			else
				-- if red < yellow then
					return "|cffff8f00" .. red .. "|r |cffffff00" .. yellow .. "|r |cff8fff00" .. green .. "|r |cff8f8f8f" .. grey .. "|r";
				-- else
					-- return "|cffffff00" .. yellow .. "|r |cff8fff00" .. green .. "|r |cff8f8f8f" .. grey .. "|r";
				-- end
			end
		end
		return "";
	end
	--	sid | difficulty	--	rank: red-1, yellow-2, green-3, grey-4
	function DataAgent.get_difficulty_rank_by_sid(sid, cur)
		if sid ~= nil then
			local info = T_Recipe_Data[sid];
			if info ~= nil then
				local bonus = T_CharRaceBonus[info[index_pid]] or 0;
				if cur >= info[index_grey_rank] + bonus then
					return 4;
				elseif cur >= info[index_green_rank] + bonus then
					return 3;
				elseif cur >= info[index_yellow_rank] + bonus then
					return 2;
				elseif cur >= info[index_learn_rank] then
					return 1;
				else
					return 0;
				end
			end
		end
		return CT.BIGNUMBER;
	end
	--	sid | avg_made, min_made, max_made
	function DataAgent.get_num_made_by_sid(sid)
		if sid ~= nil then
			local info = T_Recipe_Data[sid];
			if info ~= nil then
				local num = (info[index_num_made_min] + info[index_num_made_max]) / 2;
				return num <= 0 and 1 or num, info[index_num_made_min], info[index_num_made_max];
			end
		end
	end
	--	sid | reagent_ids{  }, reagent_nums{  }
	function DataAgent.get_reagents_by_sid(sid)
		if sid ~= nil then
			local info = T_Recipe_Data[sid];
			if info ~= nil then
				return info[index_reagents_id], info[index_reagents_count];
			end
		end
	end
	--	query_T_Recipe_Data>
	--	pid, sname | num, pids{  }
	function DataAgent.get_sid_by_pid_sname(pid, sname)
		if pid ~= nil and sname ~= nil then
			local pt = T_sname2sid[pid];
			if pt ~= nil then
				local ptn = pt[sname];
				if ptn ~= nil then
					return #ptn, ptn;
				end
			end
		end
		return 0;
	end
	--	pid, sname, cid | sid
	function DataAgent.get_sid_by_pid_sname_cid(pid, sname, cid)
		if pid ~= nil and sname ~= nil and cid ~= nil then
			local nsids, sids = DataAgent.get_sid_by_pid_sname(pid, sname);
			local index_xid = pid == 10 and index_sid or index_cid;
			if nsids > 0 then
				for index = 1, #sids do
					local sid = sids[index];
					local info = T_Recipe_Data[sid];
					if info and cid == info[index_xid] or cid == info[index_cid] then
						return sid;
					end
				end
			end
		end
	end
	--	cid | is_tradeskill
	function DataAgent.is_tradeskill_cid(cid)
		return cid ~= nil and T_cis2sid[cid] ~= nil;
	end
	--	cid | nsids, sids{  }
	function DataAgent.get_sid_by_cid(cid)
		if cid ~= nil then
			local sids = T_cis2sid[cid];
			if sids ~= nil then
				return #sids, sids;
			end
		end
		return 0;
	end
	--	pid, cid | nsids, sids{  }
	function DataAgent.get_sid_by_pid_cid(pid, cid)
		if pid ~= nil and cid ~= nil then
			local p = T_cidpid2sid[pid];
			if p ~= nil then
				local sids = p[cid];
				if sids ~= nil then
					return #sids, sids;
				end
			end
		end
		return 0;
	end
	function DataAgent.get_sid_by_rid(rid)
		if rid ~= nil then
			return T_rid2sid[rid];
		end
	end
	function DataAgent.get_sid_by_reagent(iid)
		if iid ~= nil then
			return T_material2sid[iid];
		end
	end
--	QUERY OBJ INFO
	function DataAgent.__spell_info(sid)
		if sid ~= nil then
			local sinfo = T_SpellData[sid];
			if sinfo == nil then
				return LF_CacheSpell(sid);
			else
				return sinfo;
			end
		end
	end
	function DataAgent.spell_name(sid)
		local sinfo = DataAgent.__spell_info(sid);
		if sinfo ~= nil then
			return sinfo[1];
		end
	end
	function DataAgent.spell_name_lower(sid)
		local sinfo = DataAgent.__spell_info(sid);
		if sinfo ~= nil then
			return sinfo[2];
		end
	end
	function DataAgent.spell_link(sid)
		local sinfo = DataAgent.__spell_info(sid);
		if sinfo ~= nil then
			return sinfo[3];
		end
	end
	function DataAgent.spell_link_lower(sid)
		local sinfo = DataAgent.__spell_info(sid);
		if sinfo ~= nil then
			return sinfo[4];
		end
	end
	function DataAgent.spell_string(sid)
		local sinfo = DataAgent.__spell_info(sid);
		if sinfo ~= nil then
			return sinfo[5];
		end
	end
	--
	function DataAgent.__item_info(iid)
		if iid ~= nil then
			local iinfo = T_ItemData[iid];
			if iinfo == nil then
				return LF_CacheItem(iid);
			else
				return iinfo;
			end
		end
	end
	function DataAgent.item_info(iid)
		local iinfo = DataAgent.__item_info(iid);
		if iinfo ~= nil then
			return unpack(iinfo);
		end
	end
	function DataAgent.item_name(iid)
		local iinfo = DataAgent.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_name];
		end
	end
	function DataAgent.item_link(iid)
		local iinfo = DataAgent.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_link];
		end
	end
	function DataAgent.item_rarity(iid)
		local iinfo = DataAgent.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_rarity];
		end
	end
	function DataAgent.item_loc(iid)
		local iinfo = DataAgent.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_loc];
		end
	end
	function DataAgent.item_icon(iid)
		local iinfo = DataAgent.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_icon];
		end
	end
	function DataAgent.item_sellPrice(iid)
		local iinfo = DataAgent.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_sellPrice];
		end
	end
	function DataAgent.item_typeID(iid)
		local iinfo = DataAgent.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_typeID];
		end
	end
	function DataAgent.item_subTypeID(iid)
		local iinfo = DataAgent.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_subTypeID];
		end
	end
	function DataAgent.item_bindType(iid)
		local iinfo = DataAgent.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_bindType];
		end
	end
	function DataAgent.item_name_lower(iid)
		local iinfo = DataAgent.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_name];
		end
	end
	function DataAgent.item_link_lower(iid)
		local iinfo = DataAgent.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_link];
		end
	end
	function DataAgent.item_string(iid)
		local iinfo = DataAgent.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_string];
		end
	end
	--	secure
	function DataAgent.spell_name_s(sid)
		return DataAgent.spell_name(sid) or ("spellId:" .. sid);
	end
	function DataAgent.spell_link_s(sid)
		return DataAgent.spell_link(sid) or ("spellId:" .. sid);
	end
	function DataAgent.spell_string_s(sid)
		return DataAgent.spell_string(sid) or ("spellId:" .. sid);
	end
	function DataAgent.item_name_s(iid)
		return DataAgent.item_name(iid) or ("itemId:" .. iid);
	end
	function DataAgent.item_link_s(iid)
		return DataAgent.item_link(iid) or ("itemId:" .. iid);
	end
	function DataAgent.item_string_s(iid)
		return DataAgent.item_string(iid) or ("itemId:" .. iid);
	end
--	MISC
	function DataAgent.is_spec_learned(spec)
		return T_IsSpecLearned[spec];
	end
	function DataAgent.is_name_same_skill(name1, name2)
		return name1 == name2 or name1 == T_TradeSkill_SameSkillName[name2];
	end
--	pid, list, check_hash, phase, rank, minRankOverride, maxRankOffset, rankReversed, showKnown, showUnkown, showHighRank, filterClass, filterSpec, donot_wipe | list{ sid, }
local function FilterAdd(list, sid, class, spec, filterClass, filterSpec)
	if (class == nil or not filterClass or bitband(class, USELFCLASSBIT) ~= 0) and (spec == nil or not filterSpec or T_IsSpecLearned[spec]) then
		list[#list + 1] = sid;
	end
end
function DataAgent.get_ordered_list(pid, list, check_hash, phase, rank, minRankOverride, maxRankOffset, rankReversed, showKnown, showUnkown, showHighRank, filterClass, filterSpec, donot_wipe)
	if pid == nil then
		-- MT.Debug("DataAgent.get_ordered_list|cff00ff00#1L1|r");
		if not donot_wipe then
			wipe(list);
		end
		for pid = DataAgent.DBMINPID, DataAgent.DBMAXPID do
			if T_TradeSkill_RecipeList[pid] ~= nil then
				DataAgent.get_ordered_list(pid, list, check_hash, phase, rank, minRankOverride, maxRankOffset, rankReversed, showKnown, showUnkown, showHighRank, filterClass, filterSpec, true);
			end
		end
	elseif T_TradeSkill_RecipeList[pid] ~= nil then
		-- MT.Debug("DataAgent.get_ordered_list|cff00ff00#1L2|r", pid);
		local recipe = T_TradeSkill_RecipeList[pid];
		if not donot_wipe then
			wipe(list);
		end
		phase = phase or DataAgent.CURPHASE;
		minRankOverride = (minRankOverride ~= nil and minRankOverride <= rank) and minRankOverride or 0;
		maxRankOffset = (maxRankOffset ~= nil and maxRankOffset > 0) and maxRankOffset or nil;
		local notlowerphase = phase >= DataAgent.CURPHASE;
		if check_hash ~= nil and rank ~= nil then
			local bonus = T_CharRaceBonus[pid] or 0;
			if showKnown and showUnkown then
				if rankReversed then
					for i = 1, #recipe do
						local sid = recipe[i];
						local info = T_Recipe_Data[sid];
						if (info[index_phase] <= phase or (notlowerphase and check_hash[sid] ~= nil)) and info[index_learn_rank] >= minRankOverride and info[index_grey_rank] + bonus <= rank then
							FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
						end
					end
					for i = 1, #recipe do
						local sid = recipe[i];
						local info = T_Recipe_Data[sid];
						if (info[index_phase] <= phase or (notlowerphase and check_hash[sid] ~= nil)) and info[index_learn_rank] >= minRankOverride and info[index_green_rank] + bonus <= rank and info[index_grey_rank] + bonus > rank then
							FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
						end
					end
					for i = 1, #recipe do
						local sid = recipe[i];
						local info = T_Recipe_Data[sid];
						if (info[index_phase] <= phase or (notlowerphase and check_hash[sid] ~= nil)) and info[index_learn_rank] >= minRankOverride and info[index_yellow_rank] + bonus <= rank and info[index_green_rank] + bonus > rank then
							FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
						end
					end
					for i = 1, #recipe do
						local sid = recipe[i];
						local info = T_Recipe_Data[sid];
						if (info[index_phase] <= phase or (notlowerphase and check_hash[sid] ~= nil)) and info[index_learn_rank] >= minRankOverride and info[index_learn_rank] <= rank and info[index_yellow_rank] + bonus > rank then
							FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
						end
					end
					if showHighRank then
						for i = 1, #recipe do
							local sid = recipe[i];
							local info = T_Recipe_Data[sid];
							if (info[index_phase] <= phase or (notlowerphase and check_hash[sid] ~= nil)) and info[index_learn_rank] > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					elseif maxRankOffset ~= nil then
						local Top = rank + maxRankOffset;
						for i = 1, #recipe do
							local sid = recipe[i];
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_learn_rank] > rank and info[index_learn_rank] <= Top then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
				else
					if showHighRank then
						for i = #recipe, 1, -1 do
							local sid = recipe[i];
							local info = T_Recipe_Data[sid];
							if (info[index_phase] <= phase or (notlowerphase and check_hash[sid] ~= nil)) and info[index_learn_rank] > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					elseif maxRankOffset ~= nil then
						local Top = rank + maxRankOffset;
						for i = 1, #recipe do
							local sid = recipe[i];
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_learn_rank] > rank and info[index_learn_rank] <= Top then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						local info = T_Recipe_Data[sid];
						if (info[index_phase] <= phase or (notlowerphase and check_hash[sid] ~= nil)) and info[index_learn_rank] >= minRankOverride and info[index_learn_rank] <= rank and info[index_yellow_rank] + bonus > rank then
							FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
						end
					end
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						local info = T_Recipe_Data[sid];
						if (info[index_phase] <= phase or (notlowerphase and check_hash[sid] ~= nil)) and info[index_learn_rank] >= minRankOverride and info[index_yellow_rank] + bonus <= rank and info[index_green_rank] + bonus > rank then
							FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
						end
					end
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						local info = T_Recipe_Data[sid];
						if (info[index_phase] <= phase or (notlowerphase and check_hash[sid] ~= nil)) and info[index_learn_rank] >= minRankOverride and info[index_green_rank] + bonus <= rank and info[index_grey_rank] + bonus > rank then
							FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
						end
					end
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						local info = T_Recipe_Data[sid];
						if (info[index_phase] <= phase or (notlowerphase and check_hash[sid] ~= nil)) and info[index_learn_rank] >= minRankOverride and info[index_grey_rank] + bonus <= rank then
							FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
						end
					end
				end
			elseif showKnown then
				if rankReversed then
					for i = 1, #recipe do
						local sid = recipe[i];
						if check_hash[sid] ~= nil then
							local info = T_Recipe_Data[sid];
							if (info[index_phase] <= phase or notlowerphase) and info[index_learn_rank] >= minRankOverride and info[index_grey_rank] + bonus <= rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = 1, #recipe do
						local sid = recipe[i];
						if check_hash[sid] ~= nil then
							local info = T_Recipe_Data[sid];
							if (info[index_phase] <= phase or notlowerphase) and info[index_learn_rank] >= minRankOverride and info[index_green_rank] + bonus <= rank and info[index_grey_rank] + bonus > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = 1, #recipe do
						local sid = recipe[i];
						if check_hash[sid] ~= nil then
							local info = T_Recipe_Data[sid];
							if (info[index_phase] <= phase or notlowerphase) and info[index_learn_rank] >= minRankOverride and info[index_yellow_rank] + bonus <= rank and info[index_green_rank] + bonus > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = 1, #recipe do
						local sid = recipe[i];
						if check_hash[sid] ~= nil then
							local info = T_Recipe_Data[sid];
							if (info[index_phase] <= phase or notlowerphase) and info[index_learn_rank] >= minRankOverride and info[index_learn_rank] <= rank and info[index_yellow_rank] + bonus > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					if maxRankOffset ~= nil then
						local Top = rank + maxRankOffset;
						for i = 1, #recipe do
							local sid = recipe[i];
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_learn_rank] > rank and info[index_learn_rank] <= Top then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
				else
					if maxRankOffset ~= nil then
						local Top = rank + maxRankOffset;
						for i = 1, #recipe do
							local sid = recipe[i];
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_learn_rank] > rank and info[index_learn_rank] <= Top then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						if check_hash[sid] ~= nil then
							local info = T_Recipe_Data[sid];
							if (info[index_phase] <= phase or notlowerphase) and info[index_learn_rank] >= minRankOverride and info[index_learn_rank] <= rank and info[index_yellow_rank] + bonus > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						if check_hash[sid] ~= nil then
							local info = T_Recipe_Data[sid];
							if (info[index_phase] <= phase or notlowerphase) and info[index_learn_rank] >= minRankOverride and info[index_yellow_rank] + bonus <= rank and info[index_green_rank] + bonus > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						if check_hash[sid] ~= nil then
							local info = T_Recipe_Data[sid];
							if (info[index_phase] <= phase or notlowerphase) and info[index_learn_rank] >= minRankOverride and info[index_green_rank] + bonus <= rank and info[index_grey_rank] + bonus > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						if check_hash[sid] ~= nil then
							local info = T_Recipe_Data[sid];
							if (info[index_phase] <= phase or notlowerphase) and info[index_learn_rank] >= minRankOverride and info[index_grey_rank] + bonus <= rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
				end
			elseif showUnkown then
				if rankReversed then
					for i = 1, #recipe do
						local sid = recipe[i];
						if check_hash[sid] == nil then
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_learn_rank] >= minRankOverride and info[index_grey_rank] + bonus <= rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = 1, #recipe do
						local sid = recipe[i];
						if check_hash[sid] == nil then
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_learn_rank] >= minRankOverride and info[index_green_rank] + bonus <= rank and info[index_grey_rank] + bonus > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = 1, #recipe do
						local sid = recipe[i];
						if check_hash[sid] == nil then
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_learn_rank] >= minRankOverride and info[index_yellow_rank] + bonus <= rank and info[index_green_rank] + bonus > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = 1, #recipe do
						local sid = recipe[i];
						if check_hash[sid] == nil then
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_learn_rank] >= minRankOverride and info[index_learn_rank] <= rank and info[index_yellow_rank] + bonus > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					if showHighRank then
						for i = 1, #recipe do
							local sid = recipe[i];
							if check_hash[sid] == nil then
								local info = T_Recipe_Data[sid];
								if info[index_phase] <= phase and info[index_learn_rank] > rank then
									FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
								end
							end
						end
					elseif maxRankOffset ~= nil then
						local Top = rank + maxRankOffset;
						for i = 1, #recipe do
							local sid = recipe[i];
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_learn_rank] > rank and info[index_learn_rank] <= Top then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
				else
					if showHighRank then
						for i = #recipe, 1, -1 do
							local sid = recipe[i];
							if check_hash[sid] == nil then
								local info = T_Recipe_Data[sid];
								if info[index_phase] <= phase and info[index_learn_rank] > rank then
									FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
								end
							end
						end
					elseif maxRankOffset ~= nil then
						local Top = rank + maxRankOffset;
						for i = 1, #recipe do
							local sid = recipe[i];
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_learn_rank] > rank and info[index_learn_rank] <= Top then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						if check_hash[sid] == nil then
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_learn_rank] >= minRankOverride and info[index_learn_rank] <= rank and info[index_yellow_rank] + bonus > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						if check_hash[sid] == nil then
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_learn_rank] >= minRankOverride and info[index_yellow_rank] + bonus <= rank and info[index_green_rank] + bonus > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						if check_hash[sid] == nil then
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_learn_rank] >= minRankOverride and info[index_green_rank] + bonus <= rank and info[index_grey_rank] + bonus > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						if check_hash[sid] == nil then
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_learn_rank] >= minRankOverride and info[index_grey_rank] + bonus <= rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
				end
			end
		elseif check_hash ~= nil then
			if showKnown and showUnkown then
				if rankReversed then
					for i = 1, #recipe do
						local sid = recipe[i];
						local info = T_Recipe_Data[sid];
						if info[index_phase] <= phase and info[index_learn_rank] >= minRankOverride or (notlowerphase and check_hash[sid] ~= nil) then
							FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
						end
					end
				else
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						local info = T_Recipe_Data[sid];
						if info[index_phase] <= phase and info[index_learn_rank] >= minRankOverride or (notlowerphase and check_hash[sid] ~= nil) then
							FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
						end
					end
				end
			elseif showKnown then
				if rankReversed then
					for i = 1, #recipe do
						local sid = recipe[i];
						if check_hash[sid] ~= nil then
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_learn_rank] >= minRankOverride or notlowerphase then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
				else
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						if check_hash[sid] ~= nil then
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_learn_rank] >= minRankOverride or notlowerphase then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
				end
			elseif showUnkown then
				if rankReversed then
					for i = 1, #recipe do
						local sid = recipe[i];
						if check_hash[sid] == nil then
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_learn_rank] >= minRankOverride then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
				else
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						if check_hash[sid] == nil then
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_learn_rank] >= minRankOverride then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
				end
			end
		elseif rank ~= nil then
			local bonus = T_CharRaceBonus[pid] or 0;
			rank = rank + bonus;
			if rankReversed then
				for i = 1, #recipe do
					local sid = recipe[i];
					local info = T_Recipe_Data[sid];
					if info[index_phase] <= phase and info[index_learn_rank] >= minRankOverride and info[index_grey_rank] + bonus <= rank then
						FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
					end
				end
				for i = 1, #recipe do
					local sid = recipe[i];
					local info = T_Recipe_Data[sid];
					if info[index_phase] <= phase and info[index_learn_rank] >= minRankOverride and info[index_green_rank] + bonus <= rank and info[index_grey_rank] + bonus > rank then
						FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
					end
				end
				for i = 1, #recipe do
					local sid = recipe[i];
					local info = T_Recipe_Data[sid];
					if info[index_phase] <= phase and info[index_learn_rank] >= minRankOverride and info[index_yellow_rank] + bonus <= rank and info[index_green_rank] + bonus > rank then
						FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
					end
				end
				for i = 1, #recipe do
					local sid = recipe[i];
					local info = T_Recipe_Data[sid];
					if info[index_phase] <= phase and info[index_learn_rank] >= minRankOverride and info[index_learn_rank] <= rank and info[index_yellow_rank] + bonus > rank then
						FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
					end
				end
				if showHighRank then
					for i = 1, #recipe do
						local sid = recipe[i];
						local info = T_Recipe_Data[sid];
						if info[index_phase] <= phase and info[index_learn_rank] > rank then
							FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
						end
					end
				elseif maxRankOffset ~= nil then
					local Top = rank + maxRankOffset;
					for i = 1, #recipe do
						local sid = recipe[i];
						local info = T_Recipe_Data[sid];
						if info[index_phase] <= phase and info[index_learn_rank] > rank and info[index_learn_rank] <= Top then
							FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
						end
					end
				end
			else
				if showHighRank then
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						local info = T_Recipe_Data[sid];
						if info[index_phase] <= phase and info[index_learn_rank] > rank then
							FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
						end
					end
				elseif maxRankOffset ~= nil then
					local Top = rank + maxRankOffset;
					for i = 1, #recipe do
						local sid = recipe[i];
						local info = T_Recipe_Data[sid];
						if info[index_phase] <= phase and info[index_learn_rank] > rank and info[index_learn_rank] <= Top then
							FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
						end
					end
				end
				for i = #recipe, 1, -1 do
					local sid = recipe[i];
					local info = T_Recipe_Data[sid];
					if info[index_phase] <= phase and info[index_learn_rank] >= minRankOverride and info[index_learn_rank] <= rank and info[index_yellow_rank] + bonus > rank then
						FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
					end
				end
				for i = #recipe, 1, -1 do
					local sid = recipe[i];
					local info = T_Recipe_Data[sid];
					if info[index_phase] <= phase and info[index_learn_rank] >= minRankOverride and info[index_yellow_rank] + bonus <= rank and info[index_green_rank] + bonus > rank then
						FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
					end
				end
				for i = #recipe, 1, -1 do
					local sid = recipe[i];
					local info = T_Recipe_Data[sid];
					if info[index_phase] <= phase and info[index_learn_rank] >= minRankOverride and info[index_green_rank] + bonus <= rank and info[index_grey_rank] + bonus > rank then
						FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
					end
				end
				for i = #recipe, 1, -1 do
					local sid = recipe[i];
					local info = T_Recipe_Data[sid];
					if info[index_phase] <= phase and info[index_learn_rank] >= minRankOverride and info[index_grey_rank] + bonus <= rank then
						FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
					end
				end
			end
		else
			if rankReversed then
				for i = 1, #recipe do
					local sid = recipe[i];
					local info = T_Recipe_Data[sid];
					if info[index_phase] <= phase then
						FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
					end
				end
			else
				for i = #recipe, 1, -1 do
					local sid = recipe[i];
					local info = T_Recipe_Data[sid];
					if info[index_phase] <= phase then
						FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
					end
				end
			end
		end
	else
		MT.Debug("DataAgent.get_ordered_list|cff00ff00#1L3|r", pid);
	end
	return list;
end
-->

-->		Known Recipes & Automatically Generate recipe info
DataAgent.LearnedRecipesHash = {  };
function DataAgent.MarkKnown(sid, GUID)
	local list = DataAgent.LearnedRecipesHash[sid];
	if list == nil then
		list = {  };
		DataAgent.LearnedRecipesHash[sid] = list;
	end
	list[GUID] = 1;
end
function DataAgent.CancelMarkKnown(sid, GUID)
	local list = DataAgent.LearnedRecipesHash[sid];
	if list ~= nil then
		list[GUID] = nil;
		for _ in next, list do
			return;
		end
		DataAgent.LearnedRecipesHash[sid] = nil;
	end
end
local T_DynamicCreatedSID = {  };
function DataAgent.DynamicCreateInfo(Frame, pid, cur_rank, index, sid, srank)
	--------------.-PHA-PID-----SID-----CID-LEARN--Y--GREEN-GREY-MIN--MAX---------R-------N--TRAINER-PRICE-RECIPE-QUEST-OBJ-CLASS-SPEC
	--------------1--2---3-------4-------5----6----7----8----9---10---11---------12------13---14-------15-----16---17---18---19----20
	--[~[
	local difficulty_rank = CT.T_RankIndex[srank];
	if T_DynamicCreatedSID[sid] == nil then
		local info = DataAgent.get_info_by_sid(sid);
		if info == nil then
			local cid = Frame.F_GetRecipeItemID(index);
			local minMade, maxMade = Frame.F_GetRecipeNumMade(index);
			local info = { nil, 1, pid, sid, cid, cur_rank, cur_rank, cur_rank, cur_rank, minMade, maxMade, {  }, {  }, };
			if difficulty_rank == 0 then
				info[index_learn_rank] = cur_rank + 1;
				info[index_yellow_rank] = cur_rank + 1;
				info[index_green_rank] = cur_rank + 1;
				info[index_grey_rank] = cur_rank + 1;
			elseif difficulty_rank == 1 then
				info[index_learn_rank] = cur_rank;
				info[index_yellow_rank] = cur_rank + 1;
				info[index_green_rank] = cur_rank + 1;
				info[index_grey_rank] = cur_rank + 1;
			elseif difficulty_rank == 2 then
				info[index_learn_rank] = cur_rank;
				info[index_yellow_rank] = cur_rank;
				info[index_green_rank] = cur_rank + 1;
				info[index_grey_rank] = cur_rank + 1;
			elseif difficulty_rank == 3 then
				info[index_learn_rank] = cur_rank;
				info[index_yellow_rank] = cur_rank;
				info[index_green_rank] = cur_rank;
				info[index_grey_rank] = cur_rank + 1;
			elseif difficulty_rank == 4 then
				info[index_learn_rank] = cur_rank;
				info[index_yellow_rank] = cur_rank;
				info[index_green_rank] = cur_rank;
				info[index_grey_rank] = cur_rank;
			else
				return;
			end
			local numReagents = Frame.F_GetRecipeNumReagents(index);
			if numReagents > 0 then
				local ids = info[index_reagents_id];
				local cts = info[index_reagents_count];
				for i = 1, numReagents do
					local id = Frame.F_GetRecipeReagentID(index, i);
					local name, texture, req, has = Frame.F_GetRecipeReagentInfo(index, i);
					if id ~= nil and req ~= nil then
						ids[i] = id;
						cts[i] = req;
					else
						return;
					end
				end
			end
			T_DynamicCreatedSID[sid] = info;
			return DataAgent.insert_info(sid, info);
		end
	else
		local info = T_DynamicCreatedSID[sid];
		if difficulty_rank == 0 then
			info[index_learn_rank] = cur_rank + 1;
			info[index_yellow_rank] = cur_rank + 1;
			info[index_green_rank] = cur_rank + 1;
			info[index_grey_rank] = cur_rank + 1;
		elseif difficulty_rank == 1 then
			info[index_learn_rank] = cur_rank;
			info[index_yellow_rank] = cur_rank + 1;
			info[index_green_rank] = cur_rank + 1;
			info[index_grey_rank] = cur_rank + 1;
		elseif difficulty_rank == 2 then
			info[index_learn_rank] = cur_rank;
			info[index_yellow_rank] = cur_rank;
			info[index_green_rank] = cur_rank + 1;
			info[index_grey_rank] = cur_rank + 1;
		elseif difficulty_rank == 3 then
			info[index_learn_rank] = cur_rank;
			info[index_yellow_rank] = cur_rank;
			info[index_green_rank] = cur_rank;
			info[index_grey_rank] = cur_rank + 1;
		elseif difficulty_rank == 4 then
			info[index_learn_rank] = cur_rank;
			info[index_yellow_rank] = cur_rank;
			info[index_green_rank] = cur_rank;
			info[index_grey_rank] = cur_rank;
		else
			return;
		end
	end
	--]]
end
-->

MT.RegisterOnInit('db', function(LoggedIn)
	for pid = DataAgent.DBMINPID, DataAgent.DBMAXPID do
		local list = T_TradeSkill_RecipeList[pid];
		if list ~= nil then
			T_sname2sid[pid] = {  };
			T_cidpid2sid[pid] = T_cidpid2sid[pid] or {  };
			for index = 1, #list do
				local sid = list[index];
				local info = T_Recipe_Data[sid];
				info[index_validated] = true;
				local cid = info[index_cid];
				if cid ~= nil then
					local h1 = T_cis2sid[cid];
					if h1 == nil then
						h1 = {  };
						T_cis2sid[cid] = h1;
					end
					h1[#h1 + 1] = sid;
					local h2 = T_cidpid2sid[pid][cid];
					if h2 == nil then
						h2 = {  };
						T_cidpid2sid[pid][cid] = h2;
					end
					h2[#h2 + 1] = sid;
				end
				local rids = info[index_recipe];
				if rids ~= nil then
					for index = 1, #rids do
						local rid = rids[index];
						T_rid2sid[rid] = sid;
					end
				end
				--	list
				recipe_sid_list[#recipe_sid_list + 1] = sid;
				if cid ~= nil then
					recipe_cid_list[#recipe_cid_list + 1] = cid;
				end
				--	material
				local regeants_id = info[index_reagents_id];
				local reagents_num = info[index_reagents_count];
				for index = 1, #regeants_id do
					local reagent_id = regeants_id[index];
					local val = T_material2sid[reagent_id];
					if val == nil then
						val = { {  }, {  }, };
						T_material2sid[reagent_id] = val;
					end
					val[1][#val[1] + 1] = sid;
					val[2][#val[2] + 1] = reagents_num[index];
				end
			end
		end
	end
	do
		local list = T_TradeSkill_RecipeList[-1];
		if list ~= nil then
			for index = 1, #list do
				local sid = list[index];
				local info = T_Recipe_Data[sid];
				info[index_validated] = true;
				local cid = info[index_cid];
				if cid ~= nil then
					local h1 = T_cis2sid[cid];
					if h1 == nil then
						h1 = {  };
						T_cis2sid[cid] = h1;
					end
					h1[#h1 + 1] = sid;
				end
				local rids = info[index_recipe];
				if rids ~= nil then
					for index = 1, #rids do
						local rid = rids[index];
						T_rid2sid[rid] = sid;
					end
				end
				--	material
				local regeants_id = info[index_reagents_id];
				local reagents_num = info[index_reagents_count];
				for index = 1, #regeants_id do
					local reagent_id = regeants_id[index];
					local val = T_material2sid[reagent_id];
					if val == nil then
						val = { {  }, {  }, };
						T_material2sid[reagent_id] = val;
					end
					val[1][#val[1] + 1] = sid;
					val[2][#val[2] + 1] = reagents_num[index];
				end
			end
		end
	end
	for sid, info in next, T_Recipe_Data do
		if not info[index_validated] then
			T_Recipe_Data[sid] = nil;
		end
	end
	local cache = VT.CACHE[CT.LOCALE];
	if cache == nil or cache.__WoWVersion == nil or cache.__WoWVersion < CT.TOCVERSION or cache.__DataVersion == nil or cache.__DataVersion < DataAgent.__DataVersion then
		cache = { S = T_SpellData, I = T_ItemData, };
		VT.CACHE[CT.LOCALE] = cache;
	else
		T_SpellData, T_ItemData = cache.S, cache.I;
	end
	cache.__WoWVersion = CT.TOCVERSION;
	cache.__DataVersion = DataAgent.__DataVersion;
	_LoadSavedVar();
	LF_PreloadSpell();
	LF_PreloadItem();
	for spec, pid in next, T_TradeSkill_Spec2Pid do
		T_IsSpecLearned[spec] = IsSpellKnown(spec) and true or nil;
	end
	F:RegisterEvent("LEARNED_SPELL_IN_TAB");
	F:RegisterEvent("SPELLS_CHANGED");
end);
-->
