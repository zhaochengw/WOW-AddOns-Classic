--[[--
	by ALA @ 163UI
--]]--

local __addon__, __namespace__ = ...;
local __db__ = __namespace__.__db__;
local L = __namespace__.L;

-->		upvalue
	local next = next;
	local unpack = unpack;

	local bitband = bit.band;
	local strlower = string.lower;
	local tinsert = table.insert;
	local wipe = table.wipe;

	local RequestLoadSpellData = RequestLoadSpellData or C_Spell.RequestLoadSpellData;
	local RequestLoadItemDataByID = RequestLoadItemDataByID or C_Item.RequestLoadItemDataByID;
	local GetSpellInfo = GetSpellInfo;
	local GetItemInfo = GetItemInfo;
	local IsSpellKnown = IsSpellKnown;
	local C_Timer_After = C_Timer.After;
	local IsInRaid = IsInRaid;
	local IsInGroup = IsInGroup;


	local ITEM_QUALITY_COLORS = ITEM_QUALITY_COLORS;

	local _G = _G;
	--[[
		local UnitRace = UnitRace;
		local CreateFrame = CreateFrame;
	]]
-->


local CURPHASE = __db__.CURPHASE;
local UCLASSBIT = __db__.UCLASSBIT;

local BIG_NUMBER = 4294967295;
local PLAYER_RACE, PLAYER_RACE_FILE, PLAYER_RACE_ID = UnitRace('player');

local _noop_, _log_, _error_ = __namespace__._noop_, __namespace__._log_, __namespace__._error_;


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

local F = CreateFrame('FRAME');
F:SetScript("OnEvent", function(self, event, ...)
	return self[event](...);
end);
function __db__:FireEvent(event, ...)
	local func = F[event];
	if func ~= nil then
		return func(...);
	end
end


-->		****************
__namespace__:BuildEnv("db");
-->		****************


-->		Define
--	Constant
local T_CharRaceBonus = __db__.T_RaceBonus[PLAYER_RACE_ID] or {  };
--	Recipe Data
local T_Recipe_Data = __db__.T_Recipe_Data;
--[[	T_Recipe_Data[sid] = {
			1_validated, 2_phase, 3_pid, 4_sid, 5_cid,
			6_learn, 7_yellow, 8_green, 9_grey,
			10_made, 11_made, 12_reagents_id, 13_reagents_count, 
			14_trainer, 15_train_price, 16_rid, 17_quest, 18_object
		}
--]]
--
local T_TradeSkill_ID = __db__.T_TradeSkill_ID;
--[[auto]]local T_TradeSkill_Name = {  };								--	[pid] = prof_name
--[[auto]]local T_TradeSkill_Hash = {  };								--	[prof_name] = pid
local T_TradeSkill_Texture = __db__.T_TradeSkill_Texture;
local T_TradeSkill_CheckID = __db__.T_TradeSkill_CheckID;	--	[pid] = p_check_sid
--[[auto]]local T_TradeSkill_CheckName = {  };						--	[pid] = p_check_sname
local T_TradeSkill_HasUI = __db__.T_TradeSkill_HasUI;		--	[pid] = bool
local T_TradeSkill_Spec2Pid = __db__.T_TradeSkill_Spec2Pid;
local T_TradeSkill_RecipeList = __db__.T_TradeSkill_RecipeList;
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
	if L.extra_skill_name[pid] == nil then
		T_TradeSkill_Hash[pname] = pid;
		T_TradeSkill_Hash[pname_lower] = pid;
	else
		T_TradeSkill_Hash[L.extra_skill_name[pid]] = pid;
		T_TradeSkill_Hash[strlower(L.extra_skill_name[pid])] = pid;
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
		tinsert(ptn, sid);
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
	-- else
		-- RequestLoadItemDataByID(iid);
		-- _error_("SPELL_DATA_LOAD_RESULT#1", iid);
	end
end
-->		preload
local _SPre, _IPre = 0, 0;		--	dev
if __namespace__.__is_dev then
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
	-- else
		-- local info = T_Recipe_Data[sid];
		-- RequestLoadSpellData(sid);
		-- _error_("SPELL_DATA_LOAD_RESULT#0", sid);
	end
end
function F.ITEM_DATA_LOAD_RESULT(iid, success)
	if success and T_Temp_ItemHash[iid] then
		LF_CacheItem(iid);
	-- else
		-- RequestLoadItemDataByID(iid);
		-- _error_("SPELL_DATA_LOAD_RESULT#0", iid);
	end
end

local function LF_RequestSpell()
	local completed = true;
	local maxonce = IsInRaid() and 500 or (IsInGroup() and 1000 or 10000);
	for pid = __db__.DBMINPID, __db__.DBMAXPID do
		if T_TradeSkill_Name[pid] == nil then
			local sid = T_TradeSkill_ID[pid];
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
	for pid = __db__.DBMINPID, __db__.DBMAXPID do
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
		F:RegisterEvent("SPELL_DATA_LOAD_RESULT");	--	Events registered before loading screen went out may not work well. So reg here everytime.
		C_Timer_After(2.0, LF_PreloadSpell);
		LN_Limited_RequestSpell = LN_Limited_RequestSpell + 1;
		if LN_Limited_RequestSpell >= 10 then
			_error_("LF_PreloadSpell#0", LN_Limited_RequestSpell);
		else
			return;
		end
	end
	__namespace__:FireEvent("USER_EVENT_SPELL_DATA_LOADED");
	LB_PreloadSpellFinished = true;
	if LB_PreloadItemFinished then
		__namespace__:FireEvent("USER_EVENT_DATA_LOADED");
	end
end

local function LF_RequestItem()
	local completed = true;
	local maxonce = IsInRaid() and 500 or (IsInGroup() and 1000 or 10000);
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
		F:RegisterEvent("ITEM_DATA_LOAD_RESULT");	--	Events registered before loading screen went out may not work well. So reg here everytime.
		C_Timer_After(2.0, LF_PreloadItem);
		LN_Limited_RequestItem = LN_Limited_RequestItem + 1;
		if LN_Limited_RequestItem >= 10 then
			_error_("LF_PreloadItem#0", LN_Limited_RequestItem);
		else
			return;
		end
	end
	__namespace__:FireEvent("USER_EVENT_ITEM_DATA_LOADED");
	LB_PreloadItemFinished = true;
	if LB_PreloadSpellFinished then
		__namespace__:FireEvent("USER_EVENT_DATA_LOADED");
	end
end
--
local function _LoadSavedVar()
	for pid = __db__.DBMINPID, __db__.DBMAXPID do
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
		for sid, sinfo in next, T_SpellData do
			LF_HashSpell(sid, sinfo[1], sinfo[2]);
		end
	end
end
-->
function F.LEARNED_SPELL_IN_TAB(id, tab, isGuild)
	local pid = T_TradeSkill_Spec2Pid[id];
	if pid ~= nil and T_IsSpecLearned[id] ~= true then
		T_IsSpecLearned[id] = true;
		__namespace__.F_uiMarkToUpdate(pid);
	end
end
function F.SPELLS_CHANGED()
	for spec, pid in next, T_TradeSkill_Spec2Pid do
		local val = IsSpellKnown(spec) and true or nil;
		if T_IsSpecLearned[spec] ~= val then
			T_IsSpecLearned[spec] = val;
			__namespace__.F_uiMarkToUpdate(pid);
		end
	end
end
__namespace__:AddCallback("USER_EVENT_DATA_LOADED", function()
	if LB_PreloadSpellFinished and LB_PreloadItemFinished then
		for pid = __db__.DBMINPID, __db__.DBMAXPID do
			local n1, n2 = T_TradeSkill_Name[pid], T_TradeSkill_CheckName[pid];
			if n1 ~= nil and n2 ~= nil then
				T_TradeSkill_SameSkillName[n1] = n2;
				T_TradeSkill_SameSkillName[n2] = n1;
			end
		end
		if __namespace__.__is_dev then
			_error_("Preload", _SPre, _IPre);
		end
	end
end);

-->		Query
--	GET TABLE
	--	| T_TradeSkill_CheckID{ [pid] = p_check_sid }
	function __db__.table_tradeskill_check_id()
		return T_TradeSkill_CheckID;
	end
	--	| T_TradeSkill_CheckName{ [pid] = p_check_sname }
	function __db__.table_tradeskill_check_name()
		return T_TradeSkill_CheckName;
	end
--	QUERY RECIPE DB
	--	pid | is_tradeskill
	function __db__.is_pid(pid)
		return pid ~= nil and T_TradeSkill_ID[pid] ~= nil;
	end
	--	pname | pid
	function __db__.get_pid_by_pname(pname)
		if pname ~= nil then
			return T_TradeSkill_Hash[pname];
		end
	end
	--	pid | pname
	function __db__.get_pname_by_pid(pid)
		if pid ~= nil then
			return T_TradeSkill_Name[pid];
		end
	end
	--	pid | ptexture
	function __db__.get_texture_by_pid(pid)
		if pid ~= nil then
			return T_TradeSkill_Texture[pid];
		end
	end
	--	pid | has_win
	function __db__.is_pid_has_win(pid)
		if __db__.is_pid(pid) then
			return T_TradeSkill_HasUI[pid];
		end
	end
	--	pid | check_id
	function __db__.get_check_id_by_pid(pid)
		if pid ~= nil then
			return T_TradeSkill_CheckID[pid];
		end
	end
	--	pid | check_name
	function __db__.get_check_name_by_pid(pid)
		if pid ~= nil then
			return T_TradeSkill_CheckName[pid];
		end
	end
	--	sid | is_tradeskill
	function __db__.is_tradeskill_sid(sid)
		return sid ~= nil and T_Recipe_Data[sid] ~= nil;
	end
	--	pid | list{ sid, }
	function __db__.get_list_by_pid(pid)
		if pid ~= nil then
			return T_TradeSkill_RecipeList[pid];
		end
	end
	--	<query_T_Recipe_Data
	--	sid | info{  }
	function __db__.get_info_by_sid(sid)
		if sid ~= nil then
			return T_Recipe_Data[sid];
		end
	end
	--	sid | phase
	function __db__.get_phase_by_sid(sid)
		if sid ~= nil then
			local info = T_Recipe_Data[sid];
			if info ~= nil then
				return info[index_phase];
			end
		end
	end
	--	sid | pid
	function __db__.get_pid_by_sid(sid)
		if sid ~= nil then
			local info = T_Recipe_Data[sid];
			if info ~= nil then
				return info[index_pid];
			end
		end
	end
	--	sid | cid
	function __db__.get_cid_by_sid(sid)
		if sid ~= nil then
			local info = T_Recipe_Data[sid];
			if info ~= nil then
				return info[index_cid];
			end
		end
	end
	--	sid | learn_rank
	function __db__.get_learn_rank_by_sid(sid)
		if sid ~= nil then
			local info = T_Recipe_Data[sid];
			if info ~= nil then
				return info[index_learn_rank];
			end
		end
	end
	--	sid | learn_rank, yellow_rank, green_rank, grey_rank
	function __db__.get_difficulty_rank_list_by_sid(sid)
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
	function __db__.get_difficulty_rank_list_text_by_sid(sid, tipbonus)
		if sid ~= nil then
			local red, yellow, green, grey, bonus = __db__.get_difficulty_rank_list_by_sid(sid);
			if red and yellow and green and grey then
				if red <= 0 and yellow <= 0 and green <= 0 and grey <= 0 then
					return "";
				end
				if bonus and tipbonus then
					if red < yellow then
						return "|cffff8f00" .. red .. "|r |cffffff00" .. yellow .. "|r |cff8fff00" .. green .. "|r |cff8f8f8f" .. grey .. "|r |cff00ff00*" .. PLAYER_RACE .. " " .. bonus .. "*|r";
					else
						return "|cffffff00" .. yellow .. "|r |cff8fff00" .. green .. "|r |cff8f8f8f" .. grey .. "|r |cff00ff00*" .. PLAYER_RACE .. " " .. bonus .. "*|r";
					end
				else
					if red < yellow then
						return "|cffff8f00" .. red .. "|r |cffffff00" .. yellow .. "|r |cff8fff00" .. green .. "|r |cff8f8f8f" .. grey .. "|r";
					else
						return "|cffffff00" .. yellow .. "|r |cff8fff00" .. green .. "|r |cff8f8f8f" .. grey .. "|r";
					end
				end
			end
		end
		return "";
	end
	--	sid | difficulty	--	rank: red-1, yellow-2, green-3, grey-4
	function __db__.get_difficulty_rank_by_sid(sid, cur)
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
		return BIG_NUMBER;
	end
	--	sid | avg_made, min_made, max_made
	function __db__.get_num_made_by_sid(sid)
		if sid ~= nil then
			local info = T_Recipe_Data[sid];
			if info ~= nil then
				return (info[index_num_made_min] + info[index_num_made_max]) / 2, info[index_num_made_min], info[index_num_made_max];
			end
		end
	end
	--	sid | reagent_ids{  }, reagent_nums{  }
	function __db__.get_reagents_by_sid(sid)
		if sid ~= nil then
			local info = T_Recipe_Data[sid];
			if info ~= nil then
				return info[index_reagents_id], info[index_reagents_count];
			end
		end
	end
	--	query_T_Recipe_Data>
	--	pid, sname | num, pids{  }
	function __db__.get_sid_by_pid_sname(pid, sname)
		if pid ~= nil and sname ~= nil then
			local pt = T_sname2sid[pid];
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
	function __db__.get_sid_by_pid_sname_cid(pid, sname, cid)
		if pid ~= nil and sname ~= nil and cid ~= nil then
			local nsids, sids = __db__.get_sid_by_pid_sname(pid, sname);
			local index_xid = pid == 10 and index_sid or index_cid;
			if nsids > 0 then
				for index = 1, #sids do
					local sid = sids[index];
					local info = T_Recipe_Data[sid];
					if info and cid == info[index_xid] then
						return sid;
					end
				end
			end
		end
	end
	--	cid | is_tradeskill
	function __db__.is_tradeskill_cid(cid)
		return cid ~= nil and T_cis2sid[cid] ~= nil;
	end
	--	cid | nsids, sids{  }
	function __db__.get_sid_by_cid(cid)
		if cid ~= nil then
			local sids = T_cis2sid[cid];
			if sids then
				return #sids, sids;
			end
		end
		return 0;
	end
	--	pid, cid | nsids, sids{  }
	function __db__.get_sid_by_pid_cid(pid, cid)
		if pid ~= nil and cid ~= nil then
			local p = T_cidpid2sid[pid];
			if p then
				local sids = p[cid];
				return #sids, sids;
			end
		end
		return 0;
	end
	function __db__.get_sid_by_rid(rid)
		if rid ~= nil then
			return T_rid2sid[rid];
		end
	end
	function __db__.get_sid_by_reagent(iid)
		if iid ~= nil then
			return T_material2sid[iid];
		end
	end
--	QUERY OBJ INFO
	function __db__.__spell_info(sid)
		if sid ~= nil then
			local sinfo = T_SpellData[sid];
			if sinfo == nil then
				return LF_CacheSpell(sid);
			else
				return sinfo;
			end
		end
	end
	function __db__.spell_name(sid)
		local sinfo = __db__.__spell_info(sid);
		if sinfo ~= nil then
			return sinfo[1];
		end
	end
	function __db__.spell_name_lower(sid)
		local sinfo = __db__.__spell_info(sid);
		if sinfo ~= nil then
			return sinfo[2];
		end
	end
	function __db__.spell_link(sid)
		local sinfo = __db__.__spell_info(sid);
		if sinfo ~= nil then
			return sinfo[3];
		end
	end
	function __db__.spell_link_lower(sid)
		local sinfo = __db__.__spell_info(sid);
		if sinfo ~= nil then
			return sinfo[4];
		end
	end
	function __db__.spell_string(sid)
		local sinfo = __db__.__spell_info(sid);
		if sinfo ~= nil then
			return sinfo[5];
		end
	end
	--
	function __db__.__item_info(iid)
		if iid ~= nil then
			local iinfo = T_ItemData[iid];
			if iinfo == nil then
				return LF_CacheItem(iid);
			else
				return iinfo;
			end
		end
	end
	function __db__.item_info(iid)
		local iinfo = __db__.__item_info(iid);
		if iinfo ~= nil then
			return unpack(iinfo);
		end
	end
	function __db__.item_name(iid)
		local iinfo = __db__.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_name];
		end
	end
	function __db__.item_link(iid)
		local iinfo = __db__.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_link];
		end
	end
	function __db__.item_rarity(iid)
		local iinfo = __db__.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_rarity];
		end
	end
	function __db__.item_loc(iid)
		local iinfo = __db__.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_loc];
		end
	end
	function __db__.item_icon(iid)
		local iinfo = __db__.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_icon];
		end
	end
	function __db__.item_sellPrice(iid)
		local iinfo = __db__.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_sellPrice];
		end
	end
	function __db__.item_typeID(iid)
		local iinfo = __db__.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_typeID];
		end
	end
	function __db__.item_subTypeID(iid)
		local iinfo = __db__.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_subTypeID];
		end
	end
	function __db__.item_bindType(iid)
		local iinfo = __db__.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_bindType];
		end
	end
	function __db__.item_name_lower(iid)
		local iinfo = __db__.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_name];
		end
	end
	function __db__.item_link_lower(iid)
		local iinfo = __db__.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_link];
		end
	end
	function __db__.item_string(iid)
		local iinfo = __db__.__item_info(iid);
		if iinfo ~= nil then
			return iinfo[index_i_string];
		end
	end
	--	secure
	function __db__.spell_name_s(sid)
		return __db__.spell_name(sid) or ("spellId:" .. sid);
	end
	function __db__.spell_link_s(sid)
		return __db__.spell_link(sid) or ("spellId:" .. sid);
	end
	function __db__.spell_string_s(sid)
		return __db__.spell_string(sid) or ("spellId:" .. sid);
	end
	function __db__.item_name_s(iid)
		return __db__.item_name(iid) or ("itemId:" .. iid);
	end
	function __db__.item_link_s(iid)
		return __db__.item_link(iid) or ("itemId:" .. iid);
	end
	function __db__.item_string_s(iid)
		return __db__.item_string(iid) or ("itemId:" .. iid);
	end
--	MISC
	function __db__.is_spec_learned(spec)
		return T_IsSpecLearned[spec];
	end
	function __db__.is_name_same_skill(name1, name2)
		return name1 == name2 or name1 == T_TradeSkill_SameSkillName[name2];
	end
--	pid, list, check_hash, phase, rank, rankReversed, showKnown, showUnkown, showHighRank, filterClass, filterSpec, donot_wipe_list | list{ sid, }
local function FilterAdd(list, sid, class, spec, filterClass, filterSpec)
	if (class == nil or not filterClass or bitband(class, UCLASSBIT) ~= 0) and (spec == nil or not filterSpec or T_IsSpecLearned[spec]) then
		tinsert(list, sid);
	end
end
function __db__.get_ordered_list(pid, list, check_hash, phase, rank, rankReversed, showKnown, showUnkown, showHighRank, filterClass, filterSpec, donot_wipe_list)
	if pid == nil then
		_log_("__db__.get_ordered_list|cff00ff00#1L1|r");
		if not donot_wipe_list then
			wipe(list);
		end
		for pid = __db__.DBMINPID, __db__.DBMAXPID do
			if T_TradeSkill_RecipeList[pid] then
				__db__.get_ordered_list(pid, list, check_hash, phase, rank, rankReversed, showKnown, showUnkown, showHighRank, filterClass, filterSpec, true);
			end
		end
	elseif T_TradeSkill_RecipeList[pid] ~= nil then
		_log_("__db__.get_ordered_list|cff00ff00#1L2|r", pid);
		local recipe = T_TradeSkill_RecipeList[pid];
		if not donot_wipe_list then
			wipe(list);
		end
		phase = phase or CURPHASE;
		local notlowerphase = phase >= CURPHASE;
		if check_hash ~= nil and rank ~= nil then
			local bonus = T_CharRaceBonus[pid] or 0;
			if showKnown and showUnkown then
				if rankReversed then
					for i = 1, #recipe do
						local sid = recipe[i];
						local info = T_Recipe_Data[sid];
						if (info[index_phase] <= phase or (notlowerphase and check_hash[sid] ~= nil)) and info[index_grey_rank] + bonus <= rank then
							FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
						end
					end
					for i = 1, #recipe do
						local sid = recipe[i];
						local info = T_Recipe_Data[sid];
						if (info[index_phase] <= phase or (notlowerphase and check_hash[sid] ~= nil)) and info[index_green_rank] + bonus <= rank and info[index_grey_rank] + bonus > rank then
							FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
						end
					end
					for i = 1, #recipe do
						local sid = recipe[i];
						local info = T_Recipe_Data[sid];
						if (info[index_phase] <= phase or (notlowerphase and check_hash[sid] ~= nil)) and info[index_yellow_rank] + bonus <= rank and info[index_green_rank] + bonus > rank then
							FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
						end
					end
					for i = 1, #recipe do
						local sid = recipe[i];
						local info = T_Recipe_Data[sid];
						if (info[index_phase] <= phase or (notlowerphase and check_hash[sid] ~= nil)) and info[index_learn_rank] <= rank and info[index_yellow_rank] + bonus > rank then
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
					end
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						local info = T_Recipe_Data[sid];
						if (info[index_phase] <= phase or (notlowerphase and check_hash[sid] ~= nil)) and info[index_learn_rank] <= rank and info[index_yellow_rank] + bonus > rank then
							FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
						end
					end
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						local info = T_Recipe_Data[sid];
						if (info[index_phase] <= phase or (notlowerphase and check_hash[sid] ~= nil)) and info[index_yellow_rank] + bonus <= rank and info[index_green_rank] + bonus > rank then
							FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
						end
					end
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						local info = T_Recipe_Data[sid];
						if (info[index_phase] <= phase or (notlowerphase and check_hash[sid] ~= nil)) and info[index_green_rank] + bonus <= rank and info[index_grey_rank] + bonus > rank then
							FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
						end
					end
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						local info = T_Recipe_Data[sid];
						if (info[index_phase] <= phase or (notlowerphase and check_hash[sid] ~= nil)) and info[index_grey_rank] + bonus <= rank then
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
							if (info[index_phase] <= phase or notlowerphase) and info[index_grey_rank] + bonus <= rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = 1, #recipe do
						local sid = recipe[i];
						if check_hash[sid] ~= nil then
							local info = T_Recipe_Data[sid];
							if (info[index_phase] <= phase or notlowerphase) and info[index_green_rank] + bonus <= rank and info[index_grey_rank] + bonus > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = 1, #recipe do
						local sid = recipe[i];
						if check_hash[sid] ~= nil then
							local info = T_Recipe_Data[sid];
							if (info[index_phase] <= phase or notlowerphase) and info[index_yellow_rank] + bonus <= rank and info[index_green_rank] + bonus > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = 1, #recipe do
						local sid = recipe[i];
						if check_hash[sid] ~= nil then
							local info = T_Recipe_Data[sid];
							if (info[index_phase] <= phase or notlowerphase) and info[index_learn_rank] <= rank and info[index_yellow_rank] + bonus > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
				else
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						if check_hash[sid] ~= nil then
							local info = T_Recipe_Data[sid];
							if (info[index_phase] <= phase or notlowerphase) and info[index_learn_rank] <= rank and info[index_yellow_rank] + bonus > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						if check_hash[sid] ~= nil then
							local info = T_Recipe_Data[sid];
							if (info[index_phase] <= phase or notlowerphase) and info[index_yellow_rank] + bonus <= rank and info[index_green_rank] + bonus > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						if check_hash[sid] ~= nil then
							local info = T_Recipe_Data[sid];
							if (info[index_phase] <= phase or notlowerphase) and info[index_green_rank] + bonus <= rank and info[index_grey_rank] + bonus > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						if check_hash[sid] ~= nil then
							local info = T_Recipe_Data[sid];
							if (info[index_phase] <= phase or notlowerphase) and info[index_grey_rank] + bonus <= rank then
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
							if info[index_phase] <= phase and info[index_grey_rank] + bonus <= rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = 1, #recipe do
						local sid = recipe[i];
						if check_hash[sid] == nil then
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_green_rank] + bonus <= rank and info[index_grey_rank] + bonus > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = 1, #recipe do
						local sid = recipe[i];
						if check_hash[sid] == nil then
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_yellow_rank] + bonus <= rank and info[index_green_rank] + bonus > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = 1, #recipe do
						local sid = recipe[i];
						if check_hash[sid] == nil then
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_learn_rank] <= rank and info[index_yellow_rank] + bonus > rank then
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
					end
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						if check_hash[sid] == nil then
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_learn_rank] <= rank and info[index_yellow_rank] + bonus > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						if check_hash[sid] == nil then
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_yellow_rank] + bonus <= rank and info[index_green_rank] + bonus > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						if check_hash[sid] == nil then
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_green_rank] + bonus <= rank and info[index_grey_rank] + bonus > rank then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						if check_hash[sid] == nil then
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase and info[index_grey_rank] + bonus <= rank then
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
						if info[index_phase] <= phase or (notlowerphase and check_hash[sid] ~= nil) then
							FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
						end
					end
				else
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						local info = T_Recipe_Data[sid];
						if info[index_phase] <= phase or (notlowerphase and check_hash[sid] ~= nil) then
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
							if info[index_phase] <= phase or notlowerphase then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
				else
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						if check_hash[sid] ~= nil then
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase or notlowerphase then
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
							if info[index_phase] <= phase then
								FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
							end
						end
					end
				else
					for i = #recipe, 1, -1 do
						local sid = recipe[i];
						if check_hash[sid] == nil then
							local info = T_Recipe_Data[sid];
							if info[index_phase] <= phase then
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
					if info[index_phase] <= phase and info[index_grey_rank] + bonus <= rank then
						FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
					end
				end
				for i = 1, #recipe do
					local sid = recipe[i];
					local info = T_Recipe_Data[sid];
					if info[index_phase] <= phase and info[index_green_rank] + bonus <= rank and info[index_grey_rank] + bonus > rank then
						FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
					end
				end
				for i = 1, #recipe do
					local sid = recipe[i];
					local info = T_Recipe_Data[sid];
					if info[index_phase] <= phase and info[index_yellow_rank] + bonus <= rank and info[index_green_rank] + bonus > rank then
						FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
					end
				end
				for i = 1, #recipe do
					local sid = recipe[i];
					local info = T_Recipe_Data[sid];
					if info[index_phase] <= phase and info[index_learn_rank] <= rank and info[index_yellow_rank] + bonus > rank then
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
				end
				for i = #recipe, 1, -1 do
					local sid = recipe[i];
					local info = T_Recipe_Data[sid];
					if info[index_phase] <= phase and info[index_learn_rank] <= rank and info[index_yellow_rank] + bonus > rank then
						FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
					end
				end
				for i = #recipe, 1, -1 do
					local sid = recipe[i];
					local info = T_Recipe_Data[sid];
					if info[index_phase] <= phase and info[index_yellow_rank] + bonus <= rank and info[index_green_rank] + bonus > rank then
						FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
					end
				end
				for i = #recipe, 1, -1 do
					local sid = recipe[i];
					local info = T_Recipe_Data[sid];
					if info[index_phase] <= phase and info[index_green_rank] + bonus <= rank and info[index_grey_rank] + bonus > rank then
						FilterAdd(list, sid, info[index_class], info[index_spec], filterClass, filterSpec);
					end
				end
				for i = #recipe, 1, -1 do
					local sid = recipe[i];
					local info = T_Recipe_Data[sid];
					if info[index_phase] <= phase and info[index_grey_rank] + bonus <= rank then
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
		_log_("__db__.get_ordered_list|cff00ff00#1L3|r", pid);
	end
	return list;
end
-->

function __namespace__.init_db()
	for pid = __db__.DBMINPID, __db__.DBMAXPID do
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
					tinsert(h1, sid);
					local h2 = T_cidpid2sid[pid][cid];
					if h2 == nil then
						h2 = {  };
						T_cidpid2sid[pid][cid] = h2;
					end
					tinsert(h2, sid);
				end
				local rids = info[index_recipe];
				if rids ~= nil then
					for index = 1, #rids do
						local rid = rids[index];
						T_rid2sid[rid] = sid;
					end
				end
				--	list
				tinsert(recipe_sid_list, sid);
				if cid ~= nil then
					tinsert(recipe_cid_list, cid);
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
					tinsert(val[1], sid);
					tinsert(val[2], reagents_num[index]);
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
					tinsert(h1, sid);
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
					tinsert(val[1], sid);
					tinsert(val[2], reagents_num[index]);
				end
			end
		end
	end
	for sid, info in next, T_Recipe_Data do
		if not info[index_validated] then
			T_Recipe_Data[sid] = nil;
		end
	end
	local CACHE = __namespace__.CACHE;
	local LOCALE = GetLocale();
	local cache = CACHE[LOCALE];
	local _PatchVersion, _BuildNumber, _BuildDate, _TocVersion = GetBuildInfo();
	if cache == nil or cache.__WoWVersion == nil or cache.__WoWVersion < _TocVersion or cache.__DataVersion == nil or cache.__DataVersion < __db__.__DataVersion then
		cache = { S = T_SpellData, I = T_ItemData, };
		CACHE[LOCALE] = cache;
	else
		T_SpellData, T_ItemData = cache.S, cache.I;
	end
	cache.__WoWVersion = _TocVersion;
	cache.__DataVersion = __db__.__DataVersion;
	_LoadSavedVar();
	LF_PreloadSpell();
	LF_PreloadItem();
	for spec, pid in next, T_TradeSkill_Spec2Pid do
		T_IsSpecLearned[spec] = IsSpellKnown(spec) and true or nil;
	end
	F:RegisterEvent("LEARNED_SPELL_IN_TAB");
	F:RegisterEvent("SPELLS_CHANGED");
end
