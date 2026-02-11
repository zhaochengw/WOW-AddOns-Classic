--[[--
	by ALA
	当我写这个模块的时候，从来没有料到雷火的一套组合拳催生了那么多拍卖插件......
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;

-->		upvalue
	local next = next;
	local strmatch = string.match;
	local RequestLoadItemDataByID = RequestLoadItemDataByID or C_Item.RequestLoadItemDataByID;
	local GetItemInfo = GetItemInfo;
	local CreateFrame = CreateFrame;

-->
	local DataAgent = DT.DataAgent;
	local l10n = CT.l10n;

-->
MT.BuildEnv("AuctionBase");
-->
local F = CreateFrame('FRAME');

local AuctionBase = {  };

local T_MaterialVendorPrice = DataAgent.T_MaterialVendorPrice;
local T_MaterialVendorPriceByName = {  };
local function LF_CacheItem(id)
	local name = GetItemInfo(id);
	if name ~= nil then
		T_MaterialVendorPriceByName[name] = T_MaterialVendorPrice[id];
		return true;
	else
		return false;
	end
end
local N_MaterialVendorPrice = 0;
for id, price in next, T_MaterialVendorPrice do
	N_MaterialVendorPrice = N_MaterialVendorPrice + 1;
end
F:RegisterEvent("ITEM_DATA_LOAD_RESULT");
F:SetScript("OnEvent", function(self, event, arg1, arg2)
	if T_MaterialVendorPrice[arg1] ~= nil then
		if arg2 and LF_CacheItem(arg1) then
			N_MaterialVendorPrice = N_MaterialVendorPrice - 1;
		else
			RequestLoadItemDataByID(arg1);
		end
		if N_MaterialVendorPrice <= 0 then
			self:SetScript("OnEvent", nil);
			self:UnregisterAllEvents();
			F = nil;
		end
	end
end);
for id, price in next, T_MaterialVendorPrice do
	RequestLoadItemDataByID(id);
end
--
function AuctionBase.F_QueryVendorPriceByLink(link, num)
	local id = tonumber(strmatch(link, "item:(%d+)"));
	return id ~= nil and AuctionBase.F_QueryVendorPriceByID(id, num);
end
function AuctionBase.F_QueryVendorPriceByID(id, num)
	local p = T_MaterialVendorPrice[id];
	if p ~= nil then
		if num ~= nil then
			return p * num;
		else
			return p;
		end
	else
		return nil;
	end
end
function AuctionBase.F_QueryVendorPriceByName(name, num)
	local p = T_MaterialVendorPriceByName[name];
	if p ~= nil then
		if num ~= nil then
			return p * num;
		else
			return p;
		end
	else
		return nil;
	end
end

function AuctionBase.F_QueryNameByID(id)
	return nil;
end
function AuctionBase.F_QueryQualityByID(id)
	return nil;
end

local T_AuctionList = {  };
local T_AuctionDrop = {
	["*"] = {
		text = l10n.SLASH_NOTE["first_auction_mod:*"],
		para = "*",
	},
};
local T_AuctionModList = {  };
local T_AliasList = {
	F_QueryVendorPriceByLink = "get_material_vendor_price_by_link",
	F_QueryVendorPriceByID = "get_material_vendor_price_by_id",
	F_QueryVendorPriceByName = "get_material_vendor_price_by_name",
	F_QueryNameByID = "query_name_by_id",
	F_QueryQualityByID = "query_quality_by_id",
	--
	F_QueryPriceByName = "query_ah_price_by_name",
	F_QueryPriceByID = "query_ah_price_by_id",
	F_OnDBUpdate = "add_cache_callback",
};
local function handler(_, _, addon)
	if addon ~= VT.SET.first_auction_mod then
		VT.SET.first_auction_mod = addon;
		if T_AuctionModList[addon] ~= nil then
			MT.FireCallback("AUCTION_MOD_LOADED", T_AuctionModList[addon]);
		end
	end
end
local function __onshow(Button)
	Button.Text:SetText(">> |cff00ff00" .. (Button.Text:GetText() or "") .. "|r <<");
end
local T_AuctionModListDropMeta = {
	handler = handler,
	num = 0,
};
function MT.GetAuctionModListDropMeta()
	local pos = 1;
	if VT.SET.first_auction_mod == "*" or T_AuctionDrop[VT.SET.first_auction_mod] == nil then
		local v = T_AuctionDrop["*"];
		v.__onshow = __onshow;
		T_AuctionModListDropMeta[1] = v;
		T_AuctionModListDropMeta.num = 1;
	else
		local v = T_AuctionDrop[VT.SET.first_auction_mod];
		v.__onshow = __onshow;
		T_AuctionModListDropMeta[1] = v;
		local v = T_AuctionDrop["*"];
		v.__onshow = nil;
		T_AuctionModListDropMeta[2] = v;
		T_AuctionModListDropMeta.num = 2;
	end
	for index = 1, #T_AuctionList do
		local addon = T_AuctionList[index];
		if addon ~= VT.SET.first_auction_mod then
			local v = T_AuctionDrop[addon];
			if v ~= nil then
				v.__onshow = nil;
				T_AuctionModListDropMeta.num = T_AuctionModListDropMeta.num + 1;
				T_AuctionModListDropMeta[T_AuctionModListDropMeta.num] = v;
			end
		end
	end
	return T_AuctionModListDropMeta;
end
function MT.AddAuctionMod(id, mod)
	for key, val in next, AuctionBase do
		local alias = T_AliasList[key];
		mod[key] = mod[key] or mod[alias] or val;
	end
	if T_AuctionModList[id] == nil then
		T_AuctionModList[#T_AuctionModList + 1] = id;
	end
	T_AuctionModList[id] = mod;
	if id == VT.SET.first_auction_mod or T_AuctionModList[VT.SET.first_auction_mod] == nil then
		MT.FireCallback("AUCTION_MOD_LOADED", mod);
	end
end
function MT.GetAuctionMod()
	return T_AuctionModList[T_AuctionModList[1]];
end
function MT.RegsiterAuctionModOnLoad(addon, callback)
	if T_AuctionList[addon] == nil then
		local index = #T_AuctionList + 1;
		T_AuctionList[index] = addon;
		T_AuctionList[addon] = index;
		T_AuctionDrop[addon] = {
			text = addon,
			param = addon,
		};
	end
	MT.RegisterOnAddOnLoaded(addon, callback);
end
MT.RegisterOnInit('AuctionBase', function(LoggedIn)
end);
