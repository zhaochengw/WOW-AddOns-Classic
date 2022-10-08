--[[--
	by ALA @ 163UI
--]]--
----------------------------------------------------------------------------------------------------
local __addon__, __namespace__ = ...;
local __db__ = __namespace__.__db__;
local L = __namespace__.L;

-->		upvalue
	local hooksecurefunc = hooksecurefunc;
	local tonumber = tonumber;
	local select = select;
	local setmetatable = setmetatable;
	local rawget = rawget;
	local next = next;

	local min = math.min;
	local max = math.max;
	local strrep = string.rep;
	local strupper = string.upper;
	local strsplit = string.split;
	local strmatch = string.match;
	local format = string.format;

	local IsShiftKeyDown = IsShiftKeyDown;
	local GetItemQualityColor = GetItemQualityColor;
	local GetPlayerInfoByGUID = GetPlayerInfoByGUID;
	local GetMerchantItemID = GetMerchantItemID;
	local GetBuybackItemLink = GetBuybackItemLink;
	local GetContainerItemInfo = GetContainerItemInfo;
	local GetAuctionItemInfo = GetAuctionItemInfo;
	local GetAuctionSellItemInfo = GetAuctionSellItemInfo;
	local LootSlotHasItem, GetLootSlotType, GetLootSlotLink = LootSlotHasItem, GetLootSlotType, GetLootSlotLink;
	local LOOT_SLOT_ITEM = LOOT_SLOT_ITEM;
	local GetLootRollItemLink = GetLootRollItemLink;
	local GetInventoryItemID = GetInventoryItemID;
	local GetTradePlayerItemLink = GetTradePlayerItemLink;
	local GetTradeTargetItemLink = GetTradeTargetItemLink;
	local GetQuestItemLink = GetQuestItemLink;
	local GetQuestLogChoiceInfo, GetQuestLogRewardInfo = GetQuestLogChoiceInfo, GetQuestLogRewardInfo;
	local GetInboxItem = GetInboxItem;
	local GetSendMailItem = GetSendMailItem;
	local GetTradeSkillReagentItemLink, GetTradeSkillItemLink = GetTradeSkillReagentItemLink, GetTradeSkillItemLink;
	local GetCraftReagentItemLink, GetCraftItemLink = GetCraftReagentItemLink, GetCraftItemLink;
	local GetGuildBankItemLink = GetGuildBankItemLink;
	local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
	local MISCELLANEOUS = MISCELLANEOUS or "MISC";

	local _G = _G;
	--[[
		local UnitGUID = UnitGUID;
		local GameTooltip = GameTooltip;
		local ItemRefTooltip = ItemRefTooltip;
	]]
-->


local CURPHASE = __db__.CURPHASE;

local PLAYER_GUID = UnitGUID('player');
local _, C_PLAYER_GUID_REALM_ID = strsplit("-", PLAYER_GUID);


local AVAR, VAR, SET, FAV = nil, nil, nil, nil;
local AuctionMod = nil;


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


-->		****************
__namespace__:BuildEnv("tooltip");
-->		****************


local T_PriceSpellBlackList = __db__.T_PriceSpellBlackList;
local T_PriceItemBlackList = __db__.T_PriceItemBlackList;
local T_SpaceTable = setmetatable({}, {
	__index = function(t, k)
		local str = "|cff000000" .. strrep("*", 2 * k) .. "|r";
		t[k] = str;
		return str;
	end,
});
--	return price, cost, cost_known, missing, cid
local function F_GetPriceInfoBySID(phase, sid, num, lines, stack_level, is_enchanting, ...)	--	AuctionMod not checked
	local info = __db__.get_info_by_sid(sid);
	if info ~= nil then
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
					if T_PriceItemBlackList[iid] == nil then
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
							local nsids, sids = __db__.get_sid_by_cid(iid);
							if nsids > 0 then
								for index = 1, #sids do
									local sid = sids[index];
									if T_PriceSpellBlackList[sid] == nil then
										if __db__.get_pid_by_sid(sid) == pid then
											local p2, c2 = F_GetPriceInfoBySID(phase, sid, num, detail_lines, stack_level + 1, nil, cid, ...);
											p = p or p2;
											if c2 ~= nil then
												if c ~= nil and c > c2 or c == nil then
													c = c2;
												end
											end
											got = true;
										end
									end
								end
							end
						end
					end
					if not got then
						local name = AuctionMod.F_QueryNameByID(iid) or __db__.item_name_s(iid);
						local quality = AuctionMod.F_QueryQualityByID(iid) or __db__.item_rarity(iid);
						if quality ~= nil then
							local _, _, _, code = GetItemQualityColor(quality);
							name = "|c" .. code .. name .. "|r";
						end
						if iid ~= cid then
							p = AuctionMod.F_QueryPriceByID(iid);
							local v = AuctionMod.F_QueryVendorPriceByID(iid);
							if v ~= nil then
								if p == nil or p > v then
									p = v;
								end
							end
							if p ~= nil then
								p = p * num;
								if detail_lines ~= nil then
									detail_lines[#detail_lines + 1] = T_SpaceTable[stack_level + 1] .. name .. "x" .. num;
									detail_lines[#detail_lines + 1] = __namespace__.F_GetMoneyString(p);
								end
							else
								if detail_lines ~= nil then
									local bindType = __db__.item_bindType(iid);
									if bindType == 1 or bindType == 4 then
										detail_lines[#detail_lines + 1] = T_SpaceTable[stack_level + 1] .. name .. "x" .. num;
										detail_lines[#detail_lines + 1] = L["BOP"];
									else
										detail_lines[#detail_lines + 1] = T_SpaceTable[stack_level + 1] .. name .. "x" .. num;
										detail_lines[#detail_lines + 1] = L["UNKOWN_PRICE"];
									end
								end
							end
						else
							if detail_lines ~= nil then
								detail_lines[#detail_lines + 1] = T_SpaceTable[stack_level + 1] .. name .. "x" .. num;
								detail_lines[#detail_lines + 1] = "-";
							end
						end
					end
					if p == nil and c == nil then
						cost = nil;
						if stack_level > 0 then
							break;
						end
						missing = missing + 1;
					else
						if p ~= nil then
							if c ~= nil and p > c then
								p = c;
							end
						else
							p = c;
						end
						if cost ~= nil then
							cost = cost + p;
						end
						cost_known = cost_known + p;
					end
				end
			end
		end
		local vendorPrice = cid and AuctionMod.F_QueryVendorPriceByID(cid);
		local price = cid and AuctionMod.F_QueryPriceByID(cid);
		if vendorPrice ~= nil then
			if price == nil or vendorPrice < price then
				price = vendorPrice;
			end
		end
		price = price and price * num;
		local nMade = __db__.get_num_made_by_sid(sid);
		cost = cost and cost * num / nMade;
		cost_known = cost_known * num / nMade;
		local name = cid and (AuctionMod.F_QueryNameByID(cid) or __db__.item_name_s(cid));
		local quality = cid and (AuctionMod.F_QueryQualityByID(cid) or __db__.item_rarity(cid));
		if quality ~= nil then
			local _, _, _, code = GetItemQualityColor(quality);
			name = name and ("|c" .. code .. name .. "|r") or "";
		else
			name = name or "";
		end
		if stack_level == 0 then
			if lines ~= nil then
				for index = 1, #detail_lines do
					lines[#lines+ 1] = detail_lines[index];
				end
				if is_enchanting then
					if cost ~= nil then
						lines[#lines+ 1] = "|cffff7f00**|r" .. "|cffffffff" .. __db__.spell_name_s(sid) .. "|r" or L["COST_PRICE"];
						lines[#lines+ 1] = L["COST_PRICE"] .. __namespace__.F_GetMoneyString(cost);
					else
						lines[#lines+ 1] = "|cffff7f00**|r" .. "|cffffffff" .. __db__.spell_name_s(sid) .. "|r" or L["COST_PRICE"];
						lines[#lines+ 1] = L["COST_PRICE_KNOWN"] .. __namespace__.F_GetMoneyString(cost_known);
					end
				else
					if cost ~= nil then
						lines[#lines+ 1] = "|cffff7f00**|r" .. name .. "x" .. num;
						lines[#lines+ 1] = L["COST_PRICE"] .. __namespace__.F_GetMoneyString(cost);
					else
						lines[#lines+ 1] = "|cffff7f00**|r" .. name .. "x" .. num;
						lines[#lines+ 1] = L["COST_PRICE_KNOWN"] .. __namespace__.F_GetMoneyString(cost_known);
					end
					if price ~= nil then
						lines[#lines+ 1] = "|cff00ff00**|r" .. name .. "x" .. num;
						lines[#lines+ 1] = L["AH_PRICE"] .. __namespace__.F_GetMoneyString(price);
					end
					if cost ~= nil and price ~= nil then
						local diff = price - cost;
						local diffAH = price * 0.95 - cost;
						if diff > 0 then
							lines[#lines+ 1] = "|cff00ff00**|r" .. L["PRICE_DIFF+"];
							lines[#lines+ 1] = L["PRICE_DIFF_INFO+"] .. __namespace__.F_GetMoneyString(diff);
							if diffAH > 0 then
								lines[#lines+ 1] = "|cff00ff00**|r" .. L["PRICE_DIFF_AH+"];
								lines[#lines+ 1] = L["PRICE_DIFF_INFO+"] .. __namespace__.F_GetMoneyString(diffAH);
							elseif diffAH < 0 then
								lines[#lines+ 1] = "|cffff0000**|r" .. L["PRICE_DIFF_AH-"];
								lines[#lines+ 1] = L["PRICE_DIFF_INFO-"] .. __namespace__.F_GetMoneyString(-diffAH);
							else
							end
						elseif diff < 0 then
							lines[#lines+ 1] = "|cffff0000**|r" .. L["PRICE_DIFF-"];
							lines[#lines+ 1] = L["PRICE_DIFF_INFO-"] .. __namespace__.F_GetMoneyString(-diff);
							lines[#lines+ 1] = "|cffff0000**|r" .. L["PRICE_DIFF_AH-"];
							lines[#lines+ 1] = L["PRICE_DIFF_INFO-"] .. __namespace__.F_GetMoneyString(-diffAH);
						end
					end
				end
			end
		else
			if price ~= nil and (cost == nil or cost >= price) then
				if lines then
					lines[#lines+ 1] = T_SpaceTable[stack_level] .. name .. "x" .. num;
					lines[#lines+ 1] = __namespace__.F_GetMoneyString(price);
				end
			elseif cost ~= nil and (price == nil or cost < price) then
				if lines then
					lines[#lines+ 1] = T_SpaceTable[stack_level] .. name .. "x" .. num;
					lines[#lines+ 1] = __namespace__.F_GetMoneyString(cost);
					for index = 1, #detail_lines do
						lines[#lines+ 1] = detail_lines[index];
					end
				end
				price = nil;
			else
				if lines ~= nil then
					local bindType = __db__.item_bindType(cid);
					if bindType == 1 or bindType == 4 then
						lines[#lines+ 1] = T_SpaceTable[stack_level] .. name .. "x" .. num;
						lines[#lines+ 1] = L["BOP"];
					else
						lines[#lines+ 1] = T_SpaceTable[stack_level] .. name .. "x" .. num;
						lines[#lines+ 1] = L["UNKOWN_PRICE"];
					end
				end
			end
		end
		return price, cost, cost_known, missing, cid;
	end
end
local function set_tip_by_sid(Tooltip, sid)
	local info = __db__.get_info_by_sid(sid);
	if info ~= nil then
		Tooltip:AddLine(L["CRAFT_INFO"]);
		local cid = info[index_cid];
		local pid = info[index_pid];
		local texture = __db__.get_texture_by_pid(pid);
		local pname = __db__.get_pname_by_pid(pid) or "";
		if texture ~= nil then
			pname = "|T" .. texture .. ":12:12:0:0|t " .. pname;
		end
		local rankText = __db__.get_difficulty_rank_list_text_by_sid(sid, true);
		if pname ~= "" and rankText ~= "" then
			Tooltip:AddLine("|cff00afff" .. pname .. " " .. rankText .. "|r");
		end
		local detail_lines = {  };
		F_GetPriceInfoBySID(Tooltip.__phase or CURPHASE, sid, __db__.get_num_made_by_sid(sid), detail_lines, 0, cid == nil);
		if #detail_lines > 0 then
			for i = 1, #detail_lines, 2 do
				Tooltip:AddDoubleLine(detail_lines[i], detail_lines[i + 1]);
			end
			Tooltip:Show();
		end
	end
end
local function set_tip_by_cid(Tooltip, cid)
	local nsids, sids = __db__.get_sid_by_cid(cid);
	if nsids > 0 then
		Tooltip:AddLine(L["CRAFT_INFO"]);
		for index = 1, #sids do
			local sid = sids[index];
			local info = __db__.get_info_by_sid(sid);
			if info ~= nil then
				local pid = info[index_pid];
				local pname = "|T" .. (__db__.get_texture_by_pid(pid) or [[Interface\Icons\Inv_Misc_QuestionMark]]) .. ":12:12:0:0|t " .. (__db__.get_pname_by_pid(pid) or MISCELLANEOUS);
				local rankText = __db__.get_difficulty_rank_list_text_by_sid(sid, true);
				if rankText ~= "" then
					Tooltip:AddDoubleLine("|cff00afff" .. pname .. " " .. rankText .. "|r", "ID: ".. sid, 1.0, 1.0, 1.0, 0.5, 0.5, 0.5);
				else
					Tooltip:AddDoubleLine("|cff00afff" .. pname .. "|r", "ID: ".. sid, 1.0, 1.0, 1.0, 0.5, 0.5, 0.5);
				end
				local detail_lines = {  };
				F_GetPriceInfoBySID(Tooltip.__phase or CURPHASE, sid, __db__.get_num_made_by_sid(sid), detail_lines, 0, false);
				if #detail_lines > 0 then
					for i = 1, #detail_lines, 2 do
						Tooltip:AddDoubleLine(detail_lines[i], detail_lines[i + 1]);
					end
				end
			end
		end
		Tooltip:Show();
	end
end
local function LF_AddAccountLearnedInfo(Tooltip, rid, sid)
	sid = sid or __db__.get_sid_by_rid(rid);
	if sid ~= nil then
		local info = __db__.get_info_by_sid(sid);
		if info ~= nil then
			local pid = info[index_pid];
			local add_head = true;
			local learn_rank = info[index_learn_rank];
			for GUID, VAR in next, AVAR do
				local _, R = strsplit("-", GUID);
				if R == C_PLAYER_GUID_REALM_ID then
				-- if PLAYER_GUID ~= GUID then
					local var = rawget(VAR, pid);
					if var ~= nil then
						if add_head then
							Tooltip:AddLine(L["LABEL_ACCOUT_RECIPE_LEARNED"]);
							add_head = false;
						end
						local lClass, class, lRace, race, sex, name = GetPlayerInfoByGUID(GUID);
						if name ~= nil and class ~= nil then
							local classColorTable = RAID_CLASS_COLORS[strupper(class)];
							name = format("|cff%.2x%.2x%.2x", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. name .. "|r";
						else
							name = GUID;
						end
						if var[2][sid] then
							name = T_SpaceTable[1] .. L["RECIPE_LEARNED"] .. "  " .. name .. "  |cffffffff" .. var.cur_rank .. "/" .. var.max_rank .. "|r";
						else
							name = T_SpaceTable[1] .. L["RECIPE_NOT_LEARNED"] .. "  " .. name
										.. ((var.cur_rank >= learn_rank) and "  |cff00ff00" or "  |cffff0000") .. var.cur_rank
										.. ((var.max_rank >= learn_rank) and "|r|cffffffff/|r|cff00ff00" or "|r|cffffffff/|r|cffff0000") .. var.max_rank .. "|r";
						end
						Tooltip:AddLine(name);
					end
				end
			end
			Tooltip:Show();
		end
	end
end
local function LF_AddMaterialCraftInfo(Tooltip, iid)
	local data = __db__.get_sid_by_reagent(iid);
	if data ~= nil then
		local not_show_all = not IsShiftKeyDown();
		Tooltip:AddLine(L["LABEL_USED_AS_MATERIAL_IN"]);
		local lineL = nil;
		local lineR = nil;
		local nLines = 0;
		local sids, nums = data[1], data[2];
		for index = 1, #sids do
			local sid = sids[index];
			local num = nums[index];
			if not_show_all and nLines >= 8 then
				Tooltip:AddLine(T_SpaceTable[1] .. "|cffff0000...|r");
				break;
			end
			local info = __db__.get_info_by_sid(sid);
			if info ~= nil then
				local cid = info[index_cid];
				local pname = __db__.get_pname_by_pid(info[index_pid]) or "";
				if cid ~= nil then
					lineL = T_SpaceTable[1] .. __db__.item_string_s(cid) .. "x" .. num;
				else
					lineL = T_SpaceTable[1] .. __db__.spell_string_s(sid) .. "x" .. num;
				end
				local rankText = __db__.get_difficulty_rank_list_text_by_sid(sid, true);
				if pname ~= "" and rankText ~= "" then
					Tooltip:AddDoubleLine(lineL, "|cff00afff" .. pname .. " " .. rankText .. "|r");
				else
					Tooltip:AddLine(lineL);
				end
				nLines = nLines + 1;
			end
		end
		Tooltip:Show();
	end
end
local function LF_TooltipSetSpellByID(Tooltip, sid)
	if AuctionMod ~= nil then
		if SET.show_tradeskill_tip_craft_spell_price then
			if sid and __db__.is_tradeskill_sid(sid) then
				set_tip_by_sid(Tooltip, sid);
			end
		end
	end
end
local function LF_TooltipSetItemByID(Tooltip, iid)
	if SET.show_tradeskill_tip_recipe_account_learned then
		LF_AddAccountLearnedInfo(Tooltip, iid);
	end
	if SET.show_tradeskill_tip_material_craft_info then
		LF_AddMaterialCraftInfo(Tooltip, iid);
	end
	if AuctionMod ~= nil then
		if SET.show_tradeskill_tip_craft_item_price then
			if iid and __db__.is_tradeskill_cid(iid) then
				set_tip_by_cid(Tooltip, iid);
			end
		end
		if SET.show_tradeskill_tip_recipe_price then
			local sid = __db__.get_sid_by_rid(iid);
			if sid then
				set_tip_by_sid(Tooltip, sid);
			end
		end
	end
end
local function LF_TooltipSetHyperlink(Tooltip, link)
	if link then
		local sid = strmatch(link, "enchant:(%d+)");
		if sid == nil then
			sid = strmatch(link, "spell:(%d+)");
		end
		if sid ~= nil then
			sid = tonumber(sid);
			if sid ~= nil then
				LF_TooltipSetSpellByID(Tooltip, sid);
			end
			return;
		end
		local cid = strmatch(link, "item:(%d+)");
		if cid ~= nil then
			cid = tonumber(cid);
			if cid then
				LF_TooltipSetItemByID(Tooltip, cid);
			end
		end
	end
end
local function LF_TooltipSetCraftSpell(Tooltip, index)
	local link = GetCraftItemLink(index);
	if link then
		local sid = strmatch(link, "enchant:(%d+)");
		if sid == nil then
			sid = strmatch(link, "spell:(%d+)");
		end
		if sid ~= nil then
			sid = tonumber(sid);
			if sid ~= nil then
				LF_TooltipSetSpellByID(Tooltip, sid);
			end
			return;
		end
		local cid = strmatch(link, "item:(%d+)");
		if cid ~= nil then
			cid = tonumber(cid);
			if cid then
				LF_TooltipSetItemByID(Tooltip, cid);
			end
		end
	end
end
local function LF_TooltipSetMerchantItem(Tooltip, index)
	local iid = GetMerchantItemID(index);
	if iid ~= nil then
		LF_TooltipSetItemByID(Tooltip, iid);
	end
end
local function LF_TooltipSetBuybackItem(Tooltip, index)
	local link = GetBuybackItemLink(index);
	if link then
		local iid = tonumber(strmatch(link, "item:(%d+)") or nil);
		if iid ~= nil then
			LF_TooltipSetItemByID(Tooltip, iid);
		end
	end
end
local function LF_TooltipSetBagItem(Tooltip, bag, slot)
	local _, num, _, _, _, _, link, _, _, iid = GetContainerItemInfo(bag, slot);
	if iid ~= nil then
		LF_TooltipSetItemByID(Tooltip, iid);
	end
end
local function LF_TooltipSetAuctionItem(Tooltip, type, index)
	local name, _, num, _, _, _, _, _, _, _, _, _, _, _, _, _, iid = GetAuctionItemInfo(type, index);
	if iid ~= nil then
		LF_TooltipSetItemByID(Tooltip, iid);
	end
end
local function LF_TooltipSetAuctionSellItem(Tooltip)
	local name, _, num, _, _, _, _, _, _, iid = GetAuctionSellItemInfo();
	if iid ~= nil then
		LF_TooltipSetItemByID(Tooltip, iid);
	end
end
local function LF_TooltipSetLootItem(Tooltip, slot)
	if LootSlotHasItem(slot) and GetLootSlotType(slot) == LOOT_SLOT_ITEM then
		local link = GetLootSlotLink(slot);
		if link then
			local iid = tonumber(strmatch(link, "item:(%d+)") or nil);
			if iid ~= nil then
				LF_TooltipSetItemByID(Tooltip, iid);
			end
		end
	end
end
local function LF_TooltipSetLootRollItem(Tooltip, slot)
	local link = GetLootRollItemLink(slot);
	if link then
		local iid = tonumber(strmatch(link, "item:(%d+)") or nil);
		if iid ~= nil then
			LF_TooltipSetItemByID(Tooltip, iid);
		end
	end
end
local function LF_TooltipSetInventoryItem(Tooltip, unit, slot)
	local iid = GetInventoryItemID(unit, slot);
	if iid ~= nil then
		LF_TooltipSetItemByID(Tooltip, iid);
	end
end
local function LF_TooltipSetTradePlayerItem(Tooltip, index)
	local link = GetTradePlayerItemLink(index);
	if link then
		local iid = tonumber(strmatch(link, "item:(%d+)") or nil);
		if iid ~= nil then
			LF_TooltipSetItemByID(Tooltip, iid);
		end
	end
end
local function LF_TooltipSetTradeTargetItem(Tooltip, index)
	local link = GetTradeTargetItemLink(index);
	if link then
		local iid = tonumber(strmatch(link, "item:(%d+)") or nil);
		if iid ~= nil then
			LF_TooltipSetItemByID(Tooltip, iid);
		end
	end
end
local function LF_TooltipSetQuestItem(Tooltip, type, index)
	local link = GetQuestItemLink(type, index);
	if link then
		local iid = tonumber(strmatch(link, "item:(%d+)") or nil);
		if iid ~= nil then
			LF_TooltipSetItemByID(Tooltip, iid);
		end
	end
end
local function LF_TooltipSetQuestLogItem(Tooltip, type, index)
	local iid, _;
	if type == "choice" then
		_, _, _, _, _, iid = GetQuestLogChoiceInfo(index);
	else
		_, _, _, _, _, iid = GetQuestLogRewardInfo(index)
	end
	if iid ~= nil then
		LF_TooltipSetItemByID(Tooltip, iid);
	end
end
local function LF_TooltipSetInboxItem(Tooltip, index, index2)
	local name, iid, _, num = GetInboxItem(index, index2 or 1);
	if iid ~= nil then
		LF_TooltipSetItemByID(Tooltip, iid);
	end
end
local function LF_TooltipSetSendMailItem(Tooltip, index)
	local name, iid, _, num = GetSendMailItem(index);
	if iid ~= nil then
		LF_TooltipSetItemByID(Tooltip, iid);
	end
end
local function LF_TooltipSetTradeSkillItem(Tooltip, index, reagent)
	local link;
	if reagent then
		link = GetTradeSkillReagentItemLink(index, reagent);
	else
		link = GetTradeSkillItemLink(index);
	end
	if link then
		local iid = tonumber(strmatch(link, "item:(%d+)") or nil);
		if iid ~= nil then
			LF_TooltipSetItemByID(Tooltip, iid);
		end
	end
end
local function LF_TooltipSetCraftItem(Tooltip, index, reagent)
	local link = GetCraftReagentItemLink(index, reagent);
	if link ~= nil then
		local iid = tonumber(strmatch(link, "item:(%d+)") or nil);
		if iid ~= nil then
			LF_TooltipSetItemByID(Tooltip, iid);
		end
	end
end
local function LF_TooltipSetGuildBankItem(Tooltip, tab, index)
	local link = GetGuildBankItemLink(tab, index);
	if link ~= nil then
		local iid = tonumber(strmatch(link, "item:(%d+)") or nil);
		if iid ~= nil then
			LF_TooltipSetItemByID(Tooltip, iid);
		end
	end
end
local function LF_TooltipGUISetSpell(Tooltip)
	local _, sid = Tooltip:GetSpell();
	if sid ~= nil then
		LF_TooltipSetSpellByID(Tooltip, sid);
	end
end
local function LF_TooltipGUISetItem(Tooltip)
	local _, link = Tooltip:GetItem();
	if link ~= nil then
		local iid = tonumber(strmatch(link, "item:(%d+)") or nil);
		if iid ~= nil then
			LF_TooltipSetItemByID(Tooltip, iid);
		end
	end
end
local LT_HookedTooltip = {  };
local function F_HookTooltip(Tooltip)
	if LT_HookedTooltip[Tooltip] ~= nil then
		return;
	end
	LT_HookedTooltip[Tooltip] = true;
	--
	hooksecurefunc(Tooltip, "SetHyperlink", LF_TooltipSetHyperlink);
	hooksecurefunc(Tooltip, "SetSpellByID", LF_TooltipSetSpellByID);
	hooksecurefunc(Tooltip, "SetItemByID", LF_TooltipSetItemByID);
	hooksecurefunc(Tooltip, "SetCraftSpell", LF_TooltipSetCraftSpell);
	--
	hooksecurefunc(Tooltip, "SetMerchantItem", LF_TooltipSetMerchantItem);
	hooksecurefunc(Tooltip, "SetBuybackItem", LF_TooltipSetBuybackItem);
	hooksecurefunc(Tooltip, "SetBagItem", LF_TooltipSetBagItem);
	hooksecurefunc(Tooltip, "SetAuctionItem", LF_TooltipSetAuctionItem);
	hooksecurefunc(Tooltip, "SetAuctionSellItem", LF_TooltipSetAuctionSellItem);
	hooksecurefunc(Tooltip, "SetLootItem", LF_TooltipSetLootItem);
	hooksecurefunc(Tooltip, "SetLootRollItem", LF_TooltipSetLootRollItem);
	hooksecurefunc(Tooltip, "SetInventoryItem", LF_TooltipSetInventoryItem);
	hooksecurefunc(Tooltip, "SetTradePlayerItem", LF_TooltipSetTradePlayerItem);
	hooksecurefunc(Tooltip, "SetTradeTargetItem", LF_TooltipSetTradeTargetItem);
	hooksecurefunc(Tooltip, "SetQuestItem", LF_TooltipSetQuestItem);
	hooksecurefunc(Tooltip, "SetQuestLogItem", LF_TooltipSetQuestLogItem);
	hooksecurefunc(Tooltip, "SetInboxItem", LF_TooltipSetInboxItem);
	hooksecurefunc(Tooltip, "SetSendMailItem", LF_TooltipSetSendMailItem);
	hooksecurefunc(Tooltip, "SetTradeSkillItem", LF_TooltipSetTradeSkillItem);
	hooksecurefunc(Tooltip, "SetCraftItem", LF_TooltipSetCraftItem);
	if __namespace__.__is_classic then
		hooksecurefunc(Tooltip, "SetTrainerService", LF_TooltipGUISetItem);
	elseif __namespace__.__is_bcc or __namespace__.__is_wlk then
		hooksecurefunc(Tooltip, "SetTrainerService", LF_TooltipGUISetSpell);
		hooksecurefunc(Tooltip, "SetGuildBankItem", LF_TooltipSetGuildBankItem);
		hooksecurefunc(Tooltip, "SetSocketGem", LF_TooltipGUISetItem);
		hooksecurefunc(Tooltip, "SetExistingSocketGem", LF_TooltipGUISetItem);
	end
	hooksecurefunc(Tooltip, "SetCompareItem", function(Tooltip1, Tooltip2, service)
		if Tooltip1:IsShown() then
			LF_TooltipGUISetItem(Tooltip1);
		end
		if Tooltip2:IsShown() then
			LF_TooltipGUISetItem(Tooltip2);
		end
	end);
end

__namespace__.F_HookTooltip = F_HookTooltip;
__namespace__.F_GetPriceInfoBySID = F_GetPriceInfoBySID;

local N_RecipeSourceMOD = 0;
local T_RecipeSourceMOD = {  };
__namespace__:AddCallback("RECIPESOURCE_MOD_LOADED", function(mod)
	if mod ~= nil then
		N_RecipeSourceMOD = N_RecipeSourceMOD + 1;
		T_RecipeSourceMOD[N_RecipeSourceMOD] = mod;
	end
end);
function __namespace__.F_TooltipAddSource(Tooltip, sid)
	if N_RecipeSourceMOD > 0 then
		for index = N_RecipeSourceMOD, 1, -1 do
			local mod = T_RecipeSourceMOD[index];
			if mod.SetSpell ~= nil then
				return mod.SetSpell(Tooltip, sid);
			end
		end
	end
end

local function LF_SetRecipeSourceTip(Tooltip, sid)
	local info = __db__.get_info_by_sid(sid);
	if info ~= nil then
		local spec = info[index_spec];
		if spec ~= nil then
			local name = __db__.spell_name(spec);
			if name ~= nil then
				if __db__.is_spec_learned(spec) then
					Tooltip:AddDoubleLine(" ", name, 1, 1, 1, 0, 1, 0);
				else
					Tooltip:AddDoubleLine(" ", name, 1, 1, 1, 1, 0, 0);
				end
			end
		end
		if info[index_trainer] ~= nil then			-- trainer
			local price = info[index_train_price];
			if price ~= nil and price > 0 then
				Tooltip:AddDoubleLine(L["LABEL_GET_FROM"], "|cffff00ff" .. L["trainer"] .. "|r " ..  __namespace__.F_GetMoneyString(price));
			else
				Tooltip:AddDoubleLine(L["LABEL_GET_FROM"], "|cffff00ff" .. L["trainer"] .. "|r");
			end
		end
		local rids = info[index_recipe];
		if rids ~= nil then				-- recipe
			for index = 1, #rids do
				local rid = rids[index];
				local _, line, _, _, _, _, _, _, bind = __db__.item_info(rid);
				if line == nil then
					line = "|cffffffff" .. L["item"] .. "|r ID: " .. rid;
				end
				if bind ~= 1 and bind ~= 4 then
					line = line .. "(|cff00ff00" .. L["tradable"] .. "|r)";
					if AuctionMod ~= nil then
						local price = AuctionMod.F_QueryPriceByID(rid);
						if price ~= nil and price > 0 then
							line = line .. " |cff00ff00AH|r " .. __namespace__.F_GetMoneyString(price);
						end
					end
				else
					line = line .. "(|cffff0000" .. L["non_tradable"] .. "|r)";
				end
				Tooltip:AddDoubleLine(L["LABEL_GET_FROM"], line);
			end
		end
		local qids = info[index_quest];
		if qids then			-- quests
			for index = 1, #qids do
				local qid = qids[index];
				Tooltip:AddDoubleLine(L["LABEL_GET_FROM"], "Quest: " .. qid);
			end
		end
		-- if info[index_object] ~= nil then			-- objects
		-- 	if type(info[index_object]) == 'table' then
		-- 		for _, oid in next, info[index_object] do
		-- 			LF_MTSL_SetObject(info[index_pid], oid, L["LABEL_GET_FROM"], 1);
		-- 		end
		-- 	else
		-- 		LF_MTSL_SetObject(info[index_pid], info[index_object], L["LABEL_GET_FROM"], 1);
		-- 	end
		-- end
		Tooltip:Show();
	end
end

function __namespace__.init_tooltip()
	AVAR, VAR, SET, FAV = __namespace__.AVAR, __namespace__.VAR, __namespace__.SET, __namespace__.FAV;
	F_HookTooltip(_G.GameTooltip);
	F_HookTooltip(_G.ItemRefTooltip);
	F_HookTooltip(_G.ShoppingTooltip1);
	F_HookTooltip(_G.ShoppingTooltip2);
	__namespace__:AddCallback("AUCTION_MOD_LOADED", function(mod)
		if mod ~= nil then
			AuctionMod = mod;
		end
	end);
	__namespace__:FireEvent("RECIPESOURCE_MOD_LOADED", {
		SetSpell = LF_SetRecipeSourceTip,
		SetItem = __namespace__._noop_,
		SetUnit = __namespace__._noop_,
		SetObject = __namespace__._noop_,
		SetQuest = __namespace__._noop_,
	});
end
